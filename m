Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C254E989
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377788AbiFPSiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiFPSiN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 14:38:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A73BA7F
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655404693; x=1686940693;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iOON1hVkFS/qyb4cphe8B5L7Lk/nQyZJa3J8UZs65I8=;
  b=O1DzNTTmq0hAQOBdtBRUVhNGI+ZYA4tT/HTbI5Ks2bc9cXM5u/3BaLeR
   Lexh7OK1q7NwzNZq8tZXbRE/KbeZHXHk8oFdH3mezyyX+4zq+odxR7F+C
   RmBsQyLLxNuNY/YbqPoSrlLyiz1E/KbMpwga8sqd5JTLyDrHtvP2acR/V
   mlHdkf0UYp5laadU3m8nL99G04MdSE1kFdeVeDpvMsfJ2ebfk35n+pdXZ
   NmsEXFGvGYrzcfAhHpCgSSabLxH9He8QzNBM347+FHUGVpJO1igSfQ14O
   yL/dglt7jV37gv/EM6pVKWoU/AbTkRb4kMT/Rg8YmF3xN5mlnJyogmE7F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="340978277"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="340978277"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831683404"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 11:38:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1uNe-000OfN-TG;
        Thu, 16 Jun 2022 18:38:10 +0000
Date:   Fri, 17 Jun 2022 02:38:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/imx6] BUILD SUCCESS
 2916be82737c949c49ab640d422f3352d843340a
Message-ID: <62ab788d.uDe6i074HLw/2Jkp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/imx6
branch HEAD: 2916be82737c949c49ab640d422f3352d843340a  PCI: imx6: Disable clocks in reverse order of enable

elapsed time: 1021m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
s390                          debug_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
um                                  defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
arm                         lubbock_defconfig
powerpc                         ps3_defconfig
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                             pxa_defconfig
sh                ecovec24-romimage_defconfig
mips                            ar7_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5307c3_defconfig
arc                              allyesconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
m68k                        stmark2_defconfig
arc                    vdk_hs38_smp_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
sh                             shx3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5249evb_defconfig
powerpc                      makalu_defconfig
m68k                       m5275evb_defconfig
arm                            xcep_defconfig
arm                         nhk8815_defconfig
xtensa                         virt_defconfig
arm                        clps711x_defconfig
arm                           sunxi_defconfig
mips                       capcella_defconfig
nios2                         10m50_defconfig
microblaze                      mmu_defconfig
arc                         haps_hs_defconfig
m68k                                defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
mips                             allmodconfig
sparc                               defconfig
m68k                          hp300_defconfig
sh                        sh7763rdp_defconfig
powerpc                   motionpro_defconfig
powerpc                         wii_defconfig
arm                        trizeps4_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
arm                      integrator_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220616
ia64                                defconfig
ia64                             allmodconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath79_defconfig
powerpc                          g5_defconfig
powerpc                     mpc512x_defconfig
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8540_defconfig
powerpc                       ebony_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    socrates_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
