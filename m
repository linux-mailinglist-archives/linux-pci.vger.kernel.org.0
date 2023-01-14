Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2C66AB32
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jan 2023 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjANLey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 06:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjANLex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 06:34:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B2468F
        for <linux-pci@vger.kernel.org>; Sat, 14 Jan 2023 03:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673696092; x=1705232092;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BcUOi3oLaHCGauhJdOc+1KADIxQRc+5RTmFmC3WMVC0=;
  b=KPTfrxu+e5L0XgD70adLp7a+vD1kpsOLn4MeL5njomfu3PQhAAYMXtyH
   1OLnnqhCzW6T9Zt+vyVgtXmm74+BMCZdhoO98wVenoQScIN3xPkXryy4D
   /gau9FqyyaYddSVipju4Ns7Hp+Kmn0lr1S7zu/bid4oC0MkZ1dZNPVJYL
   tBQ/7gGDZPscNHTCDops7C1BhQCsMgoDlIZ2onLt+nuFBb2uPeWfv6+Wq
   tmzzkqxJDqTK2qp9cxDoOY3+JFBvkK9KTWXE6+bmWW59pYqwcajMq7BgF
   cOhLUazj0ygAJJsN6ZbS56Ifu32O9ZMDp8NxMG5yPDW0Z0ZL3uKNjCbh+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386526163"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="386526163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 03:34:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608426967"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="608426967"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2023 03:34:50 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGeoD-000C3a-2U;
        Sat, 14 Jan 2023 11:34:49 +0000
Date:   Sat, 14 Jan 2023 19:34:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 25cfdd48a4bd9df46f5b3af92b2d21756b76d3e2
Message-ID: <63c29348.jDpT7BqrAHSoTNAV%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 25cfdd48a4bd9df46f5b3af92b2d21756b76d3e2  Merge branch 'remotes/lorenzo/pci/switchtec'

elapsed time: 720m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
i386                          randconfig-a001
s390                                defconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
arc                              allyesconfig
x86_64                           rhel-8.3-bpf
alpha                            allyesconfig
i386                          randconfig-a014
s390                             allyesconfig
arm                  randconfig-r046-20230113
ia64                             allmodconfig
arc                  randconfig-r043-20230112
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
arc                  randconfig-r043-20230113
s390                 randconfig-r044-20230112
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                randconfig-r042-20230112
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                                defconfig
arm                                 defconfig
arm                              allyesconfig
m68k                       m5249evb_defconfig
mips                  decstation_64_defconfig
arc                      axs103_smp_defconfig
mips                       bmips_be_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
arm64                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                             allyesconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                      footbridge_defconfig
sh                            shmin_defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
arm                         cm_x300_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-c001
arm                           corgi_defconfig
mips                        vocore2_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a013
hexagon              randconfig-r041-20230113
x86_64                        randconfig-a005
arm                  randconfig-r046-20230112
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230113
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a012
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
