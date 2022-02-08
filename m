Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A84AD8D1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 14:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbiBHNP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 08:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357886AbiBHMib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 07:38:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A6C03FEC0
        for <linux-pci@vger.kernel.org>; Tue,  8 Feb 2022 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644323909; x=1675859909;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WwqEDcB3DwKdF2XX3QHC0tlmLuzMZG8Y4ixggGw7gTU=;
  b=J7WMOFnqU5ja4hGJtUr3/utZRD/5/Yy+9SgMO3PjlE7W+gz5PCKgoH+m
   0hG7MXfRDHH5RAYRQkTDWfOy6zshyCc8sDF7fZmeU4yqTAKF3Pt/mHxlw
   +0/otoyWxRftWyoneqmYP8Ci+5oYOS16QUBLb9XpUqlV49NfJu4rL1/6S
   0ISh5CAhtZQJl3jhG9eqV6s/Gtuf61Vrf7mhgmbafCcW88l2lzfwkcRvJ
   Ej6V5x8Itp2W/uBvKJf6AItxOKBDz80KnJtGNVhWg2oGAb1nD0xHnXa2B
   DW43b4wyuJ9B1m+ECt+eV3/f+CDKK1435FNkJBsDjwmM05L8nKc7TR63F
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229587812"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="229587812"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 04:38:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="484797252"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 04:38:27 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHPlK-0000BL-F3; Tue, 08 Feb 2022 12:38:26 +0000
Date:   Tue, 08 Feb 2022 20:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 b139e263240928e877038c4d60527e96ed176d6b
Message-ID: <6202642f.pnCZWaU4RF+GjoWw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: b139e263240928e877038c4d60527e96ed176d6b  Revert "PCI/portdrv: Do not setup up IRQs if there are no users"

elapsed time: 721m

configs tested: 175
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220207
powerpc                    sam440ep_defconfig
m68k                       m5249evb_defconfig
mips                         mpc30x_defconfig
mips                         cobalt_defconfig
powerpc                     pq2fads_defconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      loongson3_defconfig
sh                           se7619_defconfig
nios2                            alldefconfig
arm                           stm32_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8541_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
xtensa                    xip_kc705_defconfig
nds32                            alldefconfig
sparc64                             defconfig
arm                        cerfcube_defconfig
sh                            migor_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
sh                            shmin_defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
mips                          rb532_defconfig
powerpc                 linkstation_defconfig
csky                             alldefconfig
arm                         assabet_defconfig
mips                     decstation_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
sh                           se7343_defconfig
powerpc                        cell_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
arm                             ezx_defconfig
mips                      maltasmvp_defconfig
arm                        realview_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
powerpc                  iss476-smp_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
riscv                            allyesconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
arm                  randconfig-c002-20220207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a015-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a011-20220207
i386                 randconfig-a016-20220207
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
riscv                randconfig-c006-20220208
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220208
i386                          randconfig-c001
mips                 randconfig-c004-20220208
arm                  randconfig-c002-20220208
mips                          rm200_defconfig
mips                        maltaup_defconfig
powerpc                     mpc512x_defconfig
arm                        spear3xx_defconfig
arm                   milbeaut_m10v_defconfig
mips                           ip27_defconfig
arm                  colibri_pxa270_defconfig
arm                       aspeed_g4_defconfig
arm                          imote2_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                           mtx1_defconfig
arm                            dove_defconfig
arm                    vt8500_v6_v7_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-a006-20220207
x86_64               randconfig-a004-20220207
x86_64               randconfig-a005-20220207
x86_64               randconfig-a003-20220207
x86_64               randconfig-a002-20220207
x86_64               randconfig-a001-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a004-20220207
i386                 randconfig-a003-20220207
i386                 randconfig-a006-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
