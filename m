Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2264C2BDF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiBXMiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 07:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiBXMix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 07:38:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD619E723
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645706303; x=1677242303;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wX7jCbeDPNGj3GcnCI1zkcyFYFrQxOPkEOdyUg8XeqA=;
  b=dvL0dJIimifUMWcBv1l0ACCMxbsjsB35FkMtup9H08H9TFV47iEjW9V/
   AFywZeHPQOXCjyXTcslcIEeM3XGpgWCI2pfR6Md6y4RaXETi2XoBELczT
   xuwhMJ/SD/RRzBGDpazHrOQPl4TyySp26giaAdsvBH32Zsmcbrg6l+CUD
   26jM47RjhuXkrZDe+5RPvcH3oHkEi7psv4jr3JCjwsJbpO2ZZFPCyXAzz
   +vjK+wht975mMVOMnMyj/2DPdhjljPm4olcl32SJpyf8HS3JtII/nMdSE
   rCKiSnPH0nzx3LfNm3Pl0mD7/Yser+KOYY1M8W5haidxSfY3t+7ZBqNi5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239619957"
X-IronPort-AV: E=Sophos;i="5.90,133,1643702400"; 
   d="scan'208";a="239619957"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 04:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,133,1643702400"; 
   d="scan'208";a="777042694"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2022 04:38:21 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNDO1-00034r-9g; Thu, 24 Feb 2022 12:38:21 +0000
Date:   Thu, 24 Feb 2022 20:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/vga] BUILD SUCCESS
 fd2692370d56a7f1c1a806dfd1494c6e1fb01f7a
Message-ID: <62177c32.tB32o/Zyki56+4zJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vga
branch HEAD: fd2692370d56a7f1c1a806dfd1494c6e1fb01f7a  PCI/VGA: Replace full MIT license text with SPDX identifier

possible Warning in current branch (please contact us if interested):

drivers/pci/vgaarb.c:235:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-c007
    `-- drivers-pci-vgaarb.c:warning:Value-stored-to-dev-during-its-initialization-is-never-read-clang-analyzer-deadcode.DeadStores

elapsed time: 725m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220223
i386                          randconfig-c001
sh                             sh03_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
powerpc                      bamboo_defconfig
s390                          debug_defconfig
mips                             allyesconfig
arm                           stm32_defconfig
h8300                    h8300h-sim_defconfig
sh                             espt_defconfig
arc                              alldefconfig
sh                          rsk7201_defconfig
sh                          rsk7269_defconfig
mips                           jazz_defconfig
sh                        sh7763rdp_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
ia64                             allmodconfig
sh                           se7724_defconfig
arm                         assabet_defconfig
arc                        nsimosci_defconfig
powerpc                     redwood_defconfig
powerpc                      pasemi_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ep88xc_defconfig
ia64                             alldefconfig
mips                           xway_defconfig
arm                           viper_defconfig
sh                        sh7785lcr_defconfig
sh                        sh7757lcr_defconfig
nios2                               defconfig
csky                                defconfig
arm                           tegra_defconfig
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220224
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arc                  randconfig-r043-20220223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220224
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220224
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
riscv                randconfig-c006-20220224
powerpc                      walnut_defconfig
arm                           omap1_defconfig
powerpc                        icon_defconfig
arm                         bcm2835_defconfig
arm                           spitz_defconfig
powerpc                      ppc44x_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
powerpc                      ppc64e_defconfig
mips                        maltaup_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223
s390                 randconfig-r044-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
