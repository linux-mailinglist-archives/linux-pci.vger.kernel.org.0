Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D16FB85F
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjEHUjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjEHUjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 16:39:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9D5586
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578383; x=1715114383;
  h=date:from:to:cc:subject:message-id;
  bh=oy2bfWlHel41Z/ck30V53i8+8hkmyswrkM9JvFJHt1A=;
  b=fqjv9VhfH4L0r7m+OkJCkP4EvTOv2nZy6blfcdhG0HkJIviyKnJjOuxM
   HStWEQxwHtK/SDelv3wgZFSFOTD7Ijp7ubNioOuh6NgGDTjZ7QV8Cbv0h
   iJfmwcEyfZEk0rjURMueT3Ztorc+RdK5Plta9Oi7KzGBDiw1Hc0t8d3M5
   KQhDUyR491mDsS3Rmkjd0NqDNr7NiZnOi8EOtn02jPCgoCHC+hUdy9n7k
   9mERGUyiuq0gTM4DThioBL3juUh0KKFN4BGz6IXK4EdWSWKD19q+jL6x7
   rv0aakXoOR1RYX2xM4c+w9HsV6Cgq3ZntsyAFzSBcedaHguBStfOWmhYg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334197472"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334197472"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944992967"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944992967"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2023 13:39:41 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw7e0-0001PS-0Z;
        Mon, 08 May 2023 20:39:40 +0000
Date:   Tue, 09 May 2023 04:38:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 0e12f830236928b6fadf40d917a7527f0a048d2f
Message-ID: <20230508203859.RtxSm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: 0e12f830236928b6fadf40d917a7527f0a048d2f  PCI: cadence: Fix Gen2 Link Retraining process

elapsed time: 729m

configs tested: 131
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230508   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230508   gcc  
arc                  randconfig-r025-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r011-20230507   gcc  
arm                  randconfig-r036-20230507   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r001-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230508   gcc  
csky                 randconfig-r015-20230507   gcc  
csky                 randconfig-r022-20230507   gcc  
hexagon      buildonly-randconfig-r003-20230507   clang
hexagon      buildonly-randconfig-r005-20230507   clang
hexagon              randconfig-r003-20230507   clang
hexagon              randconfig-r014-20230508   clang
hexagon              randconfig-r015-20230508   clang
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
i386                 randconfig-r003-20230508   clang
i386                 randconfig-r024-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230508   gcc  
ia64                 randconfig-r034-20230507   gcc  
ia64                 randconfig-r036-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230507   gcc  
m68k                 randconfig-r004-20230508   gcc  
m68k                 randconfig-r005-20230507   gcc  
m68k                 randconfig-r013-20230507   gcc  
microblaze   buildonly-randconfig-r003-20230508   gcc  
microblaze           randconfig-r016-20230508   gcc  
microblaze           randconfig-r021-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230508   gcc  
mips                 randconfig-r035-20230507   clang
nios2        buildonly-randconfig-r004-20230507   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230508   gcc  
openrisc     buildonly-randconfig-r005-20230508   gcc  
openrisc             randconfig-r025-20230507   gcc  
openrisc             randconfig-r032-20230507   gcc  
parisc       buildonly-randconfig-r001-20230508   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230508   gcc  
parisc               randconfig-r026-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230507   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230508   clang
riscv                randconfig-r014-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230507   clang
s390                                defconfig   gcc  
s390                 randconfig-r023-20230507   clang
s390                 randconfig-r024-20230507   clang
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230508   gcc  
sh                   randconfig-r016-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230507   gcc  
sparc                randconfig-r035-20230508   gcc  
sparc64              randconfig-r033-20230507   gcc  
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
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64               randconfig-r033-20230508   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
