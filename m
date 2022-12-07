Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6B64537C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 06:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGFjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 00:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGFjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 00:39:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0D4045F
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 21:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670391578; x=1701927578;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3+uVNJOBFls4FdMveN0eFhwqRECLSkd5emwISPoyltI=;
  b=hM4uIFP46FiQA07U0gKXTVW2xdTt+B5v5xhpqdpsHwveUf7kauSzE5e9
   RESrF4L8/R76BDulrEvwBPX1rRFkglM4Wsr26IEum3TKHAtgAaEflPj6/
   g37vo7JBuhRmIAtCfLMq8cCmQAJcknhm+ZybU2xLKbw2+OZA7/7iZnrXg
   cd1ElcNfQnI2zQ07t+jux5MQJExOrge63qLt+DW8XaCe7YM9PkUx40vi1
   SJ1l6BgY8bMny6wxMsezrDKKhI4iKvYeE+qkYU7huI8w06LoxDVMc27sR
   NV/amxoOxSY6b9RMGliMcL0FJprbs/zWGBT8rLBanKr3ey/AsuFCYQfx5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="317951552"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="317951552"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 21:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891661890"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="891661890"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2022 21:39:36 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2n9b-0001bd-26;
        Wed, 07 Dec 2022 05:39:35 +0000
Date:   Wed, 07 Dec 2022 13:38:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dt] BUILD SUCCESS
 d3fd0ee7a4a1e796413fab7affc72eeec31bed13
Message-ID: <639026df.R+op4GqscYazVKAA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dt
branch HEAD: d3fd0ee7a4a1e796413fab7affc72eeec31bed13  dt-bindings: PCI: mediatek-gen3: add support for mt7986

elapsed time: 732m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
