Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13205324E28
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhBYK1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 05:27:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:60932 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhBYKUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 05:20:19 -0500
IronPort-SDR: 8PZ0qF66r9AYYF62oRYcgu5GRo9PdD4Kk8tjsIQr/QwQLtenFGAj+IqFYr9cUMlwOq3uMCsjks
 iLS0RGKZVfeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="270448930"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="270448930"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 02:19:36 -0800
IronPort-SDR: WPc/YXCSSAWnJ5JMukxhr2GpJGLtk7jvxNrHPmWcnlYyQjEB23OkbzSD3M5qxRGxujXm6bVT4H
 DAddP06HObDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="516029682"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2021 02:19:35 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lFDk6-0002ee-AG; Thu, 25 Feb 2021 10:19:34 +0000
Date:   Thu, 25 Feb 2021 18:18:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS e18fb64b79860cf5f381208834b8fbc493ef7cbc
Message-ID: <60377983.rK9D0JkxmCUQpzdn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: e18fb64b79860cf5f381208834b8fbc493ef7cbc  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 725m

configs tested: 191
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                            q40_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm5200_defconfig
mips                         db1xxx_defconfig
arm                          pcm027_defconfig
ia64                            zx1_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
h8300                     edosk2674_defconfig
arm                        mvebu_v5_defconfig
arm                          ixp4xx_defconfig
sh                     magicpanelr2_defconfig
i386                             allyesconfig
arc                              allyesconfig
sh                   sh7724_generic_defconfig
mips                            gpr_defconfig
arm                       multi_v4t_defconfig
nios2                               defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
arm                          ep93xx_defconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         s3c6400_defconfig
arm                        magician_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
powerpc                         ps3_defconfig
powerpc                       ebony_defconfig
mips                           jazz_defconfig
ia64                         bigsur_defconfig
alpha                            alldefconfig
sh                        sh7763rdp_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
mips                         tb0226_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
mips                        omega2p_defconfig
arc                        nsim_700_defconfig
s390                             allmodconfig
riscv                            allyesconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     akebono_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
riscv                               defconfig
mips                            e55_defconfig
powerpc                     kilauea_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
i386                                defconfig
arm                  colibri_pxa270_defconfig
mips                            ar7_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
arm                        spear6xx_defconfig
sh                               j2_defconfig
mips                        qi_lb60_defconfig
riscv                    nommu_virt_defconfig
h8300                            alldefconfig
arc                        nsimosci_defconfig
sh                               allmodconfig
parisc                generic-64bit_defconfig
arm                           tegra_defconfig
xtensa                              defconfig
sh                                  defconfig
mips                      malta_kvm_defconfig
powerpc                    mvme5100_defconfig
mips                         cobalt_defconfig
mips                      maltaaprp_defconfig
arm                           sama5_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
m68k                          hp300_defconfig
nds32                               defconfig
mips                           ip22_defconfig
arm                           omap1_defconfig
sh                              ul2_defconfig
powerpc64                        alldefconfig
openrisc                 simple_smp_defconfig
sh                      rts7751r2d1_defconfig
mips                           gcw0_defconfig
arm                         vf610m4_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
arm                       aspeed_g4_defconfig
sh                           se7750_defconfig
sh                          sdk7786_defconfig
mips                        nlm_xlr_defconfig
powerpc                     tqm8540_defconfig
arm                        spear3xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
i386                 randconfig-a005-20210225
i386                 randconfig-a006-20210225
i386                 randconfig-a004-20210225
i386                 randconfig-a001-20210225
i386                 randconfig-a003-20210225
i386                 randconfig-a002-20210225
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
x86_64               randconfig-a015-20210225
x86_64               randconfig-a011-20210225
x86_64               randconfig-a012-20210225
x86_64               randconfig-a016-20210225
x86_64               randconfig-a013-20210225
x86_64               randconfig-a014-20210225
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
i386                 randconfig-a013-20210225
i386                 randconfig-a012-20210225
i386                 randconfig-a011-20210225
i386                 randconfig-a014-20210225
i386                 randconfig-a016-20210225
i386                 randconfig-a015-20210225
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223
x86_64               randconfig-a001-20210225
x86_64               randconfig-a002-20210225
x86_64               randconfig-a003-20210225
x86_64               randconfig-a005-20210225
x86_64               randconfig-a004-20210225
x86_64               randconfig-a006-20210225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
