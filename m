Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657939B25E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFDGGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 02:06:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:16673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhFDGGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 02:06:47 -0400
IronPort-SDR: np3OpGGNt6rq9GW8o7wFpbz1PN9+QVM3ZTLbW5UBPvy1Xg2jhZ3PPwWvrBP7WekKksMrdLaOJF
 xk+1ulzAxM+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204042679"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="204042679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 23:05:01 -0700
IronPort-SDR: WHXdMPntrL0HPA3fqyXBlL1V9B/K4IXi6gytr7LzgObtM5xwj4PpjWV9+99IS/W7Vzaos7TbBq
 /XN6BCP9TEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="446572926"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2021 23:04:59 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp2x0-0006if-QP; Fri, 04 Jun 2021 06:04:58 +0000
Date:   Fri, 04 Jun 2021 14:03:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/resource] BUILD SUCCESS
 5930343e4732616c2c36c8be199928307b3043c3
Message-ID: <60b9c24f.u4Rz3QWKGQbhOK9D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 5930343e4732616c2c36c8be199928307b3043c3  PCI: Coalesce host bridge contiguous apertures

elapsed time: 9271m

configs tested: 378
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
powerpc64                           defconfig
powerpc                    klondike_defconfig
arm                          badge4_defconfig
arm                           viper_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     powernv_defconfig
mips                        omega2p_defconfig
mips                        maltaup_defconfig
arm                           stm32_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         s5pv210_defconfig
xtensa                          iss_defconfig
m68k                        m5272c3_defconfig
mips                      loongson3_defconfig
h8300                       h8s-sim_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
powerpc                  storcenter_defconfig
powerpc                      pasemi_defconfig
powerpc                     rainier_defconfig
powerpc                   currituck_defconfig
m68k                           sun3_defconfig
ia64                             allmodconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
h8300                               defconfig
arm                          collie_defconfig
s390                             allyesconfig
arm                       cns3420vb_defconfig
arm                         vf610m4_defconfig
mips                           ip22_defconfig
powerpc                 mpc836x_mds_defconfig
nios2                               defconfig
powerpc                      tqm8xx_defconfig
riscv                    nommu_k210_defconfig
arm                          iop32x_defconfig
powerpc                       eiger_defconfig
xtensa                           allyesconfig
arc                        vdk_hs38_defconfig
arc                            hsdk_defconfig
s390                             allmodconfig
arm                        vexpress_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
mips                malta_qemu_32r6_defconfig
arm                       netwinder_defconfig
arm                        mvebu_v7_defconfig
powerpc                    gamecube_defconfig
arm                         at91_dt_defconfig
arm                      footbridge_defconfig
arm                          exynos_defconfig
powerpc                      ppc40x_defconfig
arm                           sunxi_defconfig
arm                            qcom_defconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
mips                 decstation_r4k_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
sparc                       sparc64_defconfig
arm                         assabet_defconfig
powerpc                        cell_defconfig
sh                         ap325rxa_defconfig
sh                        edosk7760_defconfig
powerpc                     sequoia_defconfig
s390                             alldefconfig
arc                        nsimosci_defconfig
openrisc                  or1klitex_defconfig
mips                         bigsur_defconfig
mips                          rm200_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s3c6400_defconfig
arm                        cerfcube_defconfig
microblaze                      mmu_defconfig
powerpc                      ppc44x_defconfig
powerpc                          allyesconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
riscv                            allyesconfig
arm                      pxa255-idp_defconfig
sh                         ecovec24_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
sh                           se7751_defconfig
mips                           xway_defconfig
sh                           se7705_defconfig
nios2                         3c120_defconfig
sh                          rsk7264_defconfig
s390                                defconfig
mips                            ar7_defconfig
arm                         orion5x_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          pcm027_defconfig
x86_64                           alldefconfig
m68k                        m5307c3_defconfig
powerpc                     ep8248e_defconfig
riscv                    nommu_virt_defconfig
arm                       mainstone_defconfig
sh                             espt_defconfig
mips                       bmips_be_defconfig
ia64                             allyesconfig
arm                      integrator_defconfig
s390                          debug_defconfig
sh                           se7206_defconfig
nds32                             allnoconfig
i386                                defconfig
sh                            migor_defconfig
mips                      bmips_stb_defconfig
m68k                         amcore_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
openrisc                            defconfig
mips                           ip32_defconfig
sh                           se7619_defconfig
mips                        nlm_xlp_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
powerpc                     tqm8541_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
arm                          lpd270_defconfig
nios2                         10m50_defconfig
sh                   sh7770_generic_defconfig
arm                         lpc32xx_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
arm                           spitz_defconfig
mips                    maltaup_xpa_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                            zx1_defconfig
mips                        vocore2_defconfig
nios2                            alldefconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
riscv                               defconfig
arm                             pxa_defconfig
mips                  cavium_octeon_defconfig
nds32                               defconfig
m68k                        mvme147_defconfig
m68k                             allmodconfig
powerpc                       holly_defconfig
powerpc                     tqm8555_defconfig
arm                        neponset_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
arm                         nhk8815_defconfig
mips                        bcm47xx_defconfig
arm                        spear3xx_defconfig
m68k                             alldefconfig
arm                             rpc_defconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
sparc                            alldefconfig
arm                         mv78xx0_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
m68k                         apollo_defconfig
m68k                       m5249evb_defconfig
sh                        dreamcast_defconfig
um                            kunit_defconfig
mips                           ip28_defconfig
m68k                       m5475evb_defconfig
arm                         palmz72_defconfig
sh                     magicpanelr2_defconfig
sh                          sdk7780_defconfig
arm                       aspeed_g5_defconfig
sh                               j2_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        realview_defconfig
mips                      pistachio_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc866_ads_defconfig
mips                        workpad_defconfig
sh                               allmodconfig
arm                        mini2440_defconfig
mips                            e55_defconfig
arm                         lpc18xx_defconfig
arm                        shmobile_defconfig
powerpc                       ebony_defconfig
mips                         db1xxx_defconfig
powerpc                      chrp32_defconfig
arm                            mps2_defconfig
sh                           se7721_defconfig
xtensa                    smp_lx200_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                     nsimosci_hs_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
arm                           corgi_defconfig
xtensa                              defconfig
powerpc                     ppa8548_defconfig
parisc                generic-32bit_defconfig
sh                           sh2007_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
m68k                          amiga_defconfig
ia64                             alldefconfig
sh                        sh7763rdp_defconfig
powerpc                       ppc64_defconfig
arc                              alldefconfig
mips                        nlm_xlr_defconfig
mips                           gcw0_defconfig
openrisc                    or1ksim_defconfig
arm                        clps711x_defconfig
sh                         apsh4a3a_defconfig
arm                          pxa910_defconfig
mips                      maltaaprp_defconfig
sh                          rsk7269_defconfig
nios2                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
mips                       capcella_defconfig
mips                      maltasmvp_defconfig
arm                  colibri_pxa300_defconfig
arm64                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
mips                       rbtx49xx_defconfig
mips                        qi_lb60_defconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
mips                        jmr3927_defconfig
mips                          ath25_defconfig
powerpc                        fsp2_defconfig
arm                        keystone_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     kilauea_defconfig
mips                          malta_defconfig
mips                           rs90_defconfig
m68k                          hp300_defconfig
sh                        edosk7705_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
arc                         haps_hs_defconfig
arm                        oxnas_v6_defconfig
arm                           h3600_defconfig
powerpc                          allmodconfig
sh                          rsk7201_defconfig
x86_64                            allnoconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210531
x86_64               randconfig-a003-20210531
x86_64               randconfig-a005-20210531
x86_64               randconfig-a004-20210531
x86_64               randconfig-a002-20210531
x86_64               randconfig-a001-20210531
x86_64               randconfig-a001-20210528
x86_64               randconfig-a006-20210528
x86_64               randconfig-a005-20210528
x86_64               randconfig-a003-20210528
x86_64               randconfig-a004-20210528
x86_64               randconfig-a002-20210528
i386                 randconfig-a001-20210528
i386                 randconfig-a005-20210528
i386                 randconfig-a002-20210528
i386                 randconfig-a006-20210528
i386                 randconfig-a004-20210528
i386                 randconfig-a003-20210528
i386                 randconfig-a002-20210531
i386                 randconfig-a001-20210531
i386                 randconfig-a005-20210531
i386                 randconfig-a006-20210531
i386                 randconfig-a004-20210531
i386                 randconfig-a003-20210531
i386                 randconfig-a001-20210529
i386                 randconfig-a005-20210529
i386                 randconfig-a002-20210529
i386                 randconfig-a006-20210529
i386                 randconfig-a003-20210529
i386                 randconfig-a004-20210529
i386                 randconfig-a002-20210530
i386                 randconfig-a001-20210530
i386                 randconfig-a005-20210530
i386                 randconfig-a006-20210530
i386                 randconfig-a004-20210530
i386                 randconfig-a003-20210530
x86_64               randconfig-a013-20210529
x86_64               randconfig-a014-20210529
x86_64               randconfig-a012-20210529
x86_64               randconfig-a016-20210529
x86_64               randconfig-a015-20210529
x86_64               randconfig-a011-20210529
x86_64               randconfig-a014-20210530
x86_64               randconfig-a012-20210530
x86_64               randconfig-a013-20210530
x86_64               randconfig-a016-20210530
x86_64               randconfig-a015-20210530
x86_64               randconfig-a011-20210530
i386                 randconfig-a016-20210529
i386                 randconfig-a011-20210529
i386                 randconfig-a015-20210529
i386                 randconfig-a012-20210529
i386                 randconfig-a014-20210529
i386                 randconfig-a013-20210529
i386                 randconfig-a016-20210528
i386                 randconfig-a011-20210528
i386                 randconfig-a015-20210528
i386                 randconfig-a012-20210528
i386                 randconfig-a014-20210528
i386                 randconfig-a013-20210528
i386                 randconfig-a016-20210531
i386                 randconfig-a015-20210531
i386                 randconfig-a013-20210531
i386                 randconfig-a012-20210531
i386                 randconfig-a014-20210531
i386                 randconfig-a011-20210531
i386                 randconfig-a016-20210530
i386                 randconfig-a015-20210530
i386                 randconfig-a013-20210530
i386                 randconfig-a012-20210530
i386                 randconfig-a014-20210530
i386                 randconfig-a011-20210530
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210531
x86_64               randconfig-b001-20210528
x86_64               randconfig-b001-20210529
x86_64               randconfig-b001-20210530
x86_64               randconfig-a006-20210530
x86_64               randconfig-a003-20210530
x86_64               randconfig-a005-20210530
x86_64               randconfig-a004-20210530
x86_64               randconfig-a002-20210530
x86_64               randconfig-a001-20210530
x86_64               randconfig-a013-20210528
x86_64               randconfig-a014-20210528
x86_64               randconfig-a012-20210528
x86_64               randconfig-a016-20210528
x86_64               randconfig-a015-20210528
x86_64               randconfig-a011-20210528
x86_64               randconfig-a014-20210531
x86_64               randconfig-a012-20210531
x86_64               randconfig-a013-20210531
x86_64               randconfig-a016-20210531
x86_64               randconfig-a015-20210531
x86_64               randconfig-a011-20210531
x86_64               randconfig-a006-20210529
x86_64               randconfig-a001-20210529
x86_64               randconfig-a005-20210529
x86_64               randconfig-a003-20210529
x86_64               randconfig-a004-20210529
x86_64               randconfig-a002-20210529

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
