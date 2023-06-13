Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1689D72DE44
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbjFMJuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbjFMJuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 05:50:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20868171D
        for <linux-pci@vger.kernel.org>; Tue, 13 Jun 2023 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686649790; x=1718185790;
  h=date:from:to:cc:subject:message-id;
  bh=c716JuihUOvD26OKbdQSMPm7DKC+h4b949GjfSWJuOE=;
  b=QwDZsqLsDXIZEq4MdwgTUhoEwIYtsj6XbTyfuIMvflHqCI2r3CewDpo7
   FgWBZLIqC/90gn9JWhJMBV/FnbVtm05/a7389uEvZSA7yHTJexRVj3lbd
   Z+1gk5HIHKF6PPedDOeVJNoYInxUvr05PX6jGRWua7tDNgnHDZff8iClC
   h7h11hEWJI7wfCxKELhAtyiNh+9Q5UUKN7ZKQ/D36DppQNW6kQx//5rv6
   H4kVVXNG04LSwprxTbwz4jl/WsOjwz1HUg4VwSbqKLRGWDGhHPMnWM6mo
   dnKXKJvEDSAQwvYdlZ9LoyBih4TdIS5rRwtgXeIwuErGPTet6UCBGIwVp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338643421"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338643421"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835817246"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835817246"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 02:49:47 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q90eo-0001Bq-1C;
        Tue, 13 Jun 2023 09:49:46 +0000
Date:   Tue, 13 Jun 2023 17:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 11502feab423cbbbaae47c0672409840b04037d5
Message-ID: <202306131753.VmLbIWP0-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 11502feab423cbbbaae47c0672409840b04037d5  Documentation: PCI: Tidy AER documentation

elapsed time: 725m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230612   gcc  
alpha                randconfig-r026-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230612   gcc  
arc                  randconfig-r015-20230612   gcc  
arc                  randconfig-r021-20230612   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230612   clang
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230612   gcc  
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230612   gcc  
csky                 randconfig-r031-20230612   gcc  
csky                 randconfig-r032-20230612   gcc  
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r012-20230612   gcc  
i386                 randconfig-r014-20230612   gcc  
i386                 randconfig-r021-20230612   gcc  
i386                 randconfig-r025-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230612   gcc  
loongarch            randconfig-r005-20230612   gcc  
loongarch            randconfig-r024-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230612   clang
mips                 randconfig-r024-20230612   clang
mips                 randconfig-r031-20230612   gcc  
mips                 randconfig-r034-20230612   gcc  
nios2        buildonly-randconfig-r001-20230612   gcc  
nios2        buildonly-randconfig-r005-20230612   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230612   gcc  
openrisc             randconfig-r006-20230612   gcc  
openrisc             randconfig-r013-20230612   gcc  
openrisc             randconfig-r036-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230612   gcc  
sparc64      buildonly-randconfig-r006-20230612   gcc  
sparc64              randconfig-r004-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a001-20230613   gcc  
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a002-20230613   gcc  
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a003-20230613   gcc  
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a004-20230613   gcc  
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a005-20230613   gcc  
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a006-20230613   gcc  
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
