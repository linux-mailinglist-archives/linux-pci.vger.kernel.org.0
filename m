Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C953D54C008
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 05:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiFODPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiFODPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 23:15:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C94ECEB
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655262901; x=1686798901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pEDClfRWLCCUg2XExFaLL7wswWY3J2Rnurc3aFqjjcs=;
  b=C4NvpvWM3pKeppjdIdFA+HmYv2PsURQkPIf1Fo9vca4yIf5xxk/E+JGd
   lHej8TgFjpClQ2X8m6t4FxuD74j5WQqZWDxl7m+dzJhglMS89jj3XetYS
   roZQsXSh4iw4q0Bn+YmgwdAwpDNBDaoSf1Q8FY3daCtYilyPUXeiSaiUV
   LiZjSf+ItkKom/V69jXsOjVSCAMIMWcyhLM/oP68HmS7q0iQB2T6/qwlF
   wtxZX18lAO3Cloya/RT4eNkCULItMTnKUB+Wq184dao5oGIymVwmoX+kw
   +VHiOtaQeaibMtxwit6Upwiush38ryO5a7Hy4/v1yD7z6w+n6EpwLbzwy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340479429"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340479429"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830786177"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2022 20:14:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1JUg-000MWt-Ua;
        Wed, 15 Jun 2022 03:14:58 +0000
Date:   Wed, 15 Jun 2022 11:14:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/aardvark] BUILD SUCCESS
 bcdb6fd4f3e9ac1097698c8d8f56b70853b49873
Message-ID: <62a94ea7.3AB1uWAmbdB0HYzO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/aardvark
branch HEAD: bcdb6fd4f3e9ac1097698c8d8f56b70853b49873  PCI: aardvark: Fix reporting Slot capabilities on emulated bridge

elapsed time: 1615m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220613
m68k                       m5249evb_defconfig
mips                         bigsur_defconfig
m68k                       m5275evb_defconfig
arm                       imx_v6_v7_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
s390                          debug_defconfig
arm                            mps2_defconfig
xtensa                         virt_defconfig
arm                        mini2440_defconfig
powerpc                     pq2fads_defconfig
sh                          r7780mp_defconfig
powerpc                   motionpro_defconfig
arm                             pxa_defconfig
arm                            hisi_defconfig
arm                             ezx_defconfig
sh                           se7206_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
mips                         cobalt_defconfig
arm                         axm55xx_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
arm                           u8500_defconfig
microblaze                          defconfig
arc                      axs103_smp_defconfig
arm                  randconfig-c002-20220613
x86_64               randconfig-c001-20220613
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220613
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a012-20220613
x86_64               randconfig-a013-20220613
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
s390                 randconfig-r044-20220613
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64               randconfig-c007-20220613
arm                  randconfig-c002-20220613
i386                 randconfig-c001-20220613
powerpc              randconfig-c003-20220613
riscv                randconfig-c006-20220613
s390                 randconfig-c005-20220613
mips                      malta_kvm_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      katmai_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                           allyesconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a006-20220613
i386                 randconfig-a005-20220613
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
