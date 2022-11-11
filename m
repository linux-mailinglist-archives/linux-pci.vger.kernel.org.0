Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CC625901
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKKLCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiKKLCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 06:02:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A665B589
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 03:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668164528; x=1699700528;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KhoHGNx2rCq9Bq6QscjQ0GP8Eyxalls9rPudg+TnWwM=;
  b=b0xd+4C0esevCmstKjE3+BSOFjE1bxCSLKiXZb4p7OXTSdKuuxO0JtMj
   hxl8cWGH08Ry1MTI+FCet0hX+g0YtDnhKo7tBjo29QfZ1JSxZKYePHJQr
   1qy38CLDi8INVit/4kP29MMx1bcFed7h2aup+khtQscO/50orCrYBJQ4y
   lso335k+/vz1cKtOk9Uj0Y95D4Ks26tIlfvj+7TDAxx96nbjhiYNvb31i
   2dFyMMpKM3b7WNNvVzkQPxF0a4lLSLqCb3c95ckuC2lM9sIJiUXehHMCI
   L+qf9yevgNLaKhFTMjttVTNGAsRQshYgt1Eew8HeggGkGM6lQmYfL1ruR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313365238"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="313365238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706510550"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="706510550"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2022 03:02:04 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otRnQ-0003sr-0v;
        Fri, 11 Nov 2022 11:02:04 +0000
Date:   Fri, 11 Nov 2022 19:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 90a36dd86b60063faf5a8b48e015b38f30f9b6e5
Message-ID: <636e2ba4.q7pTB1tH4/ZaigSn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 90a36dd86b60063faf5a8b48e015b38f30f9b6e5  Merge branch 'remotes/lorenzo/pci/misc'

elapsed time: 830m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a001
ia64                             allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                              defconfig
i386                                defconfig
arc                  randconfig-r043-20221110
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                             allyesconfig
m68k                             allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a014
riscv                randconfig-r042-20221110
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20221110
i386                          randconfig-a015
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
s390                 randconfig-r044-20221110
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
