Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA646774EFD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 01:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjHHXKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHHXKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 19:10:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB2101
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691536218; x=1723072218;
  h=date:from:to:cc:subject:message-id;
  bh=uSUz4qIK2oi2KMUbRTfGMkKosNjJ5m4Tj/4OcFeWTPk=;
  b=SgevbuPrHCTdSp3FKSDN6ufpWnX36dfKLM6Fc7GFyIeVuLU97Hn+5nKW
   jQWkCd05gi/upkDIMuHyP4HYcG33mxcYeVXxh2BRie6S7uyCpAYPOudjP
   2xl/y/W5RmtZhU2qj7e6hsofzwz1HOQPvfWYprN50W37b2Qn2uaCqG5K6
   3q0j7n5NBLbHr+t7woua67Gljl0fAyRei8Xv8LjBJ3QXrPYhYtdpq9lUy
   DO9qkJq1Jbf8HlsbSA0BKodeDYvbRMa0fxPx3cnyuMjMStbljer25i8Rz
   sf4sTjSi7SZw4GnGDcgo+HAzsK7gvECPinu1/wnxCbuBYt7AldA2ZstJT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437339832"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="437339832"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905409527"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="905409527"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 16:10:16 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTVqC-0005fN-01;
        Tue, 08 Aug 2023 23:10:16 +0000
Date:   Wed, 09 Aug 2023 07:09:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/microchip] BUILD SUCCESS
 bac406c34fbc906f09479af72cb6a908a5d1db1d
Message-ID: <202308090731.Rni4zmh4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/microchip
branch HEAD: bac406c34fbc906f09479af72cb6a908a5d1db1d  PCI: microchip: Re-partition code between probe() and init()

elapsed time: 721m

configs tested: 105
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230808   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230808   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230808   gcc  
arm                  randconfig-r011-20230808   clang
arm                  randconfig-r046-20230808   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230808   gcc  
csky                 randconfig-r022-20230808   gcc  
hexagon              randconfig-r041-20230808   clang
hexagon              randconfig-r045-20230808   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230808   clang
i386         buildonly-randconfig-r005-20230808   clang
i386         buildonly-randconfig-r006-20230808   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230808   clang
i386                 randconfig-i002-20230808   clang
i386                 randconfig-i003-20230808   clang
i386                 randconfig-i004-20230808   clang
i386                 randconfig-i005-20230808   clang
i386                 randconfig-i006-20230808   clang
i386                 randconfig-i011-20230808   gcc  
i386                 randconfig-i012-20230808   gcc  
i386                 randconfig-i013-20230808   gcc  
i386                 randconfig-i014-20230808   gcc  
i386                 randconfig-i015-20230808   gcc  
i386                 randconfig-i016-20230808   gcc  
i386                 randconfig-r012-20230808   gcc  
i386                 randconfig-r032-20230808   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r006-20230808   gcc  
microblaze           randconfig-r023-20230808   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230808   gcc  
openrisc             randconfig-r024-20230808   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230808   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230808   clang
powerpc              randconfig-r013-20230808   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230808   gcc  
riscv                randconfig-r042-20230808   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230808   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230808   gcc  
sh                   randconfig-r035-20230808   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r021-20230808   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230808   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230808   clang
x86_64       buildonly-randconfig-r002-20230808   clang
x86_64       buildonly-randconfig-r003-20230808   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230808   gcc  
x86_64               randconfig-x001-20230808   gcc  
x86_64               randconfig-x002-20230808   gcc  
x86_64               randconfig-x003-20230808   gcc  
x86_64               randconfig-x004-20230808   gcc  
x86_64               randconfig-x005-20230808   gcc  
x86_64               randconfig-x006-20230808   gcc  
x86_64               randconfig-x011-20230808   clang
x86_64               randconfig-x012-20230808   clang
x86_64               randconfig-x013-20230808   clang
x86_64               randconfig-x014-20230808   clang
x86_64               randconfig-x015-20230808   clang
x86_64               randconfig-x016-20230808   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
