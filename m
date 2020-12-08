Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40332D2C5E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 14:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLHN41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 08:56:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:24358 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgLHN40 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 08:56:26 -0500
IronPort-SDR: WLAz+O3tjO9mSTRmqRXn1qctEvG5e8O0IKdwPF2M8tiR7Wxjy4UP1yo/tSGVfO648uzy/ixc7l
 WXj7GdiWwILQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161653597"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="161653597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 05:55:45 -0800
IronPort-SDR: RT5cQcqfEXmUkXPyZTJWpI/ic2YykKL1nm/f2bHs5TaP70R4p4AszkTn1mrhP6mFWBSri9KDW8
 R9S+ZAUVLTHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437376871"
Received: from lkp-server01.sh.intel.com (HELO c88bd47c8831) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2020 05:55:44 -0800
Received: from kbuild by c88bd47c8831 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmdSx-0000Fk-Vp; Tue, 08 Dec 2020 13:55:43 +0000
Date:   Tue, 08 Dec 2020 21:55:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 2f378db5c89464cc00adaa755b6c04a54230edf2
Message-ID: <5fcf85de.HGG7Sj1SsI2aW+sP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 2f378db5c89464cc00adaa755b6c04a54230edf2  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 723m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
sparc64                             defconfig
sparc                       sparc64_defconfig
arm                     am200epdkit_defconfig
mips                        nlm_xlr_defconfig
powerpc                      pmac32_defconfig
sh                     sh7710voipgw_defconfig
mips                      bmips_stb_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc44x_defconfig
powerpc                      tqm8xx_defconfig
csky                             alldefconfig
ia64                         bigsur_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
mips                         tb0219_defconfig
arc                                 defconfig
mips                           ip27_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
