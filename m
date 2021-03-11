Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11610336FFD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 11:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhCKK2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 05:28:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:38551 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhCKK1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 05:27:46 -0500
IronPort-SDR: D62zh3i6tCRK4hd2W3w8otpyPOauBz8Uj42wPJMjjp1/r6dTUMc9hv1D996Mc16WX+uLLqZHLH
 ygZVnpfarfaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="250011979"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="250011979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 02:27:45 -0800
IronPort-SDR: j72GOYeVpj8Jo6CYMlhTfksUr6k0DhKxAIgfvAilHafYCkSNoYOlPZZqo7uK8Vjc6cMOHtKJ9w
 r1WpUd05XZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="521049302"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2021 02:27:44 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKIXf-0000jS-Pc; Thu, 11 Mar 2021 10:27:43 +0000
Date:   Thu, 11 Mar 2021 18:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/error] BUILD SUCCESS
 d9b7eae8e3424c3480fe9f40ebafbb0c96426e4c
Message-ID: <6049f096.kX9hC2jhxLRmqGrQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/error
branch HEAD: d9b7eae8e3424c3480fe9f40ebafbb0c96426e4c  PCI/RCEC: Fix RCiEP device to RCEC association

elapsed time: 725m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arm                         lubbock_defconfig
m68k                       bvme6000_defconfig
arc                          axs103_defconfig
m68k                             allmodconfig
sh                        dreamcast_defconfig
mips                           ip22_defconfig
mips                        bcm63xx_defconfig
sh                     magicpanelr2_defconfig
arm                       imx_v4_v5_defconfig
csky                                defconfig
arm                         s5pv210_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8548_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
xtensa                  cadence_csp_defconfig
sh                        edosk7705_defconfig
openrisc                  or1klitex_defconfig
arm                           sama5_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc8540_ads_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
x86_64                              defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
