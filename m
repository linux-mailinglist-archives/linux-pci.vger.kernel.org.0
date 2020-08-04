Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6568B23B2D9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgHDCtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 22:49:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:44388 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbgHDCtj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 22:49:39 -0400
IronPort-SDR: 7CJ1eIo2KUy6AzQWPuK6tpZlmyg9EgsnYtsPWFT7cX31uGc+aLD1p66vHrbzjM1dYQqlj0HzdS
 d1yX7k46ZTzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170326640"
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="170326640"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 19:49:38 -0700
IronPort-SDR: /DNJdKJ7ZOG9Cex3N+zBTZhD0mZ440z5AJmsDzpiyUZOIQPM1V1XYhOot56u8W3uz3MuwgyXyL
 lp3TPp6szG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="275653037"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2020 19:49:36 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2n1D-0000NK-Cd; Tue, 04 Aug 2020 02:49:35 +0000
Date:   Tue, 04 Aug 2020 10:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/irq-error] BUILD SUCCESS
 caecb05c800081c57907749f787f05f62011564e
Message-ID: <5f28cc83.NQywWI6/eiQ9eixQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/irq-error
branch HEAD: caecb05c800081c57907749f787f05f62011564e  PCI: Remove dev_err() when handing an error from platform_get_irq()

elapsed time: 724m

configs tested: 96
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                        generic_defconfig
m68k                       bvme6000_defconfig
arm                          pxa168_defconfig
h8300                     edosk2674_defconfig
arm                        shmobile_defconfig
c6x                                 defconfig
arm                            mmp2_defconfig
arm                         lubbock_defconfig
arc                     nsimosci_hs_defconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
nds32                             allnoconfig
powerpc                          alldefconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
mips                         db1xxx_defconfig
arm                        trizeps4_defconfig
parisc                           alldefconfig
mips                           ip32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
powerpc                             defconfig
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
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
