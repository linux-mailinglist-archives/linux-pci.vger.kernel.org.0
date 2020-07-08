Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81B9218517
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgGHKgz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 06:36:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:22864 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgGHKgz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 06:36:55 -0400
IronPort-SDR: 9lRnk4MGcyv+dIvif1AkwprIoXabXarDtCpn9+6OJZMgC5mse5Qb99c90M2c9M5e9bulqC7TAz
 RxEFn23UdRfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146840814"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="146840814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 03:36:54 -0700
IronPort-SDR: VYNyVKIjVjmZLrUQpWhYQED7APt9Cb7/ffy8RxN4aFBWuUo7KpAqC+92JnuTZthcwR9cEOlbri
 OEaSBhNlGx8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="322906906"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2020 03:36:53 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jt7Rc-00003q-Oa; Wed, 08 Jul 2020 10:36:52 +0000
Date:   Wed, 08 Jul 2020 18:36:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/error] BUILD SUCCESS
 16d79cd4e23b1964d36c041ab027505ceacbbeeb
Message-ID: <5f05a198.pddGYu6mKjIuCKGP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/error
branch HEAD: 16d79cd4e23b1964d36c041ab027505ceacbbeeb  PCI: Use 'pci_channel_state_t' instead of 'enum pci_channel_state'

elapsed time: 722m

configs tested: 98
configs skipped: 1

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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
i386                 randconfig-a001-20200707
i386                 randconfig-a002-20200707
i386                 randconfig-a006-20200707
i386                 randconfig-a004-20200707
i386                 randconfig-a005-20200707
i386                 randconfig-a003-20200707
x86_64               randconfig-a012-20200707
x86_64               randconfig-a016-20200707
x86_64               randconfig-a014-20200707
x86_64               randconfig-a011-20200707
x86_64               randconfig-a015-20200707
x86_64               randconfig-a013-20200707
i386                 randconfig-a011-20200707
i386                 randconfig-a014-20200707
i386                 randconfig-a015-20200707
i386                 randconfig-a016-20200707
i386                 randconfig-a012-20200707
i386                 randconfig-a013-20200707
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
