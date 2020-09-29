Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46027C294
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI2Ko0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:44:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:16751 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2Ko0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:44:26 -0400
IronPort-SDR: OrZYy4951uvd3ycIQKCNjrna30EPx2fOt8HCO2+/NHdTItO7mr7wikZ6c7av/EO6K1YBIEB4tv
 bTBgpBFQBgMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159537489"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="159537489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 03:44:24 -0700
IronPort-SDR: RcVbk+A6GkSbuOgufKvykoEprNVwsF8qV1uYTvWfR0ujXEnZlXetGKgk9qnlR5+6l3cO73/AWJ
 8j9bMJSEf1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="345221151"
Received: from lkp-server02.sh.intel.com (HELO dda5aa0886d8) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2020 03:44:22 -0700
Received: from kbuild by dda5aa0886d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kND7N-00008h-Rf; Tue, 29 Sep 2020 10:44:21 +0000
Date:   Tue, 29 Sep 2020 18:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 84023a61014848f69609cc826ce28ed874bbb69e
Message-ID: <5f730fd6.iXbjqwQlDNBCe+p1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 84023a61014848f69609cc826ce28ed874bbb69e  x86/xen: Fix xen_msi_init() missing prototype warning

elapsed time: 721m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      integrator_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                   lite5200b_defconfig
arm                         assabet_defconfig
m68k                        m5272c3_defconfig
riscv                            allmodconfig
arm                        shmobile_defconfig
sh                   secureedge5410_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
m68k                            mac_defconfig
mips                      malta_kvm_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
m68k                          multi_defconfig
arm                          pxa3xx_defconfig
sh                           se7712_defconfig
mips                     loongson1c_defconfig
arm                      footbridge_defconfig
arc                             nps_defconfig
arm                         bcm2835_defconfig
mips                           xway_defconfig
ia64                            zx1_defconfig
arm                          pxa910_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
powerpc                      pmac32_defconfig
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
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
