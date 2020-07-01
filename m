Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770B12116CC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgGAXuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 19:50:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:22037 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgGAXuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 19:50:14 -0400
IronPort-SDR: 5BTCsgbEs+Mg5qOh1vChw4MkRJmIIvWFdiz2PuRx/HGBXfanKb+QDEBVe46agwa6l/2PZzOToW
 muNPrrTYU6oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148287406"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="148287406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 16:50:13 -0700
IronPort-SDR: sxMFvsZIiXUTPoTrrALUzEiQutW5dUChNamaTpM413bEvYrUMJ6QHBWfYyK9xbcrbovmSYuPFR
 J4Sho5zKHc0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="321909968"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2020 16:50:11 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqmUV-0003O7-1e; Wed, 01 Jul 2020 23:50:11 +0000
Date:   Thu, 02 Jul 2020 07:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS WITH WARNING
 9062dcba53dd1dcfa32e4c1970acdf33660a2cdf
Message-ID: <5efd20f4.MTXTYAc19/iS4W+h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 9062dcba53dd1dcfa32e4c1970acdf33660a2cdf  PCI: Fix locking of pci_cfg_wait queue

Warning in current branch:

drivers/pci/access.c:209:17: sparse: sparse: context imbalance in 'pci_wait_cfg' - unexpected unlock

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-s001-20200630
|   `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock
|-- i386-randconfig-s002-20200630
|   `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock
|-- powerpc-randconfig-s032-20200701
|   `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock
|-- sparc-randconfig-s032-20200630
|   `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock
|-- x86_64-randconfig-s021-20200630
|   `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock
`-- x86_64-randconfig-s022-20200630
    `-- drivers-pci-access.c:sparse:sparse:context-imbalance-in-pci_wait_cfg-unexpected-unlock

elapsed time: 2824m

configs tested: 98
configs skipped: 1

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
i386                              allnoconfig
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
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
i386                 randconfig-a001-20200630
i386                 randconfig-a003-20200630
i386                 randconfig-a002-20200630
i386                 randconfig-a004-20200630
i386                 randconfig-a005-20200630
i386                 randconfig-a006-20200630
i386                 randconfig-a011-20200630
i386                 randconfig-a016-20200630
i386                 randconfig-a015-20200630
i386                 randconfig-a012-20200630
i386                 randconfig-a014-20200630
i386                 randconfig-a013-20200630
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a014-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
