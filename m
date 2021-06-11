Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD43A3E61
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFKI6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 04:58:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:26145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhFKI6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 04:58:04 -0400
IronPort-SDR: D1ZC/df2fLh8g3K/qxkTFZFB89xzJccf/o5Rf1St/pJZMXe6reGEFfaZeoMG5THUvWtH84IVGk
 ySoqZpr6l1xg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185180283"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="185180283"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 01:56:07 -0700
IronPort-SDR: ICuZJtsCZ/9A02O/o+zhxo/oqeNEZV1yZeOwRydluYn/XddE7RncQCxCILiUY5tpy3pPqLxPoE
 08ERzPyNcM1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="450697238"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2021 01:56:06 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrcxS-0000Wu-54; Fri, 11 Jun 2021 08:56:06 +0000
Date:   Fri, 11 Jun 2021 16:55:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 2462625827721ea1c072e3cc314863ffd13df9c5
Message-ID: <60c324fb.8ASFM2rpJG0NMRYt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 2462625827721ea1c072e3cc314863ffd13df9c5  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 721m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          sdk7780_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
mips                        nlm_xlp_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
x86_64                              defconfig
alpha                            allyesconfig
arm                          pxa910_defconfig
sh                   rts7751r2dplus_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           ip32_defconfig
powerpc                     tqm8560_defconfig
arm                         hackkit_defconfig
sh                          kfr2r09_defconfig
mips                        jmr3927_defconfig
arm                     am200epdkit_defconfig
mips                           ip22_defconfig
ia64                             allmodconfig
sh                          polaris_defconfig
arc                                 defconfig
arm                      footbridge_defconfig
arm                   milbeaut_m10v_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                        mini2440_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
arm                      tct_hammer_defconfig
arm                         lpc32xx_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
parisc                           alldefconfig
mips                            gpr_defconfig
nios2                               defconfig
sparc64                             defconfig
sh                            shmin_defconfig
h8300                            alldefconfig
mips                        workpad_defconfig
openrisc                  or1klitex_defconfig
sparc                            alldefconfig
sh                           se7721_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
powerpc                          allmodconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
microblaze                      mmu_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 linkstation_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                      pxa255-idp_defconfig
powerpc                      ppc44x_defconfig
x86_64                            allnoconfig
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
powerpc                           allnoconfig
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
