Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AA35125F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDAJe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 05:34:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:3929 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhDAJem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 05:34:42 -0400
IronPort-SDR: yhQofLZZpk7UEVQztgMJWwWljpTTrkkqgLPbuGKxDlTW5n1gmExW1JpFP1EBmkEL9ZM/5ZhvbT
 Y7UKZDIguUEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179332195"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179332195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 02:34:38 -0700
IronPort-SDR: UNSvYo8T2iRiV2u6P1th9CP1Gn1/+W9YcRi5MgQTOvrnY41qDO9csbsPEvxmiAdVOlBbrPGwSF
 WG4o/X5Eevtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="446171755"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2021 02:34:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRtim-0006QA-0M; Thu, 01 Apr 2021 09:34:36 +0000
Date:   Thu, 01 Apr 2021 17:33:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/pm] BUILD SUCCESS
 96ff775c35a2c0414efc4ce07b43399b04996691
Message-ID: <60659383./eMDqgTZBpRUmGe8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
branch HEAD: 96ff775c35a2c0414efc4ce07b43399b04996691  PCI/ACPI: Fix debug message in acpi_pci_set_power_state()

elapsed time: 727m

configs tested: 212
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                           se7705_defconfig
mips                         tb0219_defconfig
arm                     am200epdkit_defconfig
mips                           ip32_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
m68k                         amcore_defconfig
arm                       spear13xx_defconfig
arm                           viper_defconfig
um                            kunit_defconfig
xtensa                  cadence_csp_defconfig
m68k                        m5307c3_defconfig
mips                            gpr_defconfig
mips                        nlm_xlp_defconfig
powerpc                     akebono_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
sparc                       sparc64_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
mips                malta_kvm_guest_defconfig
sh                        edosk7760_defconfig
sh                               allmodconfig
alpha                               defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          rsk7203_defconfig
arc                         haps_hs_defconfig
mips                          ath79_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
m68k                         apollo_defconfig
arc                           tb10x_defconfig
arm                            dove_defconfig
arm                        multi_v7_defconfig
arm                  colibri_pxa300_defconfig
x86_64                           alldefconfig
sh                           se7619_defconfig
powerpc                  mpc885_ads_defconfig
mips                           mtx1_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
sh                          r7780mp_defconfig
m68k                          sun3x_defconfig
ia64                         bigsur_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
xtensa                       common_defconfig
arm                      integrator_defconfig
arm                       mainstone_defconfig
sh                         apsh4a3a_defconfig
mips                     loongson1c_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kilauea_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                                  defconfig
arm                        spear6xx_defconfig
sh                           se7722_defconfig
arm                           sama5_defconfig
parisc                           allyesconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
mips                        workpad_defconfig
arm                         lpc32xx_defconfig
sh                        sh7757lcr_defconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
sh                   sh7770_generic_defconfig
arm                           spitz_defconfig
arm                         socfpga_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
m68k                           sun3_defconfig
arm                         orion5x_defconfig
mips                           gcw0_defconfig
powerpc                        fsp2_defconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson1b_defconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
xtensa                generic_kc705_defconfig
arm                       cns3420vb_defconfig
m68k                        mvme147_defconfig
mips                 decstation_r4k_defconfig
arm                              alldefconfig
riscv                            alldefconfig
arm                            pleb_defconfig
mips                       lemote2f_defconfig
powerpc                      chrp32_defconfig
alpha                            alldefconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
sh                           sh2007_defconfig
arm                         cm_x300_defconfig
arm                          lpd270_defconfig
arm                            zeus_defconfig
powerpc                      walnut_defconfig
microblaze                          defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
mips                      malta_kvm_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
