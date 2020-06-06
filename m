Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1F1F049F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 06:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFFEUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Jun 2020 00:20:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:37090 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFFEUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 Jun 2020 00:20:53 -0400
IronPort-SDR: 5ngWmA1Ri53Rx/VnMa3lHb9J4ec7Fj5lhe+TFfVSXpkY+uaQRbEUym36/kxdZ17BQtWbpq1jRc
 tIeGp5rL9JyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 21:20:52 -0700
IronPort-SDR: QRzfbOqzhPTLEM+aYCZDS7rh92QX3rvOkSvEZm5ysyTuNz4c4RSMPZ/9UrTQyyzm4gh+S225Xc
 huSQef4HNjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="273670603"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2020 21:20:51 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhQKA-0000UV-V9; Sat, 06 Jun 2020 04:20:50 +0000
Date:   Sat, 06 Jun 2020 12:20:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:v5.8-merge] BUILD SUCCESS
 d1446bebeef8c96ce327bf8d4f91f8f67de40829
Message-ID: <5edb197f.cf9e2hq2kEN3QMLk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  v5.8-merge
branch HEAD: d1446bebeef8c96ce327bf8d4f91f8f67de40829  Merge branch 'next' into v5.8-merge

elapsed time: 483m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
xtensa                              defconfig
powerpc                        cell_defconfig
m68k                       m5475evb_defconfig
nios2                         10m50_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme147_defconfig
arm                          imote2_defconfig
powerpc                          allyesconfig
powerpc                     mpc5200_defconfig
arc                        vdk_hs38_defconfig
sh                           se7724_defconfig
powerpc                     mpc512x_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                         tb0287_defconfig
ia64                        generic_defconfig
arc                             nps_defconfig
s390                             alldefconfig
h8300                               defconfig
i386                              allnoconfig
sh                          urquell_defconfig
arc                     haps_hs_smp_defconfig
arm                          ep93xx_defconfig
c6x                               allnoconfig
sh                           cayman_defconfig
powerpc                      mgcoge_defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
um                           x86_64_defconfig
xtensa                           alldefconfig
arm                        neponset_defconfig
arm                          collie_defconfig
arm                      footbridge_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         lpc32xx_defconfig
mips                          ath79_defconfig
mips                     loongson1c_defconfig
arm                        magician_defconfig
arm                          pxa910_defconfig
arc                     nsimosci_hs_defconfig
alpha                            alldefconfig
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
mips                      pistachio_defconfig
powerpc                      pmac32_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nios2                            allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allmodconfig
h8300                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
