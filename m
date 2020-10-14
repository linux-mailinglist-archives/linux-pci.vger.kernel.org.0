Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6EE28DA1E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJNHDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 03:03:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:18671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgJNHDV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 03:03:21 -0400
IronPort-SDR: LJNV/ICKdzEmwS/DVyGtIfTtGTwyEz+/bW9uH71huEQXzBZ5ThjUWkIkBPEPz8heUWsvRIZn0U
 GSSsOw0u131w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166170250"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="166170250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 00:03:17 -0700
IronPort-SDR: Irfy1VKEjfpOF2ep4mgUE/hNxWSZL9Wb0nXk+rM9Vd7Dl2r8CUEkIalQN6aVaNn7D1OkPy1t/u
 fWG9TIXRv4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="520279109"
Received: from lkp-server01.sh.intel.com (HELO 77f7a688d8fd) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Oct 2020 00:03:16 -0700
Received: from kbuild by 77f7a688d8fd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSaod-00004W-IV; Wed, 14 Oct 2020 07:03:15 +0000
Date:   Wed, 14 Oct 2020 15:03:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS ec8d6eaa648655a79ef27f343600e561e4ab8384
Message-ID: <5f86a2a4.nnZEuSLqLSqM9UHG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: ec8d6eaa648655a79ef27f343600e561e4ab8384  Merge branch 'remotes/lorenzo/pci/xilinx'

elapsed time: 722m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
ia64                             alldefconfig
arm                         hackkit_defconfig
sh                          landisk_defconfig
arm                           h3600_defconfig
x86_64                              defconfig
mips                        nlm_xlr_defconfig
arm                        spear6xx_defconfig
powerpc                       ppc64_defconfig
powerpc                     stx_gp3_defconfig
m68k                        stmark2_defconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
powerpc                      katmai_defconfig
arm                            hisi_defconfig
arm                          iop32x_defconfig
nds32                               defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
sh                           se7721_defconfig
arm                     davinci_all_defconfig
arm                          pxa3xx_defconfig
arm                            dove_defconfig
sh                             shx3_defconfig
arm                          lpd270_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
arm                        realview_defconfig
sh                              ul2_defconfig
powerpc                     mpc5200_defconfig
powerpc                     mpc83xx_defconfig
c6x                              alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
i386                 randconfig-a005-20201013
i386                 randconfig-a006-20201013
i386                 randconfig-a001-20201013
i386                 randconfig-a003-20201013
i386                 randconfig-a004-20201013
i386                 randconfig-a002-20201013
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
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
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
