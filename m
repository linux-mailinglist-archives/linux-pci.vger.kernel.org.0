Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52CB2DABF9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgLOLZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 06:25:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:5046 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgLOLZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 06:25:21 -0500
IronPort-SDR: rbgCwEdqHr4Emoni9f4z3PuEbFWzMGOsjHME9h5Q2oFuxVSNOCYiUDSOoQwpWMH2XuM7E2SB6m
 Q3ktQeoEfMsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="154669018"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="154669018"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 03:24:39 -0800
IronPort-SDR: dnznrP1G1BkVcc80WiWsZldLSZ/56bd6o6IbbM99AUQuuDHZUvo3tCnaZy/d2fJl/LcL21nFTF
 exaKGYjF0LRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="336674487"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2020 03:24:37 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kp8RZ-0000jG-89; Tue, 15 Dec 2020 11:24:37 +0000
Date:   Tue, 15 Dec 2020 19:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 752b370726cc10b3ac5690470a20f10eb627e0db
Message-ID: <5fd89cc9.LxKI7sllbSCqN8Mm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 752b370726cc10b3ac5690470a20f10eb627e0db  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 721m

configs tested: 153
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
powerpc                 mpc834x_itx_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
m68k                             allmodconfig
mips                        nlm_xlp_defconfig
arm                      pxa255-idp_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
arm                          badge4_defconfig
arc                          axs101_defconfig
sh                           se7206_defconfig
arm                              zx_defconfig
powerpc                      arches_defconfig
arc                              alldefconfig
powerpc                     kmeter1_defconfig
mips                         rt305x_defconfig
arm                      tct_hammer_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
mips                      pistachio_defconfig
arc                        nsimosci_defconfig
xtensa                    xip_kc705_defconfig
mips                           xway_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
microblaze                    nommu_defconfig
sh                          rsk7269_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
powerpc                     pq2fads_defconfig
m68k                       m5475evb_defconfig
parisc                           alldefconfig
m68k                        m5407c3_defconfig
arm                            dove_defconfig
arm                         orion5x_defconfig
powerpc                         ps3_defconfig
powerpc                      obs600_defconfig
sh                ecovec24-romimage_defconfig
sh                   sh7770_generic_defconfig
xtensa                         virt_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
sh                          lboxre2_defconfig
sh                          sdk7786_defconfig
sh                            titan_defconfig
powerpc                    gamecube_defconfig
c6x                        evmc6472_defconfig
sh                           se7722_defconfig
arm                        spear6xx_defconfig
mips                        nlm_xlr_defconfig
mips                            gpr_defconfig
mips                       lemote2f_defconfig
sh                          rsk7264_defconfig
sh                          sdk7780_defconfig
powerpc                          g5_defconfig
powerpc                   currituck_defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
mips                  cavium_octeon_defconfig
sh                   sh7724_generic_defconfig
sh                         apsh4a3a_defconfig
h8300                               defconfig
sh                           se7619_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201214
i386                 randconfig-a004-20201214
i386                 randconfig-a003-20201214
i386                 randconfig-a002-20201214
i386                 randconfig-a006-20201214
i386                 randconfig-a005-20201214
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
x86_64               randconfig-a016-20201214
x86_64               randconfig-a012-20201214
x86_64               randconfig-a013-20201214
x86_64               randconfig-a015-20201214
x86_64               randconfig-a014-20201214
x86_64               randconfig-a011-20201214
i386                 randconfig-a014-20201214
i386                 randconfig-a013-20201214
i386                 randconfig-a012-20201214
i386                 randconfig-a011-20201214
i386                 randconfig-a015-20201214
i386                 randconfig-a016-20201214
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
x86_64               randconfig-a003-20201214
x86_64               randconfig-a006-20201214
x86_64               randconfig-a002-20201214
x86_64               randconfig-a005-20201214
x86_64               randconfig-a004-20201214
x86_64               randconfig-a001-20201214
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
