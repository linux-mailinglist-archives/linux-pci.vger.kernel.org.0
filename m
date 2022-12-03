Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131C641794
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 16:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLCPuq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 10:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCPup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 10:50:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0EB1C6
        for <linux-pci@vger.kernel.org>; Sat,  3 Dec 2022 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670082644; x=1701618644;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mUGluJou5QBqhzfLWE2ioDNg+Bi4LVhnqszGyCp+Zf8=;
  b=maSpFiVpbnV1mDWQJ9c8cJ2TFyanLFhsYWY6qRfJ6csHQb67pjB4pP14
   Apk3r1oiv4b7HlVshjj0cQMwwsb7bu2GSXifYFHBLb1c5iQbpiNdK/abd
   cOe7BeAj4P3O9UyVjwSARHkC7P0kQHdOAR6kuzdOeWN0XlhnDghMLcVhU
   AbCBkQMnjmFNE9ZVCi3j1oajsC3UUO9Lh9MWQySPBvg7q26Q15qJ4S58D
   AfhZCXxCfBrLg8KuV6LeOViDfHVPUWepXYKhy2rWfL6uro3wdN6O1Du0Q
   34dSR7aJWqAl4JbY4Wb/VhhhFlWIx5VT5YBBCXSdn0ibMEvFwX4aL9NvX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295822426"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="295822426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 07:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787606717"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="787606717"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2022 07:50:42 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1Umo-0000Bh-0B;
        Sat, 03 Dec 2022 15:50:42 +0000
Date:   Sat, 03 Dec 2022 23:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 6a53079859302c19376234aa32deaf6f61725e4e
Message-ID: <638b7025.+1nQFVeapri4u5Qz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 6a53079859302c19376234aa32deaf6f61725e4e  x86/PCI: Fix log message typo

elapsed time: 721m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
arc                                 defconfig
x86_64                        randconfig-a013
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
m68k                             allmodconfig
ia64                             allmodconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                              defconfig
alpha                            allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                           allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
i386                                defconfig
mips                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                  randconfig-c002-20221201
x86_64                        randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-k001
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
