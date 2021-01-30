Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75CE3092D0
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhA3JBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 04:01:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:5067 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhA3FCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jan 2021 00:02:47 -0500
IronPort-SDR: aax8dim/AAs5HCfG7jDPoo5JG0aiS1hS8E1WUXgG7kp/Zt2+sFzZXvThwyA28b0eFZyJdCj2pe
 4x0aR0bvgD+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="177951125"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="177951125"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 21:01:46 -0800
IronPort-SDR: yNNNCweOPw+W5DWVEriQqkGKtMmxq9FREbE2oa8DDN46JJ5Ya6/uKlkC6lhfeaB9+qVLBJPBbD
 ZveqKb9R9h0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="574351528"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2021 21:01:45 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5iOG-0004IX-FB; Sat, 30 Jan 2021 05:01:44 +0000
Date:   Sat, 30 Jan 2021 13:01:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 92036125120b9afea79b9a7b8b516026257c2d82
Message-ID: <6014e81e.9iHo1kj4CAAqcnhU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 92036125120b9afea79b9a7b8b516026257c2d82  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 722m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          sdk7786_defconfig
nios2                         3c120_defconfig
arm                             rpc_defconfig
riscv                             allnoconfig
m68k                           sun3_defconfig
riscv                            allmodconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         lubbock_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v4_v5_defconfig
sh                          rsk7203_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
sh                           se7712_defconfig
c6x                        evmc6474_defconfig
m68k                         amcore_defconfig
powerpc                       holly_defconfig
c6x                              alldefconfig
arm                           viper_defconfig
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
nds32                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210129
x86_64               randconfig-a003-20210129
x86_64               randconfig-a001-20210129
x86_64               randconfig-a005-20210129
x86_64               randconfig-a006-20210129
x86_64               randconfig-a004-20210129
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
i386                 randconfig-a013-20210129
i386                 randconfig-a011-20210129
i386                 randconfig-a012-20210129
i386                 randconfig-a016-20210129
i386                 randconfig-a014-20210129
i386                 randconfig-a015-20210129
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
