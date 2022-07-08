Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E656B8DE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiGHLst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiGHLst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 07:48:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405FF13DC7
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657280928; x=1688816928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pK584iIsR8NIUd5zOmX8VE0Ihx9kbeOS16OO+DOlxSA=;
  b=FpLqYLcy/mpbATZmhU3t8tjsS4gQITPLJfDzMYqsDjUzfYrcInqi4Icd
   qovDuvHvi5nhaI1NdI2UyoykLGqdeTe3LSuB89AKazfjzB95KsJruVFQa
   dEgVHYU6SzP05QtERc38TCcjYTojPXZM/4modG464bLOfK2UraOmwiSRg
   dubNJKgx8xGJ9+z7AJl2vFegK6ZC33RJsrKIgU3fBf+vjMZT8q8vsokbt
   crM0KsLK2FMzlZj0DFSwmIgcCbZ/C4yvnzGPoCr8Pmg173pqiD+r63Vdp
   kT4c1Y1Ov8ju/bV/pnj/FhQM/pViS9/jB5X6843977s+nPK3V1PvqpncP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264675969"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264675969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="621188378"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2022 04:48:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9mTV-000NQI-Ls;
        Fri, 08 Jul 2022 11:48:45 +0000
Date:   Fri, 08 Jul 2022 19:48:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom-pending] BUILD SUCCESS
 44d07e984b93f4fd139745d3d84e2ae04a53ed72
Message-ID: <62c8198e.Rcp8McFl1LxXXS/M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom-pending
branch HEAD: 44d07e984b93f4fd139745d3d84e2ae04a53ed72  PCI: qcom: Add IPQ60xx support

elapsed time: 895m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      mgcoge_defconfig
sh                             shx3_defconfig
mips                           xway_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
mips                         tb0226_defconfig
arm                        mvebu_v7_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
sh                      rts7751r2d1_defconfig
sh                     magicpanelr2_defconfig
arc                            hsdk_defconfig
xtensa                    xip_kc705_defconfig
arm                            qcom_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
riscv                randconfig-r042-20220707
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
