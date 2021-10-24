Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF16438B6B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Oct 2021 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhJXSdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 14:33:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:24012 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhJXSdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Oct 2021 14:33:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229800554"
X-IronPort-AV: E=Sophos;i="5.87,178,1631602800"; 
   d="scan'208";a="229800554"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 11:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,178,1631602800"; 
   d="scan'208";a="663791806"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2021 11:31:23 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1meiHD-0000tn-2x; Sun, 24 Oct 2021 18:31:23 +0000
Date:   Mon, 25 Oct 2021 02:30:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/mt7621] BUILD SUCCESS
 370ea5aa50d66c6447300d23467cdd1efd0efa72
Message-ID: <6175a662.paZ6rMFHfflHUlhp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/mt7621
branch HEAD: 370ea5aa50d66c6447300d23467cdd1efd0efa72  MAINTAINERS: Add Sergio Paracuellos as MT7621 PCIe maintainer

elapsed time: 4401m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211022
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     sequoia_defconfig
arm                        magician_defconfig
xtensa                  cadence_csp_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
um                                  defconfig
arm                         orion5x_defconfig
parisc                              defconfig
m68k                          atari_defconfig
mips                        qi_lb60_defconfig
m68k                                defconfig
powerpc                     akebono_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211022
i386                 randconfig-a003-20211022
i386                 randconfig-a002-20211022
i386                 randconfig-a005-20211022
i386                 randconfig-a006-20211022
i386                 randconfig-a001-20211022
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
arc                  randconfig-r043-20211021
riscv                randconfig-r042-20211021
s390                 randconfig-r044-20211021
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
x86_64               randconfig-a013-20211022
x86_64               randconfig-a015-20211022
x86_64               randconfig-a011-20211022
x86_64               randconfig-a014-20211022
x86_64               randconfig-a016-20211022
x86_64               randconfig-a012-20211022
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
