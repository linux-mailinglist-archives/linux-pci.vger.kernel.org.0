Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCB33893C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhCLJvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 04:51:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:63979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhCLJu7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 04:50:59 -0500
IronPort-SDR: ZtRiU7hAK7ZwoKzUd0chBIM09zxiY9A4f+D88Ej92r6RDmk2xibNB/eXT81Xwb4ej7ycTlNW0Q
 8Tq97P4Piqwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208648651"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="208648651"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 01:50:59 -0800
IronPort-SDR: p62Ykc3rRpx/RqhCRONgIs9ZTvAgUf48ODmWz0s78vNxA8Y1NqpwQ+tYeiVHRIj39PhVScyzD2
 WNDsNcDFVqVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="510286908"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2021 01:50:58 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKeRd-0001Hl-UA; Fri, 12 Mar 2021 09:50:57 +0000
Date:   Fri, 12 Mar 2021 17:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
Message-ID: <604b3960.xpVJSpryWdaeWzs5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e  PCI: Avoid building empty drivers

elapsed time: 725m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
nds32                            alldefconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
riscv                               defconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
sparc                            allyesconfig
powerpc                       eiger_defconfig
mips                      pistachio_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
sh                        sh7763rdp_defconfig
arm                        neponset_defconfig
mips                        workpad_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       netwinder_defconfig
arm                        magician_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
arm                        trizeps4_defconfig
sparc                               defconfig
parisc                generic-64bit_defconfig
mips                          malta_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8548_defconfig
powerpc                    ge_imp3a_defconfig
arm                            qcom_defconfig
riscv                            alldefconfig
powerpc                     taishan_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
powerpc                  iss476-smp_defconfig
powerpc                   motionpro_defconfig
m68k                       m5249evb_defconfig
powerpc                     mpc83xx_defconfig
sh                              ul2_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
