Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A240DC4E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhIPOGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 10:06:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:14880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhIPOGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 10:06:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308113409"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="308113409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 07:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="698873740"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2021 07:04:47 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQs0N-00016g-45; Thu, 16 Sep 2021 14:04:47 +0000
Date:   Thu, 16 Sep 2021 22:03:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/virtualization] BUILD SUCCESS
 aae89a54f6d2fbe350b3641582ef411a8af71f12
Message-ID: <61434ece.6bkcb4AALMUhsH7J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: aae89a54f6d2fbe350b3641582ef411a8af71f12  PCI: Add ACS quirk for Pericom PI7C9X2G switches

elapsed time: 1712m

configs tested: 56
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20210915
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
riscv                randconfig-r042-20210915
hexagon              randconfig-r045-20210915
s390                 randconfig-r044-20210915
hexagon              randconfig-r041-20210915

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
