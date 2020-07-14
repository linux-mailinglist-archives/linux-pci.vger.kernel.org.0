Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1A21EDF8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNKbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 06:31:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:26847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgGNKbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 06:31:39 -0400
IronPort-SDR: fq3tMexqCYybrrjGPWFhTH/u+knnDjeLsrVZOjNVXIZdU/hcilQm/UIij7zU3qgtQC+xenap0S
 UZyIaJwMC2eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="137001435"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="137001435"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 03:31:36 -0700
IronPort-SDR: w2zg3mH1S7ju+ARd1Fc+EoEicM0z2wQKr+kTsQRqExLOhWdty7FIXeytAmWSU5vwKfkP5+9BTd
 +KO1HshtvKEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="429719543"
Received: from lkp-server02.sh.intel.com (HELO 393d9bdf0d5c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2020 03:31:34 -0700
Received: from kbuild by 393d9bdf0d5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvIDm-00002t-8l; Tue, 14 Jul 2020 10:31:34 +0000
Date:   Tue, 14 Jul 2020 18:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 99b50be9d8ec9ef319cc7d5de07f4d405fac7764
Message-ID: <5f0d8976.5tsyGZj1oS1ciPYX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 99b50be9d8ec9ef319cc7d5de07f4d405fac7764  PCI: Treat "external-facing" devices themselves as internal

elapsed time: 4889m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
xtensa                           allyesconfig
sh                           se7712_defconfig
arm                     am200epdkit_defconfig
csky                             allyesconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
sh                        sh7757lcr_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
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
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200710
i386                 randconfig-a005-20200710
i386                 randconfig-a006-20200710
i386                 randconfig-a002-20200710
i386                 randconfig-a003-20200710
i386                 randconfig-a004-20200710
x86_64               randconfig-a012-20200712
x86_64               randconfig-a011-20200712
x86_64               randconfig-a016-20200712
x86_64               randconfig-a014-20200712
x86_64               randconfig-a015-20200712
x86_64               randconfig-a013-20200712
i386                 randconfig-a016-20200712
i386                 randconfig-a015-20200712
i386                 randconfig-a011-20200712
i386                 randconfig-a012-20200712
i386                 randconfig-a013-20200712
i386                 randconfig-a014-20200712
i386                 randconfig-a016-20200713
i386                 randconfig-a015-20200713
i386                 randconfig-a011-20200713
i386                 randconfig-a012-20200713
i386                 randconfig-a013-20200713
i386                 randconfig-a014-20200713
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
