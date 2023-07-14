Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6E75321D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGNGie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGNGib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 02:38:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9472694
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689316710; x=1720852710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F+D+osvIWb81zXDqVdA1oFjhtV1NAlw2wdp/1QqX+uY=;
  b=nbawmEeIF9a5QM18Kiz8vnyvLngCKI04Vsnsm1BMrPCt2sCJNSuDvz/N
   50mOPKf62nlNF3RrMjr6wuUfJ6CaEm4E0Bmjr9k/mpYaHHePFs9mBA/qO
   3ZQURWM10mLPHnM2yDhb+juuA6FRUwKmC8sTq08dWxiMn4gTd17+jze4u
   bseZfKiITorAOsMsQgsx6l3DZtVBteRcvTYmyppV4Lyo6UW8LgjeNZlFa
   w8nEJkEEkTSbv2WXFiljhCTmcIRVtGrGmol5ocNI9KONeTjbbHPrOFOLO
   tzLbeiLFK9bZqwals3PQTrodWq+mTogbojZhBgUy/xvrGhm5Mnqeo2EHj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365443384"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365443384"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896304673"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896304673"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 23:38:24 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKCRb-0007F0-24;
        Fri, 14 Jul 2023 06:38:23 +0000
Date:   Fri, 14 Jul 2023 14:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 cdb50033dd6dfcf02ae3d4ee56bc1a9555be6d36
Message-ID: <202307141401.5qHCl8zD-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: cdb50033dd6dfcf02ae3d4ee56bc1a9555be6d36  PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address

elapsed time: 726m

configs tested: 118
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r035-20230713   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230713   gcc  
arc                  randconfig-r043-20230713   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r046-20230713   clang
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r011-20230713   clang
hexagon              randconfig-r034-20230713   clang
hexagon              randconfig-r041-20230713   clang
hexagon              randconfig-r045-20230713   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230713   clang
i386                 randconfig-i002-20230713   clang
i386                 randconfig-i003-20230713   clang
i386                 randconfig-i004-20230713   clang
i386                 randconfig-i005-20230713   clang
i386                 randconfig-i006-20230713   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r022-20230713   gcc  
i386                 randconfig-r023-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230713   gcc  
microblaze           randconfig-r001-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                 randconfig-r031-20230713   gcc  
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230713   gcc  
nios2                randconfig-r016-20230713   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc              randconfig-r025-20230713   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230713   gcc  
riscv                randconfig-r042-20230713   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230713   clang
s390                 randconfig-r021-20230713   gcc  
s390                 randconfig-r044-20230713   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230713   gcc  
sh                   randconfig-r013-20230713   gcc  
sh                   randconfig-r033-20230713   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r024-20230713   gcc  
sparc64              randconfig-r032-20230713   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230713   clang
x86_64               randconfig-x012-20230713   clang
x86_64               randconfig-x013-20230713   clang
x86_64               randconfig-x014-20230713   clang
x86_64               randconfig-x015-20230713   clang
x86_64               randconfig-x016-20230713   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
