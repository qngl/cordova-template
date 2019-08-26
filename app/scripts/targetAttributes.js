// Adds target attributes

/**
 * Unfortunately the latest version of cordova-ios (4.5.2) creates the project.pbxproj file (project metadata file)
 * without the configuration `TargetAttributes` that are created by xcode 8 and later.
 *
 * Automated codesigning, particularly, setting up the right team_id int the project requires `TargetAttributes`
 * to be present. This adds such a property to project.pbxproj
 *
 * Original gist:
 * https://gist.github.com/joshstrange/cfb4128f1be7ac60c22a41dad98ea68a
 *
 * Relevant fastlane code:
 * https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/automatic_code_signing.rb#L14
 */

module.exports = function(context) {
  var fs = require('fs');
  var ROOT_DIR = context.opts.projectRoot;
  if (ROOT_DIR.substr(0, 1) === '/' && fs.existsSync(ROOT_DIR + '/platforms/ios')) {
    var srcFile = ROOT_DIR + '/platforms/ios/FSOSWP.xcodeproj/project.pbxproj';

    var projectPbxproj = fs.readFileSync(srcFile, 'utf8');

    if (projectPbxproj.indexOf('TargetAttributes') === -1) {
      console.log('Adding TargetAttributes to pbxproj...');
      var targetAttributes = '\n\t\t\t\tTargetAttributes = {\n\t\t\t  \t\t1D6058900D05DD3D006BFB54 = {};\n\t\t\t\t};';
      // Works with cordova-ios@4.5.2
      var searchString = 'LastUpgradeCheck = 510;';
      var lastUpgradeCheckIndex = projectPbxproj.indexOf(searchString);

      projectPbxproj = projectPbxproj.substr(0, lastUpgradeCheckIndex + searchString.length) + targetAttributes + projectPbxproj.substr(lastUpgradeCheckIndex + searchString.length);
    }

    fs.writeFileSync(srcFile, projectPbxproj);
  }
};
