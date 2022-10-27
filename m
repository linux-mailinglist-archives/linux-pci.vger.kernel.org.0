Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50360EF6F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 07:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJ0FTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJ0FTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 01:19:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40986371
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666847978; x=1698383978;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7iRfCIuczcVunxRdgW5QwZHNuKAZ47GAv0AOMFsaw6Q=;
  b=ZTsALMKAqrcPuOZWoMfCLExnMWi5NlCiaRdwWNGzmgNzmxRY1Q2ryHuU
   VBIFrajhphZeZXr2PoPliJj5n/NF4ki9WMoL8AqpQ/5qoxSTsncq7/y+p
   oQPwgeIGN6DhTKwEC1Z7/VRiRoXPkWSh1SX3FYQCJljxiAOzcN4QMNvWl
   GRm8Io0UL1x5JibNdWGT75O3kCFM2y9FoNO9BMNrzU4h0Q01Vry7jgTDX
   v7CaaQ+OZZhYEA1T20jURAcUToeUov6wYLF0iamefA2ju1Np7SXYq4122
   Twc5ih/aaJ5BaKa82HO9CQ+OMTUzKn45Ry3D6oI7DNp4U0Phmauk4Gyzz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="370199385"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="370199385"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="721531303"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="721531303"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2022 22:19:37 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onvIm-0008JJ-2K;
        Thu, 27 Oct 2022 05:19:36 +0000
Date:   Thu, 27 Oct 2022 13:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/pm-agp] BUILD SUCCESS
 73fcd4520edb430684246448d096f8f17f107c97
Message-ID: <635a14cf.+ZUmQzJJtxvR5XlL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm-agp
branch HEAD: 73fcd4520edb430684246448d096f8f17f107c97  agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()

elapsed time: 723m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
s390                                defconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221026
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a002
arc                  randconfig-r043-20221026
i386                          randconfig-a001
s390                 randconfig-r044-20221026
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arm                                 defconfig
m68k                            q40_defconfig
arm                           imxrt_defconfig
arm                         assabet_defconfig
arm                          gemini_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
sh                            migor_defconfig
nios2                         3c120_defconfig
sparc                               defconfig
arc                              alldefconfig
arm                            pleb_defconfig
mips                      maltasmvp_defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20221026

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015
powerpc                      pmac32_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-k001
arm                         s5pv210_defconfig
mips                      malta_kvm_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
