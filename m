Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAED72AA5A
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFJIl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jun 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJIl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Jun 2023 04:41:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FCC3A85
        for <linux-pci@vger.kernel.org>; Sat, 10 Jun 2023 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686386485; x=1717922485;
  h=date:from:to:cc:subject:message-id;
  bh=tF8khpyhju1Iu69SFDTPaZ9vB7YpSWMG9ZmVGwi2dnQ=;
  b=W5apUPfBpJhriMHoPmE0KOukvgBcR2a0ydMu4+CEXK9TscSZoAPrhEBb
   VcmiVi6WbE8LgRuQH/q2M3xrHPVt919dhjj2mYlVgtOcvCbonwZ/K3a5O
   ilfgyEc9fvziFGCn7pHEKKBimEY1symZtjcbEfUQvU+40IyvOzKT7HA6o
   Q+UDtVD7dQiaWHZrJh70PwEKdPcPjM2ir55HHMpeimzyVB2copKjNsbtU
   dXLnF4QAcXSb5NEvX7+XIWHrjKavIBwCnCagyaZwGVW+r+i38eK+JRE31
   PnI8rQOx6+EjYA45xHnv2Hr612RKp4xLmcVEWnGXhFy7aPoYdh+MTuUz9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="386117401"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="386117401"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 01:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713775239"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="713775239"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2023 01:41:24 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7uA0-0009uf-0W;
        Sat, 10 Jun 2023 08:41:24 +0000
Date:   Sat, 10 Jun 2023 16:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 5b9283e1ec21b426888005ceb3e5be46c0e6aaff
Message-ID: <202306101643.w4f9oROq-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 5b9283e1ec21b426888005ceb3e5be46c0e6aaff  Merge branch 'pci/controller/endpoint'

elapsed time: 726m

configs tested: 142
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r033-20230608   gcc  
arc                  randconfig-r043-20230609   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230608   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r046-20230609   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230608   gcc  
hexagon      buildonly-randconfig-r002-20230608   clang
hexagon              randconfig-r001-20230608   clang
hexagon              randconfig-r011-20230610   clang
hexagon              randconfig-r014-20230610   clang
hexagon              randconfig-r015-20230610   clang
hexagon              randconfig-r041-20230609   clang
hexagon              randconfig-r045-20230609   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230610   clang
i386                 randconfig-i002-20230610   clang
i386                 randconfig-i003-20230610   clang
i386                 randconfig-i004-20230610   clang
i386                 randconfig-i005-20230610   clang
i386                 randconfig-i006-20230610   clang
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i014-20230608   clang
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i016-20230608   clang
i386                 randconfig-i051-20230609   clang
i386                 randconfig-i052-20230609   clang
i386                 randconfig-i053-20230609   clang
i386                 randconfig-i054-20230609   clang
i386                 randconfig-i055-20230609   clang
i386                 randconfig-i056-20230609   clang
i386                 randconfig-i061-20230608   gcc  
i386                 randconfig-i062-20230608   gcc  
i386                 randconfig-i063-20230608   gcc  
i386                 randconfig-i064-20230608   gcc  
i386                 randconfig-i065-20230608   gcc  
i386                 randconfig-i066-20230608   gcc  
i386                 randconfig-r003-20230608   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230608   gcc  
microblaze           randconfig-r034-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230610   gcc  
openrisc             randconfig-r026-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230608   gcc  
parisc       buildonly-randconfig-r006-20230608   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc              randconfig-r025-20230608   clang
powerpc                     skiroot_defconfig   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230608   gcc  
riscv                randconfig-r036-20230608   gcc  
riscv                randconfig-r042-20230609   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230610   gcc  
s390                 randconfig-r023-20230608   clang
s390                 randconfig-r044-20230609   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230608   gcc  
sparc                randconfig-r035-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230608   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-r021-20230608   clang
x86_64               randconfig-x051-20230610   gcc  
x86_64               randconfig-x052-20230610   gcc  
x86_64               randconfig-x053-20230610   gcc  
x86_64               randconfig-x054-20230610   gcc  
x86_64               randconfig-x055-20230610   gcc  
x86_64               randconfig-x056-20230610   gcc  
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
