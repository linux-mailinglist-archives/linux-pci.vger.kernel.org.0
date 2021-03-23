Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6913457F4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 07:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCWGpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 02:45:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:37330 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhCWGp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 02:45:27 -0400
IronPort-SDR: gu+q8n642rc445i92Wyuj/7Bf4xM56vSI5NDkbBpXPEQ6UwriQZ3f6rZw9U28TNF8wyTGRDO7S
 YZTDmv255lew==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190443843"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="190443843"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 23:45:26 -0700
IronPort-SDR: 7YTjEWBxXtUCdpmy9wQZtxRBdWzNHwGe+QTUtmLTM/NqQazNRzAziTcNoMaMza3yinuHGZeJ3j
 ZQ9Qbmxk9UOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="604188179"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2021 23:45:25 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOan6-0000OT-MY; Tue, 23 Mar 2021 06:45:24 +0000
Date:   Tue, 23 Mar 2021 14:44:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/hotplug] BUILD SUCCESS
 1e0cd5d667f2c96a608faba210473a5033c7a061
Message-ID: <60598e50.ufUPGawEw5eLPDwP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 1e0cd5d667f2c96a608faba210473a5033c7a061  PCI: hotplug: fix null-ptr-dereferencd in cpcihp error path

elapsed time: 720m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
powerpc                      katmai_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     powernv_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
sparc64                          alldefconfig
powerpc                      ppc44x_defconfig
mips                      maltaaprp_defconfig
powerpc                   motionpro_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
arm                  colibri_pxa270_defconfig
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
mips                         rt305x_defconfig
arm                          gemini_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                   sb1250_swarm_defconfig
mips                           ip28_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
sh                        edosk7705_defconfig
powerpc                     mpc5200_defconfig
mips                      pic32mzda_defconfig
powerpc                      ppc64e_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                         shannon_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
mips                        omega2p_defconfig
arm                      pxa255-idp_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
m68k                        m5307c3_defconfig
arm                        realview_defconfig
powerpc                      ppc6xx_defconfig
arm                          exynos_defconfig
powerpc                     akebono_defconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
sh                           se7780_defconfig
powerpc                 mpc836x_rdk_defconfig
openrisc                         alldefconfig
m68k                       m5249evb_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
i386                                defconfig
arm                  colibri_pxa300_defconfig
mips                           jazz_defconfig
powerpc                     mpc83xx_defconfig
powerpc                mpc7448_hpc2_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
