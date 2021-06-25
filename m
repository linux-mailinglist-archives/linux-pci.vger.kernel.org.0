Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7A3B424E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYLSQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 07:18:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:33020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYLSP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 07:18:15 -0400
IronPort-SDR: CuoIslEy8zfDFjIHNj3k0FfVyCZ1Jt1oWpk2EDSuy1y5fqDTeneJQ3uSoK1tHHf4Kx107+B1Mm
 /AmNnUKpiShg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207469983"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="207469983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 04:15:55 -0700
IronPort-SDR: i7NkRYmiByGM59V5rdwf5PkO5iBCDHdZV+PyY8R07k7JMa1WCQUB8gabaXwHTjq/AdHoWUp5lj
 LZZFZzi+xUKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="424405579"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2021 04:15:53 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwjoP-00077T-2u; Fri, 25 Jun 2021 11:15:53 +0000
Date:   Fri, 25 Jun 2021 19:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 6a69c06e0e254fe4dfabd708cd5130826eaa0e09
Message-ID: <60d5baac.5bVAgToUReCR8GW0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 6a69c06e0e254fe4dfabd708cd5130826eaa0e09  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 723m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
sh                              ul2_defconfig
arm                        spear3xx_defconfig
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
arm                      pxa255-idp_defconfig
arm                        neponset_defconfig
sh                           se7721_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sh                        dreamcast_defconfig
sh                        sh7785lcr_defconfig
sh                          polaris_defconfig
arc                                 defconfig
powerpc                       eiger_defconfig
sh                           se7343_defconfig
mips                            e55_defconfig
powerpc                     ppa8548_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                             espt_defconfig
mips                        qi_lb60_defconfig
h8300                            alldefconfig
powerpc                     akebono_defconfig
ia64                             allmodconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
mips                        workpad_defconfig
sh                          urquell_defconfig
mips                        omega2p_defconfig
sh                         ecovec24_defconfig
mips                         tb0287_defconfig
arm                     davinci_all_defconfig
parisc                generic-64bit_defconfig
powerpc                    gamecube_defconfig
m68k                        m5407c3_defconfig
m68k                            mac_defconfig
xtensa                           alldefconfig
mips                        bcm63xx_defconfig
arc                          axs103_defconfig
powerpc                      pasemi_defconfig
sh                     sh7710voipgw_defconfig
um                            kunit_defconfig
sh                        edosk7760_defconfig
powerpc                      katmai_defconfig
arc                        nsimosci_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
xtensa                  audio_kc705_defconfig
mips                      maltaaprp_defconfig
arm                         bcm2835_defconfig
xtensa                    xip_kc705_defconfig
sh                          sdk7786_defconfig
mips                            gpr_defconfig
riscv                    nommu_k210_defconfig
nios2                         3c120_defconfig
sh                               j2_defconfig
sparc                       sparc64_defconfig
arm                      jornada720_defconfig
powerpc                  mpc885_ads_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7264_defconfig
arm                        shmobile_defconfig
arm                         lpc32xx_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           tegra_defconfig
powerpc                           allnoconfig
arm                             pxa_defconfig
powerpc                      walnut_defconfig
mips                     cu1000-neo_defconfig
s390                             alldefconfig
xtensa                  cadence_csp_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210625
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
