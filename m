Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E387D6FB860
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjEHUjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHUjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 16:39:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CEB5279
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578384; x=1715114384;
  h=date:from:to:cc:subject:message-id;
  bh=d71k6WJq6ru/alEHNTJUjN6LPCkdzRLeYTUP3NZ0Dag=;
  b=jMCFFnOPuBaKsYDOTJu/VohzrvnCRQsLKRVfmmPCaokv90aghnum6MSs
   LvP0dI4tWT8tPLzw2wHjmL2i6Z26aizgLIyj8+eBPR4sbR4xMpZPk5vw5
   JcC2HgQT7Vc2yTTbcHf9zn4j1yrpLENHi8t6DQoirAy7Ny1eGFOINJLl2
   Sq8v4/QZotrk/yTkt2IzEr91F2koelPS1EUDldpBN3bvfutUZ/bTHhN0i
   NwA/FbcgxgEalMm15CHcHGzoHFdNjMp1nw243aEr7GOwYGCfARL9v5b2M
   NxwlmSxLCD+y+BnjuYdXybqu3oSOR1FJjt6XlpNboPYPNWZTiJsav1ugN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348578838"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="348578838"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822825111"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="822825111"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2023 13:39:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw7dz-0001Ox-2w;
        Mon, 08 May 2023 20:39:39 +0000
Date:   Tue, 09 May 2023 04:39:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/endpoint] BUILD SUCCESS
 25b4630332e48a25c2e6f9bfa7646d1c08c0105d
Message-ID: <20230508203927.6NhIX%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/endpoint
branch HEAD: 25b4630332e48a25c2e6f9bfa7646d1c08c0105d  PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

elapsed time: 726m

configs tested: 124
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230507   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230508   gcc  
arc                  randconfig-r031-20230507   gcc  
arc                  randconfig-r032-20230507   gcc  
arc                  randconfig-r033-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230507   gcc  
arm          buildonly-randconfig-r002-20230508   clang
arm          buildonly-randconfig-r003-20230507   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230508   clang
arm                  randconfig-r026-20230508   clang
arm                  randconfig-r032-20230508   gcc  
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230507   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230507   clang
csky                                defconfig   gcc  
csky                 randconfig-r035-20230507   gcc  
hexagon              randconfig-r012-20230508   clang
hexagon              randconfig-r026-20230507   clang
hexagon              randconfig-r035-20230508   clang
hexagon              randconfig-r036-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r021-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r024-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230508   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230508   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230507   gcc  
microblaze   buildonly-randconfig-r005-20230507   gcc  
microblaze           randconfig-r001-20230507   gcc  
microblaze           randconfig-r002-20230507   gcc  
microblaze           randconfig-r014-20230508   gcc  
microblaze           randconfig-r034-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230507   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r036-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230508   gcc  
parisc               randconfig-r024-20230507   gcc  
parisc               randconfig-r033-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230507   gcc  
powerpc              randconfig-r006-20230507   gcc  
powerpc              randconfig-r023-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230507   clang
riscv        buildonly-randconfig-r005-20230508   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230508   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230508   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230507   gcc  
sparc                randconfig-r016-20230508   gcc  
sparc64              randconfig-r013-20230508   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
