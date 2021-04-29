Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFD36E6FD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhD2IZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 04:25:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:5460 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhD2IZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 04:25:53 -0400
IronPort-SDR: E1P9VmRpcrsKb+xNWsHnSl3V7IgyXmZigCBGBdyh7EH/64lPVgouZswaduOrtktAlHI6Vu4P5A
 OIsYmyD+yjaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196510409"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196510409"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 01:25:06 -0700
IronPort-SDR: LyVKjgZp947BxdxlIZHr9rfzZ93QAzdA3ds40zPjRhWYWmLdBaThBkYdsT/eJ2jkUJTuSwvM8N
 p3LfbaPvTBXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="526845386"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2021 01:25:04 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lc1yp-0007Yc-DJ; Thu, 29 Apr 2021 08:25:03 +0000
Date:   Thu, 29 Apr 2021 16:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 f89b5783f139269a16e8821b203ac2a6f1ad965c
Message-ID: <608a6d35.QT6Wf5ceobqgyh52%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: f89b5783f139269a16e8821b203ac2a6f1ad965c  PCI: Allow VPD access for QLogic ISP2722

elapsed time: 722m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
mips                           mtx1_defconfig
arm                       netwinder_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
mips                  maltasmvp_eva_defconfig
arc                           tb10x_defconfig
arm                      jornada720_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                  or1klitex_defconfig
um                           x86_64_defconfig
powerpc                     tqm8540_defconfig
mips                         tb0287_defconfig
mips                     cu1830-neo_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
arm                             rpc_defconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      arches_defconfig
powerpc                     taishan_defconfig
arm                          imote2_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         ap325rxa_defconfig
powerpc                     redwood_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                             alldefconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         nhk8815_defconfig
ia64                                defconfig
arm                          gemini_defconfig
sh                           se7724_defconfig
sh                           se7712_defconfig
ia64                          tiger_defconfig
sparc64                          alldefconfig
mips                      malta_kvm_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8555_defconfig
mips                           ip32_defconfig
arm                       mainstone_defconfig
mips                      pic32mzda_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
