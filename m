Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E138FFB3
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEYLGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 07:06:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:4628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhEYLGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 07:06:36 -0400
IronPort-SDR: osOe/iseivsk/FTlzYQdHp7ktXyoGI1NlEOAaJwmPFTyh3VpGyZ/Kw/4QxsqHKxpAZygHk6vrF
 fV3+PLQ4ZiMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="182487172"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="182487172"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 04:04:58 -0700
IronPort-SDR: EiYXIZ70Wdda8knJg+zwunocEJN05m52g26hUm+XziQMp7jwP8/QHFyUQIvtpwndbCJACyPg9K
 GjVlFNVQF+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="408714736"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2021 04:04:55 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llUrm-0001cQ-Nx; Tue, 25 May 2021 11:04:54 +0000
Date:   Tue, 25 May 2021 19:04:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/hotplug] BUILD SUCCESS
 0c82756a8d2ee6c2618466f8de82a5ee8c3c7427
Message-ID: <60acd9a9.xWecQp3hDOebNNV6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 0c82756a8d2ee6c2618466f8de82a5ee8c3c7427  PCI: pciehp: Ignore spurious link inactive change when off

elapsed time: 725m

configs tested: 227
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
mips                     loongson2k_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          collie_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
powerpc                         wii_defconfig
arm                       spear13xx_defconfig
s390                                defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           spitz_defconfig
powerpc                      makalu_defconfig
arc                          axs101_defconfig
mips                           xway_defconfig
mips                        omega2p_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
arm                            zeus_defconfig
arm                       mainstone_defconfig
alpha                            allyesconfig
arm                            mps2_defconfig
sh                           se7206_defconfig
sh                            titan_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                    or1ksim_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
powerpc                          allmodconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
mips                          malta_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7201_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
mips                       bmips_be_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
powerpc                      katmai_defconfig
arm                        spear3xx_defconfig
mips                      fuloong2e_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
xtensa                           allyesconfig
arm                            pleb_defconfig
powerpc                       holly_defconfig
powerpc                       eiger_defconfig
arm                       multi_v4t_defconfig
powerpc                     ppa8548_defconfig
sh                           se7705_defconfig
arm                        vexpress_defconfig
arm                         assabet_defconfig
sh                         ap325rxa_defconfig
mips                  cavium_octeon_defconfig
csky                             alldefconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
sparc                               defconfig
powerpc                 mpc8313_rdb_defconfig
mips                         db1xxx_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
sh                   sh7724_generic_defconfig
powerpc                    adder875_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
um                            kunit_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g5_defconfig
powerpc                      arches_defconfig
sh                              ul2_defconfig
arm                              alldefconfig
um                                allnoconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
powerpc                       maple_defconfig
mips                        jmr3927_defconfig
arm                           viper_defconfig
powerpc                        icon_defconfig
h8300                            allyesconfig
sh                          rsk7264_defconfig
sh                          r7785rp_defconfig
xtensa                  audio_kc705_defconfig
mips                  decstation_64_defconfig
powerpc64                           defconfig
powerpc                 mpc8560_ads_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arc                           tb10x_defconfig
xtensa                  nommu_kc705_defconfig
arm                     eseries_pxa_defconfig
m68k                         apollo_defconfig
mips                      pic32mzda_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
arm                            qcom_defconfig
xtensa                       common_defconfig
xtensa                generic_kc705_defconfig
m68k                       m5208evb_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
xtensa                         virt_defconfig
alpha                            alldefconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-b001-20210525
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
