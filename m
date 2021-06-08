Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60439EBD5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 04:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFHCVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 22:21:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:42048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHCVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 22:21:41 -0400
IronPort-SDR: PGB0gMrt1QQfNjVSGwqrFREn2P5zPPS+7Pz+tThu+mzbgksa7VrdC6vZQY7vCqFziGWM2q2mvl
 Enscl6taYBew==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201738758"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="201738758"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 19:19:47 -0700
IronPort-SDR: RcnwwTcdgtUWUjda98+FTyGgmfaPQZmpYDoqUjeTXFPUD1GPIrChHqpPMoEiLx46M3JTZ4E1sY
 v+NlJrT+Xq/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="401896550"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2021 19:19:45 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqRLE-0008hK-TZ; Tue, 08 Jun 2021 02:19:44 +0000
Date:   Tue, 08 Jun 2021 10:18:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/virtualization] BUILD SUCCESS
 abcb1449378eef5df7b99967da78eb6374ba7b7f
Message-ID: <60bed385.2BhlmYQbsyJcjEz+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: abcb1449378eef5df7b99967da78eb6374ba7b7f  PCI: Mark AMD Navi14 GPU ATS as broken

elapsed time: 730m

configs tested: 210
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     loongson2k_defconfig
sh                          r7780mp_defconfig
arc                    vdk_hs38_smp_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
arc                          axs103_defconfig
arm                     davinci_all_defconfig
powerpc64                           defconfig
powerpc                     sbc8548_defconfig
arm                       versatile_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
openrisc                  or1klitex_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
powerpc                    sam440ep_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
s390                          debug_defconfig
arc                            hsdk_defconfig
mips                            e55_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             sh03_defconfig
arm                           sama5_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
sh                            migor_defconfig
openrisc                         alldefconfig
powerpc                    mvme5100_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
mips                      pic32mzda_defconfig
riscv                            alldefconfig
arm                        cerfcube_defconfig
sh                   sh7724_generic_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                           allyesconfig
arm                            lart_defconfig
riscv                          rv32_defconfig
powerpc                   motionpro_defconfig
ia64                             allmodconfig
arm                      jornada720_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
x86_64                            allnoconfig
powerpc                     tqm8548_defconfig
powerpc                     tqm8540_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    adder875_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
xtensa                           allyesconfig
mips                       bmips_be_defconfig
s390                                defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
arm                      footbridge_defconfig
h8300                     edosk2674_defconfig
nds32                             allnoconfig
sh                          sdk7780_defconfig
mips                           jazz_defconfig
arm                        mvebu_v5_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc832x_mds_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                         ps3_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc64_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
powerpc                      ep88xc_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
sh                           se7619_defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
powerpc                     ppa8548_defconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            qcom_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
parisc                              defconfig
sh                         microdev_defconfig
sh                     magicpanelr2_defconfig
powerpc                 linkstation_defconfig
ia64                        generic_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
sh                      rts7751r2d1_defconfig
sh                                  defconfig
powerpc                        warp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                          allmodconfig
arm                          lpd270_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                        fsp2_defconfig
x86_64                              defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210607
i386                 randconfig-a006-20210607
i386                 randconfig-a004-20210607
i386                 randconfig-a001-20210607
i386                 randconfig-a002-20210607
i386                 randconfig-a005-20210607
x86_64               randconfig-a015-20210607
x86_64               randconfig-a011-20210607
x86_64               randconfig-a014-20210607
x86_64               randconfig-a012-20210607
x86_64               randconfig-a016-20210607
x86_64               randconfig-a013-20210607
i386                 randconfig-a015-20210607
i386                 randconfig-a011-20210607
i386                 randconfig-a012-20210607
i386                 randconfig-a013-20210607
i386                 randconfig-a016-20210607
i386                 randconfig-a014-20210607
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210607
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
