Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED02C797F
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2OHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 09:07:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:64544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2OHw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Nov 2020 09:07:52 -0500
IronPort-SDR: mIdKUWbJL2TrDj2CN1CEHo2f/p4gJEXdjzjmfsvlgbUfcYh55EVHBQpwQr+56d4hBML9ZzKtXM
 b3C1gzN07Wzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="151787337"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="151787337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 06:07:10 -0800
IronPort-SDR: WdDkHio/hbamSa5Q55XNyRU+UdmERkFCe4jgvZ2x/oWlWNtFTzsjUKYh+PW4cK6kXLTr3E+ZYz
 8LlN9qGPNGcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="548721962"
Received: from lkp-server01.sh.intel.com (HELO 3082e074203f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2020 06:07:08 -0800
Received: from kbuild by 3082e074203f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kjNM4-00006z-9z; Sun, 29 Nov 2020 14:07:08 +0000
Date:   Sun, 29 Nov 2020 22:06:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:wip/osc] BUILD SUCCESS
 d52af95c186dcb81afc0700fbd4d508f979f9dbc
Message-ID: <5fc3aaea.aGvhBWyRStbwpYtL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  wip/osc
branch HEAD: d52af95c186dcb81afc0700fbd4d508f979f9dbc  PCI/portdrv: Reorder native PCIe feature testing

elapsed time: 725m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                        evmc6472_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
powerpc                      makalu_defconfig
riscv                    nommu_k210_defconfig
arm                             mxs_defconfig
riscv                    nommu_virt_defconfig
ia64                            zx1_defconfig
sh                   rts7751r2dplus_defconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
arm                         axm55xx_defconfig
sh                          rsk7269_defconfig
arm                        shmobile_defconfig
powerpc                    socrates_defconfig
sh                             sh03_defconfig
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
i386                 randconfig-a004-20201129
i386                 randconfig-a003-20201129
i386                 randconfig-a002-20201129
i386                 randconfig-a005-20201129
i386                 randconfig-a001-20201129
i386                 randconfig-a006-20201129
x86_64               randconfig-a015-20201129
x86_64               randconfig-a011-20201129
x86_64               randconfig-a016-20201129
x86_64               randconfig-a014-20201129
x86_64               randconfig-a012-20201129
x86_64               randconfig-a013-20201129
i386                 randconfig-a012-20201129
i386                 randconfig-a013-20201129
i386                 randconfig-a011-20201129
i386                 randconfig-a016-20201129
i386                 randconfig-a014-20201129
i386                 randconfig-a015-20201129
riscv                            allyesconfig
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
x86_64               randconfig-a003-20201129
x86_64               randconfig-a006-20201129
x86_64               randconfig-a004-20201129
x86_64               randconfig-a005-20201129
x86_64               randconfig-a002-20201129
x86_64               randconfig-a001-20201129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
