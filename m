Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBB484866
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 20:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiADTSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 14:18:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:56324 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbiADTSX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 14:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641323903; x=1672859903;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OykDpQiTiQ9Kr141PENybO3IUq21uBNi131nzeMNxW4=;
  b=DV9Ezcdu6IohOsb2PTc3B00YhGCzfxuelme/DbuDJ2ZnB+O5tQWCjQss
   hdQAt5VQeSzffh3I3qx/6f9l2yPjxp3FwMXtpl7zqNVCT8e/P7ZKJvAeb
   qERD69rxZTpA93lwt/HHkF4ZjMjR+dNvF2HBBSyv+P9vIEaF9zwKtzZE4
   +3bR1jaO6XJ85v8ZcDg9s7DCa6D5qBA3fKKbFAJ+RJjCsBnn/gd0JynGX
   YdeXpkdVYZ/Z93+WXHQIut46jmP4OFlhpJC3wJlvuY6Nyagt6c79o2yTA
   7hQQG3bVE+Onf8O4sc8cJh5lcB9DrrXp39PgcJUhc+PnlQmRz/YHSMPu9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229100917"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229100917"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 11:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="470262809"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 11:18:06 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4pJu-000Fn8-7L; Tue, 04 Jan 2022 19:18:06 +0000
Date:   Wed, 05 Jan 2022 03:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver-cleanup] BUILD SUCCESS
 73a0c2be75cf777fa03eb86487dfbe7fbb88d8a2
Message-ID: <61d49d62.mESXScghbDFlJhDe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
branch HEAD: 73a0c2be75cf777fa03eb86487dfbe7fbb88d8a2  PCI: spear13xx: Avoid invalid address space conversions

elapsed time: 1104m

configs tested: 54
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
