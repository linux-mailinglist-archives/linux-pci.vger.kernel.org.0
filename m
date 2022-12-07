Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06114645E58
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGQHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 11:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLGQHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 11:07:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898C4D5F8
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670429221; x=1701965221;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7R/sid2ayhFGpN8xA6gb2+Ias4XxtdYEBXHj5aGDNJs=;
  b=YFksaesZkpJxG4KsjtSNZzf6tC6Eo1axzr2qd0VepJvOoP09FYcU2WYi
   r2rQFFZmFheTyKpo0P+ILABst5b7SQTNX7DUbhIvXZyhvPatUjoFGQ+WF
   TuRTZ4+RUSfqXjHLg6B7QLCSff1NMwh0FsVvq/x5305GHPR3fBWjXpSOk
   VrdHLSuu0NL/s0FQaLcQyvRoW2OgfRvqs4pVDrDhZIwoOT3G/gZ39flbH
   TY+SZurqwO4f2K7KHjnn+DFVQm41NHdQkHOsFF5uGuMts6p/p/zmIV9Me
   gftOcqOxjaXgTtmSKLnLqmP6FeiLQkbwr6DGMQrEM1bMghtvqT+XvVWC1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="300346062"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="300346062"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="771149287"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="771149287"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2022 08:03:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2wt4-0000Nl-0M;
        Wed, 07 Dec 2022 16:03:10 +0000
Date:   Thu, 08 Dec 2022 00:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 6c48808dabd60778df4cef6dc6425b36c3a36138
Message-ID: <6390b913.RoHWNWc3De6/NPVO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 6c48808dabd60778df4cef6dc6425b36c3a36138  Merge branch 'pci/kbuild'

elapsed time: 722m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
s390                                defconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64                        randconfig-a002
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
x86_64                              defconfig
i386                          randconfig-a003
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                  randconfig-r046-20221206
ia64                             allmodconfig
arc                  randconfig-r043-20221206
i386                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
