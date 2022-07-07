Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8711F569C8D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGGIFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGGIFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:05:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0433A1F
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657181133; x=1688717133;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zGsDRRCqf8hVAYcQFhb7XQLJha2aLE6sjrk5eQkg+bs=;
  b=eyV1e5M7ocExntNg4Es0SvFIXDmWyy8pI/AU2tHWweGYVmGc2TPyI78u
   2IXt36bBcotTTu4TyAwZ2cxdlDLGnjmreegkmOmsfXHFuiOCK+AJ2/nAN
   PP1x15PZiYiOkv0vbA1MVoFj3XE6kEUBm3ZCqV1z3wirMcr01x2SQ/hIO
   H6UzyASAZfGWwJdlNfA4nKFrjnXwJ52XZ04LChxwIxw3jPzUix9SlSUkP
   PmL1JVSPzgTrKtFdwQjD83+rLTrhe7gyZnTetobukMntSXTlo8mC63WPI
   QrPMv1WWPNCDw1O3Vka1ey6r0hMpWNEBCIAGFgHQfcyzd26x1TX04VRD2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285086711"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="285086711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 01:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="651032801"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 01:05:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9MVv-000Lju-9g;
        Thu, 07 Jul 2022 08:05:31 +0000
Date:   Thu, 07 Jul 2022 16:04:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 1dff012f636d4440f2f99256c09c5b6bfacf7552
Message-ID: <62c6939d.s06WA6MKbmiIW/Ps%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 1dff012f636d4440f2f99256c09c5b6bfacf7552  PCI: Drop of_match_ptr() to avoid unused variables

elapsed time: 721m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
m68k                        mvme147_defconfig
m68k                             alldefconfig
xtensa                       common_defconfig
powerpc                         wii_defconfig
m68k                       m5249evb_defconfig
sh                        apsh4ad0a_defconfig
arm                          lpd270_defconfig
arm                           viper_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  audio_kc705_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
powerpc                     mpc83xx_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                      jornada720_defconfig
arm                        mini2440_defconfig
arm                             rpc_defconfig
sh                           se7705_defconfig
sparc64                             defconfig
um                               alldefconfig
powerpc                       eiger_defconfig
mips                       capcella_defconfig
sh                           se7722_defconfig
nios2                               defconfig
riscv                          rv32_defconfig
ia64                             allmodconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220706
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                      walnut_defconfig
arm                            dove_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220706
hexagon              randconfig-r045-20220706
hexagon              randconfig-r041-20220706
s390                 randconfig-r044-20220706
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
