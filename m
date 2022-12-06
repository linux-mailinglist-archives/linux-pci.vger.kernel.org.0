Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843D8644F90
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 00:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiLFXZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 18:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLFXZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 18:25:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299E42F40
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670369125; x=1701905125;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8Iak1bWLAlNP7j5Eg6YwmfvZIsk+1TZZOxKs7KQ1+Rk=;
  b=KaREjzSOLB5u6LEMeTdCq3RnQ7iglMEDqgXdoQ0DHnBsbFu271WLmnkU
   rpsPUXgTY7dSKIgw8CBsFkpvDiKa0Da67qMJZ89QeBL1geZp2KiIqTwHi
   C2H5rOE7TYAhMbogQ4k4ZZwKzcaya0CLwXDD+eZUK8L5zn7boWwyxfG6z
   gvgvDBZMWCl7AxHD8rNhazY1pJ7/Xlx+6YZmEq1uJoFs8FGH/Bwz0qHwn
   kTWtKg4yMEClxtNMFKzBwND+ELytRjxn0hUM020TFLuEoxMGBVCGnSjp3
   bN91tt7frQXa3DqzhoED3eyXVKtdKYYS2hVvL8IcTthpQ+WLrE9bYfDlP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403029756"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="403029756"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 15:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="752839224"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="752839224"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2022 15:25:23 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2hJS-0001KT-2U;
        Tue, 06 Dec 2022 23:25:22 +0000
Date:   Wed, 07 Dec 2022 07:24:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/mt7621] BUILD SUCCESS
 19098934f910b4d47cb30251dd39ffa57bef9523
Message-ID: <638fcf33./CmVeq7HwhGvGKSF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/mt7621
branch HEAD: 19098934f910b4d47cb30251dd39ffa57bef9523  PCI: mt7621: Add sentinel to quirks table

elapsed time: 728m

configs tested: 62
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                              defconfig
i386                                defconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
m68k                             allyesconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a014-20221205
i386                          randconfig-a001
x86_64                        randconfig-a004
arm                                 defconfig
i386                          randconfig-a003
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                             allyesconfig
x86_64                            allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-rust
s390                                defconfig
s390                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
i386                          randconfig-a004
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
