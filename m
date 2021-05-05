Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC3373612
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEEIME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 04:12:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:64627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhEEIMD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 04:12:03 -0400
IronPort-SDR: Hv7CBVwPVXV/EJPceK89w76b0YD2wlYFdOpboObPlkOXR5rHQZEj7OHdr6P4ZeOAI6vzlgmfQp
 dmMMyZA5fOVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="185289148"
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="185289148"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 01:11:06 -0700
IronPort-SDR: BJIo4jYfUR9MRPiNGIvigFJoAD39qXkT74v8UgBs/Jgntfebxrj1gZKPZdI/le4NvmLxMI7E5d
 C7i3wKDNqyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="390240537"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2021 01:11:05 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leCcb-0009ta-2d; Wed, 05 May 2021 08:11:05 +0000
Date:   Wed, 05 May 2021 16:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 882862aaacefcb9f723b0f7817ddafc154465d8f
Message-ID: <609252ff.DMP7Pkopyf6zcP9d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 882862aaacefcb9f723b0f7817ddafc154465d8f  Merge branch 'pci/tegra'

elapsed time: 725m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sparc                       sparc32_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                      makalu_defconfig
mips                            ar7_defconfig
powerpc                     asp8347_defconfig
sparc64                          alldefconfig
mips                            e55_defconfig
mips                        vocore2_defconfig
powerpc                        icon_defconfig
arm                            zeus_defconfig
sh                          landisk_defconfig
powerpc                      mgcoge_defconfig
arm                           h3600_defconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
sh                           sh2007_defconfig
powerpc                     powernv_defconfig
arm                           sama5_defconfig
arm                           spitz_defconfig
m68k                        m5272c3_defconfig
powerpc                        cell_defconfig
arm                       imx_v6_v7_defconfig
powerpc                    mvme5100_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
m68k                            q40_defconfig
powerpc                     sbc8548_defconfig
arm                         s5pv210_defconfig
arm                         lpc32xx_defconfig
arm                          pcm027_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     ppa8548_defconfig
arm                       imx_v4_v5_defconfig
arm                      footbridge_defconfig
riscv                             allnoconfig
powerpc                     mpc83xx_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_mds_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210504
i386                 randconfig-a006-20210504
i386                 randconfig-a001-20210504
i386                 randconfig-a005-20210504
i386                 randconfig-a004-20210504
i386                 randconfig-a002-20210504
x86_64               randconfig-a014-20210504
x86_64               randconfig-a015-20210504
x86_64               randconfig-a012-20210504
x86_64               randconfig-a013-20210504
x86_64               randconfig-a011-20210504
x86_64               randconfig-a016-20210504
i386                 randconfig-a015-20210504
i386                 randconfig-a013-20210504
i386                 randconfig-a016-20210504
i386                 randconfig-a014-20210504
i386                 randconfig-a012-20210504
i386                 randconfig-a011-20210504
i386                 randconfig-a013-20210503
i386                 randconfig-a015-20210503
i386                 randconfig-a016-20210503
i386                 randconfig-a014-20210503
i386                 randconfig-a011-20210503
i386                 randconfig-a012-20210503
x86_64               randconfig-a001-20210503
x86_64               randconfig-a005-20210503
x86_64               randconfig-a003-20210503
x86_64               randconfig-a002-20210503
x86_64               randconfig-a006-20210503
x86_64               randconfig-a004-20210503
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210504
x86_64               randconfig-a003-20210504
x86_64               randconfig-a005-20210504
x86_64               randconfig-a002-20210504
x86_64               randconfig-a006-20210504
x86_64               randconfig-a004-20210504

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
