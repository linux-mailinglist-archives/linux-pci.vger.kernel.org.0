Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606905EBD96
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiI0Ijj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiI0Ije (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:39:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8098FF8
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664267971; x=1695803971;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yTvBt6Ra9jX4T7oXI1CEhrmpZwc8Uts/cbORqmWYZLI=;
  b=YmNDmyI0zvQcln1epVeNPahRAk4YaMAC6P10g5y341SOmrHiRRlkZJrg
   8SVCWmsrFbLNdXfPKOpkrNv+1AgOA5KpqvrL3ufRY05qOiddC16Q2X6S3
   MRTw3bvB+Xyc2ahM1t3SMqdGZpJ/fzoACKUUy6kjJIeML0+CMr1IHMSHY
   nG6aW9vgyKYvynbyvV9h80zcweNrdCEUxCZWgt51l/l/TyZMXFskdB8Ls
   O2iSrW2aGJqCr+1lktqe1q5llFaouQUj0+K+uMzPtxHvHig7P7qVnGxzQ
   yUTKBijJQUoiCCOIPfVcQ1nFcoT3hsAdiyb4JpRLVtNLtJsUo0Q5ZuhIM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302170854"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302170854"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 01:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725427223"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="725427223"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2022 01:39:30 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od67l-0000oW-1W;
        Tue, 27 Sep 2022 08:39:29 +0000
Date:   Tue, 27 Sep 2022 16:38:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 e01bae16a7d68931f0450cb079479c4a8f56d3e3
Message-ID: <6332b6a3.g/SevJ59OZaI5h1V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: e01bae16a7d68931f0450cb079479c4a8f56d3e3  PCI/P2PDMA: Use for_each_pci_dev() helper

elapsed time: 720m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allmodconfig
alpha                            allyesconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
sh                   secureedge5410_defconfig
arm                          gemini_defconfig
powerpc                      tqm8xx_defconfig
sh                               alldefconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
ia64                             allmodconfig
arm                         axm55xx_defconfig
powerpc                 canyonlands_defconfig
i386                          randconfig-c001
sparc                             allnoconfig
arm                          simpad_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      integrator_defconfig
microblaze                          defconfig
ia64                             alldefconfig
sh                          kfr2r09_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                          allmodconfig
arm                          collie_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
