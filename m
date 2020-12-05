Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327582CF9FE
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 07:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLEGYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Dec 2020 01:24:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:40739 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgLEGYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Dec 2020 01:24:00 -0500
IronPort-SDR: l8flmcbzdD2VZHPDOOKVwssqChHCnhwstsMd+IF74Q9XwaYYuM8b3pdYInnZZLMOpf7Lcn+Yaa
 Z+J/K+INYlkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="169984764"
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="169984764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 22:23:15 -0800
IronPort-SDR: KsAVS6TqfXTyZF93u41cfI3DoS80NBJHipbbtsen006X0Tg+Cia5V8b5esvA0JSpdPVCAlT8MM
 /LL+Yq7FTd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="346826979"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2020 22:23:13 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klQyO-0000AB-Vi; Sat, 05 Dec 2020 06:23:12 +0000
Date:   Sat, 05 Dec 2020 14:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/msi] BUILD SUCCESS
 2053230af11dc651ee3024682df12668496adad2
Message-ID: <5fcb2720.UtylFX/0y2K6WBl8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/msi
branch HEAD: 2053230af11dc651ee3024682df12668496adad2  PCI/MSI: Set device flag indicating only 32-bit MSI support

elapsed time: 721m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      cm5200_defconfig
arm                          tango4_defconfig
mips                 decstation_r4k_defconfig
powerpc                     tqm8555_defconfig
sh                           se7721_defconfig
m68k                          amiga_defconfig
sh                          r7785rp_defconfig
sh                         microdev_defconfig
m68k                       m5275evb_defconfig
c6x                        evmc6457_defconfig
mips                     loongson1c_defconfig
powerpc                         wii_defconfig
mips                  decstation_64_defconfig
xtensa                  cadence_csp_defconfig
arm                         lpc18xx_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
mips                         tb0226_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
arm                        shmobile_defconfig
arm                          pcm027_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
arm                         vf610m4_defconfig
powerpc                   motionpro_defconfig
nds32                               defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
arc                         haps_hs_defconfig
arm                           spitz_defconfig
arm                          exynos_defconfig
powerpc                     redwood_defconfig
powerpc                          g5_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         s3c2410_defconfig
openrisc                    or1ksim_defconfig
arm                         at91_dt_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
arm                           sama5_defconfig
powerpc                 mpc8560_ads_defconfig
ia64                        generic_defconfig
arm                           omap1_defconfig
arm                        mini2440_defconfig
m68k                            q40_defconfig
sparc64                             defconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
m68k                       bvme6000_defconfig
arm                        keystone_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
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
x86_64               randconfig-a004-20201205
x86_64               randconfig-a006-20201205
x86_64               randconfig-a002-20201205
x86_64               randconfig-a001-20201205
x86_64               randconfig-a005-20201205
x86_64               randconfig-a003-20201205
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
