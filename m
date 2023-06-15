Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB8732149
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbjFOVFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjFOVE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 17:04:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79952193
        for <linux-pci@vger.kernel.org>; Thu, 15 Jun 2023 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686863096; x=1718399096;
  h=date:from:to:cc:subject:message-id;
  bh=gwX+M4TW7UVcNPETiVkRDh1Yg/4AZmREK6vg5FLHSek=;
  b=KU7WS5SxJSakSse/EG9i01kW7wll0v+Ns1Z53/R3Feoy9b30abuBcEAO
   lrZ9qWtIJI3aU7GQhxsYVgN4XXBM5qXHyfmu+8UPdTMPIi5+1KEY5s4XX
   8yCG/XSWfIotnB8xzhg01oJCx09auPdgfclkc7/Dzbpcl5/p3saJEAhxo
   E0YhpxHPQ8cSxpjh03adFW1AlKhLG9Uim45Y+BC08qRGWbXXxz2ciGeHd
   1IiuZicaKT6i00AKX+EZP0pC3PBDgyafAsf6ILT7rNlzDBXXNQiH9mVjg
   qeLc31qjX8N21iHAUYNkSRVVt8iu4aDyRyAS+0fHKfzZi64GWkM9+rVvX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343780042"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343780042"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="836778083"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="836778083"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2023 14:04:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9u9B-0000NZ-1v;
        Thu, 15 Jun 2023 21:04:49 +0000
Date:   Fri, 16 Jun 2023 05:04:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/endpoint] BUILD SUCCESS
 71d9ca28015cee0bc329bc9e51c41b7a0325c285
Message-ID: <202306160521.UTNcveXQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/endpoint
branch HEAD: 71d9ca28015cee0bc329bc9e51c41b7a0325c285  PCI: layerscape: Add the endpoint linkup notifier support

elapsed time: 728m

configs tested: 107
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230615   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230615   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r043-20230615   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230615   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230615   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r035-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230615   clang
i386                 randconfig-r024-20230615   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230615   gcc  
loongarch            randconfig-r015-20230614   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r002-20230615   clang
mips                           mtx1_defconfig   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230615   gcc  
parisc               randconfig-r036-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc              randconfig-r011-20230614   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230615   gcc  
riscv                randconfig-r014-20230614   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230614   gcc  
s390                 randconfig-r021-20230615   clang
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230615   gcc  
sh                   randconfig-r031-20230615   gcc  
sh                          rsk7203_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230615   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230615   gcc  
sparc64      buildonly-randconfig-r005-20230615   gcc  
sparc64              randconfig-r032-20230615   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230615   gcc  
x86_64               randconfig-a002-20230615   gcc  
x86_64               randconfig-a003-20230615   gcc  
x86_64               randconfig-a004-20230615   gcc  
x86_64               randconfig-a005-20230615   gcc  
x86_64               randconfig-a006-20230615   gcc  
x86_64               randconfig-a011-20230614   gcc  
x86_64               randconfig-a012-20230614   gcc  
x86_64               randconfig-a013-20230614   gcc  
x86_64               randconfig-a014-20230614   gcc  
x86_64               randconfig-a015-20230614   gcc  
x86_64               randconfig-a016-20230614   gcc  
x86_64               randconfig-r022-20230615   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230615   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
