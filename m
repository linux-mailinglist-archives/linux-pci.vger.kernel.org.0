Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C732764926A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 06:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLKFJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 00:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLKFJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 00:09:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240F11C3A
        for <linux-pci@vger.kernel.org>; Sat, 10 Dec 2022 21:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670735353; x=1702271353;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P4yMS5Y+Uv/LgmxRgFndWhiOongZtipTN1LPtck0nbI=;
  b=g0i2N9gMg0bjPY5FCBkUZEta3gcm8hcCGLNy6tXSwZ/smbCcXmUI5SVt
   sohouqGoPo0++jWAMJ1UFcKTxBx0W6ff6yFhX+VgOlB/HsHbg0Y7VaYZb
   whfPeCxd8a2kotJUtgzYDsJWVfZi6aTN2vT52lhTE17KZrXAnH9KT2sP0
   64d7zJJINTFUfIxnhBoHAexTJWs/HYHAND+48Pyuwlq4Sd1rGbFyVvond
   m9aygpj8g3xdtbryimsLs9O5I9R6hgA07dXIy2+MAnuAWoFZQkuKqRqHd
   NfezFdHsfINCaHqkaPs4GJFWS61oHtM4V3aXI11fQYmmjw8MNYcAODo33
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="298020325"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="298020325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 21:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="822133628"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="822133628"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2022 21:09:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4EaL-0002rP-1g;
        Sun, 11 Dec 2022 05:09:09 +0000
Date:   Sun, 11 Dec 2022 13:08:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/portdrv] BUILD SUCCESS
 d8d2b65a940bb497749d66bdab59b530901d3854
Message-ID: <639565d5.Pqyq4r87EPqmUW0x%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/portdrv
branch HEAD: d8d2b65a940bb497749d66bdab59b530901d3854  PCI/portdrv: Allow AER service only for Root Ports & RCECs

elapsed time: 725m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                            allnoconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20221211
arm                  randconfig-r046-20221211
arc                        nsim_700_defconfig
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-rust
x86_64                               rhel-8.3
arm                        realview_defconfig
i386                          randconfig-a001
x86_64                           rhel-8.3-syz
powerpc                     tqm8555_defconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
ia64                             allmodconfig
arc                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
i386                          randconfig-a005
ia64                            zx1_defconfig
x86_64                        randconfig-a013
s390                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a011
alpha                            alldefconfig
alpha                               defconfig
mips                    maltaup_xpa_defconfig
arm                              allyesconfig
m68k                             allyesconfig
s390                                defconfig
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
arc                              allyesconfig
mips                             allyesconfig
powerpc                     pq2fads_defconfig
powerpc                          allmodconfig
alpha                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                             allyesconfig
i386                             allyesconfig
i386                          randconfig-c001
m68k                          atari_defconfig
sh                             shx3_defconfig
powerpc                      ppc6xx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221211
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a002
mips                  cavium_octeon_defconfig
arm                          sp7021_defconfig
powerpc                     kmeter1_defconfig
s390                 randconfig-r044-20221211
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
riscv                randconfig-r042-20221211
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
