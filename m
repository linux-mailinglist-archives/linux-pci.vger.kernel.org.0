Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D258215F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiG0HoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiG0HoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 03:44:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65842AC3
        for <linux-pci@vger.kernel.org>; Wed, 27 Jul 2022 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658907841; x=1690443841;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XrH/MZ9vLtzWehtNqKNNLwlyfs4yF4O9gtO4Gk2m/Nw=;
  b=JudHZiQuqo5Vxe3e85U0iU0QI3Y8C6wL7iVMKj227K2ya3I4uwpnD7JQ
   tbmpXLmEEAJSGl1YI76kp2c742Z+Z6StvhH//y+Sl48dVoNbjKA3df6uz
   n/j9DE2ruuj1Z2g804aCvCzunIvfgnzeVZzRO7o+ZEiGfLMS6y8g6DpO2
   54vm6jre6+o9RvX+pARP8KzKkRNGLgDgBCwMdX3QqSxjMgjDzfAAEpirK
   dWNLIykj1NyNyRKHm/wRGVbOI337cpt3JOfBiLdAupgX9zBdIhXEbr8g+
   ouMdwFkXmofn0SIWVNLnMmHXBkqrzN4b8fR/1QxLlzmjH1FIW0Smz7HHd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289362393"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289362393"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="927689869"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2022 00:43:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGbi2-0008UJ-1a;
        Wed, 27 Jul 2022 07:43:58 +0000
Date:   Wed, 27 Jul 2022 15:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/header-cleanup-immutable] BUILD SUCCESS
 d63ed7fe85eed2e70bdb16610f327edc765f4c44
Message-ID: <62e0ec84.G6SB2DatDOtOmm6M%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/header-cleanup-immutable
branch HEAD: d63ed7fe85eed2e70bdb16610f327edc765f4c44  x86/cyrix: include header linux/isa-dma.h

elapsed time: 726m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm64                               defconfig
arm                        spear6xx_defconfig
sh                               j2_defconfig
powerpc                  iss476-smp_defconfig
mips                       capcella_defconfig
powerpc                         ps3_defconfig
arm                        keystone_defconfig
sh                          rsk7264_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                            allyesconfig
arc                          axs103_defconfig
nios2                               defconfig
m68k                         apollo_defconfig
um                                  defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
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
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                        multi_v5_defconfig
powerpc                          allmodconfig
mips                  cavium_octeon_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           rs90_defconfig
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
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
