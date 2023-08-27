Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E678A2C0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 00:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjH0WdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjH0WdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 18:33:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4ACD2
        for <linux-pci@vger.kernel.org>; Sun, 27 Aug 2023 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693175582; x=1724711582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M9t6eebDjgO/SMMpKBkmkOtLd3pCyjVW0SotikrdSOA=;
  b=gKVjm3xtQ7upFpY7ALbgk6JE+xPveQl8yLN3QdrDaT2lyDBr5ks3lkh1
   YSF8b0F4buJPypPQwNHNJXrOumw9igxsfq3Un4jAdStFIrDyQQQg+w3Yh
   Fwad+S3ZJJsfc8JmdZjrcoaES1jwOfnVda0EU1XpIMMBrHtHThAaiLjnX
   2VLUD4uHEnkXj8mJyfFOOb2UFxiDwc+p2yhFlR/kdzmhy3mpf786YppRJ
   BGLoX25XVWn5L9Qc9ebHK6L8Vmpq7TwbatO9SnOBlRAHgn1SMhTdabeDx
   iVVJCoOqO7aC5aQAiDwuXh1b29GUxK9f++DBGl0WoCPBOeCKYR8GzPAVx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="377711600"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="377711600"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 15:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="687889333"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="687889333"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2023 15:33:00 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaOJY-0006GF-14;
        Sun, 27 Aug 2023 22:33:00 +0000
Date:   Mon, 28 Aug 2023 06:32:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/qcom-edma] BUILD SUCCESS
 06eea7d18fe86fdf09771f5a9d1ac74134725df1
Message-ID: <202308280611.2HN1puhl-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom-edma
branch HEAD: 06eea7d18fe86fdf09771f5a9d1ac74134725df1  PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API

elapsed time: 1754m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230827   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230827   gcc  
arc                  randconfig-r035-20230827   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230827   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230827   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230827   gcc  
hexagon               randconfig-001-20230827   clang
hexagon               randconfig-002-20230827   clang
hexagon              randconfig-r002-20230827   clang
hexagon              randconfig-r021-20230827   clang
hexagon              randconfig-r032-20230827   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230827   clang
i386         buildonly-randconfig-002-20230827   clang
i386         buildonly-randconfig-003-20230827   clang
i386         buildonly-randconfig-004-20230827   clang
i386         buildonly-randconfig-005-20230827   clang
i386         buildonly-randconfig-006-20230827   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230827   clang
i386                  randconfig-002-20230827   clang
i386                  randconfig-003-20230827   clang
i386                  randconfig-004-20230827   clang
i386                  randconfig-005-20230827   clang
i386                  randconfig-006-20230827   clang
i386                  randconfig-011-20230827   gcc  
i386                  randconfig-012-20230827   gcc  
i386                  randconfig-013-20230827   gcc  
i386                  randconfig-014-20230827   gcc  
i386                  randconfig-015-20230827   gcc  
i386                  randconfig-016-20230827   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230827   gcc  
loongarch            randconfig-r006-20230827   gcc  
loongarch            randconfig-r033-20230827   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230827   gcc  
microblaze           randconfig-r005-20230827   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230827   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230827   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r004-20230827   gcc  
openrisc             randconfig-r016-20230827   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230827   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r026-20230827   gcc  
powerpc64            randconfig-r031-20230827   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230827   clang
riscv                randconfig-r011-20230827   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230827   gcc  
s390                 randconfig-r023-20230827   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r015-20230827   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230827   clang
x86_64       buildonly-randconfig-002-20230827   clang
x86_64       buildonly-randconfig-003-20230827   clang
x86_64       buildonly-randconfig-004-20230827   clang
x86_64       buildonly-randconfig-005-20230827   clang
x86_64       buildonly-randconfig-006-20230827   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230827   gcc  
x86_64                randconfig-002-20230827   gcc  
x86_64                randconfig-003-20230827   gcc  
x86_64                randconfig-004-20230827   gcc  
x86_64                randconfig-005-20230827   gcc  
x86_64                randconfig-006-20230827   gcc  
x86_64                randconfig-011-20230827   clang
x86_64                randconfig-012-20230827   clang
x86_64                randconfig-013-20230827   clang
x86_64                randconfig-014-20230827   clang
x86_64                randconfig-015-20230827   clang
x86_64                randconfig-016-20230827   clang
x86_64                randconfig-071-20230827   clang
x86_64                randconfig-072-20230827   clang
x86_64                randconfig-073-20230827   clang
x86_64                randconfig-074-20230827   clang
x86_64                randconfig-075-20230827   clang
x86_64                randconfig-076-20230827   clang
x86_64               randconfig-r001-20230827   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r025-20230827   gcc  
xtensa               randconfig-r034-20230827   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
