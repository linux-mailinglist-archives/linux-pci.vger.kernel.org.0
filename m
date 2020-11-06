Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8AD2A8D2C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 03:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgKFCwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 21:52:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:50883 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgKFCwj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 21:52:39 -0500
IronPort-SDR: 167MHK1OmC4msSisw0GdpENa+4Z9z4nRWwPP+dM5AyGhmY1FAX58nfkjbFVmEsVNGuU11rLk3P
 Vk0OFT1vP6Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169604239"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="169604239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 18:52:38 -0800
IronPort-SDR: reJFGy7OsstEsaPZTF4+ZlLabD7rNfliHbBEPorbjo4l/puOU/txAKqU2nY+TGTZOI6pvgHhn5
 tXC2mjWsbt4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="364038542"
Received: from lkp-server01.sh.intel.com (HELO a340e641b702) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2020 18:52:37 -0800
Received: from kbuild by a340e641b702 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1karrg-0000JQ-Fz; Fri, 06 Nov 2020 02:52:36 +0000
Date:   Fri, 06 Nov 2020 10:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 8e1b3807dd7210db374b6a0bf2d4952d8c2ad159
Message-ID: <5fa4ba48.r2ORijCq66xqaFDk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 8e1b3807dd7210db374b6a0bf2d4952d8c2ad159  PCI: Fix kernel-doc markups

elapsed time: 725m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
sh                        sh7763rdp_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
arm                           viper_defconfig
sh                           se7705_defconfig
openrisc                         alldefconfig
powerpc                    amigaone_defconfig
arm                         mv78xx0_defconfig
powerpc                      makalu_defconfig
nios2                         3c120_defconfig
sh                          r7780mp_defconfig
powerpc                     ep8248e_defconfig
powerpc                   lite5200b_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc834x_itx_defconfig
parisc                           alldefconfig
powerpc               mpc834x_itxgp_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
arm                            zeus_defconfig
arm                            pleb_defconfig
arm                     am200epdkit_defconfig
powerpc                     stx_gp3_defconfig
openrisc                            defconfig
alpha                            allyesconfig
mips                         tb0226_defconfig
mips                          ath25_defconfig
xtensa                              defconfig
sh                           se7724_defconfig
mips                        nlm_xlr_defconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
s390                             allyesconfig
ia64                                defconfig
mips                       capcella_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
um                            kunit_defconfig
mips                         rt305x_defconfig
powerpc                     powernv_defconfig
powerpc                     taishan_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       multi_v4t_defconfig
mips                        workpad_defconfig
arm                         socfpga_defconfig
arm                          exynos_defconfig
m68k                                defconfig
powerpc                 mpc836x_rdk_defconfig
mips                malta_kvm_guest_defconfig
sh                          rsk7264_defconfig
arm                          lpd270_defconfig
powerpc                           allnoconfig
powerpc                 mpc837x_rdb_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
riscv                            alldefconfig
arm                         s3c2410_defconfig
powerpc                         ps3_defconfig
m68k                            mac_defconfig
nds32                            alldefconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                            xcep_defconfig
mips                          ath79_defconfig
sparc                               defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
mips                           ip27_defconfig
powerpc                     sequoia_defconfig
mips                        bcm47xx_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6457_defconfig
arm                          moxart_defconfig
arm                      footbridge_defconfig
powerpc                     kmeter1_defconfig
sh                           se7722_defconfig
mips                      malta_kvm_defconfig
powerpc                      ppc44x_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20201105
x86_64               randconfig-a003-20201105
x86_64               randconfig-a005-20201105
x86_64               randconfig-a002-20201105
x86_64               randconfig-a006-20201105
x86_64               randconfig-a001-20201105
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201105
i386                 randconfig-a013-20201105
i386                 randconfig-a014-20201105
i386                 randconfig-a016-20201105
i386                 randconfig-a011-20201105
i386                 randconfig-a012-20201105
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
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
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
