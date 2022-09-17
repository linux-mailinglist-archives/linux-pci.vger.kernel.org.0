Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D165BB5F6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 05:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIQDv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 23:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQDv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 23:51:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59828E39
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663386715; x=1694922715;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VmZwmJiij/LK0wJSn8MXPqGa1YVEkfEayVmu9shm0b0=;
  b=bXwlGQgcdC5k9u1sgjjBywllcBQP9Efqwqi6WlSZS/DvA48pAGnw5TDC
   aTv9gY1+bkStDvo5YNrOA9Mx+zpzAtficnuLrnsSRN9qZl0kGxXKfCLya
   GI1MbSr2HRDvLA7U9DYqiuVq/wNqCzmfrIwC+PRcY5xgFAlwYqgqEB1Tb
   eMRmzJaEnPR4/YTWtW9/D9L1xAqM8aAr6bgATUM65U8cNye7JHMxWBBqW
   +edoxuVEsgJl+KHwIb3O6FyCYdrpc0qPTcQg9qj1thoPaXnlbCSZgsnIi
   sLPgHYf4SbCoXlbLqjnhhKbU3eVMGqdg5uGlQiqvS6GlB2wxu5Pdv+irG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325399585"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="325399585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 20:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="946600883"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2022 20:51:54 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZOrx-0002Rz-21;
        Sat, 17 Sep 2022 03:51:53 +0000
Date:   Sat, 17 Sep 2022 11:51:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/aardvark] BUILD SUCCESS
 a080f9ad604598a4d32ea36fbf96437c92ccacb4
Message-ID: <63254430.lS+93yJO6GdSwTA7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/aardvark
branch HEAD: a080f9ad604598a4d32ea36fbf96437c92ccacb4  PCI: aardvark: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge

elapsed time: 843m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
x86_64                           allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
s390                                defconfig
arc                  randconfig-r043-20220916
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                        nsimosci_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
mips                     loongson1b_defconfig
powerpc                      bamboo_defconfig
arm64                               defconfig
powerpc                      pcm030_defconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sparc                               defconfig
powerpc                      pasemi_defconfig
i386                          randconfig-a005
arm                       omap2plus_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
openrisc                 simple_smp_defconfig
xtensa                    xip_kc705_defconfig
mips                    maltaup_xpa_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                           se7724_defconfig
m68k                          atari_defconfig
sh                          rsk7269_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
csky                             alldefconfig
powerpc                     tqm8548_defconfig
m68k                        m5307c3_defconfig
sh                          lboxre2_defconfig
mips                 decstation_r4k_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220916
loongarch                           defconfig
loongarch                         allnoconfig
mips                      loongson3_defconfig
sh                          r7785rp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                            shmin_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                                defconfig
m68k                        stmark2_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                         lpc18xx_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g5_defconfig
arm                           h3600_defconfig
openrisc                    or1ksim_defconfig
arm                           imxrt_defconfig
sh                            titan_defconfig
m68k                       m5275evb_defconfig
powerpc                   motionpro_defconfig
ia64                             allmodconfig
sh                          polaris_defconfig
arm                           sama5_defconfig

clang tested configs:
riscv                randconfig-r042-20220916
hexagon              randconfig-r041-20220916
s390                 randconfig-r044-20220916
hexagon              randconfig-r045-20220916
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220917
hexagon              randconfig-r041-20220917
arm                                 defconfig
mips                      maltaaprp_defconfig
arm                          moxart_defconfig
arm                         lpc32xx_defconfig
arm                         orion5x_defconfig
mips                           rs90_defconfig
powerpc                    gamecube_defconfig
mips                       rbtx49xx_defconfig
arm                         mv78xx0_defconfig
arm                       mainstone_defconfig
x86_64                           allyesconfig
powerpc                     kmeter1_defconfig
powerpc                      acadia_defconfig
arm                          ixp4xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
