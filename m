Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458E6E948C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjDTMf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjDTMfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 08:35:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D7C2D43
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681994143; x=1713530143;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M5Bt+6w5A6tgqBetTXleU5kMdmvjDdhrDzp2GcNCYH0=;
  b=JiQipg/nwmqFKgxg6/W+z/RFFiTi9rchlXganQzhfsVzCaLFaCY9uhjK
   qrZlQBiSEuDh4ZrUDDW0MjwRiG66WLHNxQ3r0h5KfCTAZKVqYohO3pRNK
   h6Bf7caW7ghSjxW16sLAK16H5jqM5sgXCITHtq4NErDMFgrmzJDOZrMip
   eXY4ncMNNBP+J+6P3DebsLje4MHp2YdSEvQh5E84tAqUF+fFtg/SC74bF
   cVe6nidEFOW1p2SaVuAwXB0WsLcQkqIEXeYo89aYuqzgPH0Sgbt7nhwvJ
   LKWldddSl6TFi25UcDQRjLK9mHhPfaGuLvnqfMpRh9yT564Vp/9EVpQKo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="326050010"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="326050010"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 05:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722354427"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="722354427"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2023 05:35:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppTVk-000fpW-2h;
        Thu, 20 Apr 2023 12:35:40 +0000
Date:   Thu, 20 Apr 2023 20:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 a0814a0e8b5bc2240ba43691172aa72ac54d16e7
Message-ID: <64413162.hl+eWy3bmBh70BVK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: a0814a0e8b5bc2240ba43691172aa72ac54d16e7  PCI: Restrict device disabled status check to DT

elapsed time: 913m

configs tested: 158
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230420   gcc  
alpha                randconfig-r036-20230420   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230418   gcc  
arc          buildonly-randconfig-r004-20230417   gcc  
arc          buildonly-randconfig-r004-20230419   gcc  
arc          buildonly-randconfig-r006-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230418   gcc  
arc                  randconfig-r015-20230416   gcc  
arc                  randconfig-r022-20230420   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230419   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230419   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230418   clang
arm64        buildonly-randconfig-r005-20230416   clang
arm64        buildonly-randconfig-r005-20230419   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230416   gcc  
arm64                randconfig-r014-20230417   clang
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r034-20230419   gcc  
csky         buildonly-randconfig-r004-20230416   gcc  
csky         buildonly-randconfig-r006-20230418   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230416   gcc  
csky                 randconfig-r036-20230417   gcc  
hexagon              randconfig-r014-20230416   clang
hexagon              randconfig-r016-20230420   clang
hexagon              randconfig-r032-20230417   clang
hexagon              randconfig-r033-20230417   clang
hexagon              randconfig-r035-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230419   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230419   clang
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
ia64                 randconfig-r026-20230420   gcc  
ia64                 randconfig-r031-20230419   gcc  
ia64                 randconfig-r036-20230416   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230420   gcc  
loongarch            randconfig-r013-20230416   gcc  
loongarch            randconfig-r014-20230420   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230418   gcc  
m68k                 randconfig-r025-20230420   gcc  
microblaze   buildonly-randconfig-r003-20230418   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230417   gcc  
mips                 randconfig-r016-20230417   gcc  
nios2        buildonly-randconfig-r006-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230418   gcc  
openrisc     buildonly-randconfig-r001-20230418   gcc  
openrisc     buildonly-randconfig-r002-20230416   gcc  
openrisc             randconfig-r015-20230417   gcc  
openrisc             randconfig-r033-20230419   gcc  
openrisc             randconfig-r033-20230420   gcc  
parisc       buildonly-randconfig-r002-20230417   gcc  
parisc       buildonly-randconfig-r003-20230419   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230420   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230418   clang
powerpc              randconfig-r015-20230420   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230416   gcc  
riscv        buildonly-randconfig-r003-20230417   clang
riscv        buildonly-randconfig-r006-20230419   clang
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230420   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230419   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230418   clang
s390                 randconfig-r021-20230420   gcc  
s390                 randconfig-r035-20230416   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230419   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230416   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r013-20230417   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230416   gcc  
sparc                randconfig-r034-20230420   gcc  
sparc64      buildonly-randconfig-r002-20230419   gcc  
sparc64              randconfig-r031-20230420   gcc  
sparc64              randconfig-r034-20230417   gcc  
sparc64              randconfig-r035-20230419   gcc  
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
x86_64               randconfig-r031-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r005-20230418   gcc  
xtensa               randconfig-r032-20230416   gcc  
xtensa               randconfig-r034-20230416   gcc  
xtensa               randconfig-r036-20230419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
