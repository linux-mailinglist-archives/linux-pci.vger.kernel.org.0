Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC47A2F40
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjIPK3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 06:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjIPK3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 06:29:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29788CED
        for <linux-pci@vger.kernel.org>; Sat, 16 Sep 2023 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694860172; x=1726396172;
  h=date:from:to:cc:subject:message-id;
  bh=3lz34+by8Wz9DLQf50eUa8S6Jxt6KhvhmxO7IpAK3wE=;
  b=JHr82epUqXrRAKUGRhYhpkjOLvD39bOXn91tBngi1Mh+oRj+2/y2AHYF
   +rnaQJaQ9sDNZMlJiymjm2w7s6J3D7IKHCNGz0zqMGudAgMelPCjoSinc
   VkTxqIPgh8OKLZZp0hMLlKnEOlgs7EjQSmL1KYJcunPtp2hpp6pEDGEmD
   vMuJjhRmqjHmWeOyPJ+xdXt+oEFThKMFCHImwKDC04XdmWCxHk570OYnv
   hlo1dg6wwS8CvynP2L5lE2lcBJ3lFucxkbQZCeGCWhwS+/upcu6Mzdnyl
   4IufgILzuyspHwIQ0ePQVYnDed15yNHMjB0jTueDrdzK97Z2/WsRGcPzT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410358481"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="410358481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 03:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="835494407"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="835494407"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2023 03:29:30 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhSYK-0004C2-2v;
        Sat, 16 Sep 2023 10:29:28 +0000
Date:   Sat, 16 Sep 2023 18:28:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 71822b3dd3395fb5a680efb9cae2d29b5dc9a604
Message-ID: <202309161856.2p7z0nSu-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 71822b3dd3395fb5a680efb9cae2d29b5dc9a604  Merge branch 'pci/endpoint'

elapsed time: 727m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230916   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20230916   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230916   gcc  
i386         buildonly-randconfig-002-20230916   gcc  
i386         buildonly-randconfig-003-20230916   gcc  
i386         buildonly-randconfig-004-20230916   gcc  
i386         buildonly-randconfig-005-20230916   gcc  
i386         buildonly-randconfig-006-20230916   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230916   gcc  
i386                  randconfig-002-20230916   gcc  
i386                  randconfig-003-20230916   gcc  
i386                  randconfig-004-20230916   gcc  
i386                  randconfig-005-20230916   gcc  
i386                  randconfig-006-20230916   gcc  
i386                  randconfig-011-20230916   gcc  
i386                  randconfig-012-20230916   gcc  
i386                  randconfig-013-20230916   gcc  
i386                  randconfig-014-20230916   gcc  
i386                  randconfig-015-20230916   gcc  
i386                  randconfig-016-20230916   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230916   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
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
powerpc                      arches_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8540_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230916   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230916   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230916   gcc  
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
x86_64       buildonly-randconfig-001-20230916   gcc  
x86_64       buildonly-randconfig-002-20230916   gcc  
x86_64       buildonly-randconfig-003-20230916   gcc  
x86_64       buildonly-randconfig-004-20230916   gcc  
x86_64       buildonly-randconfig-005-20230916   gcc  
x86_64       buildonly-randconfig-006-20230916   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230916   gcc  
x86_64                randconfig-002-20230916   gcc  
x86_64                randconfig-003-20230916   gcc  
x86_64                randconfig-004-20230916   gcc  
x86_64                randconfig-005-20230916   gcc  
x86_64                randconfig-006-20230916   gcc  
x86_64                randconfig-011-20230916   gcc  
x86_64                randconfig-012-20230916   gcc  
x86_64                randconfig-013-20230916   gcc  
x86_64                randconfig-014-20230916   gcc  
x86_64                randconfig-015-20230916   gcc  
x86_64                randconfig-016-20230916   gcc  
x86_64                randconfig-071-20230916   gcc  
x86_64                randconfig-072-20230916   gcc  
x86_64                randconfig-073-20230916   gcc  
x86_64                randconfig-074-20230916   gcc  
x86_64                randconfig-075-20230916   gcc  
x86_64                randconfig-076-20230916   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
