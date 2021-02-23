Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39E5322A29
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 13:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBWMBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 07:01:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:46873 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhBWL7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Feb 2021 06:59:13 -0500
IronPort-SDR: V5HHFdeOLzxqBzWHo/OV7yZ3qnDSH8aZi+mvSSGFyyTza7yuP7Ds8wC9kIlL4ee+njkgS5xLZW
 6e4iGy0/IzfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="246196228"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246196228"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 03:58:17 -0800
IronPort-SDR: 7yLHSx+PzhHPZGi8gjrowqtEXx9C1kLIo6juU5+II+qWm0DFBCh9w4HW2C6bU/0pK0tmnObS/N
 WqYBS93o3l/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="380459164"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2021 03:58:15 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEWKV-0001AO-5k; Tue, 23 Feb 2021 11:58:15 +0000
Date:   Tue, 23 Feb 2021 19:58:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 4cb431e82c251e2152d4ae5bcccd1513e64c1e6d
Message-ID: <6034edd1.bh3mINYQdRq+PZqj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 4cb431e82c251e2152d4ae5bcccd1513e64c1e6d  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 730m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
powerpc                   bluestone_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
powerpc                        cell_defconfig
mips                           ip22_defconfig
powerpc                 mpc8560_ads_defconfig
openrisc                            defconfig
sparc                       sparc64_defconfig
arc                           tb10x_defconfig
powerpc                     mpc512x_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
powerpc                     redwood_defconfig
arm                           sama5_defconfig
mips                      pistachio_defconfig
sh                              ul2_defconfig
arm                       mainstone_defconfig
arc                         haps_hs_defconfig
powerpc                      cm5200_defconfig
arm                            dove_defconfig
arm                      integrator_defconfig
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
s390                             allmodconfig
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
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a016-20210222
i386                 randconfig-a015-20210222
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
