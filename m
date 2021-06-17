Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2568D3AAFAF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFQJam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 05:30:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:25631 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhFQJam (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 05:30:42 -0400
IronPort-SDR: vnCrSaZu0iLzUufgoxoAmLrAGluryonEaw8exn/0UH/VfgYEOAicwA75nNQWKYftfEjKgxB35d
 leBQw/pHIdyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="193649184"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="193649184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 02:28:34 -0700
IronPort-SDR: as+nvgqOSLGdy5AC2ZtLdf6grE1wy0umSSGP8B0ntyY1Sob6AAOEdt8ZkaZs0Dm/00zi9WSblU
 KiRd9skHuCYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="450963296"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2021 02:28:33 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltoK8-0001vl-Jd; Thu, 17 Jun 2021 09:28:32 +0000
Date:   Thu, 17 Jun 2021 17:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/p2pdma] BUILD SUCCESS
 d1b8dc09dd71248f5098792af98caa497ec66d19
Message-ID: <60cb15b1.vJPoYFbScrYsJdTZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/p2pdma
branch HEAD: d1b8dc09dd71248f5098792af98caa497ec66d19  PCI/P2PDMA: Simplify distance calculation

elapsed time: 732m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                            pleb_defconfig
sh                            shmin_defconfig
powerpc                      makalu_defconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
powerpc                      ppc64e_defconfig
powerpc64                           defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
arc                            hsdk_defconfig
xtensa                  audio_kc705_defconfig
mips                            e55_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
mips                        workpad_defconfig
xtensa                generic_kc705_defconfig
arm                           sama5_defconfig
arm                         s5pv210_defconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm47xx_defconfig
sh                           se7705_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
mips                             allmodconfig
xtensa                              defconfig
sparc                       sparc64_defconfig
xtensa                          iss_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
powerpc                      ep88xc_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
sparc                            alldefconfig
arm                             ezx_defconfig
arc                        nsimosci_defconfig
powerpc                    socrates_defconfig
mips                     loongson1b_defconfig
m68k                        mvme147_defconfig
arm                  colibri_pxa270_defconfig
s390                       zfcpdump_defconfig
openrisc                  or1klitex_defconfig
sh                           se7724_defconfig
mips                          rm200_defconfig
arm                         nhk8815_defconfig
x86_64                            allnoconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
