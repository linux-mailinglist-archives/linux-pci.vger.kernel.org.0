Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135075EC296
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiI0MYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiI0MYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 08:24:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CF1C909
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281482; x=1695817482;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=buZLfYU1MlWPXBumKc2Lc3hXCL6Ux6g/aWU5HmdKfkI=;
  b=HTtaBRjpKMaLyPTKqMf30ZBPd8AFqMofCn9gXRDt150MuoLu7Lit2OOF
   tJNTFhkGQiz9O4zLWS+EwiOf7ObEuNDXUsa/gojrikh4XiMdU87zMVYlL
   NVtSHUyWeCOcH7Rug+CHIi7e687sEFJrNtlVYBD+VReLRux8c9KRPNfKe
   cz5/Pu7GkCJJQ2kRImnAAPqkhdYuQzH0/bn8Y62+qwMUhfpqniEzfbMVg
   1ZzEo7Z0N8eAMSusN5Govr2pBOfOA8FGb7jBrGZAuc0dp8vV4Kk+oEgZG
   pml5lTQ5/9K9M0U00QV8HOfklYvOZloA7iDYIdOafONzwdfHSgc2W0WdQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288452902"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="288452902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:24:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683971117"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="683971117"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 05:24:37 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od9dc-000100-1G;
        Tue, 27 Sep 2022 12:24:36 +0000
Date:   Tue, 27 Sep 2022 20:24:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 cd25b933e49dbb1839098be8bbf08038b7e2a68d
Message-ID: <6332eb62.PuXH4aoQca5644dq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: cd25b933e49dbb1839098be8bbf08038b7e2a68d  Merge branch 'pci/misc'

elapsed time: 872m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
arm                                 defconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
powerpc                          allmodconfig
i386                 randconfig-a005-20220926
mips                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
arm                              allyesconfig
i386                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220925
arc                  randconfig-r043-20220926
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
x86_64               randconfig-a002-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
ia64                             allmodconfig
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
i386                 randconfig-a011-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
