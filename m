Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D66B5606
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 00:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCJXwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 18:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCJXwi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 18:52:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FDF12CB80
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 15:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678492357; x=1710028357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4jJZW+6j9jYBHbLNnaIYBLO4N/pBWkE6i8ABTOTgcnc=;
  b=W4CzpBgZDLiRo80OIPLk5nvA74Uq3vo3x6MISX7X4h9+e99zFKm1K9Yc
   kI/H8sgjTHKdq9kREm3GImGPw6foGTyv78D2jm37fj2U7/0XO06cl6J/i
   0iJohA0Ut4CCXeqG20T9FsuA6vI+lbWv10nd1vfkoqobOEHUU134EfAj+
   toLb2uBrQwXrS5z3EBxjzGYZMMRmhs4nuNHiUzvCC7yY8nKwYaWB37jFd
   lc+aRarzf/YFDJLM+KKwQXkFonbk7tRCBEsXNsKDhd4LWsag3XyeX1gDA
   70EmwLQHmImE2OKbRzyZSA/zSUwhG/l/UavreGGGAIajrK61nOwAHcw5h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339217422"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="339217422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 15:52:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746922383"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="746922383"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 15:52:34 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pamXK-0004BN-0b;
        Fri, 10 Mar 2023 23:52:34 +0000
Date:   Sat, 11 Mar 2023 07:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/dt] BUILD SUCCESS
 b80b848bdf56bd402b7a91aea5b77cec93dfe4c2
Message-ID: <640bc2a6.DiQf0DT9QPZlAgVl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dt
branch HEAD: b80b848bdf56bd402b7a91aea5b77cec93dfe4c2  dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema

elapsed time: 730m

configs tested: 100
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230310   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230310   gcc  
arm                  randconfig-r046-20230310   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230310   clang
arm64                randconfig-r011-20230310   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r022-20230310   clang
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
ia64                 randconfig-r014-20230310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230310   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230310   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230310   gcc  
microblaze   buildonly-randconfig-r006-20230310   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r025-20230310   clang
nios2        buildonly-randconfig-r005-20230310   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230310   gcc  
nios2                randconfig-r032-20230310   gcc  
nios2                randconfig-r033-20230310   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230310   gcc  
parisc               randconfig-r021-20230310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230310   gcc  
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230310   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230310   gcc  
s390                 randconfig-r013-20230310   gcc  
s390                 randconfig-r031-20230310   clang
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230310   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230310   gcc  
sparc64      buildonly-randconfig-r003-20230310   gcc  
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
xtensa               randconfig-r023-20230310   gcc  
xtensa               randconfig-r035-20230310   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
