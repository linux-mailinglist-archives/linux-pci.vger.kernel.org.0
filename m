Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB773D44A4
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 05:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhGXDHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 23:07:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:39329 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhGXDHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 23:07:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="208872706"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="208872706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 20:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="578268433"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2021 20:48:02 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m78du-0002sb-A5; Sat, 24 Jul 2021 03:48:02 +0000
Date:   Sat, 24 Jul 2021 11:47:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/vga] BUILD SUCCESS
 d3ff98e99536cd76e77696889600ee06fe5253b2
Message-ID: <60fb8d50.QCxbgaeuRCQ0HnWL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/vga
branch HEAD: d3ff98e99536cd76e77696889600ee06fe5253b2  PCI/VGA: Rework default VGA device selection

elapsed time: 1787m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210722
powerpc                      ep88xc_defconfig
powerpc                    mvme5100_defconfig
arm                     am200epdkit_defconfig
powerpc                   currituck_defconfig
mips                          ath79_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arc                           tb10x_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8540_ads_defconfig
sh                               j2_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          ixp4xx_defconfig
h8300                            allyesconfig
arm                          gemini_defconfig
microblaze                          defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
openrisc                  or1klitex_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
powerpc                 mpc85xx_cds_defconfig
arc                          axs101_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8555_defconfig
arm                       versatile_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7757lcr_defconfig
nds32                               defconfig
arm                            hisi_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
mips                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                   microwatt_defconfig
m68k                        mvme147_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210722
x86_64               randconfig-a006-20210722
x86_64               randconfig-a001-20210722
x86_64               randconfig-a005-20210722
x86_64               randconfig-a004-20210722
x86_64               randconfig-a002-20210722
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210723
i386                 randconfig-a013-20210723
i386                 randconfig-a012-20210723
i386                 randconfig-a011-20210723
i386                 randconfig-a014-20210723
i386                 randconfig-a015-20210723
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210723
x86_64               randconfig-b001-20210723
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723
x86_64               randconfig-a011-20210722
x86_64               randconfig-a016-20210722
x86_64               randconfig-a013-20210722
x86_64               randconfig-a014-20210722
x86_64               randconfig-a012-20210722
x86_64               randconfig-a015-20210722

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
