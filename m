Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B58569C73
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiGGIEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiGGIEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:04:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A331373
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657181075; x=1688717075;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X+/O4qp3XkA3/dfVoVSa+DYcBk0DGyas2PAIwZnzO0Y=;
  b=lgwQcTucu+uXKswbk3D1VZWfg8NV/xtSiIAyyv6A8LyuSJQa47Zq1M2v
   scofJCx/yHXuFe4OhFzzh8qHRE8BQveInspYYfFx+oH0m0YfpydMtQXaw
   JwVyTlOuTB8vwrIg/S+dVcWUhcrywtkab5MHuS6FxxBgnj1sNJk8TPrGk
   PzwqfF5eyV56xy+rnuFxxdyYkxgXZ42lkQYCpHCDx7vZ9UI6BTZlJqwL1
   GlwAy73F4a+QjPkzpmHUfGuVqNKasNdspXdLNL+ouQqPifWbV3mCoBepf
   cOrMHtozaKotl2nwrwYi5fv7NzmoLqmVYM5apJu1N6Y1UKYKX+fAh8jaU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282713639"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="282713639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 01:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="661291463"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2022 01:04:32 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9MUx-000Ljo-97;
        Thu, 07 Jul 2022 08:04:31 +0000
Date:   Thu, 07 Jul 2022 16:03:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 62171cf15eb8209e0d07ea8b32566f396c4816de
Message-ID: <62c6935e.eu9dsNnC/ION+mQ9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 62171cf15eb8209e0d07ea8b32566f396c4816de  Merge branch 'pci/ctrl/vmd'

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                       m5249evb_defconfig
sh                           sh2007_defconfig
sh                         ecovec24_defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220706
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220706
hexagon              randconfig-r045-20220706
riscv                randconfig-r042-20220706
s390                 randconfig-r044-20220706

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
