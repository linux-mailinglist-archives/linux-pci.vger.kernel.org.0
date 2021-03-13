Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD99A339DB6
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 12:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCMLNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 06:13:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:34551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhCMLND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Mar 2021 06:13:03 -0500
IronPort-SDR: x6mOhrpk7m+Nrz11pZLcWxkTY/nQxY6ksC0LNxe4s9FKk4TFNXt5Waud8V9lDhVY8ku079h9Z+
 3017fOf4N1pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168848989"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="168848989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2021 03:13:03 -0800
IronPort-SDR: OVIufC9CCfFq7aLtxc/7rsixXwNpo47zwZKalNoJELleSNY7B1UFrGxKUmo8T1aX/cF3VHcEYY
 Hegk1bSy0EDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="600884239"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2021 03:13:02 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lL2Cb-0001zl-GG; Sat, 13 Mar 2021 11:13:01 +0000
Date:   Sat, 13 Mar 2021 19:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 1bb73841ea7a88765db7f641a90120490f1f4aee
Message-ID: <604c9e31.sv4W1M0igEcnWzKq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 1bb73841ea7a88765db7f641a90120490f1f4aee  PCI: Remove MicroGate SyncLink device IDs

elapsed time: 725m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                          debug_defconfig
m68k                             alldefconfig
powerpc               mpc834x_itxgp_defconfig
arm                       aspeed_g5_defconfig
arm                        oxnas_v6_defconfig
sh                   sh7724_generic_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
sh                          lboxre2_defconfig
sh                         ap325rxa_defconfig
powerpc                      pcm030_defconfig
arm                          ep93xx_defconfig
mips                            gpr_defconfig
arm                          pxa168_defconfig
mips                           ip22_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
powerpc64                           defconfig
arm                             mxs_defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
m68k                          hp300_defconfig
powerpc                 linkstation_defconfig
powerpc                      walnut_defconfig
csky                                defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
sh                             shx3_defconfig
mips                           gcw0_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
sh                           se7751_defconfig
sparc                       sparc64_defconfig
powerpc                     mpc83xx_defconfig
mips                         tb0226_defconfig
arm                         nhk8815_defconfig
nios2                         10m50_defconfig
arc                           tb10x_defconfig
mips                     cu1830-neo_defconfig
riscv                            allyesconfig
sh                        edosk7705_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
i386                 randconfig-a001-20210313
i386                 randconfig-a005-20210313
i386                 randconfig-a002-20210313
i386                 randconfig-a003-20210313
i386                 randconfig-a004-20210313
i386                 randconfig-a006-20210313
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
