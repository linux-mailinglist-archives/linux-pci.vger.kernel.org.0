Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B943D6DED
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhG0FRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 01:17:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:3915 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234781AbhG0FRr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 01:17:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="276159624"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="276159624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 22:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="498630215"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2021 22:17:45 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8FTN-0006VO-3J; Tue, 27 Jul 2021 05:17:45 +0000
Date:   Tue, 27 Jul 2021 13:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 08463f5ad501ba0573ecf4b0be3dc25690e04868
Message-ID: <60ff96c0.miZLDQMR4Gb2GdXx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 08463f5ad501ba0573ecf4b0be3dc25690e04868  Merge branch 'remotes/lorenzo/pci/tegra'

elapsed time: 726m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210726
arm                         lpc18xx_defconfig
powerpc                    socrates_defconfig
powerpc                       holly_defconfig
xtensa                          iss_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
sh                           se7722_defconfig
arm                            qcom_defconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
mips                            gpr_defconfig
arm                            mps2_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5249evb_defconfig
sh                          sdk7786_defconfig
arm                         mv78xx0_defconfig
sh                   rts7751r2dplus_defconfig
sh                 kfr2r09-romimage_defconfig
sh                               alldefconfig
arm                       imx_v6_v7_defconfig
arm                             mxs_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
riscv                    nommu_virt_defconfig
m68k                        mvme147_defconfig
sh                     magicpanelr2_defconfig
powerpc                 linkstation_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
sparc                               defconfig
powerpc                    sam440ep_defconfig
riscv                    nommu_k210_defconfig
i386                             allyesconfig
arc                            hsdk_defconfig
sh                        sh7785lcr_defconfig
powerpc                     kilauea_defconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
powerpc                     stx_gp3_defconfig
mips                           ip27_defconfig
mips                         bigsur_defconfig
sh                        sh7763rdp_defconfig
x86_64                              defconfig
openrisc                  or1klitex_defconfig
sh                             espt_defconfig
sh                              ul2_defconfig
mips                        nlm_xlp_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210726
x86_64               randconfig-a006-20210726
x86_64               randconfig-a001-20210726
x86_64               randconfig-a005-20210726
x86_64               randconfig-a004-20210726
x86_64               randconfig-a002-20210726
i386                 randconfig-a005-20210726
i386                 randconfig-a003-20210726
i386                 randconfig-a004-20210726
i386                 randconfig-a002-20210726
i386                 randconfig-a001-20210726
i386                 randconfig-a006-20210726
x86_64               randconfig-a011-20210727
x86_64               randconfig-a016-20210727
x86_64               randconfig-a013-20210727
x86_64               randconfig-a014-20210727
x86_64               randconfig-a012-20210727
x86_64               randconfig-a015-20210727
i386                 randconfig-a016-20210726
i386                 randconfig-a013-20210726
i386                 randconfig-a012-20210726
i386                 randconfig-a011-20210726
i386                 randconfig-a014-20210726
i386                 randconfig-a015-20210726
i386                 randconfig-a016-20210727
i386                 randconfig-a013-20210727
i386                 randconfig-a012-20210727
i386                 randconfig-a011-20210727
i386                 randconfig-a014-20210727
i386                 randconfig-a015-20210727
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210726
x86_64               randconfig-a003-20210725
x86_64               randconfig-a006-20210725
x86_64               randconfig-a001-20210725
x86_64               randconfig-a005-20210725
x86_64               randconfig-a004-20210725
x86_64               randconfig-a002-20210725
x86_64               randconfig-a003-20210727
x86_64               randconfig-a006-20210727
x86_64               randconfig-a001-20210727
x86_64               randconfig-a005-20210727
x86_64               randconfig-a004-20210727
x86_64               randconfig-a002-20210727
x86_64               randconfig-a011-20210726
x86_64               randconfig-a016-20210726
x86_64               randconfig-a013-20210726
x86_64               randconfig-a014-20210726
x86_64               randconfig-a012-20210726
x86_64               randconfig-a015-20210726

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
