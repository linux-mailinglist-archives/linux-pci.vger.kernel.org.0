Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400E2C3F2F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKYLhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 06:37:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:3649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgKYLhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 06:37:53 -0500
IronPort-SDR: AvHommXP5tmJjNUzadlWzRRdBiVrJbXz9Wnens+7t6zidEDfpqlRSY9N04gQCUsMgbI755oqTo
 sPiTycrH4/iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159884064"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="159884064"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 03:37:51 -0800
IronPort-SDR: 9ajKVQhqWmSTxckQHwBW+GK6M/LueCSszePm3es6+JsEe6iO1b87pwY9t+taBBV0swQLads6x/
 fABUBTlhj0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="312918781"
Received: from lkp-server01.sh.intel.com (HELO f59a693d3a73) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2020 03:37:50 -0800
Received: from kbuild by f59a693d3a73 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kht7N-00005C-Kr; Wed, 25 Nov 2020 11:37:49 +0000
Date:   Wed, 25 Nov 2020 19:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 cb72fddc79a6a48bb6305ffff9ef5e4f26a73357
Message-ID: <5fbe41f2.ui4rUPCtQ1YSLe1v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: cb72fddc79a6a48bb6305ffff9ef5e4f26a73357  x86/PCI: Convert force_disable_hpet() to standard quirk

elapsed time: 728m

configs tested: 160
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
m68k                       m5475evb_defconfig
mips                           jazz_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
powerpc                     kmeter1_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                  colibri_pxa270_defconfig
arm                          ixp4xx_defconfig
arm                           corgi_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                               allmodconfig
powerpc                     ep8248e_defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                           sama5_defconfig
mips                          rm200_defconfig
powerpc                  iss476-smp_defconfig
arc                        vdk_hs38_defconfig
mips                         db1xxx_defconfig
arm                          prima2_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
sh                           se7721_defconfig
mips                      maltaaprp_defconfig
arm                         nhk8815_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                     sh7710voipgw_defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
mips                            ar7_defconfig
sh                            titan_defconfig
powerpc                     mpc83xx_defconfig
powerpc                          allmodconfig
m68k                        stmark2_defconfig
m68k                         apollo_defconfig
mips                           rs90_defconfig
nios2                               defconfig
riscv                               defconfig
arm                            pleb_defconfig
x86_64                           alldefconfig
arm                        neponset_defconfig
sh                            migor_defconfig
s390                                defconfig
sh                          rsk7203_defconfig
arm                        mvebu_v7_defconfig
mips                 decstation_r4k_defconfig
parisc                           alldefconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
arm                            qcom_defconfig
arc                            hsdk_defconfig
m68k                       m5275evb_defconfig
arm                        multi_v5_defconfig
sh                           se7780_defconfig
mips                  cavium_octeon_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         mv78xx0_defconfig
mips                      maltasmvp_defconfig
m68k                                defconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
powerpc                        fsp2_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
h8300                            alldefconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
mips                           ip27_defconfig
powerpc                     mpc512x_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201124
i386                 randconfig-a013-20201124
i386                 randconfig-a011-20201124
i386                 randconfig-a016-20201124
i386                 randconfig-a014-20201124
i386                 randconfig-a015-20201124
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
