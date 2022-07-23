Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30157ED84
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiGWJ6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Jul 2022 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbiGWJ5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jul 2022 05:57:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB64A803
        for <linux-pci@vger.kernel.org>; Sat, 23 Jul 2022 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658570239; x=1690106239;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lUybcP2IYo7u8e3SfMg+EtGfjLKDQKmA6bfxs2mSObw=;
  b=YQOqzRlJvRrWv2yzeBdRGD2muWoh1RM5CEpyhGBmrpeQUnjMsDWLjbGb
   /490jZNPOZx6mmbREOks3LpQjr8z5hyRplAh2MSM9FRQMlS+8W5m11sUv
   7tu+Oh97TwRGku10W5WNIikGPqHdOT9Bvey904/JuXYNxpbVjPyCcvp7M
   +4V5tvM9wuWeCXWCZkv7LrIQpuR5WIoYnclwFoFCorjyCJ0Zipr9dBM+t
   jnnupHyiCcCoDQppzGl1AkUWf+GQwIphMOAdkeJCW4GVjBC2oo7B3tG8H
   +he4LRmjOOhOxhKLvAOZyMTi/Y+ga2k3H8utCATUgz3krD2gVtbCLFU9Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="270494387"
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="270494387"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 02:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="926321044"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 02:57:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFBsr-0002Ux-0C;
        Sat, 23 Jul 2022 09:57:17 +0000
Date:   Sat, 23 Jul 2022 17:56:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 960ac362648780469b2f5584bb8cff540444d119
Message-ID: <62dbc5dd.yUrFp2pWVXUUHiPm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 960ac362648780469b2f5584bb8cff540444d119  s390/pci: allow zPCI zbus without a function zero

elapsed time: 731m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
s390                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
arm                           u8500_defconfig
sh                             shx3_defconfig
arm                          simpad_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
parisc                generic-64bit_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
openrisc                            defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
powerpc                     sequoia_defconfig
arm                       omap2plus_defconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     asp8347_defconfig
arm                           corgi_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         at91_dt_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
sh                             espt_defconfig
alpha                               defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
parisc64                         alldefconfig
sh                           se7724_defconfig
sparc64                             defconfig
mips                           ci20_defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220721
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
hexagon                             defconfig
arm                      pxa255-idp_defconfig
mips                      maltaaprp_defconfig
mips                          ath79_defconfig
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
mips                        maltaup_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
s390                 randconfig-r044-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
