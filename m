Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2D4402F9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhJ2TQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 15:16:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:51997 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhJ2TQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Oct 2021 15:16:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="230684139"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="230684139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448216129"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2021 12:14:10 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgXKL-0000eO-KQ; Fri, 29 Oct 2021 19:14:09 +0000
Date:   Sat, 30 Oct 2021 03:13:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 fb2099960d46c486c552807a216aae33819155c9
Message-ID: <617c47ea.Aw03XGTlPbOgzusl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: fb2099960d46c486c552807a216aae33819155c9  MAINTAINERS: Update PCI subsystem information

elapsed time: 2672m

configs tested: 300
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
i386                 randconfig-c001-20211027
mips                        workpad_defconfig
mips                malta_qemu_32r6_defconfig
mips                         tb0226_defconfig
mips                      maltasmvp_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8272_ads_defconfig
arc                              alldefconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
mips                        vocore2_defconfig
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         db1xxx_defconfig
mips                          rm200_defconfig
parisc                generic-32bit_defconfig
powerpc                   microwatt_defconfig
mips                         rt305x_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     skiroot_defconfig
m68k                             alldefconfig
arm                          iop32x_defconfig
mips                       rbtx49xx_defconfig
sh                           se7721_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
arm                          ixp4xx_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
arc                     nsimosci_hs_defconfig
sh                     magicpanelr2_defconfig
mips                     cu1830-neo_defconfig
powerpc                       eiger_defconfig
arm                            lart_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
mips                   sb1250_swarm_defconfig
arm                           sama7_defconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
sh                             shx3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          r7785rp_defconfig
arm                       netwinder_defconfig
h8300                               defconfig
arm                           sunxi_defconfig
sh                         apsh4a3a_defconfig
mips                           rs90_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
arm                          collie_defconfig
arm                              alldefconfig
mips                      fuloong2e_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
sh                                  defconfig
mips                           ip32_defconfig
sh                           se7750_defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7203_defconfig
powerpc                      mgcoge_defconfig
powerpc                      ppc44x_defconfig
powerpc                      pasemi_defconfig
arc                     haps_hs_smp_defconfig
riscv                            alldefconfig
powerpc                    sam440ep_defconfig
sh                           se7751_defconfig
powerpc                     mpc512x_defconfig
arc                          axs101_defconfig
powerpc                      pcm030_defconfig
sh                           se7705_defconfig
mips                      bmips_stb_defconfig
arm                           u8500_defconfig
powerpc                     redwood_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
powerpc                      ppc6xx_defconfig
nios2                         10m50_defconfig
arm64                            alldefconfig
powerpc                        warp_defconfig
mips                          ath25_defconfig
arm                         at91_dt_defconfig
m68k                          amiga_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm5200_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
m68k                        stmark2_defconfig
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                          lpd270_defconfig
arm                  colibri_pxa300_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                          iss_defconfig
arm                          imote2_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc834x_itx_defconfig
microblaze                      mmu_defconfig
arm                       imx_v4_v5_defconfig
arm                          pcm027_defconfig
ia64                         bigsur_defconfig
mips                        omega2p_defconfig
arm                        mvebu_v5_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
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
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
arm                  randconfig-c002-20211029
powerpc              randconfig-c003-20211029
riscv                randconfig-c006-20211029
x86_64               randconfig-c007-20211029
mips                 randconfig-c004-20211029
s390                 randconfig-c005-20211029
i386                 randconfig-c001-20211029
x86_64               randconfig-a002-20211027
x86_64               randconfig-a004-20211027
x86_64               randconfig-a005-20211027
x86_64               randconfig-a006-20211027
x86_64               randconfig-a001-20211027
x86_64               randconfig-a003-20211027
i386                 randconfig-a004-20211029
i386                 randconfig-a003-20211029
i386                 randconfig-a002-20211029
i386                 randconfig-a001-20211029
i386                 randconfig-a006-20211029
i386                 randconfig-a005-20211029
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
