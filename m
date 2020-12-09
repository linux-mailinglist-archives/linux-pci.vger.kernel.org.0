Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA72D3F63
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgLIJ7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 04:59:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:60898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgLIJ7C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 04:59:02 -0500
IronPort-SDR: Pj2vNBTlyfw2w73DHgMbdLw6KSsTD475Dab+DjPdca4A0kUlMP7qiYBzprT+il+J+Vq2iuxOIL
 yU5QClXF9FEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="235649173"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="235649173"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 01:58:08 -0800
IronPort-SDR: ZFOQawTSN+Kz9FwSEECJjkhtis6Un6LGYTAd8UdmnJLkHFTpQOpKK7ZtmU/mFVHoa/yDfcskfK
 4h3Nav6y1CJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="407992430"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2020 01:58:07 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmwEZ-0000DY-0w; Wed, 09 Dec 2020 09:58:07 +0000
Date:   Wed, 09 Dec 2020 17:57:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 171bbcf1e05f0ce5e7ae0a6313c2e2ebee2aad63
Message-ID: <5fd09f91.J0jQ3EVbSCaDFt8P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 171bbcf1e05f0ce5e7ae0a6313c2e2ebee2aad63  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 720m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                        warp_defconfig
sh                          lboxre2_defconfig
sh                         apsh4a3a_defconfig
x86_64                           alldefconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
sh                           se7751_defconfig
arm                            lart_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7721_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
mips                  decstation_64_defconfig
powerpc                      mgcoge_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
sh                           se7724_defconfig
powerpc64                           defconfig
arm                           omap1_defconfig
h8300                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
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
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
