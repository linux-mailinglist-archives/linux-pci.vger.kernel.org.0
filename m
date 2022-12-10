Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49813648E33
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLJKas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 05:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLJKar (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 05:30:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFFE6F
        for <linux-pci@vger.kernel.org>; Sat, 10 Dec 2022 02:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670668246; x=1702204246;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xwu+YqZPoHKU1k7H1UfiSxkjxouYd5tRE17WzCrk0w8=;
  b=h3Tv4zTGcoRlWiFe3L3balZj3FC/u9j3tFHVW8Jy/DbNd1Iure3q4MSh
   irkhfKXfq4MDN0FGQT8lV7bPMe+bkBkF/6Y+pTz7p6P0N1aCQi90bE6Zb
   NZC9mOHeFJgzZOguqlsFMmUmJ7Ohn08Ntf3WxSCiWzhnvT313lKmQ1l70
   isQ13AcD4QmyNQkGqOq/Jqh+AMK4S1Ozdmyqax2N5JpgwNLi2UG302Wh7
   /fYDippLbtF0ZqRxDCi8/Xz70INvBoVoaJUAi2XOZv2t1rbE1E6E8iR2p
   jkZK8RGBcZ/SGg/tVlsx3HjJAtLb/YSEJLMqb4xEZUNUbIychsw0j12nI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="305254659"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="305254659"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 02:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="754330214"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="754330214"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2022 02:30:44 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3x7z-0002NC-2f;
        Sat, 10 Dec 2022 10:30:43 +0000
Date:   Sat, 10 Dec 2022 18:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 08d783899da585fca0e4a7752fa674b9dd39f82f
Message-ID: <63945fa7.sQNxZBhzHZ1liOUn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 08d783899da585fca0e4a7752fa674b9dd39f82f  x86/PCI: Use pr_info() when possible

elapsed time: 721m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20221209
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20221209
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221209
i386                                defconfig
powerpc                           allnoconfig
arc                                 defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                                defconfig
m68k                             allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
i386                          randconfig-a001
powerpc                          allmodconfig
i386                          randconfig-a003
ia64                             allmodconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
arm                  randconfig-r046-20221209
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
