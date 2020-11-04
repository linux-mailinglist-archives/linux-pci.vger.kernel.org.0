Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A52A61A1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 11:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKDKcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 05:32:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:59996 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgKDKb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 05:31:26 -0500
IronPort-SDR: g5UsEyUOfeEAJW+t6Vgxywz+GoqzdZoAb3zNqA6I4vw94fDFS0Yj9fYSARleU7G1efKG3XZ+w4
 0XgtaRDFBZkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="253907636"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="253907636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 02:31:12 -0800
IronPort-SDR: aax12skQtrBfQAaq3wCarPfb8QkO/i4mxrVOv9dQelhrfLLF8rzam1v8UXu2bdqtPFiDTFNQmv
 rlMM6c9OQ5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="426629389"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2020 02:31:11 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaG4N-0000qA-4K; Wed, 04 Nov 2020 10:31:11 +0000
Date:   Wed, 04 Nov 2020 18:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS WITH WARNING
 8f113d33e39f4a1a290f8d4557a0b853a1ab6753
Message-ID: <5fa282db.SKusINSqqr6jZ2g8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 8f113d33e39f4a1a290f8d4557a0b853a1ab6753  PCI: mvebu: Fix duplicate resource requests

Warning in current branch:

drivers/pci/controller/dwc/pcie-designware-host.c:597:27: warning: Possible null pointer dereference: entry [nullPointer]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- ia64-randconfig-p001-20201103
    `-- drivers-pci-controller-dwc-pcie-designware-host.c:warning:Possible-null-pointer-dereference:entry-nullPointer

elapsed time: 720m

configs tested: 135
configs skipped: 2

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                            zeus_defconfig
powerpc                     tqm5200_defconfig
ia64                          tiger_defconfig
sh                         ecovec24_defconfig
s390                          debug_defconfig
arm                       aspeed_g5_defconfig
powerpc64                        alldefconfig
xtensa                  cadence_csp_defconfig
mips                malta_kvm_guest_defconfig
sh                                  defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
ia64                      gensparse_defconfig
mips                           gcw0_defconfig
xtensa                    smp_lx200_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
sh                           se7722_defconfig
riscv                            allyesconfig
powerpc                      katmai_defconfig
sh                            hp6xx_defconfig
microblaze                      mmu_defconfig
mips                        vocore2_defconfig
arm                          pxa3xx_defconfig
arm                      tct_hammer_defconfig
powerpc                      acadia_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      chrp32_defconfig
mips                  decstation_64_defconfig
riscv                          rv32_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
mips                         rt305x_defconfig
arm                          pcm027_defconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                      cm5200_defconfig
arc                              alldefconfig
powerpc                     kmeter1_defconfig
arm                         at91_dt_defconfig
sh                           se7751_defconfig
mips                malta_qemu_32r6_defconfig
mips                        omega2p_defconfig
x86_64                              defconfig
arm                       omap2plus_defconfig
sh                          sdk7786_defconfig
sh                          r7785rp_defconfig
mips                       bmips_be_defconfig
arm                            u300_defconfig
mips                        bcm63xx_defconfig
arm                     am200epdkit_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
arm                           sunxi_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
