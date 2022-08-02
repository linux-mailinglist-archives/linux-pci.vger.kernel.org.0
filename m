Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED23558832F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 22:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiHBUoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBUog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 16:44:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A33DBE4
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659473075; x=1691009075;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mrzPS7r1QAZNJt/kWIs8CnSFhbOIFH1KXNcKSz47cVc=;
  b=enQyYRQPduWTkA7E5bIPytneA+8P0pm5C9F6+ppZiqeVxygVtFzd+D0Q
   mIscIII6iT7shpxgSqn1vnwKIgt7E+FjAWg3OVibeN7XIDBJwOnuxjaRD
   7PfN9zqt8HYffcSP+8FOHW3We3IvQsmuuN9psv/x7sbMy2kGw24WsLQGD
   OGSRaep24r6ALNcEiwVhUUS88HjYfI8wSaSxjTF0n+3GnAQiieBVVOVyB
   iNVXTA/VXq0YQs+7ycwCUAG2DukHbIBRGAPujIVB2lsnA1vkL9ePFC1Tr
   c26xiXLX6HK03jEuR1DwsPpUteBUA/52GFpW83E4we0cZ1iCJX768eC+5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="375816719"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="375816719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="602575341"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 13:44:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIyki-000GQL-2O;
        Tue, 02 Aug 2022 20:44:32 +0000
Date:   Wed, 03 Aug 2022 04:43:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/exynos] BUILD SUCCESS
 22f3571cbc84b9150238a43d271ffbf7fad3d81d
Message-ID: <62e98c88.jh4WYZdwhQ7GWc6G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/exynos
branch HEAD: 22f3571cbc84b9150238a43d271ffbf7fad3d81d  PCI: exynos: Correct generic PHY usage

elapsed time: 1437m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                             allyesconfig
x86_64                              defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220801
i386                 randconfig-a012-20220801
mips                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
i386                 randconfig-a013-20220801
i386                 randconfig-a014-20220801
i386                 randconfig-a011-20220801
s390                 randconfig-r044-20220801
i386                 randconfig-a016-20220801
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a015-20220801
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a016-20220801
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-k001-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a013-20220801
riscv                randconfig-r042-20220801
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220801
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
mips                    maltaup_xpa_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc837x_rdb_defconfig
riscv                    nommu_k210_defconfig
sh                           se7722_defconfig
xtensa                           alldefconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                        warp_defconfig
powerpc                       ppc64_defconfig
ia64                             alldefconfig
arm                           tegra_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        mini2440_defconfig
powerpc                    adder875_defconfig
powerpc                     mpc83xx_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                        vdk_hs38_defconfig

clang tested configs:
hexagon              randconfig-r045-20220801
x86_64               randconfig-a002-20220801
hexagon              randconfig-r041-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a002-20220801
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
hexagon                             defconfig
powerpc                      katmai_defconfig
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
arm                              alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
