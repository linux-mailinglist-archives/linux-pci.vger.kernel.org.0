Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706712956ED
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 05:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443485AbgJVDoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 23:44:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:13235 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443491AbgJVDoE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 23:44:04 -0400
IronPort-SDR: vZyPImRN9jIB1kxI/0FqHV0wUlR+7Je8XvkvrQ0HvREKMRB21o4ikUOEpXT0uP6kTDwW0ZVt+Q
 bP474wYUr54w==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="167564737"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="167564737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 20:44:02 -0700
IronPort-SDR: WudeIgQnKAvDPLKTJryDi/dZTODM7poQF28K2QGWsZht2fyhK0FDvwkkqLCdiOegSQ+2Ibe8+Z
 YUn+b+WSbSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="348578833"
Received: from lkp-server02.sh.intel.com (HELO 911c2f167757) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2020 20:44:01 -0700
Received: from kbuild by 911c2f167757 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVRWD-0000Fz-2J; Thu, 22 Oct 2020 03:44:01 +0000
Date:   Thu, 22 Oct 2020 11:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:v5.10-merge] BUILD SUCCESS
 f81f8dad8fc839e7d6eb48ea1d5cc542496e75d2
Message-ID: <5f90ffce.66CdavBP0H66WYpA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  v5.10-merge
branch HEAD: f81f8dad8fc839e7d6eb48ea1d5cc542496e75d2  Merge branch 'next' into v5.10-merge

elapsed time: 724m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ppc64e_defconfig
powerpc                     sbc8548_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc5200_defconfig
powerpc                    gamecube_defconfig
arm                           tegra_defconfig
sh                             shx3_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
arm                        cerfcube_defconfig
arc                        nsimosci_defconfig
arm                       mainstone_defconfig
arm                        spear6xx_defconfig
arm                            dove_defconfig
arm                            mps2_defconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
mips                      pic32mzda_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    amigaone_defconfig
arm                            xcep_defconfig
powerpc                     sequoia_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
powerpc                         ps3_defconfig
sh                         ap325rxa_defconfig
mips                        maltaup_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   motionpro_defconfig
mips                     loongson1b_defconfig
arm                            lart_defconfig
m68k                       m5275evb_defconfig
m68k                           sun3_defconfig
arm                         hackkit_defconfig
sh                ecovec24-romimage_defconfig
arm                           u8500_defconfig
openrisc                 simple_smp_defconfig
arm                             pxa_defconfig
xtensa                    xip_kc705_defconfig
mips                        qi_lb60_defconfig
ia64                            zx1_defconfig
xtensa                  cadence_csp_defconfig
mips                     cu1830-neo_defconfig
arm                          prima2_defconfig
powerpc                   lite5200b_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc866_ads_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
alpha                               defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                          rm200_defconfig
powerpc                      cm5200_defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        sh7763rdp_defconfig
powerpc                       holly_defconfig
mips                       lemote2f_defconfig
sh                             sh03_defconfig
c6x                                 defconfig
powerpc                          g5_defconfig
m68k                        m5272c3_defconfig
xtensa                           alldefconfig
powerpc                     ksi8560_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a001-20201021
x86_64               randconfig-a002-20201021
x86_64               randconfig-a003-20201021
x86_64               randconfig-a006-20201021
x86_64               randconfig-a005-20201021
x86_64               randconfig-a004-20201021
i386                 randconfig-a002-20201021
i386                 randconfig-a005-20201021
i386                 randconfig-a003-20201021
i386                 randconfig-a001-20201021
i386                 randconfig-a006-20201021
i386                 randconfig-a004-20201021
i386                 randconfig-a016-20201021
i386                 randconfig-a014-20201021
i386                 randconfig-a015-20201021
i386                 randconfig-a013-20201021
i386                 randconfig-a012-20201021
i386                 randconfig-a011-20201021
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20201021
x86_64               randconfig-a013-20201021
x86_64               randconfig-a016-20201021
x86_64               randconfig-a015-20201021
x86_64               randconfig-a012-20201021
x86_64               randconfig-a014-20201021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
