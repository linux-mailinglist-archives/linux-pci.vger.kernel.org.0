Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D886587AA4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiHBK0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiHBK0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 06:26:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4183A4AB
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659435975; x=1690971975;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Zb2RpbpBf/PgAPn/5L1IOhtDfPcDI5J1Mq2qq9bJEqU=;
  b=MMVQLIFMQcSz/p8ewEu4P0n6XO6MzgizRi0q8JaPTpA3ugbUqz0ArAV3
   NwhTUlIRzsDmyJ6IwV79NO+G/yT749wW2elKO8bvd7Ai8H5krNMrQ9BOb
   cdbV6GCVpg4Lps+DnCF4jsh80+N8UnvML6CWFb54rb9U//CeJpYAU/G6x
   vemy5F5V1WWJS2UzA2IQfWT7xCXivU0eQZLoi72Ly9rV7ybAFHgcQJ9Gx
   kVqQVnYGFJAC1wmuU7Ftes1aRT5A6xq7dZQwWgFxUuGja+pEFHKtmDpnr
   Hqnc3C8+DlReh4gSOYtYWafpW9wsPfZq9mcfzET+DeaG7Ie3v0Xohxw6I
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353379789"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="353379789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 03:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="578169106"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2022 03:26:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIp6L-000Fwl-1m;
        Tue, 02 Aug 2022 10:26:13 +0000
Date:   Tue, 02 Aug 2022 18:25:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/imx6] BUILD SUCCESS
 6213c6c545cb273510047df881230d855e474d3b
Message-ID: <62e8fb96.rufn/JsHgbzf7K6z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/imx6
branch HEAD: 6213c6c545cb273510047df881230d855e474d3b  PCI: imx6: Support more than Gen2 speed link mode

elapsed time: 819m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
powerpc                           allnoconfig
mips                             allyesconfig
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
sh                               allmodconfig
x86_64               randconfig-a011-20220801
i386                 randconfig-a014-20220801
x86_64               randconfig-a012-20220801
ia64                             allmodconfig
i386                 randconfig-a011-20220801
x86_64               randconfig-a013-20220801
i386                 randconfig-a015-20220801
arc                              allyesconfig
x86_64               randconfig-a014-20220801
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20220801
x86_64                          rhel-8.3-func
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
powerpc                          allmodconfig
x86_64               randconfig-k001-20220801
x86_64               randconfig-a016-20220801
arc                  randconfig-r043-20220801
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a016-20220801
i386                 randconfig-c001-20220801
arm64                            allyesconfig
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
alpha                            allyesconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
mips                    maltaup_xpa_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc837x_rdb_defconfig
riscv                    nommu_k210_defconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
x86_64               randconfig-a002-20220801
i386                 randconfig-a001-20220801
x86_64               randconfig-a001-20220801
i386                 randconfig-a002-20220801
x86_64               randconfig-a003-20220801
i386                 randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
x86_64               randconfig-a005-20220801
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
hexagon                             defconfig
powerpc                      katmai_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
