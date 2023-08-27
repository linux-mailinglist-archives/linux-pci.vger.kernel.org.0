Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD578A022
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjH0QLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjH0QKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 12:10:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0DEB
        for <linux-pci@vger.kernel.org>; Sun, 27 Aug 2023 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693152653; x=1724688653;
  h=date:from:to:cc:subject:message-id;
  bh=EHIoQwptDb/D4TQ1+Jr2VcK/smcvOTbyySZXZFipHJU=;
  b=JydWLS8lUfwItDf6mrAy1u4XmndB8FBODGxUebsyLSv9Hy96yTvwesPP
   /jzAZ1rVBIFaXosndh/rNUF3DqfF+jN+EmdmCWSko3FRUZ3BSglUASAMz
   Bl+7lyiArtaBQJ9Bkt1X5TucVF0PiOQ/DcqLoNWxPrQNuADYuRXYI09bD
   VJ/NmWef6dYf/rBtz/NVUVdDRb7mDiV9Yrv3TgDO9IihJKSBj0WsLqFDj
   ct976yz7I9apZCA00IYfMMUXjQcoeWSQZ9x7H8L3+ar9HRS/gRqIQ2YIU
   KddC0m16GViJ12qFMxLRPtVfrEV0oNNd/8RWMivQiugW2XShxgBZaKJAO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="372358198"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="372358198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 09:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="714875970"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="714875970"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2023 09:10:51 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaILi-0005yL-2H;
        Sun, 27 Aug 2023 16:10:50 +0000
Date:   Mon, 28 Aug 2023 00:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 5694ba13b004eea683c6d4faeb6d6e7a9636bda0
Message-ID: <202308280032.L58TCcoN-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 5694ba13b004eea683c6d4faeb6d6e7a9636bda0  PCI/PM: Only read PCI_PM_CTRL register when available

elapsed time: 2460m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230826   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230826   gcc  
arc                  randconfig-r021-20230826   gcc  
arc                  randconfig-r031-20230826   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230826   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230826   gcc  
csky                 randconfig-r036-20230826   gcc  
hexagon               randconfig-001-20230826   clang
hexagon               randconfig-002-20230826   clang
hexagon              randconfig-r006-20230826   clang
i386         buildonly-randconfig-001-20230826   gcc  
i386         buildonly-randconfig-002-20230826   gcc  
i386         buildonly-randconfig-003-20230826   gcc  
i386         buildonly-randconfig-004-20230826   gcc  
i386         buildonly-randconfig-005-20230826   gcc  
i386         buildonly-randconfig-006-20230826   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230826   gcc  
i386                  randconfig-002-20230826   gcc  
i386                  randconfig-003-20230826   gcc  
i386                  randconfig-004-20230826   gcc  
i386                  randconfig-005-20230826   gcc  
i386                  randconfig-006-20230826   gcc  
i386                  randconfig-011-20230826   clang
i386                  randconfig-012-20230826   clang
i386                  randconfig-013-20230826   clang
i386                  randconfig-014-20230826   clang
i386                  randconfig-015-20230826   clang
i386                  randconfig-016-20230826   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230826   gcc  
loongarch            randconfig-r022-20230826   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230826   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r025-20230826   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230826   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc64            randconfig-r011-20230826   clang
powerpc64            randconfig-r014-20230826   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230826   gcc  
riscv                randconfig-r015-20230826   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230826   clang
s390                 randconfig-r003-20230826   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r033-20230826   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230826   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r016-20230826   gcc  
sparc64              randconfig-r034-20230826   gcc  
sparc64              randconfig-r035-20230826   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r026-20230826   gcc  
um                   randconfig-r032-20230826   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230826   gcc  
x86_64       buildonly-randconfig-002-20230826   gcc  
x86_64       buildonly-randconfig-003-20230826   gcc  
x86_64       buildonly-randconfig-004-20230826   gcc  
x86_64       buildonly-randconfig-005-20230826   gcc  
x86_64       buildonly-randconfig-006-20230826   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230826   clang
x86_64                randconfig-002-20230826   clang
x86_64                randconfig-003-20230826   clang
x86_64                randconfig-004-20230826   clang
x86_64                randconfig-005-20230826   clang
x86_64                randconfig-006-20230826   clang
x86_64                randconfig-011-20230826   gcc  
x86_64                randconfig-012-20230826   gcc  
x86_64                randconfig-013-20230826   gcc  
x86_64                randconfig-014-20230826   gcc  
x86_64                randconfig-015-20230826   gcc  
x86_64                randconfig-016-20230826   gcc  
x86_64               randconfig-r004-20230826   gcc  
x86_64               randconfig-r024-20230826   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230826   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
