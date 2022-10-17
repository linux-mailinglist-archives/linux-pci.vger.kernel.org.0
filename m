Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CA600711
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJQGxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJQGxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 02:53:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C535973B
        for <linux-pci@vger.kernel.org>; Sun, 16 Oct 2022 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665989536; x=1697525536;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uH1o4mJJ0e5YIFpBePmtr8kwhTnVo/L3YcVgAUuyKlk=;
  b=RFMmjNBizZPQq6etqo5nNav18ktvWInnUD6F0Q27FOOgoyMlqulcF3kU
   C/9geP8RD4WcKfxnNthUQNAORde8DG+qlIFdLWbXux0mg5V9tqIM/aegD
   NFr8fSD0AVd5yVPvZtXP2mk0pHjyraC+SXLKFU827m5OeTJ9EGdxGvNTm
   75YGo5Uv8pTAIgOe0yglgUfs72prP5IT+fnQebvT11jH+YvlTDRP0gcKD
   BhYiR25bep5pWxqkFGuohP1LwOGh7TIaz8hYnGYzJ0euaFl+9Rw57jS27
   QOU2fRvfQT/Os0yCrS3Vi7V9H0hL3XXBpf+Xle4eycgdwMKL4NYUfDtq4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="392028593"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="392028593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 23:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="659245884"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="659245884"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2022 23:51:52 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okJyZ-00009Y-31;
        Mon, 17 Oct 2022 06:51:51 +0000
Date:   Mon, 17 Oct 2022 14:51:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:wip/bjorn-config-of] BUILD SUCCESS
 be531082fd9461f6d0fbe4e2f5f46313b4a62246
Message-ID: <634cfb5e.ke+dF2JHPr9115ev%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-config-of
branch HEAD: be531082fd9461f6d0fbe4e2f5f46313b4a62246  PCI: mobiveil: Drop CONFIG_OF dependencies

elapsed time: 4883m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221013
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                                defconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
s390                             allyesconfig
m68k                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
i386                          randconfig-a001
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
i386                                defconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
arc                  randconfig-r043-20221012
s390                 randconfig-r044-20221012
riscv                randconfig-r042-20221012
arc                  randconfig-r043-20221017
mips                      loongson3_defconfig
arm                         lpc18xx_defconfig
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a002-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
sh                   sh7724_generic_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
loongarch                         allnoconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
m68k                             alldefconfig
arm                         assabet_defconfig
mips                  maltasmvp_eva_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20221013
hexagon              randconfig-r041-20221013
riscv                randconfig-r042-20221013
s390                 randconfig-r044-20221013
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
