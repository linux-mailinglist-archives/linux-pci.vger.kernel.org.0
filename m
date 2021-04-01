Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BB350E9A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDAF6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 01:58:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:3789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhDAF6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 01:58:25 -0400
IronPort-SDR: 54e9WH6ZbWIyqG9t46D7JLkHHymAm3WWHpk1A+UFpNdhtX1NCJCKeEBbSbiBOm6jnam2VIbV0w
 GmPJklqo6JDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179690297"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179690297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 22:58:24 -0700
IronPort-SDR: WMHwTm1G8rpWOJXJ7CQ955CMFALmsrffH4h4StgBF3SZTIKyjpEHn1XM2hEa0LWQ9BxckGNxAi
 CzIlCXGpLLZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517200898"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 22:58:22 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRqLW-0006Ja-6E; Thu, 01 Apr 2021 05:58:22 +0000
Date:   Thu, 01 Apr 2021 13:57:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 0a0b5f4b43671f8f128eb438edacee0a1d113385
Message-ID: <606560cd.E6xM4r+K7gciVaWv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 0a0b5f4b43671f8f128eb438edacee0a1d113385  ARM: iop32x: disable N2100 PCI parity reporting

elapsed time: 722m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nios2                         3c120_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
m68k                        m5307c3_defconfig
mips                            gpr_defconfig
mips                        nlm_xlp_defconfig
powerpc                      tqm8xx_defconfig
arm                           corgi_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        fsp2_defconfig
arm                             ezx_defconfig
powerpc                 mpc837x_mds_defconfig
h8300                            allyesconfig
powerpc                   bluestone_defconfig
sh                         microdev_defconfig
sh                          rsk7269_defconfig
powerpc64                           defconfig
arm                   milbeaut_m10v_defconfig
sh                              ul2_defconfig
arm                         orion5x_defconfig
m68k                       m5208evb_defconfig
mips                         cobalt_defconfig
m68k                        stmark2_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
sparc                       sparc64_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
sh                          rsk7203_defconfig
arc                         haps_hs_defconfig
mips                          ath79_defconfig
arm                  colibri_pxa300_defconfig
x86_64                           alldefconfig
sh                           se7619_defconfig
powerpc                       ebony_defconfig
powerpc                  mpc885_ads_defconfig
mips                           mtx1_defconfig
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       mainstone_defconfig
sh                         apsh4a3a_defconfig
mips                     loongson1c_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kilauea_defconfig
h8300                     edosk2674_defconfig
arc                      axs103_smp_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
arc                              allyesconfig
mips                        qi_lb60_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
mips                        workpad_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
sh                          sdk7786_defconfig
arc                        nsim_700_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
m68k                          hp300_defconfig
sh                           se7750_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
s390                             alldefconfig
mips                           gcw0_defconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson1b_defconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
arm                            dove_defconfig
m68k                       m5475evb_defconfig
arm                       aspeed_g5_defconfig
arm                       versatile_defconfig
powerpc                      chrp32_defconfig
alpha                            alldefconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
sh                           sh2007_defconfig
arm                            zeus_defconfig
microblaze                          defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
mips                      malta_kvm_defconfig
arc                           tb10x_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
