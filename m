Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479A43FD602
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbhIAI4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 04:56:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:37495 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243274AbhIAI4m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 04:56:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198244345"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="198244345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 01:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="520180574"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2021 01:55:44 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLM23-0007lS-Ld; Wed, 01 Sep 2021 08:55:43 +0000
Date:   Wed, 01 Sep 2021 16:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/rockchip-dwc] BUILD SUCCESS
 0e898eb8df4e34c7b129452444eb7cef68a11f43
Message-ID: <612f3fe3.SMv9GiMbce6Oz1r4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/rockchip-dwc
branch HEAD: 0e898eb8df4e34c7b129452444eb7cef68a11f43  PCI: rockchip-dwc: Add Rockchip RK356X host controller driver

elapsed time: 720m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
mips                        workpad_defconfig
i386                             alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
arm                           u8500_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           jazz_defconfig
arm                         vf610m4_defconfig
mips                      maltaaprp_defconfig
sh                           se7750_defconfig
powerpc                   lite5200b_defconfig
arm                            mmp2_defconfig
arm                             rpc_defconfig
csky                             alldefconfig
sparc                            alldefconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
mips                        nlm_xlp_defconfig
mips                           mtx1_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
arm                         hackkit_defconfig
sh                                  defconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
sh                               j2_defconfig
arm                       versatile_defconfig
sh                            shmin_defconfig
powerpc                  mpc866_ads_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
i386                 randconfig-a012-20210901
i386                 randconfig-a015-20210901
i386                 randconfig-a011-20210901
i386                 randconfig-a013-20210901
i386                 randconfig-a014-20210901
i386                 randconfig-a016-20210901
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
