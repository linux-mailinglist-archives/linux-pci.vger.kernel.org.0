Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405CF15B7D3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 04:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgBMDe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 22:34:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:54627 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729515AbgBMDe6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 22:34:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 19:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="228015876"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2020 19:34:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j25HC-0006XB-Bx; Thu, 13 Feb 2020 11:34:54 +0800
Date:   Thu, 13 Feb 2020 11:34:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/hotplug] BUILD REGRESSION
 c4e85e3f147644d222f7d2da21a812f8ff3b7cbc
Message-ID: <5e44c3ca.8RJIqACJZHoHqRvC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/hotplug
branch HEAD: c4e85e3f147644d222f7d2da21a812f8ff3b7cbc  PCI: pciehp: Add DMI table for in-band presence disabled

Regressions in current branch:

drivers/pci/hotplug/pciehp.h:40:2: note: in expansion of macro 'pci_info'
drivers/pci/hotplug/pciehp_hpc.c:268:12: error: 'ctrl' undeclared (first use in this function); did you mean 'to_ctrl'?
drivers/pci/hotplug/pciehp_hpc.c:268:2: note: in expansion of macro 'ctrl_info'
drivers/pci/hotplug/pciehp_hpc.c:287:12: error: 'ctrl' undeclared (first use in this function); did you mean 'to_ctrl'?
drivers/pci/hotplug/pciehp_hpc.c:287:2: note: in expansion of macro 'ctrl_info'

Error ids grouped by kconfigs:

recent_errors
|-- alpha-randconfig-a001-20200213
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- arm-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- arm-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- arm64-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- arm64-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- i386-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- i386-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- i386-randconfig-d003-20200211
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- i386-randconfig-e001-20200212
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- i386-randconfig-g002-20200213
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- ia64-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- ia64-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- ia64-randconfig-a001-20200212
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- mips-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- mips-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- parisc-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- riscv-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- riscv-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- s390-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- s390-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- sparc-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- sparc64-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- sparc64-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- sparc64-randconfig-a001-20200211
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-allmodconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-allyesconfig
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-fedora-25
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-lkp
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-a002-20200212
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-b001-20200212
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-c002-20200213
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-e002-20200213
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-f002-20200213
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-randconfig-g001-20200211
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-rhel
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
|-- x86_64-rhel-7.2-clear
|   |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
|   |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
|   `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info
`-- x86_64-rhel-7.6
    |-- drivers-pci-hotplug-pciehp.h:note:in-expansion-of-macro-pci_info
    |-- drivers-pci-hotplug-pciehp_hpc.c:error:ctrl-undeclared-(first-use-in-this-function)-did-you-mean-to_ctrl
    `-- drivers-pci-hotplug-pciehp_hpc.c:note:in-expansion-of-macro-ctrl_info

elapsed time: 2885m

configs tested: 286
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
riscv                               defconfig
s390                          debug_defconfig
s390                                defconfig
um                                  defconfig
alpha                               defconfig
powerpc                           allnoconfig
c6x                              allyesconfig
microblaze                      mmu_defconfig
i386                                defconfig
openrisc                 simple_smp_defconfig
parisc                            allnoconfig
m68k                           sun3_defconfig
ia64                                defconfig
i386                             alldefconfig
parisc                              defconfig
ia64                             allyesconfig
s390                             allyesconfig
ia64                             alldefconfig
nds32                               defconfig
powerpc                       ppc64_defconfig
s390                             alldefconfig
mips                              allnoconfig
microblaze                    nommu_defconfig
nios2                         10m50_defconfig
i386                             allyesconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
i386                 randconfig-a003-20200211
x86_64               randconfig-a001-20200213
x86_64               randconfig-a002-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
i386                 randconfig-a002-20200213
i386                 randconfig-a003-20200213
x86_64               randconfig-a001-20200212
x86_64               randconfig-a002-20200212
x86_64               randconfig-a003-20200212
i386                 randconfig-a001-20200212
i386                 randconfig-a002-20200212
i386                 randconfig-a003-20200212
riscv                randconfig-a001-20200211
parisc               randconfig-a001-20200211
m68k                 randconfig-a001-20200211
nds32                randconfig-a001-20200211
alpha                randconfig-a001-20200211
alpha                randconfig-a001-20200212
m68k                 randconfig-a001-20200212
nds32                randconfig-a001-20200212
parisc               randconfig-a001-20200212
riscv                randconfig-a001-20200212
alpha                randconfig-a001-20200213
m68k                 randconfig-a001-20200213
mips                 randconfig-a001-20200213
nds32                randconfig-a001-20200213
parisc               randconfig-a001-20200213
riscv                randconfig-a001-20200213
c6x                  randconfig-a001-20200212
h8300                randconfig-a001-20200212
microblaze           randconfig-a001-20200212
nios2                randconfig-a001-20200212
sparc64              randconfig-a001-20200212
c6x                  randconfig-a001-20200213
h8300                randconfig-a001-20200213
microblaze           randconfig-a001-20200213
nios2                randconfig-a001-20200213
sparc64              randconfig-a001-20200213
h8300                randconfig-a001-20200211
nios2                randconfig-a001-20200211
microblaze           randconfig-a001-20200211
sparc64              randconfig-a001-20200211
c6x                  randconfig-a001-20200211
sh                   randconfig-a001-20200211
s390                 randconfig-a001-20200211
xtensa               randconfig-a001-20200211
openrisc             randconfig-a001-20200211
csky                 randconfig-a001-20200211
csky                 randconfig-a001-20200212
openrisc             randconfig-a001-20200212
s390                 randconfig-a001-20200212
sh                   randconfig-a001-20200212
xtensa               randconfig-a001-20200212
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
x86_64               randconfig-b001-20200212
x86_64               randconfig-b002-20200212
x86_64               randconfig-b003-20200212
i386                 randconfig-b001-20200212
i386                 randconfig-b002-20200212
i386                 randconfig-b003-20200212
x86_64               randconfig-b001-20200213
x86_64               randconfig-b002-20200213
x86_64               randconfig-b003-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b002-20200213
i386                 randconfig-b003-20200213
x86_64               randconfig-b001-20200211
x86_64               randconfig-b002-20200211
x86_64               randconfig-b003-20200211
i386                 randconfig-b001-20200211
i386                 randconfig-b002-20200211
i386                 randconfig-b003-20200211
x86_64               randconfig-c001-20200211
x86_64               randconfig-c002-20200211
x86_64               randconfig-c003-20200211
i386                 randconfig-c001-20200211
i386                 randconfig-c002-20200211
i386                 randconfig-c003-20200211
x86_64               randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
i386                 randconfig-c002-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-c001-20200212
x86_64               randconfig-c002-20200212
x86_64               randconfig-c003-20200212
i386                 randconfig-c001-20200212
i386                 randconfig-c002-20200212
i386                 randconfig-c003-20200212
x86_64               randconfig-d003-20200211
x86_64               randconfig-d001-20200211
i386                 randconfig-d003-20200211
x86_64               randconfig-d002-20200211
i386                 randconfig-d001-20200211
i386                 randconfig-d002-20200211
x86_64               randconfig-d001-20200212
x86_64               randconfig-d002-20200212
x86_64               randconfig-d003-20200212
i386                 randconfig-d001-20200212
i386                 randconfig-d002-20200212
i386                 randconfig-d003-20200212
x86_64               randconfig-e001-20200212
x86_64               randconfig-e002-20200212
x86_64               randconfig-e003-20200212
i386                 randconfig-e001-20200212
i386                 randconfig-e002-20200212
i386                 randconfig-e003-20200212
x86_64               randconfig-e001-20200213
x86_64               randconfig-e002-20200213
x86_64               randconfig-e003-20200213
i386                 randconfig-e001-20200213
i386                 randconfig-e002-20200213
i386                 randconfig-e003-20200213
i386                 randconfig-f001-20200211
x86_64               randconfig-f002-20200211
i386                 randconfig-f002-20200211
x86_64               randconfig-f001-20200211
x86_64               randconfig-f003-20200211
i386                 randconfig-f003-20200211
x86_64               randconfig-f001-20200212
x86_64               randconfig-f002-20200212
x86_64               randconfig-f003-20200212
i386                 randconfig-f001-20200212
i386                 randconfig-f002-20200212
i386                 randconfig-f003-20200212
x86_64               randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f001-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
x86_64               randconfig-g001-20200212
x86_64               randconfig-g002-20200212
x86_64               randconfig-g003-20200212
i386                 randconfig-g001-20200212
i386                 randconfig-g002-20200212
i386                 randconfig-g003-20200212
x86_64               randconfig-g001-20200211
x86_64               randconfig-g002-20200211
x86_64               randconfig-g003-20200211
i386                 randconfig-g001-20200211
i386                 randconfig-g002-20200211
i386                 randconfig-g003-20200211
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-h001-20200211
x86_64               randconfig-h002-20200211
x86_64               randconfig-h003-20200211
i386                 randconfig-h001-20200211
i386                 randconfig-h002-20200211
i386                 randconfig-h003-20200211
x86_64               randconfig-h001-20200212
x86_64               randconfig-h002-20200212
x86_64               randconfig-h003-20200212
i386                 randconfig-h001-20200212
i386                 randconfig-h002-20200212
i386                 randconfig-h003-20200212
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200211
arm                  randconfig-a001-20200211
arm64                randconfig-a001-20200211
ia64                 randconfig-a001-20200211
powerpc              randconfig-a001-20200211
sparc                randconfig-a001-20200211
arc                  randconfig-a001-20200212
arm                  randconfig-a001-20200212
arm64                randconfig-a001-20200212
ia64                 randconfig-a001-20200212
powerpc              randconfig-a001-20200212
sparc                randconfig-a001-20200212
arc                  randconfig-a001-20200213
arm                  randconfig-a001-20200213
arm64                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
powerpc              randconfig-a001-20200213
sparc                randconfig-a001-20200213
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
