Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BBF23EB95
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHGKfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 06:35:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:36823 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgHGKfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 06:35:07 -0400
IronPort-SDR: Jr7eGnvYjBNX56yKpmq/4Bc/w6+vhWd5MMkLbTBQ/2Vq3nb7RPDGZnyebx2OUEktSGqtzpSASz
 kUN03DsWMS/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="237900195"
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="237900195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 03:35:07 -0700
IronPort-SDR: zZRCbQbEE/p5bFozEcs1iaHU5Xgifesxst4KTtNORDuGaG8ktjaI3oQFFMhifM4iB10ZDznFaT
 UdvDv0Z4xXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="397546842"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2020 03:35:06 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3ziL-0000BX-E4; Fri, 07 Aug 2020 10:35:05 +0000
Date:   Fri, 07 Aug 2020 18:34:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:v5.9-merge] BUILD SUCCESS
 a616f02d6e64fc3643e46cb893a51a8561beb496
Message-ID: <5f2d2e32.LVA38zcsaFXhlb5w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  v5.9-merge
branch HEAD: a616f02d6e64fc3643e46cb893a51a8561beb496  Merge branch 'next' into v5.9-merge

elapsed time: 723m

configs tested: 114
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
sh                          polaris_defconfig
microblaze                      mmu_defconfig
powerpc64                           defconfig
mips                 pnx8335_stb225_defconfig
arm                       aspeed_g5_defconfig
mips                      bmips_stb_defconfig
powerpc                    amigaone_defconfig
sh                           se7712_defconfig
arc                           tb10x_defconfig
sh                           se7780_defconfig
mips                   sb1250_swarm_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
sh                        dreamcast_defconfig
m68k                       m5249evb_defconfig
alpha                               defconfig
mips                     loongson1b_defconfig
sh                         apsh4a3a_defconfig
s390                          debug_defconfig
powerpc                     powernv_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
mips                            gpr_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
arm                        keystone_defconfig
arm                          collie_defconfig
m68k                       m5475evb_defconfig
powerpc                    mvme5100_defconfig
riscv                            alldefconfig
sh                          sdk7786_defconfig
mips                       bmips_be_defconfig
sh                           se7722_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200806
x86_64               randconfig-a001-20200806
x86_64               randconfig-a004-20200806
x86_64               randconfig-a005-20200806
x86_64               randconfig-a003-20200806
x86_64               randconfig-a002-20200806
i386                 randconfig-a005-20200806
i386                 randconfig-a004-20200806
i386                 randconfig-a001-20200806
i386                 randconfig-a002-20200806
i386                 randconfig-a003-20200806
i386                 randconfig-a006-20200806
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
