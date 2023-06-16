Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD0732811
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjFPG6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbjFPG6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 02:58:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657702961
        for <linux-pci@vger.kernel.org>; Thu, 15 Jun 2023 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898694; x=1718434694;
  h=date:from:to:cc:subject:message-id;
  bh=mx7B9Xdtr/S/9S0i+7aR+dmwpDPODQTfTkVxMOPrWAE=;
  b=aAfmf9gj/RVGxVYRTCR1wzRGCgfAFqbd8x7kwF0yp7X+7xAAml8IFAgF
   UeAHeOuiZURMQ1KDAH8UjLsjnRDStWgDpsCnqazev+myX1i9wpE5XSIL9
   avTM80ksfLPT32x1EYQsHU3WwxsKXZeLYaAy05fgG6QMA1VhIc9jTHNDu
   zA0ENtXzKhANtvonDmKQT+Jib74unnufI+pqIIIlfqEQqFU6uYlDYlq/K
   FXPBFzcb5H2hQnYuceiUL47s5XEkAj7kk3bOyjrkf4+1UgGrGYdpCaoW9
   oVBiDZqi+BRRtWA1Z2mX6le+TFZLwNCX0oDu+S4bl+xvCHat3JRoi4Tdy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361666333"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="361666333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782779597"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="782779597"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 23:58:12 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA3PQ-0000tX-0T;
        Fri, 16 Jun 2023 06:58:12 +0000
Date:   Fri, 16 Jun 2023 14:57:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 7bf3ac8f8a883b57320c85f2377a4441737a2ef8
Message-ID: <202306161438.HjRL30Ep-lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 7bf3ac8f8a883b57320c85f2377a4441737a2ef8  PCI: Add failed link recovery for device reset events

elapsed time: 722m

configs tested: 109
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230615   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230615   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm          buildonly-randconfig-r001-20230614   clang
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r024-20230615   gcc  
arm                  randconfig-r046-20230615   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230614   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230615   gcc  
i386                 randconfig-i002-20230615   gcc  
i386                 randconfig-i003-20230615   gcc  
i386                 randconfig-i004-20230615   gcc  
i386                 randconfig-i005-20230615   gcc  
i386                 randconfig-i006-20230615   gcc  
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230615   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230615   gcc  
loongarch            randconfig-r015-20230614   gcc  
loongarch            randconfig-r021-20230615   gcc  
loongarch            randconfig-r034-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230615   gcc  
nios2                randconfig-r036-20230615   gcc  
openrisc             randconfig-r035-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r023-20230615   clang
powerpc              randconfig-r026-20230615   clang
powerpc              randconfig-r032-20230615   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r003-20230614   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230614   gcc  
riscv                randconfig-r033-20230615   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230614   gcc  
s390                 randconfig-r025-20230615   clang
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230615   gcc  
sparc64              randconfig-r006-20230615   gcc  
um                               alldefconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230616   clang
x86_64               randconfig-a002-20230616   clang
x86_64               randconfig-a003-20230616   clang
x86_64               randconfig-a004-20230616   clang
x86_64               randconfig-a005-20230616   clang
x86_64               randconfig-a006-20230616   clang
x86_64               randconfig-a011-20230614   gcc  
x86_64               randconfig-a012-20230614   gcc  
x86_64               randconfig-a013-20230614   gcc  
x86_64               randconfig-a014-20230614   gcc  
x86_64               randconfig-a015-20230614   gcc  
x86_64               randconfig-a016-20230614   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230614   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
