Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D822644F8F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 00:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLFXZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 18:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLFXZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 18:25:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D78429BE
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 15:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670369124; x=1701905124;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7OHxDjzKXb44wgC61OeNXzrMrTNh1lhMBez3+6GGzps=;
  b=QHjHCT/Ip+vNmHGGdnqiuRuzEms1RyC9M2WjTWmAC6tuC01RXV6bz11u
   uORt6OS/43QWwOfVdE6AZ2XC/I7Gy/zhUsTLWiZD2KpeWzP9MeI4ovNzf
   wdH0Rpo4L7tVpZFXxz/efOP9KgPdlg8pqschx0VQE7pdzs56A2FPrzxon
   84saFMx3JpvHuBVfe+jNuVMzF6dd/WeKYUIVM+d5DFNJjHRDC/7ScioTo
   c7yda/9BS8YvwOxrpPyH6Quxq0twZBT4UkemffCZpA+5q8Ov44X//qzxf
   j7rmyG467fxDuJOZ5zSo/qwLGGSX6pswYSPu0/8CQvgFajFnEVwCSuUMB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403029753"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="403029753"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 15:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648509816"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="648509816"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2022 15:25:23 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2hJS-0001KV-2b;
        Tue, 06 Dec 2022 23:25:22 +0000
Date:   Wed, 07 Dec 2022 07:24:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/vmd] BUILD SUCCESS
 0a584655ef89541dae4d48d2c523b1480ae80284
Message-ID: <638fcf30.0jQ49pWO3UKP55tB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/vmd
branch HEAD: 0a584655ef89541dae4d48d2c523b1480ae80284  PCI: vmd: Fix secondary bus reset for Intel bridges

elapsed time: 728m

configs tested: 61
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arc                                 defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                              defconfig
alpha                               defconfig
s390                                defconfig
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                        randconfig-a006
arm                  randconfig-r046-20221206
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20221206
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
x86_64                          rhel-8.3-rust
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r041-20221206
x86_64                        randconfig-a005
x86_64                        randconfig-a001
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
x86_64                        randconfig-a003
i386                          randconfig-a011
hexagon              randconfig-r045-20221206
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
