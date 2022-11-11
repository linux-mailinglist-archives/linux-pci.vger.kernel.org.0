Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635C5625673
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 10:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiKKJSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 04:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKKJSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 04:18:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6161CB02
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668158290; x=1699694290;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aWN0iLxCFe0NodKduEcBjtfFNxQ8KX+cuFcyt0E7F6s=;
  b=Drh8LdsF3Vs+H6+mYusWZ59j2ly5vu14krY6fsq76+iPjwlUCFGjtDyH
   rkPdqX8921VPGCRdkPGHnJhVscilSuRqoJLactrHud4Xhkff+u5tzmvGV
   fbY232H4/60Gy20AXhgBWZ5I+PCv4B8Sg43R5jya2tYPfNy1eL+j2Bc/d
   +k97k1DRx1nhWRJ0u3WIfVxB/LRvUdxEwe3G2rtkpRh2r3dXRC3S1G9cK
   Pq3jIj/jPf0ttdhau4fnrn9JECrgsr+oXSSvR9e+3rtdwTVRqY4gUiS/p
   tz+D4CbqMFKJF7QJ2JreLqoYUnyhy39GqpF6ZN/VTpxNmk5fGjLZfWebc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373694666"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="373694666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706488956"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="706488956"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2022 01:18:01 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otQAi-0003o1-2M;
        Fri, 11 Nov 2022 09:18:00 +0000
Date:   Fri, 11 Nov 2022 17:17:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/kbuild] BUILD SUCCESS
 51dfb612ab3becf91eab20569fd88a1172df87ab
Message-ID: <636e133e.fO3BWLemhi758a5I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/kbuild
branch HEAD: 51dfb612ab3becf91eab20569fd88a1172df87ab  PCI: Drop controller CONFIG_OF dependencies

elapsed time: 725m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                            allnoconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                                defconfig
arc                        nsimosci_defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                       ppc64_defconfig
arm                          pxa910_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20221111
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7724_defconfig
parisc                           alldefconfig
powerpc                    amigaone_defconfig
arm                           viper_defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
microblaze                          defconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20221110
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                randconfig-r042-20221111
arc                  randconfig-r043-20221111
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                      integrator_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig

clang tested configs:
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
arm                       aspeed_g4_defconfig
mips                      pic32mzda_defconfig
arm                         lpc32xx_defconfig
powerpc                      obs600_defconfig
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
