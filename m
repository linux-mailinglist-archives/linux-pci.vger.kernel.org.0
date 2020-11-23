Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFF2BFEB5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 04:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKWDZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Nov 2020 22:25:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:24145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKWDZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 22 Nov 2020 22:25:02 -0500
IronPort-SDR: +tTj/2bvhK3hsGGR60AKsG/3GRh9jL9A6PcU/1JB6AY6TOuA/TwTuZsCBjCFUolOCbPsfTPTX3
 ss0G1zADsV4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="150956915"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="150956915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 19:25:01 -0800
IronPort-SDR: isw2LaYFvKfJQ56P+WETGtXr6/wPDLbONUw7uA5FLAybZmWJvqnC7jZhR17XCLYAqhBjattcSc
 YdJBfN1slk2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="364508208"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2020 19:25:00 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kh2TL-0000Pj-Vc; Mon, 23 Nov 2020 03:24:59 +0000
Date:   Mon, 23 Nov 2020 11:24:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 0848f8cfe9943a0b852843dfd4143c9608ec000c
Message-ID: <5fbb2b55.VG/pmB+39IJmIbw8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 0848f8cfe9943a0b852843dfd4143c9608ec000c  PCI: Fix overflow in command-line resource alignment requests

elapsed time: 724m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
sh                          landisk_defconfig
powerpc                     asp8347_defconfig
m68k                           sun3_defconfig
arm                          lpd270_defconfig
um                           x86_64_defconfig
mips                     loongson1b_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
arm                              zx_defconfig
sparc                            alldefconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
powerpc                     ep8248e_defconfig
mips                           xway_defconfig
sparc64                             defconfig
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
x86_64               randconfig-a006-20201122
x86_64               randconfig-a003-20201122
x86_64               randconfig-a004-20201122
x86_64               randconfig-a005-20201122
x86_64               randconfig-a001-20201122
x86_64               randconfig-a002-20201122
i386                 randconfig-a004-20201122
i386                 randconfig-a003-20201122
i386                 randconfig-a002-20201122
i386                 randconfig-a005-20201122
i386                 randconfig-a001-20201122
i386                 randconfig-a006-20201122
i386                 randconfig-a012-20201122
i386                 randconfig-a013-20201122
i386                 randconfig-a011-20201122
i386                 randconfig-a016-20201122
i386                 randconfig-a014-20201122
i386                 randconfig-a015-20201122
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
x86_64               randconfig-a015-20201122
x86_64               randconfig-a011-20201122
x86_64               randconfig-a014-20201122
x86_64               randconfig-a016-20201122
x86_64               randconfig-a012-20201122
x86_64               randconfig-a013-20201122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
