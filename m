Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36E0232E99
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgG3IXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 04:23:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:9989 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3IXU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 04:23:20 -0400
IronPort-SDR: T+bxq+7tGudaSzOdaKeuuesKN8gU0QZM7OCJykhCD9dptUP47MkwPCDwTRHQey5bc2OPu6ChWY
 NtrVlSBMTvHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="213092650"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="213092650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:23:20 -0700
IronPort-SDR: vc5l45zg0uve14yZWyELWoGQDhP0k/nofEK4EvSxhKa9SE0vyd6XofDY+2ie3qECWm5ghsJPDZ
 oMsnvahJsEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="290806780"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2020 01:23:18 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k13qP-000015-UJ; Thu, 30 Jul 2020 08:23:17 +0000
Date:   Thu, 30 Jul 2020 16:23:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/switchtec] BUILD SUCCESS
 1ac14871844dc49d60b9ef6ae3511e797bb78a25
Message-ID: <5f22836f.w8c1n1Fpsf8qNq51%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/switchtec
branch HEAD: 1ac14871844dc49d60b9ef6ae3511e797bb78a25  PCI/switchtec: Add missing __iomem tag to fix sparse warnings

elapsed time: 727m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200729
i386                 randconfig-a004-20200729
i386                 randconfig-a005-20200729
i386                 randconfig-a002-20200729
i386                 randconfig-a006-20200729
i386                 randconfig-a001-20200729
x86_64               randconfig-a004-20200729
x86_64               randconfig-a005-20200729
x86_64               randconfig-a002-20200729
x86_64               randconfig-a006-20200729
x86_64               randconfig-a003-20200729
x86_64               randconfig-a001-20200729
i386                 randconfig-a016-20200729
i386                 randconfig-a012-20200729
i386                 randconfig-a013-20200729
i386                 randconfig-a014-20200729
i386                 randconfig-a011-20200729
i386                 randconfig-a015-20200729
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
