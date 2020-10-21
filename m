Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF755294818
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411601AbgJUGXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 02:23:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:14086 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408726AbgJUGXT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 02:23:19 -0400
IronPort-SDR: e/GIvqDl1cY+ArzhrKE1qyeKgu9BmbgJL0xfqceOVeRFSarfKdYWECTxtMDri3WEJ5WN3CBUHb
 3yxJEiTQnmmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="166544177"
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="166544177"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 23:23:19 -0700
IronPort-SDR: O7crgid4mdoPjJRBKjx/739NG+3aHg9/UD51f6MM7JrPwF2kpcxIQTPOxr+DWj2Tr8K9EAYYD5
 7paFfkG3Hfsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="348176507"
Received: from lkp-server01.sh.intel.com (HELO 2c14ddb8ab9c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2020 23:23:18 -0700
Received: from kbuild by 2c14ddb8ab9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kV7Wn-00000M-Fl; Wed, 21 Oct 2020 06:23:17 +0000
Date:   Wed, 21 Oct 2020 14:22:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 065c21a8f8a466bf640ca46f8f7c07f119a9bc26
Message-ID: <5f8fd3a2.RH08J+K5Jc0BR1tB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 065c21a8f8a466bf640ca46f8f7c07f119a9bc26  Merge branch 'remotes/lorenzo/pci/xilinx'

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
arm                         ebsa110_defconfig
powerpc                      obs600_defconfig
arm                      tct_hammer_defconfig
sh                   secureedge5410_defconfig
sparc                            alldefconfig
mips                       bmips_be_defconfig
arm                        spear3xx_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
arm                       mainstone_defconfig
mips                  decstation_64_defconfig
mips                         cobalt_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a002-20201020
i386                 randconfig-a005-20201020
i386                 randconfig-a003-20201020
i386                 randconfig-a001-20201020
i386                 randconfig-a006-20201020
i386                 randconfig-a004-20201020
x86_64               randconfig-a011-20201020
x86_64               randconfig-a013-20201020
x86_64               randconfig-a016-20201020
x86_64               randconfig-a015-20201020
x86_64               randconfig-a012-20201020
x86_64               randconfig-a014-20201020
i386                 randconfig-a016-20201020
i386                 randconfig-a014-20201020
i386                 randconfig-a015-20201020
i386                 randconfig-a013-20201020
i386                 randconfig-a012-20201020
i386                 randconfig-a011-20201020
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
x86_64               randconfig-a001-20201020
x86_64               randconfig-a002-20201020
x86_64               randconfig-a003-20201020
x86_64               randconfig-a006-20201020
x86_64               randconfig-a005-20201020
x86_64               randconfig-a004-20201020

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
