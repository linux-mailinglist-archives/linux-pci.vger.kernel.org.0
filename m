Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00F47EE0E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352329AbhLXJts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Dec 2021 04:49:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:39566 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343853AbhLXJts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Dec 2021 04:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640339388; x=1671875388;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sZpph6TdL31ELELq38jHCmBu6KiZbnwVdRzH33cPPeA=;
  b=GQ8Pw9E89RpmuC07YKwNy2caDuQoQckxu/kb80wgE2NcjEG5ghH4gaI4
   IaoV5DMQrGkzLR2ITZ5tzjn86lVku8oJwG+5ramJx6X5efVz/RDTOjWT3
   GIX6+RB87YgmA2VAGxIhjuYdjpQX6KhpFcues7qX7ziZyxyaRWFqqpO/b
   UIHkEd1V5nrGfxluREYUizsyJ0cJ8V63oGNzCPobSLu4a8j5Xt6ncWmYA
   Ip5h8fipO1cxqdpGiOiQH/gUQSvEEkk6ZuCBGO6WrRThv1Okk7QtUaipj
   fh+3HX/TfVsOZuU0BZxSVK04Ppml/CsgBbR3Bsd6TJAsy8WOydoqqxCcp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="238495103"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="238495103"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 01:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="509119057"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Dec 2021 01:49:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0hCr-0002sS-HT; Fri, 24 Dec 2021 09:49:45 +0000
Date:   Fri, 24 Dec 2021 17:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver-cleanup] BUILD SUCCESS
 f1b3feeb052bfdfe7dfba3239916a264a26287eb
Message-ID: <61c597a4.QElLRRDJdaAybQOw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
branch HEAD: f1b3feeb052bfdfe7dfba3239916a264a26287eb  PCI: spear13xx: Avoid invalid address space conversions

elapsed time: 720m

configs tested: 185
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
xtensa                         virt_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
mips                             allmodconfig
m68k                        mvme147_defconfig
arm                            qcom_defconfig
arm                          iop32x_defconfig
arc                          axs103_defconfig
powerpc                      mgcoge_defconfig
um                           x86_64_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
mips                           ip27_defconfig
arc                              alldefconfig
sh                            migor_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
sh                           se7721_defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
sh                           se7619_defconfig
arm                           corgi_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 linkstation_defconfig
arm                           u8500_defconfig
arm                            xcep_defconfig
um                               alldefconfig
mips                 decstation_r4k_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
mips                     cu1000-neo_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
mips                         rt305x_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sh                          rsk7203_defconfig
mips                       capcella_defconfig
mips                         tb0226_defconfig
xtensa                           alldefconfig
ia64                             allmodconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                      chrp32_defconfig
powerpc                     tqm5200_defconfig
powerpc                      cm5200_defconfig
h8300                    h8300h-sim_defconfig
h8300                            alldefconfig
arm                     eseries_pxa_defconfig
powerpc64                           defconfig
arm                        neponset_defconfig
arm                         lpc18xx_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
arm                          exynos_defconfig
sh                          lboxre2_defconfig
nios2                               defconfig
x86_64                           allyesconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                  randconfig-c002-20211224
arm                  randconfig-c002-20211223
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a013-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
arc                  randconfig-r043-20211223
s390                 randconfig-r044-20211223
riscv                randconfig-r042-20211223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a002-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
x86_64               randconfig-a013-20211224
x86_64               randconfig-a014-20211224
x86_64               randconfig-a015-20211224
x86_64               randconfig-a012-20211224
x86_64               randconfig-a011-20211224
x86_64               randconfig-a016-20211224
i386                 randconfig-a012-20211224
i386                 randconfig-a011-20211224
i386                 randconfig-a014-20211224
i386                 randconfig-a016-20211224
i386                 randconfig-a015-20211224
i386                 randconfig-a013-20211224
hexagon              randconfig-r041-20211224
hexagon              randconfig-r045-20211224
s390                 randconfig-r044-20211224
riscv                randconfig-r042-20211224
hexagon              randconfig-r041-20211223
hexagon              randconfig-r045-20211223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
