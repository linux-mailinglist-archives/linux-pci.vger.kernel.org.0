Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298684792C2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 18:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhLQRX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 12:23:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:57000 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhLQRX1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 12:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639761807; x=1671297807;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F1bUaABxDpQakI3vVfCys7O8GLj/vLoJUp6/cAr6cNk=;
  b=YwL5mVyeSpD+b/ofKALGIR+9lpH3l5ADjv6p2tELytQFuO+3E7wCjsYT
   Vy/nWwKZRWeUwLvIJeIegnVug54RGeBuM6t9iKaqquPXKl7bSYZcpz1jQ
   mFp8HG2vZwdA2lAROxtAnFZ8W631Kq1J2U2oJq4jQTcaIe6x/+HKCh2VI
   FwG5Fke3F0+fahOERxf6iuSko7swHeCBQxCEWAMLFyI4Dk1icDG8/PQgn
   wj+LJrcrFgIE1X1qrSDQ0wBVhlKHU7ELbmOcfrKj0jOt3Ky2zt9nJX8QI
   MaiXZLfRoSgrqU6uOAp65YWG8PQQu2Pzc81XkdONGLF0hca+GtoWzpaPO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="220474984"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220474984"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 09:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="585634721"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2021 09:23:26 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myGx3-00051R-Lp; Fri, 17 Dec 2021 17:23:25 +0000
Date:   Sat, 18 Dec 2021 01:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver-cleanup] BUILD SUCCESS
 7683e4befa9c82392c4c37f121c1d2141fee7a67
Message-ID: <61bcc782.iSK7hSNme089TN+y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
branch HEAD: 7683e4befa9c82392c4c37f121c1d2141fee7a67  PCI: rcar: Replace device * with platform_device *

elapsed time: 726m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211216
m68k                       m5475evb_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
arm                      tct_hammer_defconfig
ia64                                defconfig
powerpc                      katmai_defconfig
sh                            migor_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
sparc                               defconfig
mips                        vocore2_defconfig
sh                   rts7751r2dplus_defconfig
nds32                             allnoconfig
mips                     loongson1b_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
sh                        dreamcast_defconfig
arm                           sunxi_defconfig
sh                           se7722_defconfig
mips                           mtx1_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         cm_x300_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         assabet_defconfig
arm                           h5000_defconfig
arm                           sama5_defconfig
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
parisc                generic-32bit_defconfig
arm                          ixp4xx_defconfig
arm                        oxnas_v6_defconfig
arm                       omap2plus_defconfig
arm                           u8500_defconfig
m68k                         amcore_defconfig
arm                      integrator_defconfig
s390                       zfcpdump_defconfig
arm                       imx_v4_v5_defconfig
arm                        mvebu_v5_defconfig
sparc64                             defconfig
mips                           ip32_defconfig
mips                            e55_defconfig
arm                         bcm2835_defconfig
arm                        mini2440_defconfig
arm                        mvebu_v7_defconfig
xtensa                       common_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
mips                        bcm63xx_defconfig
powerpc                      ppc44x_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
arm                         vf610m4_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
arm                  randconfig-c002-20211216
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211217
x86_64               randconfig-a005-20211217
x86_64               randconfig-a001-20211217
x86_64               randconfig-a002-20211217
x86_64               randconfig-a003-20211217
x86_64               randconfig-a004-20211217
x86_64               randconfig-a011-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
hexagon              randconfig-r041-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r045-20211217
hexagon              randconfig-r041-20211217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
