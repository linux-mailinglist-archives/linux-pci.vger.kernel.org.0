Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9D263400
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgIIRMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 13:12:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:21863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgIIPcj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:39 -0400
IronPort-SDR: ely5vO4QadqE3HXRJmmrrBCkehEdn+bKEEi3BCCC9gShvIBVgbCSpUSxyYQnU+etvErdPbHurm
 acvye/RhaMlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="219905492"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="219905492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 08:13:15 -0700
IronPort-SDR: IuEnGuAzJv0C6oRVLNxl+IkyIcO3DVCYUVXQa+Io5XkgjDr4Ya/nsPVUKCT8AtkyDPSim7m8Ax
 F6JM139C1dJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="449231885"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2020 08:13:14 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kG1mb-0000Tp-RS; Wed, 09 Sep 2020 15:13:13 +0000
Date:   Wed, 09 Sep 2020 23:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 e338eecf3fe79054e8a31b8c39a1234b5acfdabe
Message-ID: <5f58f0e2.masS6cavl8YXivMU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: e338eecf3fe79054e8a31b8c39a1234b5acfdabe  PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()

elapsed time: 723m

configs tested: 136
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
sh                   sh7724_generic_defconfig
arm                          simpad_defconfig
c6x                              allyesconfig
arm                         shannon_defconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
arm                            lart_defconfig
parisc                generic-32bit_defconfig
mips                           ci20_defconfig
i386                             allyesconfig
c6x                        evmc6678_defconfig
arm                        vexpress_defconfig
c6x                        evmc6472_defconfig
m68k                       m5475evb_defconfig
mips                     decstation_defconfig
h8300                    h8300h-sim_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
arm                       spear13xx_defconfig
nds32                            alldefconfig
sh                          kfr2r09_defconfig
arm                        spear6xx_defconfig
mips                           xway_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlp_defconfig
mips                         tb0287_defconfig
riscv                            alldefconfig
m68k                         amcore_defconfig
arm                           h5000_defconfig
sh                          lboxre2_defconfig
sh                   secureedge5410_defconfig
um                            kunit_defconfig
sh                                  defconfig
arm                              zx_defconfig
arm                  colibri_pxa270_defconfig
arm                          pxa168_defconfig
mips                        workpad_defconfig
m68k                            mac_defconfig
arc                        nsimosci_defconfig
mips                         bigsur_defconfig
mips                      loongson3_defconfig
m68k                                defconfig
s390                                defconfig
mips                          rm200_defconfig
powerpc                          alldefconfig
sh                  sh7785lcr_32bit_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7264_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
mips                         rt305x_defconfig
arm                         s3c2410_defconfig
m68k                        stmark2_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
arm                      tct_hammer_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
sh                         apsh4a3a_defconfig
xtensa                generic_kc705_defconfig
sparc                               defconfig
arm                         s5pv210_defconfig
h8300                               defconfig
mips                malta_kvm_guest_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
xtensa                       common_defconfig
powerpc                          allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
