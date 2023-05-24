Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD370EF39
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjEXHSG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbjEXHR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 03:17:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AF2135
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684912674; x=1716448674;
  h=date:from:to:cc:subject:message-id;
  bh=f7mk61vN4SJgUCVmKTSedqQau/L2idBlmRFNOCxhlOI=;
  b=AwmBhUcehQQIaNne87tZRfVTKjUkuQB/1hm5XAxGbqZ52XtmTiyk+MJy
   QKe2XUGjs/b7rnc66jDVx74a7w45iW2TPjh+fuWkP+7qtltPbxriX2b/o
   OX0J9E2CKJ5W6D2B8qcmnJ6HIJG2DpWiuQZhIaym/aC68iuxTgoUUMWyS
   3JGRI9MmqsgFM8h3Rws2PfsvHp6QOVcC3gZu56hZ3Owx7v79Xxeksqi6e
   nQg+A5KdUqdxApta0fvGwwF0kQOZzWFEKduC/inMKAli/xmBQUtuK94gk
   PIADolk8qqDzn1jZBIkL9KyjqOyda1qMa1voTxiGH3Qts/YE3PLrtXsHA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416944093"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416944093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="735064157"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="735064157"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2023 00:17:53 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1ikq-000EXP-1X;
        Wed, 24 May 2023 07:17:52 +0000
Date:   Wed, 24 May 2023 15:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 3f6c79e20398f3ff33d11a6f6c1a9fcbb6fd8a4b
Message-ID: <20230524071657.fbEl-%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524121217/lkp-src/repo/*/pci
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 3f6c79e20398f3ff33d11a6f6c1a9fcbb6fd8a4b  PCI: acpiphp: Reassign resources on bridge if necessary

elapsed time: 898m

configs tested: 151
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230521   gcc  
alpha                randconfig-r024-20230521   gcc  
alpha                randconfig-r025-20230521   gcc  
alpha                randconfig-r026-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230521   gcc  
arc          buildonly-randconfig-r003-20230522   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230521   gcc  
arc                  randconfig-r023-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230521   clang
arm64                randconfig-r011-20230522   clang
arm64                randconfig-r021-20230522   clang
arm64                randconfig-r033-20230521   clang
arm64                randconfig-r034-20230522   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r006-20230522   clang
hexagon              randconfig-r024-20230522   clang
hexagon              randconfig-r036-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-r004-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230521   gcc  
ia64                 randconfig-r035-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230521   gcc  
loongarch            randconfig-r032-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r031-20230522   gcc  
microblaze           randconfig-r015-20230522   gcc  
microblaze           randconfig-r031-20230521   gcc  
microblaze           randconfig-r034-20230521   gcc  
microblaze           randconfig-r035-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips                 randconfig-r014-20230521   clang
nios2        buildonly-randconfig-r004-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230522   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230521   gcc  
parisc               randconfig-r012-20230521   gcc  
parisc               randconfig-r016-20230522   gcc  
parisc               randconfig-r036-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230521   gcc  
powerpc              randconfig-r006-20230522   gcc  
powerpc              randconfig-r016-20230521   gcc  
powerpc              randconfig-r021-20230521   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230521   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230521   gcc  
s390                 randconfig-r033-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230521   gcc  
sh                   randconfig-r002-20230522   gcc  
sh                   randconfig-r006-20230521   gcc  
sh                   randconfig-r013-20230522   gcc  
sh                   randconfig-r014-20230522   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r003-20230521   gcc  
sparc64              randconfig-r001-20230522   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-r022-20230522   clang
x86_64               randconfig-r025-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64                        randconfig-x081   gcc  
x86_64                        randconfig-x082   clang
x86_64                        randconfig-x083   gcc  
x86_64                        randconfig-x084   clang
x86_64                        randconfig-x085   gcc  
x86_64                        randconfig-x086   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230522   gcc  
xtensa               randconfig-r001-20230521   gcc  
xtensa               randconfig-r003-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
