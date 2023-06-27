Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1B73F814
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjF0JEM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjF0JEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 05:04:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB710FC
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687856644; x=1719392644;
  h=date:from:to:cc:subject:message-id;
  bh=yxEZPy8x50KWqEZag1h+zBeAOptCJpn+cZyuG4RmddM=;
  b=Vs2QOEcUAoyzQFoW5gXypeLiiONdt3SN8yz9zJmzNxEj2/UyQZIH4OmE
   m3nT/3GzzFrWGiNin8PHaGJaHXWehHfBDwHNxQO3bPgS1v5DYZ0a+LIHw
   kJFyw8B7MaEa3fn++oWnR6ZHbBuzoESMPo507X3as4k3SbtTbjDevf19N
   ggjpdCaU3mXnJV2M0sNow7JAbCBiRN6eRe1m/USRXqNJsgupceSMvVKqt
   AbHJOkTLLk1sqnqJ9Knw5cwNaq0MHoD3KHl14kdPQUHy43C0VuTzkqQr7
   sXKt1X62seuD45v4ZLcdr41A/tlxEDT+mSxHU65z49bd2diYNx6h73epD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="361560258"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361560258"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 02:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840625422"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="840625422"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2023 02:04:03 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qE4cE-000BqC-15;
        Tue, 27 Jun 2023 09:04:02 +0000
Date:   Tue, 27 Jun 2023 17:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 6ecac465eee887de7ceda7ffe3bccf538eb786bc
Message-ID: <202306271735.icLF5jjs-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 6ecac465eee887de7ceda7ffe3bccf538eb786bc  Merge branch 'pci/controller/remove-void-callbacks'

elapsed time: 725m

configs tested: 104
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230626   gcc  
arc                  randconfig-r016-20230626   gcc  
arc                  randconfig-r043-20230626   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230626   gcc  
arm                  randconfig-r046-20230626   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230626   gcc  
arm64                randconfig-r015-20230626   gcc  
arm64                randconfig-r036-20230626   clang
csky                                defconfig   gcc  
hexagon              randconfig-r025-20230626   clang
hexagon              randconfig-r041-20230626   clang
hexagon              randconfig-r045-20230626   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230626   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r003-20230626   gcc  
microblaze           randconfig-r005-20230626   gcc  
microblaze           randconfig-r024-20230626   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r035-20230626   gcc  
nios2                               defconfig   gcc  
openrisc                         alldefconfig   gcc  
openrisc             randconfig-r001-20230626   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230626   gcc  
parisc               randconfig-r031-20230626   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc              randconfig-r022-20230626   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230626   gcc  
s390                 randconfig-r026-20230626   gcc  
s390                 randconfig-r044-20230626   gcc  
sh                               allmodconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230626   gcc  
sparc                       sparc64_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230626   gcc  
um                   randconfig-r004-20230626   gcc  
um                   randconfig-r032-20230626   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230626   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
