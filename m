Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F279621001
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 13:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiKHMMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 07:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKHMMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 07:12:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850FE02
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 04:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667909571; x=1699445571;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xqc/yjBwOQfxrRUkEluJe1lkk+LHksPgYfwZg0ctVP8=;
  b=M4hS5006uqToNmE0hn2GT0zhlrK5NdwgEYUwuUVkmB5oJnyhSab98uvF
   TvvBL1Li/rXg+JsQITo3hCaoB+r5ozKPrCbSIdzGToMz3qm9yaS/LG0Az
   l1XRJz+8fZIyUuVkz4WyD66uIdEorX3euQOyMUynIDGjLV8mRjgqujbBF
   cujM4mXDErJCCkV7/LkLK4Mt2hP8IGLLWHJK3OcyL8rH94kkzaaRqawLM
   dyHnkEKkh4gAThG5lZnrQ6/31F0HvF6TaqEFwfkWEIdEsIxp7B0HSs9o6
   QCsgX8ASfmtiHhlH+jS9p/j6mHita+EHjIvEssDSpuDi5fQB4EwlPUwiE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312469322"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="312469322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667567147"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="667567147"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2022 04:12:50 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osNTF-0000KG-1B;
        Tue, 08 Nov 2022 12:12:49 +0000
Date:   Tue, 08 Nov 2022 20:12:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 3702266d504e1336cc4446326881ee437eaf83dd
Message-ID: <636a47ad.UocsB2qjv/cFWvK2%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 3702266d504e1336cc4446326881ee437eaf83dd  PCI: Assign PCI domain IDs by ida_alloc()

Warning ids grouped by kconfigs:

clang_recent_errors
`-- riscv-randconfig-r042-20221107
    `-- drivers-pci-probe.c:warning:variable-err-is-used-uninitialized-whenever-if-condition-is-true

elapsed time: 720m

configs tested: 40
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
arc                                 defconfig
arc                  randconfig-r043-20221107
alpha                               defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
s390                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a016-20221107
s390                 randconfig-r044-20221107
riscv                randconfig-r042-20221107
hexagon              randconfig-r045-20221107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
