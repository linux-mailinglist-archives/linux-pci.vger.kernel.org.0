Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961AF21BD5B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGJTJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 15:09:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:60523 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJTJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 15:09:20 -0400
IronPort-SDR: ZrwLG37yC8O3Py9+SPSbsPV85vbfJoeFexfcYluMaLsgdmdcSVfwOD0P1lPBTj7HjbY1VJKNXV
 UXoWIe0fvr4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="209805667"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="209805667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 12:09:09 -0700
IronPort-SDR: HGKAZgKAyYrLTs1WqSs50vPpjZbJJwVG3D8YPA35c0eew3K+CMQNg5XHD0JrhXKOWDQFuUL03G
 qo/309pdFJmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="359216911"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2020 12:09:08 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtyOR-00010a-BK; Fri, 10 Jul 2020 19:09:07 +0000
Date:   Sat, 11 Jul 2020 03:08:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 2575b2f3ee711f4638e772e07a5146afcc704f30
Message-ID: <5f08bcb5.rrNsBamkmWTcndhf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 2575b2f3ee711f4638e772e07a5146afcc704f30  PCI: Move PCI_VENDOR_ID_REDHAT definition to pci_ids.h

elapsed time: 723m

configs tested: 110
configs skipped: 2

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
sh                      rts7751r2d1_defconfig
arm                          gemini_defconfig
sh                        edosk7760_defconfig
arm                      footbridge_defconfig
ia64                            zx1_defconfig
arm                        spear3xx_defconfig
mips                      pic32mzda_defconfig
arm                          iop32x_defconfig
powerpc                    mvme5100_defconfig
mips                        maltaup_defconfig
arm                            hisi_defconfig
mips                           ip32_defconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200710
i386                 randconfig-a005-20200710
i386                 randconfig-a006-20200710
i386                 randconfig-a002-20200710
i386                 randconfig-a003-20200710
i386                 randconfig-a004-20200710
x86_64               randconfig-a012-20200710
x86_64               randconfig-a011-20200710
x86_64               randconfig-a016-20200710
x86_64               randconfig-a014-20200710
x86_64               randconfig-a015-20200710
x86_64               randconfig-a013-20200710
i386                 randconfig-a016-20200710
i386                 randconfig-a015-20200710
i386                 randconfig-a011-20200710
i386                 randconfig-a012-20200710
i386                 randconfig-a013-20200710
i386                 randconfig-a014-20200710
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
