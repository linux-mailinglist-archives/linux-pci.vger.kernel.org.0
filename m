Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF12E24E3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 07:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLXGnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 01:43:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:35550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgLXGnD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Dec 2020 01:43:03 -0500
IronPort-SDR: cGuKEGOpUcxcfGkjrWbD03LlC8wTbe27yHEdYcwVHf+g/niRyrohsfFFSr0jihyOXMDNJ/XzYl
 kBR4Mcvmp/QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="163837535"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="163837535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 22:42:16 -0800
IronPort-SDR: HmodsxN3Fqtbrr0PbLGpLjwRDxkVUOZvHgwrpCasznzodju2EsPjUCBmpCsSOB1z2ymmewT877
 HXdTIh59xuuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="342545706"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Dec 2020 22:42:14 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ksKKE-0000nU-36; Thu, 24 Dec 2020 06:42:14 +0000
Date:   Thu, 24 Dec 2020 14:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/dwc] BUILD SUCCESS
 fd6c550169476df7b5f52162b52989eae0419495
Message-ID: <5fe43845.8gIFt2sxrzRRypLV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/dwc
branch HEAD: fd6c550169476df7b5f52162b52989eae0419495  PCI: dwc/tegra: Fix host link initialization

elapsed time: 724m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                             allnoconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
arm                            zeus_defconfig
nds32                               defconfig
sh                          landisk_defconfig
arc                    vdk_hs38_smp_defconfig
ia64                             allyesconfig
arm                        neponset_defconfig
parisc                              defconfig
c6x                                 defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
sh                               alldefconfig
powerpc                 mpc8560_ads_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                         mv78xx0_defconfig
arm                        trizeps4_defconfig
riscv                               defconfig
arm                          prima2_defconfig
sparc                            alldefconfig
mips                       bmips_be_defconfig
powerpc                mpc7448_hpc2_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_kvm_guest_defconfig
s390                          debug_defconfig
m68k                            q40_defconfig
mips                           mtx1_defconfig
sparc64                          alldefconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
xtensa                       common_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
mips                        nlm_xlp_defconfig
mips                         db1xxx_defconfig
sh                              ul2_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                              zx_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                       omap2plus_defconfig
ia64                        generic_defconfig
sparc                       sparc32_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
arm                             pxa_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
alpha                               defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
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
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
