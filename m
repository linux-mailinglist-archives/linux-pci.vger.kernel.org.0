Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDD610868
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiJ1CsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiJ1CsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 22:48:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D3A2316
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666925283; x=1698461283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RpdnJXCDqbpmEIOQq1qwX6VVi9ixkXtiNAfrikeU30I=;
  b=jQIajy+3UfYJj9lOasCT0JDYXwSB21wUkeRIhYtqULn/HLEWPSh9quGy
   86XLjuggO96y9ZkaPw1dov+Oqy4KXohRLYLZt4f5BBa9Wctnj1FdhzVBx
   q+o0YhhT/cXGSbD+qjScqko02BUY4QUZVOoI6Gih+xnQa8KtpRVyAUCQQ
   UUkRrZJlA1Lct3TOfkPmMlB99WZmAUpZq5P9PBqgLXjcwbCyncxUEin/A
   CH6a9E4I9msF+TWP4Y8lyhI/CzPq/OMXQ+083Dooz8hdxZiw/hu/dNUaX
   Ckt02uf6zIB/3WbYZ4Bc2MscaDNyWIfR1CDqLo6QkDTRX0rjkuwZkhh1W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288790398"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288790398"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 19:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="721897890"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="721897890"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2022 19:48:00 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooFPc-0009Ox-15;
        Fri, 28 Oct 2022 02:48:00 +0000
Date:   Fri, 28 Oct 2022 10:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/tegra] BUILD SUCCESS
 16e3f40779659ff525364e5d9df369953fa7192b
Message-ID: <635b42d6.BFL3XPWbresVAUGn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/tegra
branch HEAD: 16e3f40779659ff525364e5d9df369953fa7192b  PCI: tegra: Switch to using devm_fwnode_gpiod_get

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
riscv                randconfig-r042-20221026
m68k                             allmodconfig
i386                                defconfig
arc                  randconfig-r043-20221026
s390                                defconfig
s390                 randconfig-r044-20221026
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
