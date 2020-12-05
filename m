Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EF2CFB37
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 13:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgLEL7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Dec 2020 06:59:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:24732 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgLELVe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Dec 2020 06:21:34 -0500
IronPort-SDR: nbTBG4hC9/0yhx+fdnGrMLU3yu1GydRXsPX3gxianOy+NxjjBxpddm5030g8JSUcIMmOlyrLqD
 jEC2vcpp6eog==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="160554339"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="160554339"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 03:20:44 -0800
IronPort-SDR: o2Pal4Ix2c+GJkfkwyv2tu1G1DAKdIVvxncFToYbu6N5lBo3iKRCE4cbJk7lrcanNv1YF0tLSr
 p/xLh/xE7yRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="366620526"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2020 03:20:43 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klVcI-0000H3-Qv; Sat, 05 Dec 2020 11:20:42 +0000
Date:   Sat, 05 Dec 2020 19:20:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/pm] BUILD SUCCESS
 9c2cc571f92500d2d0f4e70466c90ee8b2b440e6
Message-ID: <5fcb6cfa.2BFw9+hvqFMnFgqM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/pm
branch HEAD: 9c2cc571f92500d2d0f4e70466c90ee8b2b440e6  PCI/PM: Do not generate wakeup event when runtime resuming device

elapsed time: 723m

configs tested: 99
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
s390                                defconfig
sh                           se7721_defconfig
powerpc                   motionpro_defconfig
nds32                               defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                               defconfig
arm                        spear3xx_defconfig
arm                         at91_dt_defconfig
powerpc                       ebony_defconfig
mips                         tb0226_defconfig
m68k                            q40_defconfig
sparc64                             defconfig
s390                          debug_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
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
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
