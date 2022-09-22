Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22C5E5D84
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIVIbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIVIap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 04:30:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43DCBAC0
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2022 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663835415; x=1695371415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2JWMeeJNGRyw4nVNqR4jnKEwqWXEr9kIdUY3mWCli3U=;
  b=COZFPM8/lsHPDJOe/i7veyIwsJ+SkwhIEfaCelPiUecBmaE42p3Km11I
   En/lU+Ok2In756KYCJe6lEd2g4vpIdgXu/mjidzHMGGYphIezL5/MxUEe
   tYVIbTzPMTgTP96o7zqNsssvYQqTsFf5r+54Ifh+BRr7aERtP2/Ezhale
   +fYxlCNRCDJX+gGcDKbzhKAx1iNn395pr+G+hgdxq+rTU8ZsrnDhgFvCu
   Tr8NkFkDU7Amfq/c6NpfUydgiz69Y5teuiG8H9JUypie69wGt+9A0upVl
   SslRN5NWGihd5FhSGZjweKnKBIm/GXszhLBmtoYLMxnxFBHTQ+zcxkjau
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="362004684"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="362004684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570878001"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 01:30:13 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obHb2-0004Ue-2p;
        Thu, 22 Sep 2022 08:30:12 +0000
Date:   Thu, 22 Sep 2022 16:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 58e011609c4305fc50674c4610cbe8a8c26261f6
Message-ID: <632c1d01.gUTiL/kZkmwGHjFZ%lkp@intel.com>
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
branch HEAD: 58e011609c4305fc50674c4610cbe8a8c26261f6  PCI: Fix typo in pci_scan_child_bus_extend()

elapsed time: 724m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                 randconfig-r044-20220921
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                     stx_gp3_defconfig
arm                          exynos_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5208evb_defconfig
arm                        multi_v7_defconfig
powerpc                      makalu_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
i386                          randconfig-c001
powerpc                    adder875_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
x86_64                        randconfig-c001
arm                  randconfig-c002-20220922
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
