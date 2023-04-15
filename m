Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFE6E2F40
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 08:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDOGIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Apr 2023 02:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDOGIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Apr 2023 02:08:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4821989
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681538897; x=1713074897;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UMA2A3CBG+y8nc1vbe7+imtY1WPOzr5sGmejfS0oa40=;
  b=BvnPBfUsnlEz9UTwNInlXxf386+wG5UEEckRMUyp1iZexPGvSekvy/rp
   HpKZXZyMFB8xzjQ8940iR3sWQbHA63fsRbt+G8t7F6QVFiqx+1ouYfpME
   DXOFa2Od5N43DGhcep0o9Pmdg8Yk0TEAv6IiBsgD853UZRurhmoK2Ur22
   SVeCJJg3CjJaN0brHipNVeEOSOMX5sNpyWY18u5FKNmCeH5TdZr24sPCt
   pNw37n3fJv7j/uvIUzz/wqLvfZduArnh4XxXzvDJ27MyJK0kolbqET2LU
   zF1zj9tMGX1rybZ/UqMT/OMe4LgDlmvo59NVmUOGJMTkaNoQNpMxwN1xr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="342113710"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="342113710"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 23:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="722714713"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="722714713"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2023 23:08:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnZ55-000aZ7-0F;
        Sat, 15 Apr 2023 06:08:15 +0000
Date:   Sat, 15 Apr 2023 14:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 1fdef2055d8690d6f29d08d6d506bb7fba708488
Message-ID: <643a3f25.AMbLEWIS+bFzjZ8Y%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 1fdef2055d8690d6f29d08d6d506bb7fba708488  Merge branch 'pci/controller/rcar'

elapsed time: 724m

configs tested: 144
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230409   gcc  
alpha                randconfig-r013-20230410   gcc  
alpha                randconfig-r026-20230414   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230410   gcc  
arc                  randconfig-r036-20230413   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230413   gcc  
arc                  randconfig-r043-20230414   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230409   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm                  randconfig-r046-20230413   gcc  
arm                  randconfig-r046-20230414   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230410   clang
arm64                randconfig-r015-20230413   clang
csky                                defconfig   gcc  
csky                 randconfig-r015-20230409   gcc  
csky                 randconfig-r031-20230409   gcc  
csky                 randconfig-r034-20230414   gcc  
hexagon              randconfig-r033-20230414   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r041-20230414   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
hexagon              randconfig-r045-20230413   clang
hexagon              randconfig-r045-20230414   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r006-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230410   gcc  
loongarch            randconfig-r032-20230414   gcc  
loongarch            randconfig-r034-20230410   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r016-20230409   gcc  
m68k                 randconfig-r023-20230414   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230410   clang
mips                 randconfig-r014-20230413   gcc  
mips                 randconfig-r025-20230414   clang
mips                 randconfig-r032-20230413   clang
mips                 randconfig-r034-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230409   gcc  
nios2                randconfig-r013-20230409   gcc  
nios2                randconfig-r015-20230410   gcc  
nios2                randconfig-r016-20230410   gcc  
nios2                randconfig-r034-20230413   gcc  
openrisc             randconfig-r006-20230409   gcc  
openrisc             randconfig-r036-20230414   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230410   clang
powerpc              randconfig-r011-20230410   gcc  
powerpc              randconfig-r021-20230414   gcc  
powerpc              randconfig-r033-20230413   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r022-20230414   gcc  
riscv                randconfig-r035-20230410   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230413   clang
riscv                randconfig-r042-20230414   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230414   clang
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230413   clang
s390                 randconfig-r044-20230414   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230409   gcc  
sh                   randconfig-r011-20230413   gcc  
sh                   randconfig-r035-20230413   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r005-20230410   gcc  
sparc64              randconfig-r016-20230413   gcc  
sparc64              randconfig-r032-20230409   gcc  
sparc64              randconfig-r033-20230409   gcc  
sparc64              randconfig-r036-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230413   gcc  
xtensa               randconfig-r031-20230414   gcc  
xtensa               randconfig-r033-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
