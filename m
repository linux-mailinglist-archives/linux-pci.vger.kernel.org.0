Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B795F3938
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 00:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJCWjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJCWjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 18:39:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399F57204
        for <linux-pci@vger.kernel.org>; Mon,  3 Oct 2022 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664836746; x=1696372746;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bKenzmA+HHU2WLHTUr0lLtOSrtw3pH27EakXOQlxCH0=;
  b=ZVlCJn7Mq71x4SuZ7huUu4uGQW8YlG5Ja3uUxSN9qTH0rsnwwePmj2jF
   WS6f/Ub/3tM6m+AeH2vmUGVkdXdzqwXCsJGMubgK8CW+kDdKpuLYxatA0
   non8rdJ3e9YJ2hPWNBw/efmqfQG4owtsdvxREnCR1atM8imOb+56tWc+T
   IZGw1kuMPlKDm+06ySBfcjXlnvBUAW++DS8WFL/ChbWrNjOdc83J3ex5D
   nawhbnO5R/blxrMu2iGwdp9w6j+qvQ8r4m+Ff0SHozrk1SOs4Io2eJstZ
   REVAMHYtr6P9DVJSJq+Ax1LB2N52SFao4NR0tYhN/3vrpXXX5AvrCcttN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302754564"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302754564"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="727979566"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="727979566"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2022 15:39:04 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofU5Y-00050V-0l;
        Mon, 03 Oct 2022 22:39:04 +0000
Date:   Tue, 04 Oct 2022 06:38:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 e5107be15bef6bdab51be3fc8e70713db6d1ae29
Message-ID: <633b644e./cM9yPLBnoJ4t+5u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: e5107be15bef6bdab51be3fc8e70713db6d1ae29  PCI: qcom-ep: Add support for SM8450 SoC

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
sh                               allmodconfig
alpha                               defconfig
powerpc                          allmodconfig
x86_64                              defconfig
mips                             allyesconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
i386                 randconfig-a014-20221003
s390                 randconfig-r044-20221003
i386                 randconfig-a011-20221003
s390                             allyesconfig
i386                 randconfig-a012-20221003
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a013-20221003
alpha                            allyesconfig
i386                 randconfig-a015-20221003
i386                                defconfig
arc                              allyesconfig
i386                 randconfig-a016-20221003
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
i386                             allyesconfig
x86_64               randconfig-a016-20221003
x86_64               randconfig-a015-20221003
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221003
hexagon              randconfig-r045-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
x86_64               randconfig-a003-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
x86_64               randconfig-a002-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
