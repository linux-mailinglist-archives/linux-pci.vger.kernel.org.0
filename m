Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4548D518
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiAMJiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 04:38:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:46172 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233252AbiAMJiu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 04:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642066730; x=1673602730;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9ouIefcz1muB75wy0WmnSN1XcPoxLQ3DV+u2AW2BDz8=;
  b=V3NChWPbk+jqzLfBV6+BnKBicnvQFgrScIW5+LE2OCarZlef08VTIwgj
   YkZzEuZD2XLmhgwFKO67YEsIGUeLZfZa7WvVU3hyNm6TFeonxGMB+9Vo1
   3pG8uSX92UuFF9J2plUfIcLqyXz2Pvs0Tw5QTMGyF6TMdoyFYSl/AQeFP
   54Au+MMdvjSRiZUkV13Q2rhQHCwQAjpiyN2Zbh4YJ6zP66nP9RZ9XVqQX
   wxCA2f5lmMWiVIstnFkjRwcVCouHBBBvKgxfwiUO6z0cWh4ZLQvGdDcJr
   ieBMSa9EakYhXFhKAhSJKS/SsaQK9eeHaEfoFdRYGIeVYEKagZURDPlAR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304707762"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="304707762"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="559048302"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2022 01:38:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7wZ3-00072x-Aa; Thu, 13 Jan 2022 09:38:37 +0000
Date:   Thu, 13 Jan 2022 17:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/brcmstb] BUILD SUCCESS
 11ed8b8624b8085f706864b4addcd304b1e4fc38
Message-ID: <61dff30f.Iup2TWzwpfJAceK7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/brcmstb
branch HEAD: 11ed8b8624b8085f706864b4addcd304b1e4fc38  PCI: brcmstb: Do not turn off WOL regulators on suspend

elapsed time: 725m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                             alldefconfig
sh                          sdk7780_defconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
mips                  maltasmvp_eva_defconfig
sh                                  defconfig
mips                       capcella_defconfig
powerpc                      ppc40x_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
sh                               alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
powerpc                    klondike_defconfig
arm                           stm32_defconfig
powerpc                      bamboo_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                          rsk7269_defconfig
um                           x86_64_defconfig
sh                               j2_defconfig
powerpc64                        alldefconfig
mips                     decstation_defconfig
powerpc                       holly_defconfig
csky                                defconfig
powerpc                        warp_defconfig
m68k                       m5475evb_defconfig
mips                             allyesconfig
arm                            pleb_defconfig
arm                        trizeps4_defconfig
sh                           se7705_defconfig
mips                         mpc30x_defconfig
xtensa                  audio_kc705_defconfig
mips                 decstation_r4k_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
arm                           tegra_defconfig
arm                          badge4_defconfig
mips                            ar7_defconfig
mips                        jmr3927_defconfig
openrisc                 simple_smp_defconfig
powerpc                  iss476-smp_defconfig
sh                   sh7770_generic_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
sh                         apsh4a3a_defconfig
mips                           xway_defconfig
powerpc                       ppc64_defconfig
arm                          simpad_defconfig
arm                         lpc18xx_defconfig
m68k                        mvme16x_defconfig
ia64                          tiger_defconfig
m68k                       bvme6000_defconfig
sh                             sh03_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                  nommu_kc705_defconfig
sh                          r7785rp_defconfig
arm                            hisi_defconfig
powerpc                       maple_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
sh                           se7780_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
m68k                         amcore_defconfig
sh                          rsk7264_defconfig
sh                          kfr2r09_defconfig
um                             i386_defconfig
h8300                               defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220112
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                        randconfig-a006
x86_64                        randconfig-a004
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                        bcm63xx_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pmac32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
hexagon              randconfig-r041-20220112
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
