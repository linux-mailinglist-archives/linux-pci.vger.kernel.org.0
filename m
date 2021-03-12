Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F795338BBE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCLLoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 06:44:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:48561 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhCLLoI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 06:44:08 -0500
IronPort-SDR: o0xOb43DBZe7LaWsJmd+3TbxXZVqL10etMWs/2rZt054y8h8lBtfzvVBTt6qRmCu3p8knjGl37
 QaD/8TfQtdPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="168094336"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="168094336"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 03:44:07 -0800
IronPort-SDR: awBzUXWrWpw+pahgvlOhe6qEfPqe2nedNuWvtJZf1UGMtXYri9l0kFQ0crmRXb4r3hU0Lzu0U5
 GeYHlELDuCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="370878411"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2021 03:44:06 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKgD7-0001KZ-DX; Fri, 12 Mar 2021 11:44:05 +0000
Date:   Fri, 12 Mar 2021 19:43:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 6af60eb39df3e6df15a806215f41cdb96f06045b
Message-ID: <604b53fe.l1txduQHLUyQE57U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 6af60eb39df3e6df15a806215f41cdb96f06045b  MAINTAINERS: Update PCI patchwork to kernel.org instance

elapsed time: 720m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
nds32                            alldefconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
riscv                               defconfig
arm                          collie_defconfig
powerpc                    ge_imp3a_defconfig
sh                             sh03_defconfig
arm                             mxs_defconfig
sh                        dreamcast_defconfig
arm                          ixp4xx_defconfig
h8300                               defconfig
arc                          axs101_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
sh                        sh7763rdp_defconfig
mips                        workpad_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc832x_rdb_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
arm                        trizeps4_defconfig
sparc                               defconfig
parisc                generic-64bit_defconfig
mips                          malta_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8548_defconfig
arm                         s3c6400_defconfig
mips                        nlm_xlr_defconfig
arm                          iop32x_defconfig
sparc                       sparc32_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            qcom_defconfig
riscv                            alldefconfig
powerpc                     taishan_defconfig
arm                        neponset_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc5200_defconfig
powerpc                       maple_defconfig
arm                       multi_v4t_defconfig
powerpc                     tqm8540_defconfig
powerpc                   motionpro_defconfig
m68k                       m5249evb_defconfig
powerpc                     mpc83xx_defconfig
sh                              ul2_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
