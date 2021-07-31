Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD45C3DC710
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaRDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 13:03:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:18153 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaRDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 31 Jul 2021 13:03:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="210141735"
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="210141735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 10:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="582668789"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2021 10:03:39 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9sOg-000BLq-VR; Sat, 31 Jul 2021 17:03:38 +0000
Date:   Sun, 01 Aug 2021 01:02:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:wip/bjorn-vpd-v2] BUILD SUCCESS
 de2caa4c558fb5285a395703081c5a4b61b9d3dc
Message-ID: <61058233.GVaWqgV1KP0Krn2L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-vpd-v2
branch HEAD: de2caa4c558fb5285a395703081c5a4b61b9d3dc  PCI/VPD: Remove struct pci_vpd.flag

elapsed time: 1105m

configs tested: 115
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210730
xtensa                generic_kc705_defconfig
sh                               allmodconfig
sh                             espt_defconfig
powerpc                      katmai_defconfig
arm                        magician_defconfig
powerpc                 mpc8315_rdb_defconfig
parisc                           alldefconfig
sh                           se7751_defconfig
sh                           se7724_defconfig
powerpc                      bamboo_defconfig
powerpc                         wii_defconfig
mips                            e55_defconfig
nios2                         3c120_defconfig
powerpc                 mpc8540_ads_defconfig
mips                     loongson1b_defconfig
m68k                          amiga_defconfig
powerpc                        cell_defconfig
arm                       aspeed_g5_defconfig
powerpc                        warp_defconfig
mips                      pic32mzda_defconfig
mips                          malta_defconfig
h8300                            alldefconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210730
i386                 randconfig-a004-20210730
i386                 randconfig-a003-20210730
i386                 randconfig-a002-20210730
i386                 randconfig-a006-20210730
i386                 randconfig-a001-20210730
i386                 randconfig-a005-20210731
i386                 randconfig-a004-20210731
i386                 randconfig-a003-20210731
i386                 randconfig-a002-20210731
i386                 randconfig-a006-20210731
i386                 randconfig-a001-20210731
x86_64               randconfig-a015-20210730
x86_64               randconfig-a014-20210730
x86_64               randconfig-a013-20210730
x86_64               randconfig-a011-20210730
x86_64               randconfig-a012-20210730
x86_64               randconfig-a016-20210730
i386                 randconfig-a013-20210730
i386                 randconfig-a016-20210730
i386                 randconfig-a012-20210730
i386                 randconfig-a011-20210730
i386                 randconfig-a014-20210730
i386                 randconfig-a015-20210730
x86_64               randconfig-a001-20210731
x86_64               randconfig-a006-20210731
x86_64               randconfig-a005-20210731
x86_64               randconfig-a004-20210731
x86_64               randconfig-a002-20210731
x86_64               randconfig-a003-20210731
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210731
x86_64               randconfig-c001-20210730
x86_64               randconfig-a001-20210730
x86_64               randconfig-a006-20210730
x86_64               randconfig-a005-20210730
x86_64               randconfig-a004-20210730
x86_64               randconfig-a002-20210730
x86_64               randconfig-a003-20210730

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
