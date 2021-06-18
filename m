Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607E83AC626
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhFRId6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 04:33:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:48933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233757AbhFRId5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 04:33:57 -0400
IronPort-SDR: VGQb5HifjyE57hF/ekPMUo3t6fC4xcMRXT+vL+uAqvSByYhFpEgtSVovt1X60mg5TRt7BqVJJ8
 GSRd0KyvJTtA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270366340"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="270366340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 01:31:47 -0700
IronPort-SDR: T1deuKi29BorSIcKgSCuVhgIaomAsj+mfmxmwf+DGyFxEQpl2rmz13exvqdHmvA47CFRCEMHxI
 9myCN5GJxRpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="422156430"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2021 01:31:46 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lu9uj-0002kp-ML; Fri, 18 Jun 2021 08:31:45 +0000
Date:   Fri, 18 Jun 2021 16:31:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS f25d926127a2a75b3b3599e2d3d3f4442bebc8bb
Message-ID: <60cc59c4.jthgsYWbMYhfc7BQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: f25d926127a2a75b3b3599e2d3d3f4442bebc8bb  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 726m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
mips                          rm200_defconfig
h8300                               defconfig
mips                            e55_defconfig
arm                       imx_v4_v5_defconfig
arm                            qcom_defconfig
powerpc                     redwood_defconfig
powerpc                   currituck_defconfig
powerpc                     kmeter1_defconfig
arc                        nsim_700_defconfig
sh                            shmin_defconfig
arm64                            alldefconfig
arm                        keystone_defconfig
riscv                          rv32_defconfig
arm                        trizeps4_defconfig
sh                      rts7751r2d1_defconfig
arm                       omap2plus_defconfig
s390                          debug_defconfig
mips                         mpc30x_defconfig
arm                           sama5_defconfig
arm                            pleb_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
powerpc                   bluestone_defconfig
powerpc                    adder875_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
sh                          rsk7264_defconfig
openrisc                            defconfig
sh                            titan_defconfig
sh                   secureedge5410_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
powerpc                       maple_defconfig
m68k                          hp300_defconfig
x86_64                           alldefconfig
mips                        jmr3927_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                       eiger_defconfig
arc                          axs101_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                      pmac32_defconfig
mips                 decstation_r4k_defconfig
arm                         shannon_defconfig
x86_64                              defconfig
sh                  sh7785lcr_32bit_defconfig
arm                      jornada720_defconfig
xtensa                    xip_kc705_defconfig
m68k                          atari_defconfig
arm                             ezx_defconfig
xtensa                  cadence_csp_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
powerpc                     pseries_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          pxa910_defconfig
sh                          lboxre2_defconfig
arm                         at91_dt_defconfig
arm                      tct_hammer_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
sh                           se7722_defconfig
powerpc                    klondike_defconfig
ia64                            zx1_defconfig
arm                          lpd270_defconfig
x86_64                           allyesconfig
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
parisc                           allyesconfig
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
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
