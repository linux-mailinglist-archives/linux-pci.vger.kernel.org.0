Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0583E2631
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbhHFIeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 04:34:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:11433 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242530AbhHFIeI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 04:34:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="214316244"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="214316244"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 01:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="523384518"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2021 01:33:48 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBvIa-000GgI-2f; Fri, 06 Aug 2021 08:33:48 +0000
Date:   Fri, 06 Aug 2021 16:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 89ba70faa33cd8e8e6054e3219568647ab91c251
Message-ID: <610cf3dd.+Upc+knx32q3DJJZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 89ba70faa33cd8e8e6054e3219568647ab91c251  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 724m

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
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                         wii_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
mips                         tb0219_defconfig
arm                       mainstone_defconfig
powerpc                     mpc512x_defconfig
um                                  defconfig
riscv                            allmodconfig
sh                      rts7751r2d1_defconfig
mips                     loongson2k_defconfig
arc                                 defconfig
m68k                       m5275evb_defconfig
arm                          imote2_defconfig
arm                            qcom_defconfig
mips                  maltasmvp_eva_defconfig
ia64                            zx1_defconfig
i386                             alldefconfig
sh                          sdk7780_defconfig
ia64                        generic_defconfig
arm                            hisi_defconfig
mips                         tb0226_defconfig
powerpc                     sequoia_defconfig
arm                      pxa255-idp_defconfig
powerpc                     taishan_defconfig
sh                          urquell_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     ep8248e_defconfig
x86_64                            allnoconfig
sh                         ecovec24_defconfig
parisc                           alldefconfig
m68k                         apollo_defconfig
arm                         palmz72_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
