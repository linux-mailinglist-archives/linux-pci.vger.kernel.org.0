Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6929D336E26
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhCKIrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 03:47:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:52613 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhCKIqn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 03:46:43 -0500
IronPort-SDR: zKuMadmnkJn/p6rarQF9wbNbLdWj3q26OBo/0dzIpbsZtltefbeu3aD/zz6HivZ4VotYZH5MFD
 j0aJUer9/+fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175747328"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="175747328"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:46:40 -0800
IronPort-SDR: fcVOXkmQqPnfjUmh1fXHFS3Lx1Sz2SdRXshbyo+whXYnTHgoixo5HkGw264fcfZ5l/XvPCLA3U
 6Bw6gn/5CVgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="409415003"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 00:46:36 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKGxo-0000ge-9S; Thu, 11 Mar 2021 08:46:36 +0000
Date:   Thu, 11 Mar 2021 16:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 12f6db15c40e6b0f846120f1f9548d278f12f370
Message-ID: <6049d8dc.njgPz0ToJnKO8ihE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 12f6db15c40e6b0f846120f1f9548d278f12f370  PCI: Avoid building empty drivers

elapsed time: 725m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
s390                             allyesconfig
arm                         lubbock_defconfig
m68k                       bvme6000_defconfig
arc                          axs103_defconfig
sh                        dreamcast_defconfig
mips                           ip22_defconfig
mips                        bcm63xx_defconfig
sh                     magicpanelr2_defconfig
arm                       imx_v4_v5_defconfig
csky                                defconfig
arm                         s5pv210_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
arm                       cns3420vb_defconfig
sparc                            alldefconfig
m68k                         amcore_defconfig
m68k                          multi_defconfig
sh                           se7721_defconfig
powerpc                    sam440ep_defconfig
powerpc                     akebono_defconfig
mips                        jmr3927_defconfig
mips                        nlm_xlp_defconfig
arm                         lpc18xx_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc8315_rdb_defconfig
s390                       zfcpdump_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
sh                            shmin_defconfig
mips                   sb1250_swarm_defconfig
nios2                               defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
sh                          lboxre2_defconfig
ia64                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
x86_64               randconfig-a011-20210310
x86_64               randconfig-a016-20210310
x86_64               randconfig-a013-20210310
x86_64               randconfig-a015-20210310
x86_64               randconfig-a014-20210310
x86_64               randconfig-a012-20210310
i386                 randconfig-a013-20210310
i386                 randconfig-a016-20210310
i386                 randconfig-a011-20210310
i386                 randconfig-a014-20210310
i386                 randconfig-a015-20210310
i386                 randconfig-a012-20210310
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
