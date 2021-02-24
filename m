Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA86F3239D5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhBXJsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 04:48:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:45359 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhBXJrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Feb 2021 04:47:49 -0500
IronPort-SDR: Xa9owsU7GmLccn5Q2amBG9b1OjsMlfcLP6ZiyMH0abUdsaRdIjk6wDT1DVBmN+xBkdaTWZrfGw
 dlK+wZlr0+Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="185165066"
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="scan'208";a="185165066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 01:46:05 -0800
IronPort-SDR: XkmQOr5gCRQ+jImUQ5TnQGAOEvMjDyIORIEYIZp0qELyZ656kGCKHt2uIJ2reQWm4LgjXwrPpS
 YZHXe01uD+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="scan'208";a="431562530"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2021 01:46:03 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEqk6-0001wq-Lg; Wed, 24 Feb 2021 09:46:02 +0000
Date:   Wed, 24 Feb 2021 17:45:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/dwc] BUILD SUCCESS
 718466bbe763599995452cdb5d6ba9ff2e954cb6
Message-ID: <6036202d.ZSzpfrZzdwl4JyqK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/dwc
branch HEAD: 718466bbe763599995452cdb5d6ba9ff2e954cb6  PCI: dwc: Add upper limit address for outbound iATU

elapsed time: 727m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         ap325rxa_defconfig
m68k                       m5475evb_defconfig
arm                            pleb_defconfig
sh                     sh7710voipgw_defconfig
powerpc                  iss476-smp_defconfig
mips                             allyesconfig
arm                   milbeaut_m10v_defconfig
arm                        vexpress_defconfig
sh                           sh2007_defconfig
powerpc                     kmeter1_defconfig
arm                          collie_defconfig
nds32                            alldefconfig
powerpc                      chrp32_defconfig
sh                          landisk_defconfig
arc                                 defconfig
arm                      tct_hammer_defconfig
arm                          pcm027_defconfig
arm                           sama5_defconfig
nds32                               defconfig
m68k                       m5275evb_defconfig
sh                           se7619_defconfig
microblaze                      mmu_defconfig
m68k                             allyesconfig
arm                           omap1_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1c_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
powerpc                      pasemi_defconfig
sh                           se7751_defconfig
mips                           xway_defconfig
csky                             alldefconfig
powerpc                   currituck_defconfig
mips                         tb0226_defconfig
arm64                            alldefconfig
mips                    maltaup_xpa_defconfig
arm                            hisi_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
sh                          lboxre2_defconfig
mips                        workpad_defconfig
sh                           se7712_defconfig
arm                       netwinder_defconfig
mips                        vocore2_defconfig
powerpc                      makalu_defconfig
arm                            zeus_defconfig
parisc                generic-32bit_defconfig
openrisc                    or1ksim_defconfig
sh                     magicpanelr2_defconfig
arm                      footbridge_defconfig
powerpc                     sequoia_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
riscv                          rv32_defconfig
mips                      maltaaprp_defconfig
powerpc                   lite5200b_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                         mpc30x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
