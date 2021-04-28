Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4436D65F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhD1LV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 07:21:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:64445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhD1LV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 07:21:57 -0400
IronPort-SDR: JdqNleVW7gqLAYwkZ7ZPdGGR0wVN31kyXtmTEfuMD41hFptA+gSj0j48a8Jx8bRlAb89d+uQIz
 5z7eZTFxoRgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="260666878"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="260666878"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 04:21:12 -0700
IronPort-SDR: VPars68cSrjFs1uGRk/X9DftFyjER69Rf6lr1nX5YkQ59rxJoeJ+S73AZDO/Of0BIeC2iz8kV6
 TnJ9uVLrj+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="465867628"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2021 04:21:11 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbiFi-00075G-JJ; Wed, 28 Apr 2021 11:21:10 +0000
Date:   Wed, 28 Apr 2021 19:20:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/sysfs] BUILD SUCCESS
 c3404cbf15d93a8be70994b4241c55afca5cd364
Message-ID: <60894509.kZdyLOXw281X2YZc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/sysfs
branch HEAD: c3404cbf15d93a8be70994b4241c55afca5cd364  PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions

elapsed time: 724m

configs tested: 119
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
riscv                            allyesconfig
arm                         cm_x300_defconfig
m68k                       m5208evb_defconfig
sh                           se7712_defconfig
powerpc64                        alldefconfig
riscv                          rv32_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
csky                                defconfig
arm                         lpc32xx_defconfig
sh                           se7343_defconfig
powerpc                    mvme5100_defconfig
arm                         axm55xx_defconfig
ia64                         bigsur_defconfig
mips                            e55_defconfig
arm                           viper_defconfig
mips                      maltasmvp_defconfig
arm                        multi_v7_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
sh                        sh7757lcr_defconfig
arm                           corgi_defconfig
powerpc                    socrates_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7619_defconfig
arm                       aspeed_g4_defconfig
m68k                        mvme16x_defconfig
arc                                 defconfig
parisc                           alldefconfig
sh                          sdk7780_defconfig
mips                         tb0226_defconfig
arm                         orion5x_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pmac32_defconfig
sh                     magicpanelr2_defconfig
powerpc                      pasemi_defconfig
um                             i386_defconfig
um                               alldefconfig
sh                   rts7751r2dplus_defconfig
powerpc                     asp8347_defconfig
mips                   sb1250_swarm_defconfig
arm                         nhk8815_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
