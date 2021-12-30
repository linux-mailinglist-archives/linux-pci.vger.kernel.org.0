Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9375481B03
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhL3JP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Dec 2021 04:15:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:62082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237961AbhL3JP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Dec 2021 04:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640855756; x=1672391756;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0sD+ixvvsw5WB5Q3AyZGkdXnTumVJiXDG1cdBiSLA50=;
  b=ORxvP8z3QUtbYo7jXJOBTUMptjMt2mDajvYoICfgYp6vqvr1GWMjfsvt
   onE1lnRQPGEjST9M/t/vpMsXy/uH41clckSc4TL+8xgxCpDmg+3v8mim2
   njvSyTvDbdTBVSs28JburzIWTuXhuxpLret3w0MmLVYNhANGelVnnBzum
   G3hjXdbSkgJZICrCQlfcuSTmk03PGmJ7OUHACPqlBmWBdILMwiQPjW9Um
   lmKiss/zi8Q9m7AMGeOWdZm9mjHgibWmgy3fI66D0mU7OP8wzYTdrieO7
   DcfYV1cBDzDbhJo4bWnxG9h+18auIpd65EUPlq0OIfJAyw+oin+SfvjVO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241855158"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241855158"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 01:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="687165298"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2021 01:15:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2rXI-0009xn-9P; Thu, 30 Dec 2021 09:15:48 +0000
Date:   Thu, 30 Dec 2021 17:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 0cf948aab9a0049456d9a498af3da6b403e2a0ed
Message-ID: <61cd78a2.8ltt4LzMHxTiuTIm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 0cf948aab9a0049456d9a498af3da6b403e2a0ed  PCI/sysfs: Use default_groups in kobj_type for slot attrs

elapsed time: 725m

configs tested: 221
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211228
i386                 randconfig-c001-20211230
mips                 randconfig-c004-20211230
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      pasemi_defconfig
arm                        shmobile_defconfig
powerpc                 linkstation_defconfig
mips                         bigsur_defconfig
powerpc                 mpc832x_mds_defconfig
nios2                               defconfig
arm                  colibri_pxa300_defconfig
mips                           ip28_defconfig
arm                      tct_hammer_defconfig
arm                         s3c6400_defconfig
powerpc                     pseries_defconfig
arm                         lpc18xx_defconfig
arm                     eseries_pxa_defconfig
arc                     nsimosci_hs_defconfig
sh                        edosk7705_defconfig
powerpc                   bluestone_defconfig
sh                          landisk_defconfig
arm                          moxart_defconfig
arm                       imx_v6_v7_defconfig
alpha                               defconfig
powerpc                     tqm8541_defconfig
s390                          debug_defconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     akebono_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
arm                        oxnas_v6_defconfig
mips                        workpad_defconfig
alpha                            alldefconfig
mips                      pic32mzda_defconfig
powerpc                        fsp2_defconfig
powerpc                  iss476-smp_defconfig
mips                malta_qemu_32r6_defconfig
arm                            pleb_defconfig
arm                           sama7_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
ia64                            zx1_defconfig
powerpc                     pq2fads_defconfig
sh                          sdk7786_defconfig
arc                            hsdk_defconfig
arm                        multi_v7_defconfig
sh                                  defconfig
s390                             allmodconfig
mips                            e55_defconfig
mips                         cobalt_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                             alldefconfig
arm                            qcom_defconfig
sh                             sh03_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
xtensa                          iss_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
mips                     loongson1b_defconfig
sh                           se7721_defconfig
openrisc                         alldefconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
arm                           sunxi_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
xtensa                       common_defconfig
arm                        clps711x_defconfig
arm                             ezx_defconfig
parisc                           alldefconfig
mips                       rbtx49xx_defconfig
mips                       bmips_be_defconfig
powerpc                  mpc866_ads_defconfig
arm                             pxa_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
powerpc                      arches_defconfig
sparc                       sparc64_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc44x_defconfig
xtensa                  nommu_kc705_defconfig
m68k                          atari_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
mips                         tb0226_defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8560_defconfig
arm                  randconfig-c002-20211229
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211228
mips                 randconfig-c004-20211228
powerpc              randconfig-c003-20211228
arm                  randconfig-c002-20211228
x86_64               randconfig-c007-20211228
i386                 randconfig-c001-20211228
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
