Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545373BF8B9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGHLOO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 07:14:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:56559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhGHLOO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 07:14:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="206471567"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="206471567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 04:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="648416007"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2021 04:11:31 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1RwI-000EFE-RZ; Thu, 08 Jul 2021 11:11:30 +0000
Date:   Thu, 08 Jul 2021 19:10:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/pm-vaibhav] BUILD SUCCESS
 68feca293610b3c96cbe92556bf1a1fd3492b6cc
Message-ID: <60e6dd42.0HtQbzrlOIEO3ay4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/pm-vaibhav
branch HEAD: 68feca293610b3c96cbe92556bf1a1fd3492b6cc  ata: use generic power management

elapsed time: 723m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
mips                        bcm63xx_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
h8300                       h8s-sim_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
xtensa                  audio_kc705_defconfig
arm                            mps2_defconfig
arm                           sunxi_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
sh                          sdk7786_defconfig
riscv                          rv32_defconfig
powerpc                     kilauea_defconfig
um                             i386_defconfig
sh                           se7206_defconfig
arc                           tb10x_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
sh                             sh03_defconfig
powerpc                     pseries_defconfig
powerpc                     sbc8548_defconfig
arm                         vf610m4_defconfig
sparc                       sparc32_defconfig
sh                          rsk7201_defconfig
sh                          rsk7264_defconfig
xtensa                    xip_kc705_defconfig
powerpc                       ebony_defconfig
mips                           mtx1_defconfig
arc                        nsim_700_defconfig
powerpc                      katmai_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
sh                         ecovec24_defconfig
m68k                        stmark2_defconfig
powerpc                    socrates_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      arches_defconfig
ia64                          tiger_defconfig
powerpc                  storcenter_defconfig
powerpc                    sam440ep_defconfig
powerpc                     tqm8541_defconfig
sh                           se7722_defconfig
mips                           xway_defconfig
sh                           sh2007_defconfig
parisc                           allyesconfig
arm                         cm_x300_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
powerpc                     akebono_defconfig
arm                       cns3420vb_defconfig
m68k                           sun3_defconfig
m68k                             alldefconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                   sh7770_generic_defconfig
xtensa                       common_defconfig
sh                           se7619_defconfig
x86_64                            allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a006-20210708
i386                 randconfig-a004-20210708
i386                 randconfig-a001-20210708
i386                 randconfig-a003-20210708
i386                 randconfig-a005-20210708
i386                 randconfig-a002-20210708
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
x86_64               randconfig-a015-20210708
x86_64               randconfig-a011-20210708
x86_64               randconfig-a012-20210708
x86_64               randconfig-a014-20210708
x86_64               randconfig-a016-20210708
x86_64               randconfig-a013-20210708
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210708
x86_64               randconfig-b001-20210707
x86_64               randconfig-a004-20210708
x86_64               randconfig-a005-20210708
x86_64               randconfig-a002-20210708
x86_64               randconfig-a006-20210708
x86_64               randconfig-a003-20210708
x86_64               randconfig-a001-20210708
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
