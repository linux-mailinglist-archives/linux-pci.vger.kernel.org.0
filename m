Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6795608CB4
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJVLd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Oct 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJVLdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2022 07:33:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B9635CA
        for <linux-pci@vger.kernel.org>; Sat, 22 Oct 2022 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666437218; x=1697973218;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JHIzt8ymeztBZThL/F24h91M0JFo/zsfSPfHDo93AMI=;
  b=I4U3mLkZBHAt2/AbCaRru/XPoO69dygt3o9GjcHQa8o8Md0j0sECnCVx
   AOhJeKVpkU/BRkIAAA0JKXqwKo6mLMfpFUbkF9ERLZOCOi1q/1JWk89p1
   p0G7jBmgVcoGaSMJ1u2xVuREgXjCYBN4WlHRXJHzHrylScstFSNGg8p49
   /dzAGQ/fY0dx4S1D7aZWQk8JmY/Jz6WW0c1Kwei09vX2L7sUzOdLWDsR1
   JFuBrpBFh9hEbRRw25ffdPNUQe43FsZmLD011vBuVfbszGrr5CvPn6ovG
   BQwn9IbdlLbxenY3NoBPTkRRqLYYFrHLByf2iFNAHwc7UpaLxlEROyn9s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369243197"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="369243197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 04:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773343581"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="773343581"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2022 04:13:36 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omCRb-0003ag-3D;
        Sat, 22 Oct 2022 11:13:35 +0000
Date:   Sat, 22 Oct 2022 19:12:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:wip/bjorn-22-10-config-of] BUILD SUCCESS
 f9864e8f2ce05244bc0e15e6593972f07dfcea8c
Message-ID: <6353d026.Ieh/yVjHE3mUxBIS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-22-10-config-of
branch HEAD: f9864e8f2ce05244bc0e15e6593972f07dfcea8c  PCI: Drop controller CONFIG_OF dependencies

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                                defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
s390                             allmodconfig
arc                              allyesconfig
arc                  randconfig-r043-20221022
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a001
arm                                 defconfig
riscv                randconfig-r042-20221022
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
arm64                            allyesconfig
mips                             allyesconfig
i386                          randconfig-a003
s390                 randconfig-r044-20221022
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a013
sh                               allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                          randconfig-a014
arc                  randconfig-r043-20221019
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221022
hexagon              randconfig-r045-20221022
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
