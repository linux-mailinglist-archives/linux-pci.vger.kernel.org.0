Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF772AABF
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFJJ4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jun 2023 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJ4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Jun 2023 05:56:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86C30F4
        for <linux-pci@vger.kernel.org>; Sat, 10 Jun 2023 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686390990; x=1717926990;
  h=date:from:to:cc:subject:message-id;
  bh=iM7swoYB47S/J7G2FjGo7GwR1hlA0oJp4+hEy8qjqjg=;
  b=B1IDWT7QJ7ufAfULGB8vUt1/0xlvWpzU/JRXmGWnxyzUmUh8iQJlZrkT
   hFoVCstkfva+U/Upj4PPImqQiehxiyw4gL3vQHkppoqV834OcWChiwc4t
   Wsnxid4j208QxqRu10coWVU5D+8YQARMKF4aEvZJdbxdXEAQ1eWTKxde+
   0jt7LccLLoV90v6gREwYMfI0N/ia94IQ/6SB4FdlZpJvF+qn9j4vTRZ+h
   emPtgwaiMO8plzNhsDH5ZVFOJ1Sg4Cuir57dMJfDd+zRPtflWsipx2pSE
   e5ggEhmQHQbKNxvfNvQDMI81ut/T60xD863LVilCt4QBzLYLfgpK4wllM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342428749"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="342428749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 02:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713786716"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="713786716"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2023 02:56:28 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7vKd-0009yi-2L;
        Sat, 10 Jun 2023 09:56:27 +0000
Date:   Sat, 10 Jun 2023 17:56:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 e54223275ba1bc6f704a6bab015fcd2ae4f72572
Message-ID: <202306101709.Ctwd5EkW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: e54223275ba1bc6f704a6bab015fcd2ae4f72572  PCI: Release resource invalidated by coalescing

elapsed time: 726m

configs tested: 166
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r003-20230608   clang
arm                  randconfig-r032-20230608   clang
arm                  randconfig-r046-20230608   gcc  
arm                             rpc_defconfig   gcc  
arm                         socfpga_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230608   gcc  
csky         buildonly-randconfig-r002-20230610   gcc  
csky         buildonly-randconfig-r005-20230610   gcc  
csky         buildonly-randconfig-r006-20230610   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r013-20230610   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230610   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i011-20230609   gcc  
i386                 randconfig-i012-20230609   gcc  
i386                 randconfig-i013-20230609   gcc  
i386                 randconfig-i014-20230609   gcc  
i386                 randconfig-i015-20230609   gcc  
i386                 randconfig-i016-20230609   gcc  
i386                 randconfig-i051-20230610   clang
i386                 randconfig-i052-20230610   clang
i386                 randconfig-i053-20230610   clang
i386                 randconfig-i054-20230610   clang
i386                 randconfig-i055-20230610   clang
i386                 randconfig-i056-20230610   clang
i386                 randconfig-i061-20230610   clang
i386                 randconfig-i062-20230610   clang
i386                 randconfig-i063-20230610   clang
i386                 randconfig-i064-20230610   clang
i386                 randconfig-i065-20230610   clang
i386                 randconfig-i066-20230610   clang
i386                 randconfig-r011-20230610   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230608   gcc  
loongarch            randconfig-r024-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r001-20230610   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r033-20230608   gcc  
microblaze           randconfig-r036-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                          malta_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r016-20230610   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r014-20230610   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r035-20230608   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8560_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230608   gcc  
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230610   gcc  
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r004-20230610   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230608   gcc  
sparc                randconfig-r004-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a011-20230610   gcc  
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a012-20230610   gcc  
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a013-20230610   gcc  
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a014-20230610   gcc  
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a015-20230610   gcc  
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-a016-20230610   gcc  
x86_64               randconfig-r031-20230608   gcc  
x86_64               randconfig-x051-20230608   clang
x86_64               randconfig-x052-20230608   clang
x86_64               randconfig-x053-20230608   clang
x86_64               randconfig-x054-20230608   clang
x86_64               randconfig-x055-20230608   clang
x86_64               randconfig-x056-20230608   clang
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r006-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
