Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3C57D7D1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiGVAiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 20:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 20:38:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1995C13
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658450287; x=1689986287;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BgAuoR9mjwQFhPyjK3j4ilr8CnRuNhgrT3ArRb6xpHs=;
  b=AQ2v3IQT1g3qN+pA6e91NwABLdLpo008ankMd8Et59A5IMmeakDua9MI
   a5t7iD+bLnmuvYGLN3e7oyBFuMlb3yl4lj+lVpgC7GA+nzc0s508d5Avd
   R6rjqa/9O9HtwowqPzgyGktpuF+0gcHoSFBWOXfqPFXyAOU+Z9eaN40aL
   3KUBylxbp8iKlIEhOXIE2Blkmcwksa2a+LzaCj3PlpfIl+IVehCGBBgqx
   FK/yD2iRUbFY0WHR1LG8rV35K/8o4ZnOfZ3+XbZXdBpcEMvSVJj2bNwBt
   uPJbEy3mIcXXS8ynw79moRlUxXnEZkSVkGxzna09NHrYMtuG66jp/sM9A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267603683"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267603683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631385294"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2022 17:38:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEgg9-0000mu-1X;
        Fri, 22 Jul 2022 00:38:05 +0000
Date:   Fri, 22 Jul 2022 08:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/imx6] BUILD SUCCESS
 2e76e6144b74c699dcb32baec9072fd35626e0aa
Message-ID: <62d9f151.CcpB+3r3v6GOYZrl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/imx6
branch HEAD: 2e76e6144b74c699dcb32baec9072fd35626e0aa  PCI: imx6: Support more than Gen2 speed link mode

elapsed time: 1617m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a016-20220718
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64               randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
riscv                randconfig-r042-20220718
s390                 randconfig-r044-20220718
arc                  randconfig-r043-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a004
i386                 randconfig-a003-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a006-20220718
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
s390                 randconfig-r044-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
