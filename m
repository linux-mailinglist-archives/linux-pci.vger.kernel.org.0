Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5954E271
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiFPNtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFPNtF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 09:49:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88B25E9E
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655387344; x=1686923344;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xb53sHkrI03n0bUyRrINNhNOJJ/x78ur5KU/7nLMPFU=;
  b=kKUtquUp3fuTrOlcDoOfdMhKVqs+TIHAHpg6MdWKg/ZrmUVl47NqNt4k
   TyrVL2I+RTMNqMBTzlaNZBNzVtSTPIXpBgRCVcZ5Lkf+tWbPzrbKZbIee
   fG+pPM/YB/DVdGgS5EmFQC2JJXCtVabpzz5Dvrx7gGfcOmHsaDQNHjld8
   /xAu3h7CF0JjYUD8etKOfLcAebTmSlhDRFkAln03pr6WC+iPnUEUzTG7h
   Qca3blO/JNNm89adn8yzk6TVDq5jfcT7nZNLKouCC+W4PMYWlWaBy7bok
   vqQ+77Q/4ZLLTzpWsO6arE1gf5WV1o45CrZW9E6Y4ZVps/XUreJ2yQvft
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262271724"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="262271724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="618883612"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 06:49:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1prp-000OQf-1o;
        Thu, 16 Jun 2022 13:49:01 +0000
Date:   Thu, 16 Jun 2022 21:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 dd104bcc2cf233234f82bfc4bd5b8ab32cdbf117
Message-ID: <62ab34b0.4UGa0D7MBWf3qJef%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: dd104bcc2cf233234f82bfc4bd5b8ab32cdbf117  x86/PCI: Revert "x86/PCI: Clip only host bridge windows for E820 regions"

elapsed time: 733m

configs tested: 126
configs skipped: 44

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
s390                          debug_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
um                                  defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5307c3_defconfig
arc                              allyesconfig
sh                          landisk_defconfig
sh                             shx3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5249evb_defconfig
powerpc                      makalu_defconfig
m68k                       m5275evb_defconfig
arm                            xcep_defconfig
arm                         nhk8815_defconfig
xtensa                         virt_defconfig
arm                        clps711x_defconfig
arm                           sunxi_defconfig
mips                       capcella_defconfig
nios2                         10m50_defconfig
microblaze                      mmu_defconfig
arc                         haps_hs_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
mips                             allmodconfig
sparc                               defconfig
m68k                          hp300_defconfig
m68k                        stmark2_defconfig
powerpc                         wii_defconfig
arm                        trizeps4_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
arm                      integrator_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8540_defconfig
powerpc                       ebony_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    socrates_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
