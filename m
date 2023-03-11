Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498496B5CC0
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCKOUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 09:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCKOTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:19:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D510E8
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 06:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678544276; x=1710080276;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/UH1QDVzPKiLOMKH1dBYYYyqb4NZa1MQ2PYuA/aqPLQ=;
  b=b1MhcAq8bmcnvzX1fIRX+/zG9uXZeyfWsOgOAoFXK9xQ3RfeesEhcjtg
   obMzEl4p9OIZoOLHZ6egqYQS0vRL8cbbIwQ4jb+K698gl0ZTca7MP9h91
   97q9JRPmfgTa0QZyGeazSJ56iahlzWwfzNwkSBjwf/oIQ7bF4FussLxlC
   s0GairEBiq0deSSF+LHvQ7rxFYWSaA3zG8yE/D0BOYaPQxJn0moQRbDVG
   7QIOOur4Lr2cQc8AZpyOw3Giu6QYDt2rLPb1qVbHlq5jHbpBhmuZdAP98
   0BYP/p5CXnCpYSq7PBQONDwnv9tVCnA/IYuZds6idVGV35RZau+BXsIXI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="316552694"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="316552694"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 06:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="747065796"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="747065796"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2023 06:17:53 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pb02j-0004cv-0I;
        Sat, 11 Mar 2023 14:17:53 +0000
Date:   Sat, 11 Mar 2023 22:17:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS b0d4fc005ef2baeb56f648d422d0e59810eddb96
Message-ID: <640c8d8a.uNR86XZ5uj8MgHcB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b0d4fc005ef2baeb56f648d422d0e59810eddb96  Merge branch 'pci/controller/rcar'

elapsed time: 921m

configs tested: 101
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230310   clang
arm                  randconfig-r026-20230310   clang
arm                  randconfig-r046-20230310   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230310   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230310   clang
hexagon              randconfig-r045-20230310   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230310   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230310   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230310   gcc  
microblaze   buildonly-randconfig-r001-20230310   gcc  
microblaze           randconfig-r013-20230310   gcc  
microblaze           randconfig-r023-20230310   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230310   gcc  
mips                 randconfig-r033-20230310   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230310   gcc  
nios2                randconfig-r024-20230310   gcc  
nios2                randconfig-r036-20230310   gcc  
openrisc             randconfig-r005-20230310   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230310   gcc  
parisc               randconfig-r021-20230310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230310   clang
powerpc              randconfig-r016-20230310   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230310   clang
s390                 randconfig-r035-20230310   clang
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230310   gcc  
sh           buildonly-randconfig-r005-20230310   gcc  
sh                   randconfig-r002-20230310   gcc  
sh                   randconfig-r032-20230310   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230310   gcc  
sparc64              randconfig-r001-20230310   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
