Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE04AA92A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 14:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380002AbiBENdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 08:33:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:9694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378932AbiBENdd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 08:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644068013; x=1675604013;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mwDLNfzHRmZqwUmNm9wQaiDiHcBKq0OZo7DtnekeM8k=;
  b=HfD1/H6K4iN12v7RktNJRyslAuXEHSTEa3Visjp2k/j9Mg2FI3vjW3r2
   1weXyDwctsSl/zCqCenlZcwx2MjIxaKiOuq7WyfqM3/KCdUW+NkkZN8xr
   Ewi8La6kf6LlndWbzsuCuO3tewLfRt8mBXtA1rNXvz7Iu7mldHrefzs6Q
   2xtXrpnbQj3cojwTcwj13l24CIkeZqakwIxDqurYFmaTJwwWIxnmeTj44
   scOmQ3sYgwtmKdTCaiTrhczBrNeeS6AzOFZanWS9ofdxAenyoSfrJdWJw
   KwdIESLNZhnL/TvClCv0RRckXQ1Jex8TUHR0ZThvy1V4eCV7TP73x0BOk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="235911342"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="235911342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="481112870"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2022 05:33:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGLBz-000Z4P-4g; Sat, 05 Feb 2022 13:33:31 +0000
Date:   Sat, 05 Feb 2022 21:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/acpi] BUILD SUCCESS
 9a607a54a16314ca4f9ec1843e7c01131d851f33
Message-ID: <61fe7c7a.Sx5Aw19OWIdFaErq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/acpi
branch HEAD: 9a607a54a16314ca4f9ec1843e7c01131d851f33  PCI/ACPI: Replace acpi_bus_get_device() with acpi_fetch_acpi_dev()

elapsed time: 723m

configs tested: 187
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
mips                      fuloong2e_defconfig
arm                         vf610m4_defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        warp_defconfig
mips                         tb0226_defconfig
sh                          r7780mp_defconfig
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
arm                            hisi_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
ia64                        generic_defconfig
mips                    maltaup_xpa_defconfig
openrisc                  or1klitex_defconfig
sparc64                             defconfig
arc                           tb10x_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
arm                       aspeed_g5_defconfig
sh                           se7206_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
arm                        mini2440_defconfig
sh                           se7619_defconfig
powerpc                 mpc834x_itx_defconfig
arm                          gemini_defconfig
m68k                        mvme147_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
mips                           gcw0_defconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
arm                        keystone_defconfig
arm                            zeus_defconfig
powerpc                     redwood_defconfig
sh                              ul2_defconfig
mips                            gpr_defconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
sh                          polaris_defconfig
sh                           se7780_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           h3600_defconfig
csky                             alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
mips                         mpc30x_defconfig
arm                         axm55xx_defconfig
powerpc                     rainier_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220205
arm                  randconfig-c002-20220202
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a002-20220131
x86_64               randconfig-a004-20220131
x86_64               randconfig-a005-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a005-20220131
i386                 randconfig-a002-20220131
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220205
powerpc              randconfig-c003-20220205
mips                 randconfig-c004-20220205
arm                  randconfig-c002-20220205
riscv                randconfig-c006-20220201
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
powerpc                 mpc832x_rdb_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                 randconfig-a011-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
