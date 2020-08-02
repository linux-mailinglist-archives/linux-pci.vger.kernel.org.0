Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F712355A2
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgHBGKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 02:10:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:64401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgHBGKs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Aug 2020 02:10:48 -0400
IronPort-SDR: VzvBw5Q12wgep2XSgrNC4TmDDC1lp21a/d92cn3UHUR/RykcBuBMO35KXC/CmZ3phEG4dmHZMY
 GZQTSntyhDpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="170083045"
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="170083045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 23:10:47 -0700
IronPort-SDR: w4J6n2i2S1k+uUO8jZm5g1tydFwrLIlz/VroM7MLobu8ZWy3rRjoi3mBAQvVTx3k27QFZFUqXi
 jKhHZKqaJuZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="331562338"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2020 23:10:46 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k27Cn-0001X8-Aq; Sun, 02 Aug 2020 06:10:45 +0000
Date:   Sun, 02 Aug 2020 14:09:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD REGRESSION
 d189141dc9d45bf2bcc7d990d105eed99237ac33
Message-ID: <5f2658b4.KNFK0dVpQicPR9Q7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: d189141dc9d45bf2bcc7d990d105eed99237ac33  Merge branch 'pci/doc'

Error/Warning in current branch:

drivers/pci/controller/pcie-xilinx-cpm.c:553:8: error: implicit declaration of function 'pci_parse_request_of_pci_ranges' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- arm-allmodconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- arm-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- arm64-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- i386-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- ia64-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- mips-allmodconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- mips-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- powerpc-allmodconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- powerpc-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- s390-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- sparc-allyesconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
|-- x86_64-allmodconfig
|   `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges
`-- xtensa-allyesconfig
    `-- drivers-pci-controller-pcie-xilinx-cpm.c:error:implicit-declaration-of-function-pci_parse_request_of_pci_ranges

elapsed time: 1861m

configs tested: 83
configs skipped: 4

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                            q40_defconfig
riscv                    nommu_virt_defconfig
powerpc                     mpc512x_defconfig
mips                 decstation_r4k_defconfig
xtensa                    xip_kc705_defconfig
arm                       versatile_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a006-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a005-20200802
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
