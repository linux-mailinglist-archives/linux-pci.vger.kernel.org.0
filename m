Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C352FE144
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 05:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbhAUDw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 22:52:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:59205 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393007AbhAUBzy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 20:55:54 -0500
IronPort-SDR: 11h8yJwS2sSSxRKbUELdnBkifY6oaq0kwMSaxJKKCLjoLSCLzHf5Dlnz+wdvIxyed3eVAqcYPW
 uhICJnvipVkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="197938541"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="197938541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:55:14 -0800
IronPort-SDR: RY4FoIO/kqd5G7qUHpsy9QaAOKfSoGC2KRCxgseWbTWvCsP4qnpsd7C5UiXs+j06c0TKmYK2GC
 +qx32FT62r8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="402994244"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2021 17:55:13 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2PBo-00069Q-Fm; Thu, 21 Jan 2021 01:55:12 +0000
Date:   Thu, 21 Jan 2021 09:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS f9812c033ad35b9465bc9c991aba2e4c2d121c07
Message-ID: <6008decb.7SfV7K0tFS1GoDGF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: f9812c033ad35b9465bc9c991aba2e4c2d121c07  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 727m

configs tested: 146
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                             pxa_defconfig
mips                        maltaup_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
mips                        workpad_defconfig
sh                                  defconfig
arm                          gemini_defconfig
mips                           jazz_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
ia64                      gensparse_defconfig
arm                         cm_x300_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc83xx_defconfig
mips                  decstation_64_defconfig
mips                        vocore2_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     powernv_defconfig
sh                   secureedge5410_defconfig
powerpc                     skiroot_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5249evb_defconfig
ia64                          tiger_defconfig
arm                       versatile_defconfig
powerpc                 linkstation_defconfig
powerpc                     sbc8548_defconfig
arm                           viper_defconfig
powerpc                     ppa8548_defconfig
powerpc                   motionpro_defconfig
parisc                           alldefconfig
riscv                    nommu_virt_defconfig
sh                          lboxre2_defconfig
powerpc                    amigaone_defconfig
arm                            pleb_defconfig
powerpc                   lite5200b_defconfig
sh                   sh7770_generic_defconfig
powerpc                         wii_defconfig
um                            kunit_defconfig
h8300                       h8s-sim_defconfig
mips                         bigsur_defconfig
sh                           se7712_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
openrisc                    or1ksim_defconfig
mips                     loongson1b_defconfig
mips                        omega2p_defconfig
powerpc                 canyonlands_defconfig
xtensa                generic_kc705_defconfig
m68k                             alldefconfig
arm                           spitz_defconfig
xtensa                  cadence_csp_defconfig
arm                        spear6xx_defconfig
ia64                        generic_defconfig
arc                                 defconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
csky                             alldefconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
i386                 randconfig-a006-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
