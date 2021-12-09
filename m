Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D046E49F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 09:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhLIIyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 03:54:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:32891 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235243AbhLIIyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 03:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639039878; x=1670575878;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wQs/ApopcmwRqlqQXGZMifpE3fhg23Fm33uDec5LiLg=;
  b=P/eteEb0/vKV8cgmPuyR2kLHxACvZYHA8w5ICrxlS4cg69N5PHR6C1Y3
   Mk+6rLCJl3jsNltv7hDPDbh6utJZgvOFSIIp0cDzrg6AbUdsg3leCEsno
   Q46ypVJzf2LzPE3Lts4gpFKd+it/n5NaTO7+dXLtqqN1I31aa/P10TOqO
   oAqUO8OAUxD0PuRopMRELnEnh9AlJd7NhwJ0IX8uAfT5fgdua4apY35zL
   s8jO8XXHft9Vofjc9dwQBA219Kear/o5pUTVI1ZiCCUw+PvaWHyny6nBP
   gMzmlwmmWZE/HFjeukKLTZRkJuoZIAf7AHk62opMV43ZDtjiG4ezirIv/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238275903"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238275903"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 00:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="680250978"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 00:51:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvF91-0001hH-9x; Thu, 09 Dec 2021 08:51:15 +0000
Date:   Thu, 09 Dec 2021 16:51:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/legacy-pm-removal] BUILD SUCCESS
 7bd0daa8a3437746246a912921593c2111f835eb
Message-ID: <61b1c37c.zRXhMQvK3bXd9bi2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/legacy-pm-removal
branch HEAD: 7bd0daa8a3437746246a912921593c2111f835eb  via-agp: convert to generic power management

elapsed time: 725m

configs tested: 191
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
i386                 randconfig-c001-20211208
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                            xcep_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
parisc                           alldefconfig
arm                        spear6xx_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
arm                           sama5_defconfig
powerpc                     pseries_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7201_defconfig
nios2                               defconfig
powerpc                      chrp32_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      pcm030_defconfig
arm                         mv78xx0_defconfig
sh                           se7206_defconfig
um                           x86_64_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
powerpc                 canyonlands_defconfig
arm                         lpc18xx_defconfig
arm                            hisi_defconfig
powerpc                        icon_defconfig
powerpc                       ebony_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
arm                        neponset_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            zeus_defconfig
powerpc                      cm5200_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         hackkit_defconfig
powerpc                      acadia_defconfig
arm                          badge4_defconfig
powerpc                  iss476-smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                        warp_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                     magicpanelr2_defconfig
powerpc                 mpc834x_itx_defconfig
i386                                defconfig
sh                            migor_defconfig
arm                       aspeed_g4_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                       sparc64_defconfig
arm                  randconfig-c002-20211207
arm                  randconfig-c002-20211209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a016-20211208
x86_64               randconfig-a011-20211208
x86_64               randconfig-a013-20211208
x86_64               randconfig-a012-20211208
x86_64               randconfig-a015-20211208
x86_64               randconfig-a014-20211208
i386                 randconfig-a013-20211208
i386                 randconfig-a016-20211208
i386                 randconfig-a011-20211208
i386                 randconfig-a014-20211208
i386                 randconfig-a012-20211208
i386                 randconfig-a015-20211208
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
i386                 randconfig-a001-20211208
i386                 randconfig-a005-20211208
i386                 randconfig-a003-20211208
i386                 randconfig-a002-20211208
i386                 randconfig-a006-20211208
i386                 randconfig-a004-20211208
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211208
hexagon              randconfig-r041-20211208
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
