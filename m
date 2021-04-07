Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4704356284
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 06:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhDGE1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 00:27:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:54688 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344515AbhDGE1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 00:27:04 -0400
IronPort-SDR: Oah72GoIhqKmhDYHLhsxN7VoxtGqMGMjttYgZ9jGREKOoFHpAGEgT5kJXljRdDgD7Tsf9vEJ5y
 r72klmoRrMew==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180349868"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180349868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 21:26:55 -0700
IronPort-SDR: Ct03xDhLIU6nnZlGSNhV55ezIme5QDEkdQkjdPgUry2xD9uSmb4HypigOR7ju/cLtUJY9MHqvS
 RM9EVWwFixrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519287959"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2021 21:26:53 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTzmH-000Cma-0c; Wed, 07 Apr 2021 04:26:53 +0000
Date:   Wed, 07 Apr 2021 12:26:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS e9d14c046bcffdf06052380ea610185fa6223cd4
Message-ID: <606d346a.n432IYhUlrGdkMir%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: e9d14c046bcffdf06052380ea610185fa6223cd4  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 722m

configs tested: 140
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                      fuloong2e_defconfig
ia64                                defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
arm                           spitz_defconfig
riscv                    nommu_virt_defconfig
arm                     am200epdkit_defconfig
xtensa                  audio_kc705_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     pq2fads_defconfig
powerpc                        fsp2_defconfig
arm                       versatile_defconfig
arm                        trizeps4_defconfig
arc                      axs103_smp_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
mips                          rb532_defconfig
m68k                        stmark2_defconfig
arc                          axs101_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
mips                    maltaup_xpa_defconfig
arm                      jornada720_defconfig
powerpc                   motionpro_defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
s390                       zfcpdump_defconfig
sh                         microdev_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     akebono_defconfig
arc                 nsimosci_hs_smp_defconfig
parisc                generic-64bit_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            mmp2_defconfig
powerpc                     sequoia_defconfig
arc                     nsimosci_hs_defconfig
arm                           tegra_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc836x_mds_defconfig
arc                         haps_hs_defconfig
sparc64                             defconfig
arm                      pxa255-idp_defconfig
xtensa                          iss_defconfig
powerpc                 mpc837x_mds_defconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
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
x86_64               randconfig-a004-20210406
x86_64               randconfig-a003-20210406
x86_64               randconfig-a005-20210406
x86_64               randconfig-a001-20210406
x86_64               randconfig-a002-20210406
x86_64               randconfig-a006-20210406
i386                 randconfig-a006-20210406
i386                 randconfig-a003-20210406
i386                 randconfig-a001-20210406
i386                 randconfig-a004-20210406
i386                 randconfig-a005-20210406
i386                 randconfig-a002-20210406
i386                 randconfig-a014-20210406
i386                 randconfig-a016-20210406
i386                 randconfig-a011-20210406
i386                 randconfig-a012-20210406
i386                 randconfig-a015-20210406
i386                 randconfig-a013-20210406
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
x86_64               randconfig-a014-20210406
x86_64               randconfig-a015-20210406
x86_64               randconfig-a013-20210406
x86_64               randconfig-a011-20210406
x86_64               randconfig-a012-20210406
x86_64               randconfig-a016-20210406

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
