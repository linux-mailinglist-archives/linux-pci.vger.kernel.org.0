Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CDC5B45B5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIJJcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIJJcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 05:32:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163327A525
        for <linux-pci@vger.kernel.org>; Sat, 10 Sep 2022 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662802373; x=1694338373;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gpsogxegXXorIhRFpyOSt6sZ9FXlwZIRNkqA1d/oh78=;
  b=HqbSPDiNhPEtnO0iRz/W5M9BF6HmmC6WFI+89iNJ6+gfrDPq+yxPltlD
   XAp9Yr6F3ZO2vJ02GLI9CX/kF3I87Wwrx+euMrQOu6u0GWr26g6z8Um+4
   F0yuBsxzzdBb/kwMzGPlKL1xGMbR3/oy+Z8NUlam1+U2Nuz7jB26UHxD3
   CE5vdOt3ybIFl4LXRvY6HU7kyxw9yTMyVrrhX6rzzK26usD9gX7019fQm
   pkWiOd7F5scCgiLnAuY4jRumNZiTwOF/AF2Ng4vUuJ3keWbVHI/lATj0w
   80xGLbZzsUJCkKf68i/sT2zjPDR4rr9QBbtWy9iDvoMlxGxbnI1jmJ557
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298427672"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298427672"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 02:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="566632112"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2022 02:32:51 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWwr4-0002Ma-1E;
        Sat, 10 Sep 2022 09:32:50 +0000
Date:   Sat, 10 Sep 2022 17:32:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:wip/bjorn-pm-v4] BUILD SUCCESS
 1495e5bcd9f11e1ff8f07994e0a4458e3f17c81b
Message-ID: <631c59a1.kYt4gaTT5y+sW7J8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-pm-v4
branch HEAD: 1495e5bcd9f11e1ff8f07994e0a4458e3f17c81b  PCI/PM: Always disable PTM for all devices during suspend

elapsed time: 722m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220907
m68k                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
i386                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
