Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF172F5E4C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhANKE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 05:04:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:64680 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbhANKEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 05:04:55 -0500
IronPort-SDR: 1AZIdXZ/mPCZozlsbZkf7a8nH7atCOXTZafMSPl2jzzaIhcW2FIVMKclK0sHm2xLtp0SmVmkVN
 qVx1/vRn4BlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165428685"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="165428685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 02:04:10 -0800
IronPort-SDR: hE79dyMu6oTtA2QK6dRBbpj7niAz2bMSXYi/inYkNP7d64wNa0YR4jtHc3msVSwOaeuowy3Jwj
 Li0lk5ooxzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="405112990"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2021 02:04:09 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzzU8-0000lU-VK; Thu, 14 Jan 2021 10:04:08 +0000
Date:   Thu, 14 Jan 2021 18:03:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 91327d9b3add49a1580024c24857ae2c5ef30982
Message-ID: <600016f8.yknPZtDMICePsGLT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 91327d9b3add49a1580024c24857ae2c5ef30982  Merge branch 'pci/resource'

elapsed time: 722m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8540_ads_defconfig
mips                      pistachio_defconfig
arm                        spear3xx_defconfig
m68k                          hp300_defconfig
powerpc64                           defconfig
ia64                             allyesconfig
m68k                          multi_defconfig
parisc                              defconfig
powerpc                 mpc8560_ads_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
arm                          pxa910_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
m68k                        mvme147_defconfig
um                            kunit_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      pasemi_defconfig
powerpc                      ppc64e_defconfig
powerpc                    gamecube_defconfig
mips                          ath25_defconfig
riscv                          rv32_defconfig
mips                         db1xxx_defconfig
arm                           stm32_defconfig
m68k                        m5272c3_defconfig
ia64                            zx1_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc834x_itx_defconfig
arm                       imx_v6_v7_defconfig
arm                        magician_defconfig
mips                       lemote2f_defconfig
arm                        clps711x_defconfig
c6x                        evmc6457_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
m68k                        mvme16x_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
arm                             mxs_defconfig
xtensa                       common_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
sh                         ecovec24_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                             allnoconfig
powerpc                           allnoconfig
x86_64                           alldefconfig
arm                         palmz72_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
