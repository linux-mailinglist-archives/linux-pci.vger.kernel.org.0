Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81C92BC324
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 03:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgKVCVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 21:21:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:53709 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgKVCVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Nov 2020 21:21:23 -0500
IronPort-SDR: WbWodC1KA2u4RRvUWLJi71rJpvdabPEPsYowJYbhqd7X8QtSaUNsvu/mF27JmkuLpdZ7EFW3ky
 w+kr/mORTH0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="235767019"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="235767019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 18:21:22 -0800
IronPort-SDR: AsXskUrGkNhgLXm6rtdqrCVrLga6taE/Gdmsyq8qwzvM1hGVxU3G0JnKcCkl8w1q/nVxa79j7d
 MzYzVoQX3F0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="369626308"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2020 18:21:21 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgf0C-000012-Lr; Sun, 22 Nov 2020 02:21:20 +0000
Date:   Sun, 22 Nov 2020 10:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/err] BUILD SUCCESS
 4513f3a6cfb1e95fe3c108f007254729eedf309c
Message-ID: <5fb9caec.MvGDIfpuS2ebxud6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/err
branch HEAD: 4513f3a6cfb1e95fe3c108f007254729eedf309c  PCI/AER: Add RCEC AER error injection support

elapsed time: 720m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
sh                          polaris_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        spear3xx_defconfig
powerpc                       holly_defconfig
sh                           sh2007_defconfig
arm                      integrator_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  cadence_csp_defconfig
c6x                                 defconfig
sh                           se7750_defconfig
powerpc                      obs600_defconfig
mips                        maltaup_defconfig
i386                                defconfig
arm                           tegra_defconfig
xtensa                              defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201121
i386                 randconfig-a003-20201121
i386                 randconfig-a002-20201121
i386                 randconfig-a005-20201121
i386                 randconfig-a001-20201121
i386                 randconfig-a006-20201121
x86_64               randconfig-a015-20201121
x86_64               randconfig-a011-20201121
x86_64               randconfig-a014-20201121
x86_64               randconfig-a016-20201121
x86_64               randconfig-a012-20201121
x86_64               randconfig-a013-20201121
i386                 randconfig-a012-20201121
i386                 randconfig-a013-20201121
i386                 randconfig-a011-20201121
i386                 randconfig-a016-20201121
i386                 randconfig-a014-20201121
i386                 randconfig-a015-20201121
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
x86_64               randconfig-a006-20201121
x86_64               randconfig-a003-20201121
x86_64               randconfig-a004-20201121
x86_64               randconfig-a005-20201121
x86_64               randconfig-a002-20201121
x86_64               randconfig-a001-20201121

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
