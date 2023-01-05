Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DBE65E7D4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAEJao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 04:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjAEJan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 04:30:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391F50E56
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 01:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672911042; x=1704447042;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hH28VauCHYRXgyG+PZq3j/qXd3gj9Ta1yfu3z/rcg/s=;
  b=oIHqu4eMUjZG2HW2FoHknkrrB9XkPFD0JpFtlroMB48bJXXt6VGhx8SD
   hmXwxlqOnBwWeKlsmHvkLndQmCXXJYzybd92wDO8iazONsHRLFVa+z1U4
   aaBoK4BQXfv3sXq1vziC2vVqGqbq1ea0rDAEpTgwjR9wef9cecNiscvwh
   qxinFX+6qZJQ7XhyJ8SRBVdzwdbeD92dH84fyT9kXiPP40KxrhhTmA276
   mHyGMGX2uih0EMTxs5Nnw7lTz4iBnex3RXdVpKx4DyvbGVGeohDK3rQ1r
   1MgiVYUTsx0X+6gUN2AHUrFXkiMLOXcWSbn2jp10jILZhWWDRq3dM1Arh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="302532741"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="302532741"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 01:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984237886"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="984237886"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2023 01:30:41 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDMa8-0001Rx-1g;
        Thu, 05 Jan 2023 09:30:40 +0000
Date:   Thu, 05 Jan 2023 17:30:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 b3fa1166679a805cd28a664734342ce26ca9c7ff
Message-ID: <63b698bd.VSPEnAAdoQH4Awkz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: b3fa1166679a805cd28a664734342ce26ca9c7ff  PCI: Distribute available resources for root buses too

elapsed time: 726m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a006-20230102
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64               randconfig-a005-20230102
i386                                defconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                                 defconfig
i386                          randconfig-a005
i386                             allyesconfig
arc                  randconfig-r043-20230105
s390                 randconfig-r044-20230105
i386                          randconfig-a014
i386                          randconfig-a012
riscv                randconfig-r042-20230105
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
