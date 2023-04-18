Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278CD6E5EB5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDRK04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDRK0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 06:26:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576B3C02
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681813600; x=1713349600;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=voSjACFxh4AQOqqeyICpk3tsvn7LBkZr4T7kPiZl4jI=;
  b=hl6pPQkl73xn6B1SMGl7i8X8Yge88lyd3gl3D7l7G+oLKEelRF/hrDiv
   MIgkiCJcepHvY1N3Z02Dx+ol2xjDmRgBNE6jwbKAJnDZHOZA5p01Dl90g
   K+WES1mSVk7LnCpWUEMlfiX9A05Rk84AQerFtFmMva4xNEpC9YqxNJsEE
   fjQnMbc0B/1dlqEk5PPHY47nQjSZG9ocpr7gs4ZPwJ27ut07VM4A+Lc/q
   EX27chf8qtGBANl40bkxBqeQBjrbfyoDeqS9AywFAfd3HsNTo7tkD1xzI
   lOntqQFtov3Y4vPzj7i9NozJlCt0Ts44NnZ9beFOqdXjfFqKZbqliS8Rt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="373012798"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="373012798"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 03:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780456088"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780456088"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 03:26:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poiXh-000dFr-0S;
        Tue, 18 Apr 2023 10:26:33 +0000
Date:   Tue, 18 Apr 2023 18:25:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 a5a6dd2624698b6e3045c3a1450874d8c790d5d9
Message-ID: <643e7037.J24xs9WGgAEP6Kpa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: a5a6dd2624698b6e3045c3a1450874d8c790d5d9  PCI/PM: Extend D3hot delay for NVIDIA HDA controllers

elapsed time: 726m

configs tested: 104
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230416   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230416   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230416   clang
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230417   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230417   gcc  
hexagon      buildonly-randconfig-r006-20230416   clang
hexagon      buildonly-randconfig-r006-20230417   clang
hexagon              randconfig-r036-20230417   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r033-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230417   gcc  
loongarch            randconfig-r034-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230416   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r011-20230416   gcc  
microblaze           randconfig-r031-20230416   gcc  
microblaze           randconfig-r034-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230417   gcc  
nios2                randconfig-r035-20230417   gcc  
openrisc             randconfig-r035-20230416   gcc  
parisc       buildonly-randconfig-r004-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230416   gcc  
parisc               randconfig-r026-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r023-20230416   gcc  
powerpc              randconfig-r031-20230417   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230416   gcc  
s390                 randconfig-r022-20230416   gcc  
s390                 randconfig-r036-20230416   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230417   gcc  
sh                   randconfig-r032-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230416   gcc  
sparc64      buildonly-randconfig-r003-20230417   gcc  
sparc64              randconfig-r024-20230416   gcc  
sparc64              randconfig-r032-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r015-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
