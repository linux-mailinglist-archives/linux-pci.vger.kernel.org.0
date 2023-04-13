Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA556E0414
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 04:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDMC0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDMC0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 22:26:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7062D43
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681352794; x=1712888794;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PYu9/0RVxRIzPSNRqu5cKiBvH+OLhniGqejowZPL+6Y=;
  b=Fcl2VEAD3GTWP7Om4zM1SI8C08J1zexfNXaVK8gixw3V292h5Xuw4rDh
   ckG+YQ1D+vmJMqtbeCHzNuh8AOuBPGNnpGg9WK3HXBFihz6KtNIsAFgJ/
   58kozyM7jesWJiBRBfdfYL8bG9QrBMdtR2s3SWg/HC/YJqJBu3l2MO6e5
   XfAdv+jmkVVAS7OeXDOGjNL39v0AeQODdjvXgPZJZDxXjUAusRiFfSQXJ
   nND4U3XVYTntPsUic6dPZgZRWyMRYPQ1/Aw0xDwLCDfWNJNjSpLvrQcDW
   bZJqRO+f1lgVQ8y8EjAwp9CmFtx0PZyWmDJ0CyGdONTkK+uFO/X0N2ca0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328182054"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328182054"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 19:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639455023"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639455023"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2023 19:26:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmmfP-000YGb-1I;
        Thu, 13 Apr 2023 02:26:31 +0000
Date:   Thu, 13 Apr 2023 10:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 c025c7e5dbf4706279183c16788fa83001b8331e
Message-ID: <64376822.G4QCbaXDAkDXwaWz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: c025c7e5dbf4706279183c16788fa83001b8331e  dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties

elapsed time: 726m

configs tested: 215
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc          buildonly-randconfig-r006-20230410   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r002-20230409   gcc  
arc                  randconfig-r005-20230409   gcc  
arc                  randconfig-r005-20230412   gcc  
arc                  randconfig-r013-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230412   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230412   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r025-20230412   gcc  
arm64                randconfig-r026-20230409   gcc  
arm64                randconfig-r035-20230409   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
csky                 randconfig-r031-20230412   gcc  
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r033-20230409   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r045-20230412   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r036-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r015-20230410   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r032-20230412   gcc  
ia64                 randconfig-r035-20230413   gcc  
ia64                 randconfig-r036-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230410   gcc  
loongarch    buildonly-randconfig-r004-20230409   gcc  
loongarch    buildonly-randconfig-r004-20230410   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
loongarch            randconfig-r016-20230410   gcc  
loongarch            randconfig-r021-20230410   gcc  
loongarch            randconfig-r031-20230412   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230410   gcc  
m68k         buildonly-randconfig-r005-20230409   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
microblaze   buildonly-randconfig-r006-20230409   gcc  
microblaze           randconfig-r004-20230409   gcc  
microblaze           randconfig-r004-20230412   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
microblaze           randconfig-r035-20230412   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r001-20230410   gcc  
mips         buildonly-randconfig-r002-20230409   gcc  
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                           mtx1_defconfig   clang
mips                 randconfig-r036-20230412   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230409   gcc  
nios2                randconfig-r011-20230409   gcc  
openrisc     buildonly-randconfig-r002-20230409   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r024-20230410   gcc  
openrisc             randconfig-r024-20230412   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230410   gcc  
parisc               randconfig-r012-20230409   gcc  
parisc               randconfig-r022-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc               randconfig-r033-20230413   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230410   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r026-20230410   gcc  
powerpc              randconfig-r034-20230409   clang
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230412   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230409   gcc  
s390                 randconfig-r025-20230410   gcc  
s390                 randconfig-r031-20230413   gcc  
s390                 randconfig-r033-20230410   clang
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230412   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r001-20230412   gcc  
sh                   randconfig-r014-20230409   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230409   gcc  
sh                   randconfig-r023-20230410   gcc  
sh                   randconfig-r026-20230409   gcc  
sh                   randconfig-r032-20230410   gcc  
sh                          rsk7264_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230409   gcc  
sparc        buildonly-randconfig-r004-20230409   gcc  
sparc        buildonly-randconfig-r005-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230409   gcc  
sparc                randconfig-r023-20230412   gcc  
sparc                randconfig-r032-20230412   gcc  
sparc64      buildonly-randconfig-r005-20230410   gcc  
sparc64              randconfig-r003-20230410   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r006-20230412   gcc  
sparc64              randconfig-r021-20230409   gcc  
sparc64              randconfig-r022-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r022-20230410   gcc  
x86_64               randconfig-r025-20230410   gcc  
x86_64               randconfig-r034-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230409   gcc  
xtensa               randconfig-r002-20230410   gcc  
xtensa               randconfig-r006-20230409   gcc  
xtensa               randconfig-r034-20230412   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
