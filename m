Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134E6E774A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDSKTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDSKTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 06:19:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA04215
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681899589; x=1713435589;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3KWFiGpkT30OXf+2sD7zdu9T5ncmJ0dlcO8879dgI7Q=;
  b=LWt/6PxVK0wNclrGPR5ws+KGTC+kK1R2hAhR1s19XQmBpLsI2n2iVucu
   eKsBEboL2v4RHZODeNHVXPFjmaN3rXXQ4sRnBG24Iqdn3hXrPPriKDX6z
   aT+JfyUCHEznJ5c3+UsGkKlutAjqtpbIkz8R1e3hvP4mmcuu8rX2m1V7G
   u/KQ9tob2YZdGC1fqp1s8myI/oNpTwOUfo+PN2rFs+y755dLTmWmJ3KGd
   O8GsHBZsItWAdtHsYgSX21TKOlq1qkFqfx6QewZOBRp3oVhb6CWeyYy6P
   uzaqvF3y3grwtgcwnIuKJqjDfgmA7jB5N7KdvrHqidr8r8myKIrZHqwfX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408319589"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="408319589"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 03:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780809772"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780809772"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2023 03:19:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp4ug-000env-1x;
        Wed, 19 Apr 2023 10:19:46 +0000
Date:   Wed, 19 Apr 2023 18:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 9195ee1a1f76033eccb424b97ee647625b7af096
Message-ID: <643fc008.V/daSogcGnC0Q/M0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 9195ee1a1f76033eccb424b97ee647625b7af096  PCI: Use of_property_present() for testing DT property presence

elapsed time: 721m

configs tested: 96
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230418   gcc  
arm                  randconfig-r032-20230416   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230416   gcc  
arm64                randconfig-r014-20230417   clang
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r035-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230416   gcc  
csky                 randconfig-r032-20230417   gcc  
hexagon              randconfig-r014-20230416   clang
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
ia64                 randconfig-r036-20230418   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230418   gcc  
microblaze           randconfig-r034-20230418   gcc  
microblaze           randconfig-r036-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230417   gcc  
mips                 randconfig-r016-20230417   gcc  
mips                 randconfig-r031-20230417   clang
mips                 randconfig-r033-20230416   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r015-20230417   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r032-20230418   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230417   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230417   gcc  
sh                   randconfig-r035-20230416   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r033-20230417   gcc  
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
xtensa               randconfig-r034-20230416   gcc  
xtensa               randconfig-r035-20230418   gcc  
xtensa               randconfig-r036-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
