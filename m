Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64249747C81
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 07:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGEFiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 01:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGEFh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 01:37:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D2E7B
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688535475; x=1720071475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jqQBc6hHXlUhkWR05Bads3V43qZGJKNesTOOSwzVDw=;
  b=GyGN/pklm4R9d/YuWWPLA0guBBB4P1IOeJ+1hQ91ZVdGBK92ckS5mcnq
   YKYV1zEPblQ7T9gsge58NmUTljd+GM0Dr0xh8t9uK0bWyv3UO08RiDkxu
   qXD8k4W+/Aiy2uzsOyU6kYvi3nDGenzvIsx6PRqdSelyTFxbju8frpUv7
   V8hd5GFjePPrUPnUqLlc1x8ua/nt9YlKgI0iS7Kob8J2SBzps+JVxW/wK
   /Lool32FD/MqBywZoAnup+9cycw68Vq0ZWhqOy40a6EWsFnqiVYxl7/NM
   qixBPKiK8I/lPGNRrjQUvHu74bVJbOkuxKR+dEJqwrjmEhNseT5S8KpCU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="353083842"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="353083842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 22:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="784405883"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="784405883"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2023 22:37:49 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGvD2-0000Of-2b;
        Wed, 05 Jul 2023 05:37:48 +0000
Date:   Wed, 05 Jul 2023 13:37:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/remove-void-cast] BUILD SUCCESS
 1928737d492a1f9adc1e194c29a5716ef0d5262e
Message-ID: <202307051324.10pMCnKb-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/remove-void-cast
branch HEAD: 1928737d492a1f9adc1e194c29a5716ef0d5262e  PCI: microchip: Remove cast between incompatible function type

elapsed time: 724m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230704   gcc  
alpha                randconfig-r004-20230704   gcc  
alpha                randconfig-r025-20230704   gcc  
alpha                randconfig-r034-20230703   gcc  
alpha                randconfig-r035-20230704   gcc  
alpha                randconfig-r036-20230703   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230704   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          ixp4xx_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r002-20230704   gcc  
arm                  randconfig-r046-20230704   clang
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230704   gcc  
hexagon              randconfig-r013-20230704   clang
hexagon              randconfig-r023-20230704   clang
hexagon              randconfig-r026-20230704   clang
hexagon              randconfig-r033-20230704   clang
hexagon              randconfig-r041-20230703   clang
hexagon              randconfig-r041-20230704   clang
hexagon              randconfig-r045-20230703   clang
hexagon              randconfig-r045-20230704   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230703   gcc  
i386         buildonly-randconfig-r005-20230703   gcc  
i386         buildonly-randconfig-r006-20230703   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230703   gcc  
i386                 randconfig-i001-20230704   clang
i386                 randconfig-i002-20230703   gcc  
i386                 randconfig-i002-20230704   clang
i386                 randconfig-i003-20230703   gcc  
i386                 randconfig-i003-20230704   clang
i386                 randconfig-i004-20230703   gcc  
i386                 randconfig-i004-20230704   clang
i386                 randconfig-i005-20230703   gcc  
i386                 randconfig-i005-20230704   clang
i386                 randconfig-i006-20230703   gcc  
i386                 randconfig-i006-20230704   clang
i386                 randconfig-i011-20230703   clang
i386                 randconfig-i012-20230703   clang
i386                 randconfig-i013-20230703   clang
i386                 randconfig-i014-20230703   clang
i386                 randconfig-i015-20230703   clang
i386                 randconfig-i016-20230703   clang
i386                 randconfig-r032-20230704   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r015-20230704   gcc  
loongarch            randconfig-r032-20230703   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r012-20230704   gcc  
m68k                 randconfig-r033-20230703   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r014-20230704   clang
mips                       rbtx49xx_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230704   gcc  
nios2                randconfig-r024-20230704   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230704   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                    socrates_defconfig   clang
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230704   gcc  
riscv                randconfig-r042-20230703   clang
riscv                randconfig-r042-20230704   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230704   gcc  
s390                 randconfig-r031-20230703   gcc  
s390                 randconfig-r044-20230703   clang
s390                 randconfig-r044-20230704   gcc  
sh                               allmodconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230704   gcc  
sparc                randconfig-r036-20230704   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230704   gcc  
um                   randconfig-r034-20230704   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230703   gcc  
x86_64       buildonly-randconfig-r002-20230703   gcc  
x86_64       buildonly-randconfig-r003-20230703   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230703   clang
x86_64               randconfig-x001-20230704   gcc  
x86_64               randconfig-x002-20230703   clang
x86_64               randconfig-x002-20230704   gcc  
x86_64               randconfig-x003-20230703   clang
x86_64               randconfig-x003-20230704   gcc  
x86_64               randconfig-x004-20230703   clang
x86_64               randconfig-x004-20230704   gcc  
x86_64               randconfig-x005-20230703   clang
x86_64               randconfig-x005-20230704   gcc  
x86_64               randconfig-x006-20230703   clang
x86_64               randconfig-x006-20230704   gcc  
x86_64               randconfig-x011-20230703   gcc  
x86_64               randconfig-x011-20230704   clang
x86_64               randconfig-x012-20230703   gcc  
x86_64               randconfig-x012-20230704   clang
x86_64               randconfig-x013-20230703   gcc  
x86_64               randconfig-x013-20230704   clang
x86_64               randconfig-x014-20230703   gcc  
x86_64               randconfig-x014-20230704   clang
x86_64               randconfig-x015-20230703   gcc  
x86_64               randconfig-x015-20230704   clang
x86_64               randconfig-x016-20230703   gcc  
x86_64               randconfig-x016-20230704   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
