Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3D288998
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgJINKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 09:10:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:6669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732547AbgJINKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 09:10:36 -0400
IronPort-SDR: DaGnioMwD2BiB2AM7ZqRSlof/wj/yatrOMxBFSRN+yZ+k8ar2+KeK+UbWiL6DjdkPCGLIK7+UM
 161MdzKCxT3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="162019592"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="162019592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 06:10:35 -0700
IronPort-SDR: 7t1D9PQaI1Fndihkyri6vRYTCLtXM4a8KjQYY/L9I6lF8+ZUaIMZLjpq3kACdFvW2Re3XH5kXG
 P3OobvJEumeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="355752781"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2020 06:10:34 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQsAL-0000V1-EW; Fri, 09 Oct 2020 13:10:33 +0000
Date:   Fri, 09 Oct 2020 21:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/err-rcec] BUILD SUCCESS
 829518f1a2eb8561c28d522e9c26fe0dabe22c54
Message-ID: <5f806116.UEjnFHnIvK8TyX3J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/err-rcec
branch HEAD: 829518f1a2eb8561c28d522e9c26fe0dabe22c54  PCI/AER: Add RCEC AER error injection support

elapsed time: 721m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
s390                                defconfig
mips                   sb1250_swarm_defconfig
powerpc                     tqm8541_defconfig
arm                          pxa3xx_defconfig
sh                        edosk7760_defconfig
arm                             ezx_defconfig
arm                          badge4_defconfig
mips                            gpr_defconfig
arm                           efm32_defconfig
powerpc                 mpc8560_ads_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
mips                      pistachio_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
sh                             espt_defconfig
um                             i386_defconfig
c6x                         dsk6455_defconfig
arm                          simpad_defconfig
nds32                               defconfig
sh                          rsk7264_defconfig
sh                               alldefconfig
powerpc                      ppc40x_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
arm                   milbeaut_m10v_defconfig
mips                       rbtx49xx_defconfig
powerpc                 canyonlands_defconfig
arm                          lpd270_defconfig
powerpc                          allyesconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      obs600_defconfig
riscv                               defconfig
sh                             shx3_defconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
arm                         assabet_defconfig
mips                          ath25_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
mips                      loongson3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                         lpc18xx_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                          pxa168_defconfig
arm                         cm_x300_defconfig
powerpc                      pcm030_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
powerpc                      katmai_defconfig
powerpc                     ksi8560_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
arm                        trizeps4_defconfig
mips                       capcella_defconfig
powerpc                       eiger_defconfig
powerpc                     kmeter1_defconfig
openrisc                    or1ksim_defconfig
arm                       aspeed_g4_defconfig
arm                         hackkit_defconfig
arm                      tct_hammer_defconfig
arm                         vf610m4_defconfig
sh                        edosk7705_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
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
x86_64               randconfig-a005-20201009
x86_64               randconfig-a006-20201009
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
