Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9C502C87
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355008AbiDOPYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354985AbiDOPX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 11:23:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81225EDCA
        for <linux-pci@vger.kernel.org>; Fri, 15 Apr 2022 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650036075; x=1681572075;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oihyZRTh+6Bn/iu/zUgvjjXhE0BbqQaVdInjATi9jTw=;
  b=CN/Ovb2nynjgRMtUqcQL3fs1LNOBk83FsY9k4KbpzCs2RYk+rl+hkKxV
   USL6aAv6Pzsequ1MI15kehG+wsnz1decjJ4wUKgmXH++BB/JXD68JphSP
   IR4cPkwzG25TL/rc67cCEBqcnEKlnq8NMY9JR3q3sbGg9MZlqjxi4xuLN
   r61+UU/RiqbNuxWlzMYP3++tqKYmwcDX0fUA3UCtlv2L/0LtMnidcwRpt
   ezcu4YsKVwnSNzMVYpltxAB/VKw7g9Omc24VlN0tjQ/FfQ4KzybohQsIz
   QzBFKX3S1wRb8nMIGgHk2vTEiQNlRL+Cw1Tr49hMF8sSJW5GbGzre82q6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263345167"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="263345167"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 08:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="527426004"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2022 08:21:13 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfNl2-00025G-O7;
        Fri, 15 Apr 2022 15:21:12 +0000
Date:   Fri, 15 Apr 2022 23:20:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 89905ffa454593cf61ad907980146d42bd79c772
Message-ID: <62598d32.tP8EYd4yIShHmWcS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 89905ffa454593cf61ad907980146d42bd79c772  Merge branch 'remotes/lorenzo/pci/rockchip'

elapsed time: 721m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220414
sh                   secureedge5410_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
arc                          axs103_defconfig
m68k                        stmark2_defconfig
powerpc64                           defconfig
powerpc                      bamboo_defconfig
microblaze                          defconfig
sparc                            allyesconfig
mips                     loongson1b_defconfig
arm                          pxa910_defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
sh                           se7724_defconfig
arm                           imxrt_defconfig
arm                            mps2_defconfig
mips                     decstation_defconfig
s390                          debug_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220415
s390                 randconfig-r044-20220415
riscv                randconfig-r042-20220415
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
riscv                randconfig-c006-20220414
x86_64                           allyesconfig
mips                           ip28_defconfig
powerpc                     kmeter1_defconfig
powerpc                      acadia_defconfig
arm                       mainstone_defconfig
mips                       rbtx49xx_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220415
hexagon              randconfig-r041-20220415

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
