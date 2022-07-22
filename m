Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329A857E98E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 00:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiGVWOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 18:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGVWOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 18:14:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505CCA9B96
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658528083; x=1690064083;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FqSj+BapONT0uWHu6Wa47AQQry2W0Y0hDTriIX/N1mA=;
  b=d9+mR8/NRyvs25ZPVmActJgrTRgQF1uf6Qyp6NOMSpqzGWKUQ5c0u8Dj
   qdcAJDcXtbfok8vPk4jWonN4lb+FEuR4dzekLZg9hOzCrywiewAtFOuAz
   bZea6G/Hkr8HQibPGjXW7Gy+3v8xtxOHtBMk+MHBnMzRggrUZvxF58RI4
   u8bwMQ+CtxQJUZE9jiJz2zkcw29105sdiXw5YPraS/0HQkYj3gKcnkZan
   w3GbHPvYB5rQZsBlyQc7AFh+uiCsykpPNuaUEs6sQ99O3XgTWtqbVfMrl
   cGrvMo4tT47hQyW9NJ5EtH8HUeP8yqDzGO2nOsXvmivmrqD4mew2/8bIf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="270451452"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="270451452"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 15:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="549322117"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2022 15:14:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF0uu-0001sV-2x;
        Fri, 22 Jul 2022 22:14:40 +0000
Date:   Sat, 23 Jul 2022 06:14:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/pm-ops] BUILD SUCCESS
 5f4053d43a941d0ae7844fd07da10080eb2fc41d
Message-ID: <62db2130.27DQlukYrATKv7LA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/pm-ops
branch HEAD: 5f4053d43a941d0ae7844fd07da10080eb2fc41d  PCI: Convert to new *_PM_OPS macros

elapsed time: 1794m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
sh                               j2_defconfig
arc                          axs101_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                           allyesconfig
arc                        vdk_hs38_defconfig
powerpc                       maple_defconfig
powerpc                      makalu_defconfig
parisc                              defconfig
arc                      axs103_smp_defconfig
m68k                        mvme147_defconfig
mips                     loongson1b_defconfig
arm                         at91_dt_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
powerpc                     sequoia_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
powerpc                    amigaone_defconfig
arm                     eseries_pxa_defconfig
sh                        edosk7760_defconfig
sh                          rsk7203_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
sparc                               defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220721
x86_64                        randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
arm                          pxa168_defconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220722
hexagon              randconfig-r045-20220722

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
