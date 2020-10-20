Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0E2936F7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 10:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgJTIpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 04:45:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:34490 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389435AbgJTIph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 04:45:37 -0400
IronPort-SDR: 560gkOrOJTCPb43+O30oP+eZ4WZuX9JexQV+UITnCCn5Cb4JArR9iztLtw2WVwenl+IdvOuAk8
 4s0Is8X+NbEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="184802130"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="184802130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:45:36 -0700
IronPort-SDR: ORPhOITlYzviuvhGUGezGT3WcuBH4RNtfbXo3pjGJAHby+iyF1Ia9h04Olv9gsBWizCr0w9AaA
 SeM8KCefgI3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="422444617"
Received: from lkp-server02.sh.intel.com (HELO 5d721fc6b6d3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2020 01:45:35 -0700
Received: from kbuild by 5d721fc6b6d3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUnGx-00001c-2q; Tue, 20 Oct 2020 08:45:35 +0000
Date:   Tue, 20 Oct 2020 16:44:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 2b1568a6f12c0289662a2c564ca23aac475d4475
Message-ID: <5f8ea38a.NZUJq3L7ROiFhcil%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 2b1568a6f12c0289662a2c564ca23aac475d4475  Merge branch 'remotes/lorenzo/pci/xilinx'

elapsed time: 720m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
arm                     am200epdkit_defconfig
nios2                         3c120_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
xtensa                generic_kc705_defconfig
mips                           jazz_defconfig
arm                        multi_v5_defconfig
powerpc                        cell_defconfig
arm                              alldefconfig
powerpc                    socrates_defconfig
c6x                        evmc6678_defconfig
mips                     cu1000-neo_defconfig
arm                           spitz_defconfig
powerpc                     skiroot_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201019
i386                 randconfig-a005-20201019
i386                 randconfig-a001-20201019
i386                 randconfig-a003-20201019
i386                 randconfig-a004-20201019
i386                 randconfig-a002-20201019
x86_64               randconfig-a004-20201019
x86_64               randconfig-a002-20201019
x86_64               randconfig-a006-20201019
x86_64               randconfig-a003-20201019
x86_64               randconfig-a005-20201019
x86_64               randconfig-a001-20201019
i386                 randconfig-a015-20201019
i386                 randconfig-a013-20201019
i386                 randconfig-a016-20201019
i386                 randconfig-a012-20201019
i386                 randconfig-a011-20201019
i386                 randconfig-a014-20201019
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
x86_64               randconfig-a016-20201019
x86_64               randconfig-a015-20201019
x86_64               randconfig-a012-20201019
x86_64               randconfig-a013-20201019
x86_64               randconfig-a011-20201019
x86_64               randconfig-a014-20201019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
