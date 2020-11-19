Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260502B9217
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 13:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSMGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 07:06:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:23874 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgKSMGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 07:06:25 -0500
IronPort-SDR: gQFFKXV37b2xn93jtPh/OWexRDgcybwwHz1ISet+VEp2fU6WIf+1JPPT+decHPJSROY0tb4I6W
 bJF1l7su2JjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167766733"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="167766733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 04:06:24 -0800
IronPort-SDR: oYAmTi/X22WUP+zvDAuxsJJdjLSuhbTAAeqdR0MxikNOsITnY6X0yTMogL9bLageRQpmos3Byz
 6UmDznAJ5fnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="544984792"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2020 04:06:22 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfihN-00001k-Io; Thu, 19 Nov 2020 12:06:01 +0000
Date:   Thu, 19 Nov 2020 20:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/pm] BUILD SUCCESS
 9f1c0ebea21a68a2f31ab2743bbb2c60013e35fe
Message-ID: <5fb65f81.6RjVsvV3PK9+ORKg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/pm
branch HEAD: 9f1c0ebea21a68a2f31ab2743bbb2c60013e35fe  PCI: Add sysfs attribute for device power state

elapsed time: 772m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         mpc30x_defconfig
sh                           se7780_defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
arm                            mps2_defconfig
nios2                               defconfig
mips                        workpad_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
powerpc                     akebono_defconfig
powerpc                 linkstation_defconfig
arm                            xcep_defconfig
arc                     nsimosci_hs_defconfig
arm                     davinci_all_defconfig
powerpc                    klondike_defconfig
arm                            mmp2_defconfig
arm                          pcm027_defconfig
parisc                generic-32bit_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     rainier_defconfig
xtensa                           alldefconfig
powerpc                     stx_gp3_defconfig
sh                           se7206_defconfig
powerpc                   lite5200b_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
mips                     loongson1c_defconfig
mips                        jmr3927_defconfig
arm                        oxnas_v6_defconfig
powerpc                       maple_defconfig
arm                       cns3420vb_defconfig
sh                         ecovec24_defconfig
arm                         nhk8815_defconfig
sh                           se7712_defconfig
sh                   sh7770_generic_defconfig
sh                        apsh4ad0a_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         10m50_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
arc                            hsdk_defconfig
ia64                      gensparse_defconfig
arm                  colibri_pxa300_defconfig
arm                        magician_defconfig
powerpc                     kmeter1_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
mips                   sb1250_swarm_defconfig
sh                        sh7763rdp_defconfig
arm                           u8500_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                               defconfig
sh                        sh7757lcr_defconfig
mips                         tb0287_defconfig
sh                          kfr2r09_defconfig
sh                            titan_defconfig
sparc64                             defconfig
mips                            gpr_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                         wii_defconfig
m68k                           sun3_defconfig
powerpc                    ge_imp3a_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
arc                    vdk_hs38_smp_defconfig
h8300                    h8300h-sim_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
