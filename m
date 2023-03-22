Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94E6C4403
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 08:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCVHZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVHZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 03:25:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BAD19122
        for <linux-pci@vger.kernel.org>; Wed, 22 Mar 2023 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679469931; x=1711005931;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7VmOamKZMrYxYB6pymC18pnvyxPSx9PGA1Fu7oDw1VU=;
  b=XTp+/uLRS3eXHSqJRJY3c6GIm+LwBmSgdFwkHGJhCLJA/ewgiRea5EON
   wymWK12AJLOH1OJtGoPdcdLOYlzI56wIXRYXBuKv2hbQa4vMKyN5L6CKn
   Ui9VcjjKIhLYbm1BZ9VfjM8vW9FfM57/xAioo1UcOYsWiHkP0zXRLOouI
   NzajjtD/V+yWRBJZuv0RIAOWusNkEGBaA4EBJlJhL+PsO1y+mFXnj5ISV
   vB7DFE/tZ4LD4F/GJWPMjvkXREv/g1N6wkylFMOUqrJuFqcdVdyq+QKcg
   gfmuJR0OTPrJWqo0EFiAjSwX9+0jlFjUMU1XA8jVwF00vdHh+pPQlnPuU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401715230"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="401715230"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 00:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746200366"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="746200366"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 00:25:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pesqb-000D2o-1U;
        Wed, 22 Mar 2023 07:25:25 +0000
Date:   Wed, 22 Mar 2023 15:24:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 cdce67099117ece371582f706c6eff7d3a65326d
Message-ID: <641aad3b.QGHvfEYSsKpuCxLe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: cdce67099117ece371582f706c6eff7d3a65326d  PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled

elapsed time: 731m

configs tested: 96
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230321   gcc  
arc                  randconfig-r035-20230319   gcc  
arc                  randconfig-r036-20230321   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r035-20230321   clang
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230319   gcc  
csky                 randconfig-r022-20230319   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r004-20230320   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r026-20230319   gcc  
microblaze           randconfig-r014-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230319   gcc  
parisc               randconfig-r034-20230321   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc              randconfig-r002-20230319   gcc  
powerpc              randconfig-r032-20230319   gcc  
powerpc              randconfig-r034-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230321   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230319   gcc  
sh                   randconfig-r031-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r021-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64               randconfig-a002-20230320   clang
x86_64               randconfig-a003-20230320   clang
x86_64               randconfig-a004-20230320   clang
x86_64               randconfig-a005-20230320   clang
x86_64               randconfig-a006-20230320   clang
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230320   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230319   gcc  
xtensa               randconfig-r036-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
