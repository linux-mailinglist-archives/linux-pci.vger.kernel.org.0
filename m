Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C481C7D1AB5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Oct 2023 06:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjJUEN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Oct 2023 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUENy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Oct 2023 00:13:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1FDA
        for <linux-pci@vger.kernel.org>; Fri, 20 Oct 2023 21:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697861628; x=1729397628;
  h=date:from:to:cc:subject:message-id;
  bh=bIfamow3629Y/Xcw+ArGBU7tP8mx9m9QDaaydo8LdI0=;
  b=JXPpGPkUruHNUnEBdQuD+M+082rCkAeD1zD9eUwqeZOV7Gh4EfINty9q
   5YI1MKxSEVJFg4R37gLIaX00ExfHV5Xu2EGCT9ng267MGWc7cNNPIjejo
   gSXQgg4AftwNnxnrTFVd/e1vhkPHoxXdIlDX5Z+hxlIhBdiLwsYmAAlXT
   26vYpr7kLxdvOfBenefzQCSf8cAAC0JDdllIIk6OrZ3iMwEhvX+KY+S32
   dS503wVyPpLXTEjNLBkYhA1ApDQxm6w+fm9glbxJMgoMbKKxXYvqGyyzA
   v6cCpXTvr6DMA74tnLVPafI/j8DVzxvcKvNbUp1Qq+TAvLRNmCbHvgD9s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="472832637"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="472832637"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 21:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088928068"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088928068"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 21:13:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu3Mv-0004Oe-1g;
        Sat, 21 Oct 2023 04:13:45 +0000
Date:   Sat, 21 Oct 2023 12:12:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:ats] BUILD SUCCESS
 a18615b1cfc04f00548c60eb9a77e0ce56e848fd
Message-ID: <202310211244.GMCIpMzH-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git ats
branch HEAD: a18615b1cfc04f00548c60eb9a77e0ce56e848fd  PCI: Disable ATS for specific Intel IPU E2000 devices

elapsed time: 3254m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231019   gcc  
arc                   randconfig-001-20231021   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231019   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20231020   gcc  
i386         buildonly-randconfig-002-20231020   gcc  
i386         buildonly-randconfig-003-20231020   gcc  
i386         buildonly-randconfig-004-20231020   gcc  
i386         buildonly-randconfig-005-20231020   gcc  
i386         buildonly-randconfig-006-20231020   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231019   gcc  
i386                  randconfig-001-20231021   gcc  
i386                  randconfig-002-20231019   gcc  
i386                  randconfig-002-20231021   gcc  
i386                  randconfig-003-20231019   gcc  
i386                  randconfig-003-20231021   gcc  
i386                  randconfig-004-20231019   gcc  
i386                  randconfig-004-20231021   gcc  
i386                  randconfig-005-20231019   gcc  
i386                  randconfig-005-20231021   gcc  
i386                  randconfig-006-20231019   gcc  
i386                  randconfig-006-20231021   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-011-20231021   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-012-20231021   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-013-20231021   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-014-20231021   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-015-20231021   gcc  
i386                  randconfig-016-20231019   gcc  
i386                  randconfig-016-20231021   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231019   gcc  
loongarch             randconfig-001-20231021   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231019   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231019   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231019   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-001-20231021   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-002-20231021   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-003-20231021   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-004-20231021   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-005-20231021   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64       buildonly-randconfig-006-20231021   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231019   gcc  
x86_64                randconfig-001-20231021   gcc  
x86_64                randconfig-002-20231019   gcc  
x86_64                randconfig-002-20231021   gcc  
x86_64                randconfig-003-20231019   gcc  
x86_64                randconfig-003-20231021   gcc  
x86_64                randconfig-004-20231019   gcc  
x86_64                randconfig-004-20231021   gcc  
x86_64                randconfig-005-20231019   gcc  
x86_64                randconfig-005-20231021   gcc  
x86_64                randconfig-006-20231019   gcc  
x86_64                randconfig-006-20231021   gcc  
x86_64                randconfig-011-20231020   gcc  
x86_64                randconfig-012-20231020   gcc  
x86_64                randconfig-013-20231020   gcc  
x86_64                randconfig-014-20231020   gcc  
x86_64                randconfig-015-20231020   gcc  
x86_64                randconfig-016-20231020   gcc  
x86_64                randconfig-071-20231020   gcc  
x86_64                randconfig-072-20231020   gcc  
x86_64                randconfig-073-20231020   gcc  
x86_64                randconfig-074-20231020   gcc  
x86_64                randconfig-075-20231020   gcc  
x86_64                randconfig-076-20231020   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
