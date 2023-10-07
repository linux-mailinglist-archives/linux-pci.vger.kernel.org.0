Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62457BC459
	for <lists+linux-pci@lfdr.de>; Sat,  7 Oct 2023 05:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjJGDRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 23:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjJGDRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 23:17:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01578BF
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696648663; x=1728184663;
  h=date:from:to:cc:subject:message-id;
  bh=n0OJMT+10ERfnXPNBPNBRa95MGStyoT6QhSkYdNP3go=;
  b=Kevqqow4ciDgFsyhqOgASRcqL01zRNLZ9QxdWBjeK4kHlvxbx+2cRw9g
   KfnhA64PJfemsLfXMGN4sZkyQc4KnLlnjYZTCqvghoWZtF9/iJ5U9ktKu
   vc0eU4Z4BxS2RI3OUecZIpChEFkUG+x8OjZ6FA3tYK+vB+wwPuow6GB7I
   LkQ6Csd14gtoyGmvClZNZHTtRu+fJIxsfkT916kj+eTEEesK/Z5pKXdMw
   RiBVZ7lEeNqMpfbIcKDiTK6buCnIFJkWbvjYue12cS3tyGjKuHK0pw3z6
   /Kq3vxAaTnfJrwUxbLKgJtj45lva8SC9RtOA8s+ir0lK9ljf+nw2TxIKl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387757538"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387757538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 20:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="876172685"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="876172685"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 20:17:42 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoxoy-0003uC-0y;
        Sat, 07 Oct 2023 03:17:40 +0000
Date:   Sat, 07 Oct 2023 11:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 7d08f21f8c6307cb05cabb8d86e90ff6ccba57e9
Message-ID: <202310071124.uKAciOzO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: 7d08f21f8c6307cb05cabb8d86e90ff6ccba57e9  x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4

elapsed time: 747m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231007   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231007   gcc  
i386                  randconfig-002-20231007   gcc  
i386                  randconfig-003-20231007   gcc  
i386                  randconfig-004-20231007   gcc  
i386                  randconfig-005-20231007   gcc  
i386                  randconfig-006-20231007   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
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
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
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
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231007   gcc  
x86_64                randconfig-002-20231007   gcc  
x86_64                randconfig-003-20231007   gcc  
x86_64                randconfig-004-20231007   gcc  
x86_64                randconfig-005-20231007   gcc  
x86_64                randconfig-006-20231007   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
