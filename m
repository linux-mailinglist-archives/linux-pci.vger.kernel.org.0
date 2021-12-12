Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2014471923
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhLLHfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 02:35:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:25627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLLHfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Dec 2021 02:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639294504; x=1670830504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zY0yCALvW1fEjH/9m7ohuCl9i0+3NtoJiyUfAnS9IHw=;
  b=KzLyB6VYlZfEM4XjF/cQNygLSiqUHvRbyXM9SSVwrc3O35BT+SL0iCna
   2MFi0dzdkNyk4azqH/OFpPGrPL4YDxgZm22NEK3oNRGtVlZZ9l6GmtuqU
   7oztS4/1m8zy5YEPlgKTPnBLKjjnCSGC2vnYHcfnSVUn9BOWmOdJmnM6g
   qQEjXpFEg1kryxdEVAhkAEeGY4hdZ5zY6S0qxsDSYeK6rknb/m9Rd51pc
   OR1UnrVdtcwsMeLnf+0WSKgIE8g5bQ/7Gas9MS0aNEftUOB957kNgr1Sd
   yqekpRE3U8Q7fnnkAeVqBNQ1HcozHwKY2Fgd2D5OUXilGL9jUJCl/Dbg8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="299369451"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="299369451"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 23:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="464254855"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 23:35:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwJNs-0005Uz-UC; Sun, 12 Dec 2021 07:35:00 +0000
Date:   Sun, 12 Dec 2021 15:34:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 4121485d271bd730537f613ce041e7ea659606a7
Message-ID: <61b5a616.BCYzV2LkkPrlciiq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 4121485d271bd730537f613ce041e7ea659606a7  PCI: Sort Intel Device IDs by value

elapsed time: 771m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        mini2440_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
powerpc64                        alldefconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
arm                         s3c6400_defconfig
parisc                generic-64bit_defconfig
sparc                       sparc64_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     kmeter1_defconfig
mips                           gcw0_defconfig
sh                           se7712_defconfig
mips                 decstation_r4k_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20211212
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a001-20211212
i386                 randconfig-a002-20211212
i386                 randconfig-a005-20211212
i386                 randconfig-a003-20211212
i386                 randconfig-a006-20211212
i386                 randconfig-a004-20211212
x86_64               randconfig-a001-20211212
x86_64               randconfig-a002-20211212
x86_64               randconfig-a003-20211212
x86_64               randconfig-a004-20211212
x86_64               randconfig-a006-20211212
x86_64               randconfig-a005-20211212
arc                  randconfig-r043-20211212
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211212
x86_64               randconfig-a012-20211212
x86_64               randconfig-a013-20211212
x86_64               randconfig-a014-20211212
x86_64               randconfig-a015-20211212
x86_64               randconfig-a016-20211212
i386                 randconfig-a013-20211212
i386                 randconfig-a011-20211212
i386                 randconfig-a014-20211212
i386                 randconfig-a012-20211212
i386                 randconfig-a016-20211212
i386                 randconfig-a015-20211212
hexagon              randconfig-r045-20211212
s390                 randconfig-r044-20211212
hexagon              randconfig-r041-20211212
riscv                randconfig-r042-20211212

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
