Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8A25B7A5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgICAf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 20:35:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:40853 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgICAf4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 20:35:56 -0400
IronPort-SDR: Xq5GO3K0Az7nrkVUnLqI3rXsiAG0JCy+0xli1a9XtH+WXTu6L0TO3OfCUdeegM49I/vKig0F6u
 Fmra8Z+O33mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154901418"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="154901418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 17:35:55 -0700
IronPort-SDR: 6FCE0fX+qVA1ICldmJG1EhzFRIjtIQZh2gHSR4m9e2i9oLGurZqVS3/eMMrFdhgxNO5Kn7M1q6
 gOL+z9HtCooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="283912076"
Received: from lkp-server02.sh.intel.com (HELO eb469fda2af7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2020 17:35:54 -0700
Received: from kbuild by eb469fda2af7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDdEI-0000Ji-3F; Thu, 03 Sep 2020 00:35:54 +0000
Date:   Thu, 03 Sep 2020 08:35:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 88f66c6817809ce9705efe376b65b93fdbdb7f35
Message-ID: <5f503a47.TRKAqysXjCv6xS3L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 88f66c6817809ce9705efe376b65b93fdbdb7f35  Merge branch 'pci/pm'

elapsed time: 721m

configs tested: 137
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           alldefconfig
xtensa                    xip_kc705_defconfig
nios2                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                         s5pv210_defconfig
m68k                        mvme147_defconfig
openrisc                 simple_smp_defconfig
arm                             pxa_defconfig
xtensa                generic_kc705_defconfig
arm                         bcm2835_defconfig
x86_64                              defconfig
m68k                            mac_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
mips                          rb532_defconfig
sh                            hp6xx_defconfig
arm                           h5000_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
mips                           ip28_defconfig
openrisc                         alldefconfig
arm                          iop32x_defconfig
sh                        sh7785lcr_defconfig
i386                             allyesconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
mips                      loongson3_defconfig
powerpc                      tqm8xx_defconfig
c6x                              alldefconfig
sh                         ecovec24_defconfig
arm                          collie_defconfig
m68k                          multi_defconfig
mips                        workpad_defconfig
c6x                        evmc6457_defconfig
mips                          rm200_defconfig
h8300                            alldefconfig
sh                      rts7751r2d1_defconfig
mips                     cu1830-neo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc885_ads_defconfig
mips                      pic32mzda_defconfig
mips                       capcella_defconfig
alpha                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200902
i386                 randconfig-a005-20200902
i386                 randconfig-a006-20200902
i386                 randconfig-a002-20200902
i386                 randconfig-a001-20200902
i386                 randconfig-a003-20200902
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
x86_64               randconfig-a013-20200902
x86_64               randconfig-a016-20200902
x86_64               randconfig-a011-20200902
x86_64               randconfig-a012-20200902
x86_64               randconfig-a015-20200902
x86_64               randconfig-a014-20200902
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903
x86_64               randconfig-a013-20200901

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
