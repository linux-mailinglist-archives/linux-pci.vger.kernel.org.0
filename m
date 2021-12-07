Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77646BDB0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhLGOcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 09:32:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:12747 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238078AbhLGOch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 09:32:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300967697"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="300967697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="679457657"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2021 06:29:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mubSr-000Mfn-4Q; Tue, 07 Dec 2021 14:29:05 +0000
Date:   Tue, 07 Dec 2021 22:28:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 cc3062ee1393cb98177e40e339acf38a35f21488
Message-ID: <61af6f76.9sMrcbhXj1f+iF1z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: cc3062ee1393cb98177e40e339acf38a35f21488  Merge branch 'pci/errors'

elapsed time: 720m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
arm                       omap2plus_defconfig
sh                                  defconfig
sh                             sh03_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
arm                         mv78xx0_defconfig
arc                     nsimosci_hs_defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            titan_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
xtensa                generic_kc705_defconfig
arm                         at91_dt_defconfig
arm                           spitz_defconfig
arc                           tb10x_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
arm                           sama7_defconfig
mips                            e55_defconfig
powerpc                   motionpro_defconfig
openrisc                         alldefconfig
powerpc                   lite5200b_defconfig
mips                         mpc30x_defconfig
m68k                                defconfig
arc                         haps_hs_defconfig
sparc                            alldefconfig
arm                         s5pv210_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                        keystone_defconfig
arm                        cerfcube_defconfig
powerpc                     akebono_defconfig
sparc                            allyesconfig
mips                         db1xxx_defconfig
mips                     cu1000-neo_defconfig
powerpc                      pmac32_defconfig
mips                     decstation_defconfig
powerpc                        fsp2_defconfig
powerpc                 mpc836x_mds_defconfig
mips                  cavium_octeon_defconfig
mips                           mtx1_defconfig
sh                   sh7770_generic_defconfig
alpha                               defconfig
arm                      jornada720_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20211207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
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
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
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
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
