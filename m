Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C947A3AB249
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhFQLSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 07:18:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:47682 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhFQLSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 07:18:45 -0400
IronPort-SDR: RDRlFcIPRX+AGMHsZGjah/xVnCDWNyjaWpghgKHH93OxlIl7QIY69FwqSW2g16E04MooiNkOiG
 vas66ZRKTVWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="186040912"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="186040912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 04:16:38 -0700
IronPort-SDR: 2KXVUOF6WZc+j66A4S8jQK0PItj+7agexv3Gt6ywnGCSSc55lXK4nEGF9HIKPyc3TpDgdk/gAn
 f0UIdSN824Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="450987687"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2021 04:16:36 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltq0h-0001zO-Jm; Thu, 17 Jun 2021 11:16:35 +0000
Date:   Thu, 17 Jun 2021 19:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 8fe55ef23387ce3c7488375b1fd539420d7654bb
Message-ID: <60cb2f0b.eKjt4/xzR+S5GuOY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 8fe55ef23387ce3c7488375b1fd539420d7654bb  PCI: Dynamically map ECAM regions

elapsed time: 739m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                           ip28_defconfig
m68k                          amiga_defconfig
arc                              alldefconfig
sh                   rts7751r2dplus_defconfig
arm                          collie_defconfig
arm                       imx_v4_v5_defconfig
arc                         haps_hs_defconfig
mips                    maltaup_xpa_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip32_defconfig
powerpc                   motionpro_defconfig
powerpc                      pcm030_defconfig
nios2                         10m50_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
powerpc                      ppc64e_defconfig
mips                         tb0219_defconfig
mips                      pistachio_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
powerpc64                           defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
sh                        sh7785lcr_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm47xx_defconfig
powerpc                     pq2fads_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
sh                           se7705_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
mips                             allmodconfig
xtensa                              defconfig
sh                 kfr2r09-romimage_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         s5pv210_defconfig
sparc                       sparc64_defconfig
xtensa                          iss_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
powerpc                      ep88xc_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
powerpc                      makalu_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                          simpad_defconfig
powerpc                     akebono_defconfig
arm                           sunxi_defconfig
sh                          rsk7201_defconfig
s390                       zfcpdump_defconfig
openrisc                  or1klitex_defconfig
sh                           se7724_defconfig
mips                          rm200_defconfig
arm                         nhk8815_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
