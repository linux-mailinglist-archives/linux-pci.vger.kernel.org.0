Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A096547283
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jun 2022 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiFKHEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jun 2022 03:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFKHEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jun 2022 03:04:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807095AA77
        for <linux-pci@vger.kernel.org>; Sat, 11 Jun 2022 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654931047; x=1686467047;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wm+flojvzY/ZD5AQg6SHtLHHbrBXa8Gi/ywxSJUHjHI=;
  b=nQ+XcPmqnEqimd8pW72jS9LafxBdfZ2yYY9FJ22wKCLTd3NOPeHjYdUG
   mH6lMqmgnN0hD447Aq3YBCZiH3Wr4UER5w2mAg8u0ON1zs/e6T0UWs6wU
   WqoxOlwAqjLHDUOnczrxjPAuimM9AADV/AAo90yE7ITMjYxh2J5x1vvHE
   YF0o9k8E73VklYNqum7Wo/EeW9lEnrOSH/JOM4iiRifOY/DeMpeOFul9g
   /2OQ06I0bLv6rku3OsSU6T/ITxeHA5rMuJn9TRWI/thhaPHgJ3FeDMOjF
   ZbZGdaxexs5CDyXgsRRQqnKhd67dlZ82N2hGOxjM1Mk4XYYckwZYgEDzw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278634404"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="278634404"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 00:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="567196164"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2022 00:04:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzvAD-000IeU-Bf;
        Sat, 11 Jun 2022 07:04:05 +0000
Date:   Sat, 11 Jun 2022 15:04:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/switchtec] BUILD SUCCESS
 aa195350cdc8e93a890c56d0999b17c441b60b97
Message-ID: <62a43e61.AKCUZvKtCelPpffg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/switchtec
branch HEAD: aa195350cdc8e93a890c56d0999b17c441b60b97  PCI: switchtec: Prefer ida_alloc()/free() over ida_simple_get()/remove()

elapsed time: 2240m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0226_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                      ep88xc_defconfig
um                           x86_64_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220608
arc                  randconfig-r043-20220608
s390                 randconfig-r044-20220608
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                    socrates_defconfig
powerpc                     ppa8548_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220609
s390                 randconfig-r044-20220609
riscv                randconfig-r042-20220609
hexagon              randconfig-r041-20220609
hexagon              randconfig-r045-20220608
hexagon              randconfig-r041-20220608

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
