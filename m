Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFA27E546
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgI3Jh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 05:37:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:23696 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgI3Jh0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 05:37:26 -0400
IronPort-SDR: UdpTdetZCfdpSYHubUT6xtcOQbxrlDBZ5fHy17FE38jbFdi+FAQ8kUeZt8in/dH74Fjcyl64c0
 0rRR0O7FNjcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="180564706"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="180564706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 02:37:24 -0700
IronPort-SDR: P+Y5WlmqA6kmzrTadM6Kc8dfr3CPtjXzVziSFLF4qAbzstCatN3Jg7mkbgGBX/sw6t8XRwphoL
 00OzAf5fib6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="324983923"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Sep 2020 02:37:22 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNYY6-0000BO-6h; Wed, 30 Sep 2020 09:37:22 +0000
Date:   Wed, 30 Sep 2020 17:36:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 2a87f534d1988f10eb6ca3ce4971003a74d297f3
Message-ID: <5f7451a1.P/TI3/4ZimZz5164%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 2a87f534d1988f10eb6ca3ce4971003a74d297f3  PCI: Add Kconfig options for pcie_bus_config

elapsed time: 723m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
riscv                               defconfig
arm                         orion5x_defconfig
mips                         tb0219_defconfig
arm                         socfpga_defconfig
m68k                          atari_defconfig
arm                             ezx_defconfig
ia64                      gensparse_defconfig
arm                           h3600_defconfig
powerpc                          g5_defconfig
arm                       spear13xx_defconfig
mips                           ip22_defconfig
arm                         nhk8815_defconfig
arm                           efm32_defconfig
sh                           se7750_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
openrisc                 simple_smp_defconfig
mips                       lemote2f_defconfig
xtensa                         virt_defconfig
sparc                            alldefconfig
powerpc                      pmac32_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
m68k                       m5275evb_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc512x_defconfig
um                            kunit_defconfig
sh                     magicpanelr2_defconfig
powerpc                    amigaone_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
powerpc               mpc834x_itxgp_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
mips                        nlm_xlr_defconfig
powerpc                     ppa8548_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
arm                         ebsa110_defconfig
sparc                       sparc32_defconfig
arm                          pxa168_defconfig
m68k                                defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                    gamecube_defconfig
sh                        dreamcast_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
powerpc                 canyonlands_defconfig
ia64                             allyesconfig
arm                             mxs_defconfig
arm                         lpc32xx_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
m68k                          hp300_defconfig
sh                            titan_defconfig
arm                        multi_v5_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
sh                           se7724_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
h8300                            alldefconfig
mips                      pic32mzda_defconfig
mips                 decstation_r4k_defconfig
arc                              allyesconfig
microblaze                          defconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
sh                          r7780mp_defconfig
m68k                       m5249evb_defconfig
mips                       capcella_defconfig
c6x                                 defconfig
mips                         tb0287_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
sparc64                             defconfig
powerpc                      ppc6xx_defconfig
arm                      pxa255-idp_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
