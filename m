Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACD6FBAFB
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHWXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEHWXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:23:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E75B84
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683584625; x=1715120625;
  h=date:from:to:cc:subject:message-id;
  bh=tz9xKpK0fs/isdKXuwvuRTutFbd+2UNYNzRnDu0acn4=;
  b=Ubp41nAOgzwyR5hdMsXBvBteIkxNnfYWho650s594+fSeVBGvV35Ix67
   Eb/K9+vlHPaY9JI3huh7vP9meO/5vzBmvaAta6MrjLu82dlBBTp+4Ldxe
   Bw79MBtVMItuXAwF9EQnqbG4Era8JkKQgRuzwzJYthCrARZ+0ci4pOxcZ
   K8dfPpgdHTkTo3is/Dt8M+Ft2GK6hN0TEdyqIuZcyoTXVIDnD5DNsP5Z0
   3fnBwoSnKBLyHF31r2DQ1mO2Km6ZNOAXn1Uv4xMjqX5LxPQ3imTfXBhSy
   rUH6jXWhkPxVSg0GqEbxVnrX0HJs3o87WXQuOx41r/CxWwHIOqb1Ky5hT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347233155"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="347233155"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 15:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788283111"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788283111"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 15:23:44 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw9Gh-0001RY-2l;
        Mon, 08 May 2023 22:23:43 +0000
Date:   Tue, 09 May 2023 06:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/vmd] BUILD SUCCESS
 b61cf04c49c3dfa70a0d6725d3eb40bf9b35cf71
Message-ID: <20230508222313.jOQ_I%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/vmd
branch HEAD: b61cf04c49c3dfa70a0d6725d3eb40bf9b35cf71  PCI: vmd: Reset VMD config register between soft reboots

elapsed time: 829m

configs tested: 121
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230507   gcc  
arc                                 defconfig   gcc  
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
arm64                randconfig-r024-20230507   clang
csky                                defconfig   gcc  
csky                 randconfig-r031-20230507   gcc  
hexagon              randconfig-r003-20230507   clang
hexagon              randconfig-r022-20230508   clang
hexagon              randconfig-r034-20230507   clang
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
i386                 randconfig-r013-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230507   gcc  
ia64                 randconfig-r025-20230508   gcc  
ia64                 randconfig-r026-20230507   gcc  
ia64                 randconfig-r035-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230507   gcc  
loongarch            randconfig-r005-20230508   gcc  
loongarch            randconfig-r036-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230507   gcc  
m68k                 randconfig-r033-20230507   gcc  
microblaze           randconfig-r003-20230508   gcc  
microblaze           randconfig-r005-20230507   gcc  
microblaze           randconfig-r011-20230508   gcc  
microblaze           randconfig-r021-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230508   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r002-20230508   gcc  
openrisc             randconfig-r015-20230508   gcc  
openrisc             randconfig-r025-20230507   gcc  
parisc       buildonly-randconfig-r006-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230507   clang
powerpc              randconfig-r016-20230507   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230508   gcc  
s390                 randconfig-r032-20230507   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230507   gcc  
sh           buildonly-randconfig-r005-20230507   gcc  
sparc        buildonly-randconfig-r004-20230507   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230507   gcc  
sparc64              randconfig-r015-20230507   gcc  
sparc64              randconfig-r022-20230507   gcc  
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
x86_64               randconfig-r001-20230508   clang
x86_64               randconfig-r006-20230508   clang
x86_64               randconfig-r021-20230508   gcc  
x86_64               randconfig-r023-20230508   gcc  
x86_64               randconfig-r024-20230508   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
