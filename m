Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60F612097
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 07:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ2FlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ2FlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 01:41:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326D88DC2
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2022 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667022069; x=1698558069;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QdiL21udHgy47F1BlWIK2C4V46NPHyuHd42DgxztGt4=;
  b=l1dXag+GPp0qoJgA/n/n5Lj0TULzJZlObEpHnnyJLnjXTh5pfJGw6bKB
   XR004CUM9PSRKFri+YENzSisMBLO6h/bQnxYBafOWY7dJXxliH+6nSsz7
   6+75wgjU0C6Biqj4IInKEBATyM49eWm/Me0868c6Akxl5nKI3y9Ar0Keq
   kYhCpA4n96kKmSYc/uk42F2vZy1QW6yrron8ySOzm/8MMAoMKz1/yHzkL
   UFImVQDoWkaO11F+WtKesMHRqGTw+d/PnL/iMljjfkajIUt4LF4VcsU6Y
   2kfvYk+Pe5DZVj2+DBnVpd5Wu1xuKSRxemUgEPVaSTSkfeGGraCjV+Yyp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="289033901"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="289033901"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 22:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="666308295"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="666308295"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Oct 2022 22:41:07 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooeah-000AfC-0K;
        Sat, 29 Oct 2022 05:41:07 +0000
Date:   Sat, 29 Oct 2022 13:40:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 39a654f39efb035b961359db91f15a347e8d7fd8
Message-ID: <635cbcbe.rK2Y22ERm9q+fwc8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 39a654f39efb035b961359db91f15a347e8d7fd8  MAINTAINERS: Add Manivannan Sadhasivam as Qcom PCIe RC maintainer

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
um                             i386_defconfig
x86_64                              defconfig
i386                                defconfig
arc                  randconfig-r043-20221029
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
i386                          randconfig-a001
x86_64                           allyesconfig
i386                          randconfig-a003
arc                              allyesconfig
s390                             allmodconfig
i386                          randconfig-a005
alpha                            allyesconfig
arm                                 defconfig
m68k                             allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a015
i386                          randconfig-a014
arm64                            allyesconfig
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221029
hexagon              randconfig-r045-20221029
riscv                randconfig-r042-20221029
s390                 randconfig-r044-20221029
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
