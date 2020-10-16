Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAD290565
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbgJPMkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 08:40:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:42582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394753AbgJPMkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 08:40:13 -0400
IronPort-SDR: E0FeHWSswHGjEMj+noXzDMxygtUzgbzrEzdDXzdQxGd0FiywvLnWZmKNTcqAbqRA85JE1GJvYi
 3x33AsTAxlWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153512761"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="153512761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:40:12 -0700
IronPort-SDR: F4qA3Lxzo0Mm9TZA7TF2DiZ3cooEeBrvKNuu2eR0stUY233avT3t8U27UMMrA0PXeFWUHRbSTR
 GPQ46PppsmVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="352179348"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2020 05:40:11 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTP1m-00000h-Ds; Fri, 16 Oct 2020 12:40:10 +0000
Date:   Fri, 16 Oct 2020 20:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 30eec02c942d6de400f08da98183ab8cd7dd0fb4
Message-ID: <5f89947e.ZZo3ThjrYaINqKct%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 30eec02c942d6de400f08da98183ab8cd7dd0fb4  Merge branch 'remotes/lorenzo/pci/xilinx'

elapsed time: 725m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                  audio_kc705_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
powerpc                     tqm5200_defconfig
mips                      pic32mzda_defconfig
m68k                          multi_defconfig
nds32                               defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     ppa8548_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
riscv                               defconfig
ia64                             allyesconfig
powerpc                     stx_gp3_defconfig
powerpc                           allnoconfig
powerpc                         ps3_defconfig
h8300                       h8s-sim_defconfig
arm                           stm32_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20201015
i386                 randconfig-a006-20201015
i386                 randconfig-a001-20201015
i386                 randconfig-a003-20201015
i386                 randconfig-a004-20201015
i386                 randconfig-a002-20201015
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
