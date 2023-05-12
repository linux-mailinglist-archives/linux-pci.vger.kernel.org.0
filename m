Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583B70070E
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbjELLnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjELLnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 07:43:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FD1BFB
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683891827; x=1715427827;
  h=date:from:to:cc:subject:message-id;
  bh=mSBaXlvjFqJOB8m6uow+9qWHgQr8QtSROnBqywRgflo=;
  b=ciJGl8qfb88gOesOVR/c84Kz4M2Iy68Iz5ALpjzNtC3+SAT3ZGEMRz0P
   OpskGwuGPHgtfrQXGt9rBQW0BBOrY76JwSDhf+pFgaqclUaSVJjjDEv9Y
   mPFfsGM6Hxpt/NYQTrJUmnvBJb3UkTyVEhhZz8ikvI6jzFdoLKgZObuRN
   nZPDcahRAfIbGuxrYhFSXESlVFUL104RvocjBTTL+bL1Lc+uQhvUpCoYG
   rSZ4xgnQSHLcMZjkZ1gjJcUY4jSyai0o+h7qYEyIaiWw7elgV+g+BB/UA
   ZgjrDJtDsqSLOGRQLBrCDM3VYmDgh04Y57AgIlFmMxF7mcHfX6Cue+Gd+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="437104381"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="437104381"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765152422"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765152422"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2023 04:43:46 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxRBa-0004p6-0G;
        Fri, 12 May 2023 11:43:46 +0000
Date:   Fri, 12 May 2023 19:43:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 3b8803494a0612acdeee714cb72aa142b1e05ce5
Message-ID: <20230512114301.LOlrX%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 3b8803494a0612acdeee714cb72aa142b1e05ce5  PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

elapsed time: 726m

configs tested: 139
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230510   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230511   gcc  
alpha                randconfig-r004-20230511   gcc  
alpha                randconfig-r006-20230511   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc          buildonly-randconfig-r002-20230510   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230509   gcc  
arc                  randconfig-r005-20230511   gcc  
arc                  randconfig-r036-20230512   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230511   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230509   gcc  
arm64                randconfig-r001-20230511   clang
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r004-20230509   gcc  
csky         buildonly-randconfig-r003-20230510   gcc  
csky         buildonly-randconfig-r006-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230511   gcc  
csky                 randconfig-r026-20230511   gcc  
hexagon      buildonly-randconfig-r003-20230511   clang
hexagon      buildonly-randconfig-r004-20230510   clang
hexagon      buildonly-randconfig-r004-20230511   clang
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
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
ia64                 randconfig-r013-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230510   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230511   gcc  
m68k                 randconfig-r031-20230512   gcc  
microblaze           randconfig-r001-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230509   clang
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230512   gcc  
nios2                randconfig-r036-20230509   gcc  
openrisc             randconfig-r002-20230511   gcc  
openrisc             randconfig-r011-20230511   gcc  
openrisc             randconfig-r033-20230511   gcc  
openrisc             randconfig-r035-20230511   gcc  
openrisc             randconfig-r036-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc               randconfig-r024-20230511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230512   clang
powerpc      buildonly-randconfig-r004-20230512   clang
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc              randconfig-r005-20230509   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230509   gcc  
riscv                randconfig-r034-20230509   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230509   gcc  
s390                 randconfig-r022-20230511   gcc  
s390                 randconfig-r033-20230509   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230511   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc                randconfig-r035-20230512   gcc  
sparc64              randconfig-r006-20230509   gcc  
sparc64              randconfig-r032-20230509   gcc  
sparc64              randconfig-r032-20230511   gcc  
sparc64              randconfig-r032-20230512   gcc  
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
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230510   gcc  
xtensa               randconfig-r001-20230511   gcc  
xtensa               randconfig-r006-20230511   gcc  
xtensa               randconfig-r015-20230511   gcc  
xtensa               randconfig-r035-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
