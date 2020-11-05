Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76602A79A1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgKEIuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 03:50:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:4681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKEIuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 03:50:04 -0500
IronPort-SDR: wYFwECtrSkMU2Er5FczFYEw3jJYQ0SMwrSZYOa+atxin24US5dyNW3gdfFEFT4S2pHXxiYV3qX
 DmyU5qUpl2sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="148628853"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="148628853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 00:50:03 -0800
IronPort-SDR: 7eKSqLkJ50BuC/LcCq6JUydi0ZEvmAZq74WmBqXA8xpo2ymQJ4L06fsthK+9ljPNDQF2t7Utmm
 7GLxohELXFng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="527891217"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2020 00:50:02 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaay1-0001Hz-IB; Thu, 05 Nov 2020 08:50:01 +0000
Date:   Thu, 05 Nov 2020 16:49:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 832ea234277a2465ec6602fa6a4db5cd9ee87ae3
Message-ID: <5fa3bc86.Z9ru5bWpOFGkFbXh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 832ea234277a2465ec6602fa6a4db5cd9ee87ae3  PCI: mvebu: Fix duplicate resource requests

elapsed time: 724m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      bmips_stb_defconfig
powerpc                  storcenter_defconfig
arm                      pxa255-idp_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                        vexpress_defconfig
mips                          ath25_defconfig
arm                            u300_defconfig
powerpc                  mpc885_ads_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
powerpc                 canyonlands_defconfig
xtensa                              defconfig
microblaze                    nommu_defconfig
sh                          rsk7269_defconfig
mips                        maltaup_defconfig
arm                          tango4_defconfig
openrisc                            defconfig
mips                         tb0226_defconfig
powerpc                    sam440ep_defconfig
mips                         db1xxx_defconfig
arm                            pleb_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7785lcr_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                                defconfig
mips                       capcella_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                    ge_imp3a_defconfig
mips                     loongson1c_defconfig
arm                        multi_v5_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                            titan_defconfig
i386                             allyesconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
powerpc                     taishan_defconfig
arm                          ep93xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                      katmai_defconfig
m68k                       bvme6000_defconfig
sh                     sh7710voipgw_defconfig
arm                         orion5x_defconfig
arm                     davinci_all_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
mips                       lemote2f_defconfig
riscv                            allmodconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  iss476-smp_defconfig
arm                          gemini_defconfig
powerpc                     asp8347_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8548_defconfig
powerpc                     ksi8560_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
