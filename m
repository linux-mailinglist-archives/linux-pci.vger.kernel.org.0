Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284173225A4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBWGEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 01:04:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:8611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhBWGEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Feb 2021 01:04:24 -0500
IronPort-SDR: s8/ouJuc5TkoxjeUUOjaFg0qZ5QszVJiT54jcMC2wncGAvk9xkAvN+dsrH+g8fx8aEJEYjSr/C
 ikUrlxZxlkxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="183995119"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="183995119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 22:03:43 -0800
IronPort-SDR: ALi73Ki0/zeX/wHn4OWqzGezQ1ccv/ZzcIvvETmPlAzGm/ufr3PioLTCqjJ/hiVOyuTJbC4/Rt
 DUhepXw9fDMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="583081732"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2021 22:03:42 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEQnN-0000wl-Au; Tue, 23 Feb 2021 06:03:41 +0000
Date:   Tue, 23 Feb 2021 14:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/aspm] BUILD SUCCESS
 d2bb2f9e1af66d70323abaadc3a51afff4538bc2
Message-ID: <60349aa1.1TPLnY+iJbt8dkv6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: d2bb2f9e1af66d70323abaadc3a51afff4538bc2  PCI/ASPM: Move LTR, ASPM L1SS save/restore into PCIe save/restore

elapsed time: 729m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
x86_64                           alldefconfig
mips                            gpr_defconfig
s390                                defconfig
powerpc                 mpc836x_mds_defconfig
alpha                            alldefconfig
powerpc                      ppc64e_defconfig
arm                           tegra_defconfig
powerpc                     ksi8560_defconfig
openrisc                    or1ksim_defconfig
sh                   sh7724_generic_defconfig
arc                      axs103_smp_defconfig
arm                       netwinder_defconfig
m68k                       bvme6000_defconfig
m68k                            mac_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
powerpc                        warp_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
powerpc                          allmodconfig
arm                       spear13xx_defconfig
sh                        sh7785lcr_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a016-20210222
i386                 randconfig-a015-20210222
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
