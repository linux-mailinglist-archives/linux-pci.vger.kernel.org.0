Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5632048E9B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 13:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiANMK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 07:10:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:28310 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240964AbiANMKr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jan 2022 07:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642162247; x=1673698247;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1edDdgWPVf/HolQMn6ZircHZ8QwB7EBmEsqkhQuPTCg=;
  b=LnYTILk2NnIc9ifptzaf0Xd79Gy8VsFBFrnF6y/vTAWn4PGxjYcvq+Ql
   azLNU3u5iwKbh0lq8oSJPP521XOTZwdoe+uO8B0e2oNVvJ6E8FllqW0ZG
   TxZZWQ6fSVeQfN66rXrK1xA/DLL0kw0awChwnjPNJGhAyxRkKKoFHq79k
   X6HV4E0SwxbBFZJdzGEjRmGt2kMzyq9HzWH1632sQYHrgGqsh/5MDJOed
   VDCzvfPFJt6IxopcUBWqkSGSTxJnNU+uWwXMxxQRZT3zmeaPXqTDXZkud
   8MkEdWTm/Wyrf9+7laJRSWiqQdXhQMA35h/h4LwIwpmeTglHxb1J6Rm93
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244029837"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244029837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 04:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="692191321"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2022 04:10:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8LPo-0008VK-Ts; Fri, 14 Jan 2022 12:10:44 +0000
Date:   Fri, 14 Jan 2022 20:09:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/mt7621] BUILD SUCCESS
 44ddb791f8f41f5f9f2ab4280a27c179ca7a8aed
Message-ID: <61e16815.2keJbWD4gET3kYNk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/mt7621
branch HEAD: 44ddb791f8f41f5f9f2ab4280a27c179ca7a8aed  PCI: mt7621: Allow COMPILE_TEST for all arches

elapsed time: 2223m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                           viper_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7780_defconfig
sparc                       sparc32_defconfig
arm                       imx_v6_v7_defconfig
sh                           se7712_defconfig
powerpc                 mpc834x_mds_defconfig
arc                     nsimosci_hs_defconfig
mips                        jmr3927_defconfig
arm                             ezx_defconfig
s390                          debug_defconfig
arm                          badge4_defconfig
arm                        multi_v7_defconfig
powerpc                       ppc64_defconfig
sh                         microdev_defconfig
arm                  randconfig-c002-20220113
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
s390                 randconfig-c005-20220113
mips                 randconfig-c004-20220113
arm                  randconfig-c002-20220113
arm                         s5pv210_defconfig
powerpc                      acadia_defconfig
arm                         mv78xx0_defconfig
mips                           ip28_defconfig
arm                          pxa168_defconfig
powerpc                     akebono_defconfig
mips                           ip27_defconfig
powerpc                     pseries_defconfig
mips                      malta_kvm_defconfig
riscv                            alldefconfig
arm                        multi_v5_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
