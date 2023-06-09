Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8C729038
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbjFIGmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbjFIGlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 02:41:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7E26AD
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686292901; x=1717828901;
  h=date:from:to:cc:subject:message-id;
  bh=fiCgXUhRHODqqeHs5JXFVlm575B/gKuMA6Y+Kxc9Qps=;
  b=CGd630LEY6xkx9CjwbRFSHVsL8Hf50gI1POaWn32HvYGyJaNwymO2F6Z
   I8AgVsZJAEtPRys32gsiq5PAcK1fExyHivZKLizx3gj70rypoAc5g3CjI
   YWRyvZCgu6wCJ/HI/ZtKoWzxTLWZPWh+lOqG3iUiBnogXmTbT52vKfiTk
   c02rAxeR21+uXUg2kpyR3KC6MXpRMeQbpBksbk4PL5kByVfAuhw0UauiW
   aXlk8sin+LK/DEZmu8lDJMsQS3Ai2uh9OmQFWfooqmwH83AUtu4j5SvJP
   gQ7GgKYqWX6Vh+b1QdOt1+J7qik4SNkkZiqxG9M8II7nHdb9MVn0RAIhv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355022080"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355022080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 23:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775382700"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="775382700"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2023 23:41:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7VoZ-0008kQ-22;
        Fri, 09 Jun 2023 06:41:39 +0000
Date:   Fri, 09 Jun 2023 14:41:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 88d341716b83abd355558523186ca488918627ee
Message-ID: <202306091422.bK4wyfmZ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 88d341716b83abd355558523186ca488918627ee  PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

elapsed time: 761m

configs tested: 65
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230608   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230608   gcc  
arc                  randconfig-r015-20230608   gcc  
arc                  randconfig-r021-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230608   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230608   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230608   gcc  
csky                 randconfig-r032-20230608   gcc  
hexagon      buildonly-randconfig-r001-20230608   clang
hexagon              randconfig-r016-20230608   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230608   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r034-20230608   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230608   gcc  
m68k                 randconfig-r031-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230608   gcc  
mips                 randconfig-r035-20230608   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
