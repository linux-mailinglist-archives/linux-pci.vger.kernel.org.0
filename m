Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4262A24CD
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgKBGdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 01:33:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:2301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKBGdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 01:33:46 -0500
IronPort-SDR: v1LlEGod6e1zvWjzvGNdYAVMKdLEam8lsgND2DDJyanRb0crGWRzog93wrweGfelSEpanLuT0f
 VDxonjeEUEHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="166251011"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="166251011"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 22:33:45 -0800
IronPort-SDR: l2K7yw7ZBeIQZbITZtaqHftPLWAuV4EsMzzafYkRueHYODKuWsQS2KSwUR2wG5octL1KtjKuNl
 TBx4zPGIbr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="537897222"
Received: from lkp-server02.sh.intel.com (HELO 5575c2e0dde6) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2020 22:33:44 -0800
Received: from kbuild by 5575c2e0dde6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZTPT-0000A2-CI; Mon, 02 Nov 2020 06:33:43 +0000
Date:   Mon, 02 Nov 2020 14:33:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 af0dd809f3d304ab06e9b1db9ade198a4a584c49
Message-ID: <5f9fa828.rY7xXdJ/snc4DgKq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: af0dd809f3d304ab06e9b1db9ade198a4a584c49  PCI: Add Designated Vendor-Specific Extended Capability #defines

elapsed time: 724m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
nios2                            allyesconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                        sh7785lcr_defconfig
nios2                         10m50_defconfig
sh                           se7712_defconfig
mips                         mpc30x_defconfig
powerpc                   currituck_defconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        cell_defconfig
arm                          gemini_defconfig
sh                          sdk7780_defconfig
sparc                       sparc32_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
sh                            titan_defconfig
arm                             rpc_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                        icon_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20201101
i386                 randconfig-a006-20201101
i386                 randconfig-a005-20201101
i386                 randconfig-a001-20201101
i386                 randconfig-a002-20201101
i386                 randconfig-a003-20201101
i386                 randconfig-a015-20201101
i386                 randconfig-a013-20201101
i386                 randconfig-a014-20201101
i386                 randconfig-a016-20201101
i386                 randconfig-a011-20201101
i386                 randconfig-a012-20201101
x86_64               randconfig-a004-20201101
x86_64               randconfig-a003-20201101
x86_64               randconfig-a005-20201101
x86_64               randconfig-a002-20201101
x86_64               randconfig-a006-20201101
x86_64               randconfig-a001-20201101
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
x86_64               randconfig-a012-20201101
x86_64               randconfig-a015-20201101
x86_64               randconfig-a013-20201101
x86_64               randconfig-a011-20201101
x86_64               randconfig-a014-20201101
x86_64               randconfig-a016-20201101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
