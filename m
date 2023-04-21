Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CE6EB455
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjDUWC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjDUWC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 18:02:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345BAC
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682114546; x=1713650546;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TJwreCz9AqqBhevyHJru7XYMF+33A4Y0T0YxX1BvNAE=;
  b=mrl+xuQ/+XpCBNYWjVy1sCJNReaBfBk+EhXm4vIt3NXKI8kCp1E/k51B
   RMS1vwqDFANDbqwyKaOvTPFHnaOXbT1aCNT8i40m1Rlim+uLn+Ywr4GZp
   oeI9ZvhiOUnZEnU1d74EqvydpPg7E8OyDHjvBIHFuxQ8gOBiCGWWz4dj7
   p7jKxEG/8LMn9oCPC/iGG77rUtMRuNwc/3LX+NqQFZ9HFfoRm0Jj/WoHU
   UotU8F5jM9p3MybiZy1kP2EUkxnav4jjOfGRlbYRWu4Ys45AdBfQuo75D
   VX2p32xwqPu2EIgWcfv8EhMpD2uuiRUGL5a40Z4Gc3pZBNXB4jcu2xjIF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411363803"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="411363803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 15:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866828091"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866828091"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 15:02:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppypk-000gqm-1H;
        Fri, 21 Apr 2023 22:02:24 +0000
Date:   Sat, 22 Apr 2023 06:01:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 eac223e852082407b1bd1624de3f6b6ad5372369
Message-ID: <644307b8.KMYvOA9iHuCMQpR4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: eac223e852082407b1bd1624de3f6b6ad5372369  PCI: cadence: Fix Gen2 Link Retraining process

elapsed time: 727m

configs tested: 155
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230421   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230421   gcc  
alpha                randconfig-r023-20230421   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230421   gcc  
arc                  randconfig-r006-20230421   gcc  
arc                  randconfig-r031-20230421   gcc  
arc                  randconfig-r033-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230421   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230421   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230421   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230421   gcc  
csky                 randconfig-r015-20230421   gcc  
csky                 randconfig-r023-20230421   gcc  
csky                 randconfig-r025-20230421   gcc  
csky                 randconfig-r036-20230421   gcc  
hexagon      buildonly-randconfig-r001-20230421   clang
hexagon              randconfig-r022-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230421   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230421   gcc  
ia64                 randconfig-r022-20230421   gcc  
ia64                 randconfig-r034-20230421   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230421   gcc  
loongarch            randconfig-r035-20230421   gcc  
loongarch            randconfig-r036-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230421   gcc  
m68k                 randconfig-r014-20230421   gcc  
m68k                 randconfig-r016-20230421   gcc  
microblaze           randconfig-r012-20230421   gcc  
microblaze           randconfig-r013-20230421   gcc  
microblaze           randconfig-r015-20230421   gcc  
microblaze           randconfig-r024-20230421   gcc  
microblaze           randconfig-r034-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230421   gcc  
mips                 randconfig-r022-20230421   gcc  
nios2        buildonly-randconfig-r002-20230421   gcc  
nios2        buildonly-randconfig-r005-20230421   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230421   gcc  
nios2                randconfig-r026-20230421   gcc  
nios2                randconfig-r035-20230421   gcc  
openrisc     buildonly-randconfig-r002-20230421   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc     buildonly-randconfig-r006-20230421   gcc  
openrisc             randconfig-r031-20230421   gcc  
openrisc             randconfig-r032-20230421   gcc  
parisc       buildonly-randconfig-r002-20230421   gcc  
parisc       buildonly-randconfig-r004-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230421   gcc  
parisc               randconfig-r024-20230421   gcc  
parisc               randconfig-r036-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230421   clang
powerpc              randconfig-r002-20230421   gcc  
powerpc              randconfig-r022-20230421   clang
powerpc              randconfig-r025-20230421   clang
powerpc              randconfig-r032-20230421   gcc  
powerpc              randconfig-r033-20230421   gcc  
powerpc              randconfig-r034-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230421   clang
riscv        buildonly-randconfig-r005-20230421   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230421   gcc  
riscv                randconfig-r035-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230421   clang
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230421   gcc  
sh                   randconfig-r012-20230421   gcc  
sparc        buildonly-randconfig-r004-20230421   gcc  
sparc        buildonly-randconfig-r005-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230421   gcc  
sparc                randconfig-r021-20230421   gcc  
sparc                randconfig-r034-20230421   gcc  
sparc64      buildonly-randconfig-r001-20230421   gcc  
sparc64              randconfig-r025-20230421   gcc  
sparc64              randconfig-r035-20230421   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230417   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230417   clang
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230417   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230417   clang
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230417   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230421   gcc  
xtensa               randconfig-r013-20230421   gcc  
xtensa               randconfig-r021-20230421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
