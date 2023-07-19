Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF952759AA2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGSQUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGSQUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 12:20:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB71733
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689783606; x=1721319606;
  h=date:from:to:cc:subject:message-id;
  bh=iTDZih+9GFibyHNHfiEj2pRrmgQl8hvKSceOONfW1Gc=;
  b=GpSWIjawR4sjpUexqekK96eEnSVZD5pLSM/LBNo06gSw2xKPAX4MbTn8
   aOrINT09+uU/ZTnMPz6FyHMjN/c3L/FaaiqEFYzi8AvVF96AePkQ7wpLK
   Ywc+VuhO6UNsnL3Ehm267hKcuz4rmolPyqI4rc3kY3b19p9sY0IgGcf/j
   +EC1ECLUvf3jAOwxRMgQeD+ylTSbW426/L46mdPrtQCp/GW1eVuw5N6Pv
   1eQx0FHbbV/qLEks+bRr5mN0oHu4TZzg7xYbq5Dj6jF2Uluj4V9BdTbGW
   ESQaRYB9jsUuXGKDcGUqzD6AzFTp2ONIiT8sgrQqUx4QyNQoUtBklpATi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365393993"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365393993"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="837751669"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="837751669"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2023 09:19:49 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM9u0-00057J-1P;
        Wed, 19 Jul 2023 16:19:48 +0000
Date:   Thu, 20 Jul 2023 00:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 c925cfaf0992f151c02f239e035ca9316224f224
Message-ID: <202307200035.r0zAEPjS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: c925cfaf0992f151c02f239e035ca9316224f224  PCI: Explicitly include correct DT includes

elapsed time: 1185m

configs tested: 142
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230718   gcc  
arc                  randconfig-r013-20230718   gcc  
arc                  randconfig-r031-20230718   gcc  
arc                  randconfig-r035-20230718   gcc  
arc                  randconfig-r043-20230718   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r032-20230718   clang
arm                  randconfig-r046-20230718   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230718   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230718   clang
hexagon              randconfig-r045-20230718   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230718   gcc  
i386         buildonly-randconfig-r004-20230719   clang
i386         buildonly-randconfig-r005-20230718   gcc  
i386         buildonly-randconfig-r005-20230719   clang
i386         buildonly-randconfig-r006-20230718   gcc  
i386         buildonly-randconfig-r006-20230719   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230718   gcc  
i386                 randconfig-i002-20230718   gcc  
i386                 randconfig-i003-20230718   gcc  
i386                 randconfig-i004-20230718   gcc  
i386                 randconfig-i005-20230718   gcc  
i386                 randconfig-i006-20230718   gcc  
i386                 randconfig-i011-20230718   clang
i386                 randconfig-i012-20230718   clang
i386                 randconfig-i013-20230718   clang
i386                 randconfig-i014-20230718   clang
i386                 randconfig-i015-20230718   clang
i386                 randconfig-i016-20230718   clang
i386                 randconfig-r006-20230718   gcc  
i386                 randconfig-r015-20230718   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r004-20230718   gcc  
microblaze           randconfig-r012-20230718   gcc  
microblaze           randconfig-r033-20230718   gcc  
microblaze           randconfig-r036-20230718   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ip22_defconfig   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc              randconfig-r005-20230718   gcc  
powerpc              randconfig-r026-20230718   clang
powerpc              randconfig-r036-20230718   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r025-20230718   clang
riscv                randconfig-r042-20230718   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230718   gcc  
s390                 randconfig-r006-20230718   gcc  
s390                 randconfig-r011-20230718   clang
s390                 randconfig-r016-20230718   clang
s390                 randconfig-r031-20230718   gcc  
s390                 randconfig-r044-20230718   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r001-20230718   gcc  
sh                   randconfig-r034-20230718   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230718   gcc  
sparc                randconfig-r023-20230718   gcc  
sparc                randconfig-r024-20230718   gcc  
sparc64              randconfig-r022-20230718   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230718   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230718   gcc  
x86_64       buildonly-randconfig-r001-20230719   clang
x86_64       buildonly-randconfig-r002-20230718   gcc  
x86_64       buildonly-randconfig-r002-20230719   clang
x86_64       buildonly-randconfig-r003-20230718   gcc  
x86_64       buildonly-randconfig-r003-20230719   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230718   clang
x86_64               randconfig-r014-20230718   clang
x86_64               randconfig-r032-20230718   gcc  
x86_64               randconfig-x001-20230718   clang
x86_64               randconfig-x002-20230718   clang
x86_64               randconfig-x003-20230718   clang
x86_64               randconfig-x004-20230718   clang
x86_64               randconfig-x005-20230718   clang
x86_64               randconfig-x006-20230718   clang
x86_64               randconfig-x011-20230718   gcc  
x86_64               randconfig-x012-20230718   gcc  
x86_64               randconfig-x013-20230718   gcc  
x86_64               randconfig-x014-20230718   gcc  
x86_64               randconfig-x015-20230718   gcc  
x86_64               randconfig-x016-20230718   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230718   gcc  
xtensa               randconfig-r034-20230718   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
