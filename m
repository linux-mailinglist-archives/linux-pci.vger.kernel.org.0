Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0566196AF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDM6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDM6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 08:58:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196BFF
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667566700; x=1699102700;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fGymz2eImI9yriT1o2PbdLz0lkYDWGVJ6CYgtrjSUMY=;
  b=c9tTxoLgA0rt3y0QTeGMlkRB/lQWosJI9tCwrN4rSfIPrMExZNqOqUNe
   1+fIEA+Vf2xZce+IiN1GtQ0hrfNxpDqR+wo86HY2uXaF16Wb6qigOCZTL
   A8twbeSNb5B132bIK6vKJxHBGAbhP1ejODRtjwRdoIdnwgqhEyYFqPFBe
   Dc5vqZjO/DaeWwG2v8U2xz4BaIqWv26VVePMLtyAygA5NJkEzm/KsVvEX
   qZbnc5oAse/qrjmWbmGys1dnsvyl2GEjHZyxy2tBT9Aiss6vVpOUvIt5o
   V+XYS2v9N2rXkFIv5adVmK5JMYkM838W83gxRf1OBI3iu2lj5FfR1gb9n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293285816"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="293285816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="586177522"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="586177522"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2022 05:58:19 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqwH4-000GzJ-1h;
        Fri, 04 Nov 2022 12:58:18 +0000
Date:   Fri, 04 Nov 2022 20:57:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 a009d44bb8129bbad6de73bdaceef6e63f7eca4f
Message-ID: <63650c2f.YyjRNHidQhrqx+Rg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: a009d44bb8129bbad6de73bdaceef6e63f7eca4f  PCI: Access Link 2 registers only for devices with Links

elapsed time: 722m

configs tested: 89
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
s390                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allyesconfig
arm                                 defconfig
riscv                randconfig-r042-20221104
s390                 randconfig-r044-20221104
arc                  randconfig-r043-20221104
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
powerpc                     taishan_defconfig
xtensa                  cadence_csp_defconfig
m68k                        m5307c3_defconfig
xtensa                         virt_defconfig
m68k                           sun3_defconfig
arm                        keystone_defconfig
arm                        spear6xx_defconfig
m68k                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-c001
powerpc              randconfig-c003-20221104
s390                       zfcpdump_defconfig
powerpc                    amigaone_defconfig
sh                            titan_defconfig
m68k                          amiga_defconfig
mips                           gcw0_defconfig
arm                          pxa910_defconfig
m68k                        m5407c3_defconfig
arm                           u8500_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
sh                           se7619_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_virt_defconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a011
hexagon              randconfig-r041-20221102
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                       rbtx49xx_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
