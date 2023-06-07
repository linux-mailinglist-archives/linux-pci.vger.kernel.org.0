Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E4725D06
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjFGL0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbjFGL0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 07:26:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743B1712
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686137161; x=1717673161;
  h=date:from:to:cc:subject:message-id;
  bh=GWSdcQS5bR0Pw3nmHP2N3T+hsv6IX8AmVVFlh5fTbJA=;
  b=Gy/u5CfcSj8mjvmva2ihH3C8PIov3MJ5s6qMCo8KYtfxDyEynnGyxZB3
   WvnCcJGrPLAe5K7yM7pc8TLmVE2Et9ECAjPx5T2A8UVGIssNXqpoucyMZ
   5EDmjSexW0WGHJpWkGXKq62C2Fl5VUgQHVi5WvBf/esS5kfx5zALH1qa1
   bmmaY5QaTt1Lix1tI4aVGKA/Vr6EWKsKxVQvWRi3IP8PKu3ecy6GuQlpx
   VV3o/Pw/zwgufQ9qn3dskCX5iCMBPkLqHnYDifdm11/ZtRyt+5/jTMP3b
   DV/WcFBRLfRzA2owtzZpD1Hqf3tcVkv4IK7o3rHTAbCv+D9P/5LmyQtf3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355813781"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="355813781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686928051"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="686928051"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 04:25:58 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6rIc-0006VF-09;
        Wed, 07 Jun 2023 11:25:58 +0000
Date:   Wed, 07 Jun 2023 19:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 c6f54cf44c3d05510f8f292a1782105c087797ba
Message-ID: <20230607112511.DzEsp%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: c6f54cf44c3d05510f8f292a1782105c087797ba  PCI: of: Propagate firmware node by calling device_set_node()

elapsed time: 724m

configs tested: 135
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230607   gcc  
alpha        buildonly-randconfig-r003-20230607   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230607   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r035-20230607   gcc  
arc                  randconfig-r043-20230607   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230607   clang
csky                                defconfig   gcc  
csky                 randconfig-r015-20230607   gcc  
csky                 randconfig-r024-20230607   gcc  
hexagon              randconfig-r034-20230607   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230607   clang
i386                 randconfig-i002-20230607   clang
i386                 randconfig-i003-20230607   clang
i386                 randconfig-i004-20230607   clang
i386                 randconfig-i005-20230607   clang
i386                 randconfig-i006-20230607   clang
i386                 randconfig-i011-20230607   gcc  
i386                 randconfig-i012-20230607   gcc  
i386                 randconfig-i013-20230607   gcc  
i386                 randconfig-i014-20230607   gcc  
i386                 randconfig-i015-20230607   gcc  
i386                 randconfig-i016-20230607   gcc  
i386                 randconfig-i051-20230607   clang
i386                 randconfig-i052-20230607   clang
i386                 randconfig-i053-20230607   clang
i386                 randconfig-i054-20230607   clang
i386                 randconfig-i055-20230607   clang
i386                 randconfig-i056-20230607   clang
i386                 randconfig-i061-20230607   clang
i386                 randconfig-i062-20230607   clang
i386                 randconfig-i063-20230607   clang
i386                 randconfig-i064-20230607   clang
i386                 randconfig-i065-20230607   clang
i386                 randconfig-i066-20230607   clang
i386                 randconfig-r031-20230607   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230607   gcc  
loongarch            randconfig-r025-20230607   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r002-20230607   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                 randconfig-r005-20230607   gcc  
m68k                 randconfig-r016-20230607   gcc  
m68k                 randconfig-r031-20230607   gcc  
microblaze   buildonly-randconfig-r003-20230607   gcc  
microblaze           randconfig-r004-20230607   gcc  
microblaze           randconfig-r013-20230607   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r003-20230607   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230607   gcc  
openrisc             randconfig-r012-20230607   gcc  
openrisc             randconfig-r015-20230607   gcc  
openrisc             randconfig-r016-20230607   gcc  
parisc       buildonly-randconfig-r001-20230607   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230607   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r016-20230607   gcc  
powerpc              randconfig-r021-20230607   gcc  
powerpc              randconfig-r035-20230607   clang
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230607   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230607   gcc  
riscv                randconfig-r022-20230607   gcc  
riscv                randconfig-r042-20230607   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230607   clang
s390                 randconfig-r044-20230607   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230607   clang
x86_64               randconfig-a002-20230607   clang
x86_64               randconfig-a003-20230607   clang
x86_64               randconfig-a004-20230607   clang
x86_64               randconfig-a006-20230607   clang
x86_64               randconfig-a011-20230607   gcc  
x86_64               randconfig-a012-20230607   gcc  
x86_64               randconfig-a013-20230607   gcc  
x86_64               randconfig-a014-20230607   gcc  
x86_64               randconfig-a015-20230607   gcc  
x86_64               randconfig-a016-20230607   gcc  
x86_64               randconfig-r015-20230607   gcc  
x86_64               randconfig-x051-20230607   gcc  
x86_64               randconfig-x052-20230607   gcc  
x86_64               randconfig-x053-20230607   gcc  
x86_64               randconfig-x054-20230607   gcc  
x86_64               randconfig-x055-20230607   gcc  
x86_64               randconfig-x056-20230607   gcc  
x86_64               randconfig-x061-20230607   gcc  
x86_64               randconfig-x062-20230607   gcc  
x86_64               randconfig-x063-20230607   gcc  
x86_64               randconfig-x064-20230607   gcc  
x86_64               randconfig-x065-20230607   gcc  
x86_64               randconfig-x066-20230607   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230607   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
