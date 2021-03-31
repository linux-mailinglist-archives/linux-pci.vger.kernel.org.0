Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8903934FB03
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhCaIAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 04:00:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:29148 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbhCaH7t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 03:59:49 -0400
IronPort-SDR: ZEMcTaYxrVvrbbrG0R4pcBiE5sgzvWhEvZzimwD6Obdb+MjXnZ9YfmXZUfEl0irNbxKyW9QEdN
 vvssU81Js1NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="188681410"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="188681410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:59:48 -0700
IronPort-SDR: kTbTlJfjxc6FX1kUZVXEcwAgmR1zYjUmQF7iRIoHKVpjSNdvoRU5vJg780rVrv8qj6RvnV5htd
 XTCm5oIm5esA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="445552826"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2021 00:59:47 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRVlS-0005ke-CH; Wed, 31 Mar 2021 07:59:46 +0000
Date:   Wed, 31 Mar 2021 15:59:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS a305a5b25e60b76947c858c629ba2bb3d62735b1
Message-ID: <60642bdc.gS4iVno8ADa59xaE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: a305a5b25e60b76947c858c629ba2bb3d62735b1  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 724m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         s3c6400_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
arm                           tegra_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
sh                              ul2_defconfig
arm                        neponset_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                         virt_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
sh                               j2_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
h8300                               defconfig
arm                     am200epdkit_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
parisc                           allyesconfig
mips                         cobalt_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
nios2                               defconfig
powerpc                     sbc8548_defconfig
mips                  decstation_64_defconfig
sh                           se7780_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
riscv                          rv32_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
m68k                        stmark2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    socrates_defconfig
arm                           u8500_defconfig
riscv                    nommu_virt_defconfig
arm                         s5pv210_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc40x_defconfig
arm                            mps2_defconfig
sh                     magicpanelr2_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       ebony_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
