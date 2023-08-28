Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2E78A533
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 07:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjH1F0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 01:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjH1F00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 01:26:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA1A8
        for <linux-pci@vger.kernel.org>; Sun, 27 Aug 2023 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693200383; x=1724736383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iiprHJA8CniACUrBogwl/ZXsejc8OoeA9JdPd+LfNNg=;
  b=jqgbNpuFheiqwK/z1QLsvoRrpOOj5JJJoV8OR//OtW+RtgWS524bMiPd
   Yjk5M7b0Yey935PWAPmsNiUu3i0QYyuvqagZwyW8iDf75DKCIXkTolyXK
   XLWaJWN9hDRP1F8eVKuK7UNJ0rW1+93nJTTF4wPQS44zuIuEfBHvCWOOG
   FFrXdHaStGflBEdSJDBaiwo33Mu0XxCS1sQCZRVYk8o/w0l5j88rp53re
   vE620jykwr9xfQhixNpLNShcaK4cNkMKKON/nhjogUYDO+PmLE1PQ7HJt
   JRNYDvNRKMiox4ejjDbySmw89YzjZR5S+G5KpLMjFy/+tnYw3uz9+KjSm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="378792554"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="378792554"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 22:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068911050"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="1068911050"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2023 22:26:21 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaUlL-0007aw-2N;
        Mon, 28 Aug 2023 05:26:13 +0000
Date:   Mon, 28 Aug 2023 13:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 15d63a897f79f465d71fb55cc11c6b7e20c19391
Message-ID: <202308281348.Yi5QB9Io-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 15d63a897f79f465d71fb55cc11c6b7e20c19391  dt-bindings: PCI: qcom: Fix SDX65 compatible

elapsed time: 721m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230828   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230828   gcc  
arc                  randconfig-r032-20230828   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230828   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230828   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230828   gcc  
hexagon               randconfig-001-20230828   clang
hexagon               randconfig-002-20230828   clang
hexagon              randconfig-r013-20230828   clang
hexagon              randconfig-r025-20230828   clang
hexagon              randconfig-r035-20230828   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230828   gcc  
i386         buildonly-randconfig-002-20230828   gcc  
i386         buildonly-randconfig-003-20230828   gcc  
i386         buildonly-randconfig-004-20230828   gcc  
i386         buildonly-randconfig-005-20230828   gcc  
i386         buildonly-randconfig-006-20230828   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230828   gcc  
i386                  randconfig-002-20230828   gcc  
i386                  randconfig-003-20230828   gcc  
i386                  randconfig-004-20230828   gcc  
i386                  randconfig-005-20230828   gcc  
i386                  randconfig-006-20230828   gcc  
i386                  randconfig-011-20230828   clang
i386                  randconfig-012-20230828   clang
i386                  randconfig-013-20230828   clang
i386                  randconfig-014-20230828   clang
i386                  randconfig-015-20230828   clang
i386                  randconfig-016-20230828   clang
i386                 randconfig-r014-20230828   clang
i386                 randconfig-r021-20230828   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230828   gcc  
loongarch            randconfig-r003-20230828   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230828   gcc  
m68k                 randconfig-r034-20230828   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r005-20230828   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230828   gcc  
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
powerpc64            randconfig-r011-20230828   clang
powerpc64            randconfig-r031-20230828   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230828   gcc  
riscv                randconfig-r012-20230828   clang
riscv                randconfig-r033-20230828   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230828   clang
s390                 randconfig-r016-20230828   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230828   gcc  
sparc                randconfig-r036-20230828   gcc  
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
x86_64       buildonly-randconfig-001-20230828   gcc  
x86_64       buildonly-randconfig-002-20230828   gcc  
x86_64       buildonly-randconfig-003-20230828   gcc  
x86_64       buildonly-randconfig-004-20230828   gcc  
x86_64       buildonly-randconfig-005-20230828   gcc  
x86_64       buildonly-randconfig-006-20230828   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230828   clang
x86_64                randconfig-002-20230828   clang
x86_64                randconfig-003-20230828   clang
x86_64                randconfig-004-20230828   clang
x86_64                randconfig-005-20230828   clang
x86_64                randconfig-006-20230828   clang
x86_64                randconfig-011-20230828   gcc  
x86_64                randconfig-012-20230828   gcc  
x86_64                randconfig-013-20230828   gcc  
x86_64                randconfig-014-20230828   gcc  
x86_64                randconfig-015-20230828   gcc  
x86_64                randconfig-016-20230828   gcc  
x86_64                randconfig-071-20230828   gcc  
x86_64                randconfig-072-20230828   gcc  
x86_64                randconfig-073-20230828   gcc  
x86_64                randconfig-074-20230828   gcc  
x86_64                randconfig-075-20230828   gcc  
x86_64                randconfig-076-20230828   gcc  
x86_64               randconfig-r015-20230828   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r001-20230828   gcc  
xtensa               randconfig-r004-20230828   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
