Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A53DB620
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhG3JhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:37:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:48063 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238156AbhG3JhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:37:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="276841893"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="276841893"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 02:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="664774994"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2021 02:37:13 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9Ox6-0009rL-NG; Fri, 30 Jul 2021 09:37:12 +0000
Date:   Fri, 30 Jul 2021 17:37:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/virtualization] BUILD SUCCESS
 319e4c98dd7fe498a602d4cca260025af72ac702
Message-ID: <6103c845.UEZK6L5jOtlaryYE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: 319e4c98dd7fe498a602d4cca260025af72ac702  PCI: Add ACS quirk for NXP LX2160A and LX2162A

elapsed time: 723m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
i386                 randconfig-c001-20210730
sh                         microdev_defconfig
arm                         s5pv210_defconfig
arm                           spitz_defconfig
mips                        bcm47xx_defconfig
mips                      pistachio_defconfig
mips                     cu1830-neo_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8540_defconfig
arm                          collie_defconfig
mips                        nlm_xlp_defconfig
arm                      tct_hammer_defconfig
ia64                        generic_defconfig
i386                                defconfig
arm                         assabet_defconfig
sh                          rsk7269_defconfig
arm                     am200epdkit_defconfig
mips                  decstation_64_defconfig
arm                           viper_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         shannon_defconfig
powerpc                      mgcoge_defconfig
parisc                generic-32bit_defconfig
s390                             alldefconfig
xtensa                          iss_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210730
i386                 randconfig-a004-20210730
i386                 randconfig-a003-20210730
i386                 randconfig-a002-20210730
i386                 randconfig-a006-20210730
i386                 randconfig-a001-20210730
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
x86_64               randconfig-a016-20210729
x86_64               randconfig-a011-20210729
x86_64               randconfig-a014-20210729
x86_64               randconfig-a013-20210729
x86_64               randconfig-a012-20210729
x86_64               randconfig-a015-20210729
i386                 randconfig-a013-20210730
i386                 randconfig-a016-20210730
i386                 randconfig-a012-20210730
i386                 randconfig-a011-20210730
i386                 randconfig-a014-20210730
i386                 randconfig-a015-20210730
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210730
x86_64               randconfig-a001-20210730
x86_64               randconfig-a006-20210730
x86_64               randconfig-a005-20210730
x86_64               randconfig-a004-20210730
x86_64               randconfig-a002-20210730
x86_64               randconfig-a003-20210730
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
