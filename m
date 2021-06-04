Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BF39AF42
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 02:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFDA73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 20:59:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:53837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFDA72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 20:59:28 -0400
IronPort-SDR: o5jQGzTKbG/rtVUfdplcj1GlaO5kwnVDTq50c4fhvs+bDx1RsM2DAreAb/JP/apFRjQPYdDvqq
 La0PdgA4FdFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183878692"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="183878692"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:57:33 -0700
IronPort-SDR: r8uU8NB7RfjNvS4icMW0xyUs5EqPQqVRv1Tpaw4iEq56QeoDHmsosQetBzptnC8oQILGgC80ML
 8amFemajoz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="400773592"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2021 17:57:31 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1loy9S-0006WX-VS; Fri, 04 Jun 2021 00:57:30 +0000
Date:   Fri, 04 Jun 2021 08:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/error] BUILD SUCCESS
 8e3237989b0d38176a3603422777ac7da6bfab2b
Message-ID: <60b97a59.GggPuapSC9bmj6tE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/error
branch HEAD: 8e3237989b0d38176a3603422777ac7da6bfab2b  Documentation: PCI: Fix typo in pci-error-recovery.rst

elapsed time: 3381m

configs tested: 358
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
m68k                          amiga_defconfig
riscv                             allnoconfig
riscv                               defconfig
arm                           sunxi_defconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
mips                        qi_lb60_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
powerpc                      mgcoge_defconfig
arm                           spitz_defconfig
xtensa                              defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
powerpc                           allnoconfig
h8300                     edosk2674_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        multi_v5_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
arm                         s3c2410_defconfig
microblaze                          defconfig
arc                     nsimosci_hs_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
mips                        workpad_defconfig
arc                     haps_hs_smp_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                     tqm8560_defconfig
sh                           se7722_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
nds32                               defconfig
arm                        mini2440_defconfig
parisc                              defconfig
sh                               j2_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
arm                       cns3420vb_defconfig
mips                        jmr3927_defconfig
sh                           sh2007_defconfig
sh                          polaris_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        bcm47xx_defconfig
s390                       zfcpdump_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
arm                            mps2_defconfig
arc                          axs103_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
mips                           rs90_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc64                        alldefconfig
powerpc64                           defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
xtensa                generic_kc705_defconfig
mips                            gpr_defconfig
h8300                       h8s-sim_defconfig
sh                         microdev_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     redwood_defconfig
powerpc                    gamecube_defconfig
mips                      loongson3_defconfig
powerpc                     tqm5200_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
nds32                             allnoconfig
alpha                               defconfig
x86_64                            allnoconfig
arc                              alldefconfig
arm                        neponset_defconfig
sh                          lboxre2_defconfig
m68k                       m5475evb_defconfig
arm                          pcm027_defconfig
arm                         lubbock_defconfig
sh                        sh7785lcr_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          simpad_defconfig
arm                       aspeed_g4_defconfig
sh                           se7751_defconfig
mips                      bmips_stb_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
m68k                       m5208evb_defconfig
sh                          r7785rp_defconfig
mips                       capcella_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
mips                        maltaup_defconfig
powerpc                      ppc64e_defconfig
s390                             alldefconfig
nios2                               defconfig
powerpc                     pseries_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
arm                  colibri_pxa270_defconfig
sh                            hp6xx_defconfig
um                            kunit_defconfig
arm                       imx_v4_v5_defconfig
i386                             alldefconfig
m68k                                defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
arc                            hsdk_defconfig
powerpc                   currituck_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
arc                        nsimosci_defconfig
xtensa                    xip_kc705_defconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
sh                        dreamcast_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
arm                         palmz72_defconfig
sparc                               defconfig
powerpc                         wii_defconfig
powerpc                  mpc866_ads_defconfig
arm                           omap1_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                 linkstation_defconfig
arm                         vf610m4_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                     sh7710voipgw_defconfig
arm                         orion5x_defconfig
sh                        sh7763rdp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
m68k                        m5307c3_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
sparc64                             defconfig
h8300                            alldefconfig
arm                           tegra_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
mips                     loongson2k_defconfig
mips                      pistachio_defconfig
sh                        sh7757lcr_defconfig
mips                           mtx1_defconfig
sh                   rts7751r2dplus_defconfig
arm                  colibri_pxa300_defconfig
h8300                               defconfig
powerpc                 mpc837x_rdb_defconfig
sh                         ap325rxa_defconfig
mips                      malta_kvm_defconfig
arm                       versatile_defconfig
arm                          gemini_defconfig
arm                           stm32_defconfig
arm                          badge4_defconfig
mips                         cobalt_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
m68k                        mvme147_defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
powerpc                      chrp32_defconfig
mips                        nlm_xlr_defconfig
arm                          moxart_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
ia64                                defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                         at91_dt_defconfig
openrisc                            defconfig
arm                            mmp2_defconfig
arm                        magician_defconfig
powerpc                        icon_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20210602
x86_64               randconfig-a004-20210602
x86_64               randconfig-a003-20210602
x86_64               randconfig-a006-20210602
x86_64               randconfig-a005-20210602
x86_64               randconfig-a001-20210602
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
i386                 randconfig-a003-20210602
i386                 randconfig-a006-20210602
i386                 randconfig-a004-20210602
i386                 randconfig-a001-20210602
i386                 randconfig-a005-20210602
i386                 randconfig-a002-20210602
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
i386                 randconfig-a015-20210602
i386                 randconfig-a013-20210602
i386                 randconfig-a016-20210602
i386                 randconfig-a011-20210602
i386                 randconfig-a014-20210602
i386                 randconfig-a012-20210602
i386                 randconfig-a013-20210603
i386                 randconfig-a016-20210603
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-b001-20210601
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210602
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601
x86_64               randconfig-a015-20210602
x86_64               randconfig-a011-20210602
x86_64               randconfig-a012-20210602
x86_64               randconfig-a014-20210602
x86_64               randconfig-a016-20210602
x86_64               randconfig-a013-20210602

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
