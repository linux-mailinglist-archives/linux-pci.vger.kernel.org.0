Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C648D09B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 04:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiAMDEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 22:04:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:64628 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231833AbiAMDEc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 22:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642043072; x=1673579072;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PHyeXUlXAzbJik1j1BfbKp1pPMJI3E6VA1o41vDpK4A=;
  b=eh9c8DbWgtyIEumKBPuZRu6846gF/HHO3FJGJ8aHuY1Wb3nFpmtK1gjY
   Es7F1SvjM2u9P7qYBGW2DJasxgpKTb+BJFtlLlyf8vV2emznQPqYkF53B
   P3xGp9BYyZ9sDpjILijuoL5AVgv2dF9ljpL2tlSukKMILAokLa/piwEs8
   1uQBeayNp8JVRCvhHzvfjbnwnFWCuRphVK4icBy/y1yogDIX1zfHzFpfv
   jLnKvudhP6EBoJyzkJwFKhm2DWAEsf4rsihaGDq/AcihIMx+m4P50DYHu
   7+WIIZEcsO87Bi4MNO2A6EarIxnoJFhzx0AVQ2mf7zLYr/ym+nd1YFfAG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244119741"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244119741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 19:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475150631"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2022 19:04:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7qPd-0006ll-Fu; Thu, 13 Jan 2022 03:04:29 +0000
Date:   Thu, 13 Jan 2022 11:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 085a9f43433f30cbe8a1ade62d9d7827c3217f4d
Message-ID: <61df96a0.gtdDgiIUDvxHgBfg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 085a9f43433f30cbe8a1ade62d9d7827c3217f4d  PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors

elapsed time: 733m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                       m5249evb_defconfig
h8300                               defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
mips                        vocore2_defconfig
xtensa                  nommu_kc705_defconfig
m68k                             alldefconfig
sh                          sdk7780_defconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
mips                  maltasmvp_eva_defconfig
arm                             pxa_defconfig
m68k                          atari_defconfig
powerpc                    klondike_defconfig
arm                           stm32_defconfig
powerpc                      bamboo_defconfig
csky                             alldefconfig
powerpc                 mpc834x_itx_defconfig
m68k                       bvme6000_defconfig
sh                        apsh4ad0a_defconfig
sh                              ul2_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
sh                          rsk7269_defconfig
um                           x86_64_defconfig
sh                               j2_defconfig
powerpc64                        alldefconfig
mips                     decstation_defconfig
powerpc                       holly_defconfig
csky                                defconfig
powerpc                        warp_defconfig
arc                          axs101_defconfig
sh                           sh2007_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      pasemi_defconfig
sh                          r7785rp_defconfig
arm                            hisi_defconfig
sh                           se7705_defconfig
arm                  randconfig-c002-20220112
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220112
x86_64                        randconfig-c007
riscv                randconfig-c006-20220112
powerpc              randconfig-c003-20220112
i386                          randconfig-c001
mips                 randconfig-c004-20220112
powerpc                     akebono_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          collie_defconfig
powerpc                  mpc866_ads_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
mips                        bcm63xx_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
hexagon              randconfig-r041-20220112

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
