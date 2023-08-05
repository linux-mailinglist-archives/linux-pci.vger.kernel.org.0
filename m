Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E06771081
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 18:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHEQVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHEQVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 12:21:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D93C3D
        for <linux-pci@vger.kernel.org>; Sat,  5 Aug 2023 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691252503; x=1722788503;
  h=date:from:to:cc:subject:message-id;
  bh=EbNX00ty23GQ6OoG7EnK6xcR2yJtwQXlXxhcyR62YYk=;
  b=czymham5cKD1nV50B6xdgYul6T8CqVYXKhluFR2fDCW7ZRLb19wdHd78
   baHd/lHtIGgv6AcXNvU358uT+2bPzRxSZN1lBiZK4eQbJJZe7OJTMc4NF
   x8Wco2o/BBp06ojomvKTKjFWMu4a6NpSMj7PnMfNlddtAtXGcrTcNkP4l
   qxT10ePCBl8YJjRrB7J4+krjZ2k2uJsRNQcOEbO1kAIGUngLovoLP1gNZ
   y/r+0HQAe9yGcDXs9xwHDNenNfV+WZZ+TstfYqibbHf3EbLpjczahH6Yc
   j3XtC56zoMn1QUpAYSZWD+3XeTPHpyrci+x1hoCEYUdsyGN72i8poy6JX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="350635301"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="350635301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 09:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="680308845"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="680308845"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2023 09:21:40 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSK27-0003kH-1w;
        Sat, 05 Aug 2023 16:21:39 +0000
Date:   Sun, 06 Aug 2023 00:21:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 3bfc37d92687b4b19056998cebc02f94fbc81427
Message-ID: <202308060008.CgClDMOQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 3bfc37d92687b4b19056998cebc02f94fbc81427  Revert "PCI: mvebu: Mark driver as BROKEN"

elapsed time: 1076m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230731   gcc  
alpha                randconfig-r034-20230803   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230731   gcc  
arc                  randconfig-r026-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230731   gcc  
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230801   gcc  
csky                 randconfig-r036-20230803   gcc  
hexagon              randconfig-r001-20230731   clang
hexagon              randconfig-r016-20230801   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r002-20230731   gcc  
microblaze           randconfig-r013-20230801   gcc  
microblaze           randconfig-r025-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230801   gcc  
mips                 randconfig-r022-20230731   gcc  
mips                 randconfig-r033-20230803   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230801   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230801   clang
s390                 randconfig-r032-20230803   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230803   gcc  
sparc64              randconfig-r035-20230803   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230805   gcc  
x86_64               randconfig-x012-20230805   gcc  
x86_64               randconfig-x013-20230805   gcc  
x86_64               randconfig-x014-20230805   gcc  
x86_64               randconfig-x015-20230805   gcc  
x86_64               randconfig-x016-20230805   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
