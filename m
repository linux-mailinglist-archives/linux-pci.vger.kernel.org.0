Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B627EFFCE
	for <lists+linux-pci@lfdr.de>; Sat, 18 Nov 2023 14:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKRNVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Nov 2023 08:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRNVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Nov 2023 08:21:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CE127
        for <linux-pci@vger.kernel.org>; Sat, 18 Nov 2023 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700313695; x=1731849695;
  h=date:from:to:cc:subject:message-id;
  bh=D7dcALPON0uc7XcBwwGEIGfJ20SEzViA7MX8Z8UNtxM=;
  b=AxsQq3E/rvg6vYuDtLo1i0QQ5tXF16CdzniwfwhEvzbHuADWE0rozYwB
   BU/TUDS/l2fcU/lDE/TGjcqpIUv28I9SGoIp4sVl83OLuqQUoGzPRzpUc
   76Zj7y6GnRwPmXVAhHNkPtq4b0jE8A0lIQuRnTVeP7exX7ICdbab5Dnis
   X5fLJaElCKC8zp3mE7yXD4r4drPX1zqPkVPNMPzpNCjH7P8rT8V0M++Ux
   PrLlsFJNpht4rxPl6upnsGY2TEWpTMjsA868/8cpUkcBwuvyg4m/2WVA8
   WYw7oqZMaGo2WlPMUHLTmXWydRjKtf/kNcvfbhT3gnMb62d/Dhv7HY4yN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390290351"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="390290351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 05:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="7279144"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2023 05:21:34 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4LGN-0003vz-0X;
        Sat, 18 Nov 2023 13:21:31 +0000
Date:   Sat, 18 Nov 2023 21:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/ecam] BUILD SUCCESS
 936e987d63a9e1a7039ffcae1e48ef40f89d36b2
Message-ID: <202311182145.zg96E2MQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git review/ecam
branch HEAD: 936e987d63a9e1a7039ffcae1e48ef40f89d36b2  x86/pci: Clarify ECAM 'reserved' messages

elapsed time: 722m

configs tested: 116
configs skipped: 124

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-002-20231118   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-004-20231118   gcc  
arm                           u8500_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-004-20231118   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-002-20231118   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-016-20231118   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-002-20231118   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                        allnoconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-002-20231118   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-002-20231118   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-003-20231118   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                          rv32_defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-002-20231118   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-002-20231118   gcc  
sh                            titan_defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-002-20231118   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-002-20231118   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-076-20231118   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-002-20231118   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
