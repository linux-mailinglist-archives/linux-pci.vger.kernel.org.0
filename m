Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4396FB85D
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjEHUjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHUjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 16:39:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3EA5279
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578382; x=1715114382;
  h=date:from:to:cc:subject:message-id;
  bh=ZgLbJUXBfH/mMeAfqlgNOt65+OxpZmTm0qTKD9CtaA8=;
  b=iTtLQE2Cb8zmsMgGjyE/XRT0FRA9sZsOSBTHx1HTUz1813xw+4RcpYVQ
   W9uOk41ACyXIME0xkQNEa+SlbtvnGQQklU6+FVcgod5903xOVGrcVS+GY
   aer4WC6WPFk72pESOVNK37yAdtlrsUAxwVBr7JItP9+P08sPIJzkFKrE3
   WH3zli1LMWha3wFryAKWI9sGTigPsEswB7nzhSO0TuB/AXH4QE6TeHIyA
   uNdXf8FgJB9HL7ODNUouVrGrWuqcX6oXXJp9/Z8vr9oIdvbP1RBynK+cX
   LbOW2wbMI+1WvFTiqODedUUoOTVpS6vOZBEzlnWHdH1uLRMYP/4OoEmnQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334197476"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334197476"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944992965"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944992965"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2023 13:39:41 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw7e0-0001PL-0Q;
        Mon, 08 May 2023 20:39:40 +0000
Date:   Tue, 09 May 2023 04:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/dt] BUILD SUCCESS
 c0aba9f328019fa8ba1b771ba0146ac61ce561ad
Message-ID: <20230508203935.NK3He%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dt
branch HEAD: c0aba9f328019fa8ba1b771ba0146ac61ce561ad  dt-bindings: PCI: qcom: Add SDX65 SoC

elapsed time: 728m

configs tested: 122
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230507   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230508   gcc  
arc                  randconfig-r025-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r014-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230507   clang
csky         buildonly-randconfig-r001-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230507   gcc  
hexagon      buildonly-randconfig-r003-20230507   clang
hexagon      buildonly-randconfig-r005-20230507   clang
hexagon              randconfig-r002-20230508   clang
hexagon              randconfig-r023-20230508   clang
hexagon              randconfig-r026-20230508   clang
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
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230507   gcc  
ia64                 randconfig-r021-20230508   gcc  
ia64                 randconfig-r022-20230507   gcc  
ia64                 randconfig-r026-20230507   gcc  
ia64                 randconfig-r036-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230507   gcc  
microblaze   buildonly-randconfig-r003-20230508   gcc  
microblaze           randconfig-r002-20230507   gcc  
microblaze           randconfig-r011-20230508   gcc  
microblaze           randconfig-r033-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230508   gcc  
nios2        buildonly-randconfig-r004-20230507   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230508   gcc  
nios2                randconfig-r014-20230507   gcc  
nios2                randconfig-r024-20230507   gcc  
openrisc     buildonly-randconfig-r005-20230508   gcc  
openrisc             randconfig-r013-20230507   gcc  
openrisc             randconfig-r015-20230507   gcc  
parisc       buildonly-randconfig-r001-20230508   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230507   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230508   gcc  
sh                   randconfig-r025-20230508   gcc  
sh                   randconfig-r034-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230508   gcc  
sparc                randconfig-r035-20230507   gcc  
sparc64              randconfig-r004-20230508   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r024-20230508   gcc  
xtensa               randconfig-r031-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
