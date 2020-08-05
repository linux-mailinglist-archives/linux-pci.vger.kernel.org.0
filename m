Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33C23D258
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 22:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHEUL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 16:11:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:19699 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHEQ1l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:41 -0400
IronPort-SDR: Iye8yeWbA5rNWU48C2eq68Wcb/5flTKXebUMe8yqdJGtI1IEd0XTV53eaRoOhq5hiP1N6tsdLp
 yD/+QvJ9Mdbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="149984596"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="149984596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 07:30:24 -0700
IronPort-SDR: p6F84Wrmseb9K0wq4K9RRTeCbi36sJn5Rh9I2N2mPd7rtkWC2j/kUC1y0+8b1oGLlJ/Tgvhh3l
 y822P+/BmylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="292955514"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2020 07:30:22 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3KQw-0000o0-0n; Wed, 05 Aug 2020 14:30:22 +0000
Date:   Wed, 05 Aug 2020 22:29:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS a231039775c4b7cb6f73f2540ff5cfb6f5165e98
Message-ID: <5f2ac25f.dIok0vWVWMGre6A7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: a231039775c4b7cb6f73f2540ff5cfb6f5165e98  Merge branch 'pci/irq-error'

elapsed time: 720m

configs tested: 137
configs skipped: 15

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
arm                         hackkit_defconfig
mips                           mtx1_defconfig
mips                             allyesconfig
mips                 decstation_r4k_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
powerpc                       holly_defconfig
powerpc                     pq2fads_defconfig
c6x                                 defconfig
arm                           u8500_defconfig
sh                          r7780mp_defconfig
arm                        realview_defconfig
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
sh                          rsk7269_defconfig
arc                     haps_hs_smp_defconfig
arm                        mini2440_defconfig
powerpc                      pmac32_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
arc                      axs103_smp_defconfig
powerpc                    mvme5100_defconfig
mips                        bcm47xx_defconfig
c6x                         dsk6455_defconfig
powerpc                  storcenter_defconfig
m68k                       m5275evb_defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
arm                         orion5x_defconfig
m68k                             alldefconfig
arm                     am200epdkit_defconfig
arm                         nhk8815_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
sh                         apsh4a3a_defconfig
m68k                       m5249evb_defconfig
powerpc                      chrp32_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
sh                               j2_defconfig
mips                      bmips_stb_defconfig
xtensa                              defconfig
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
arm                         shannon_defconfig
arm                     davinci_all_defconfig
xtensa                generic_kc705_defconfig
arm                          moxart_defconfig
sh                           sh2007_defconfig
sh                           se7751_defconfig
powerpc                       ppc64_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
arm                             ezx_defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
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
