Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C458AF84
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiHESEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHESEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 14:04:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539DFCC
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659722676; x=1691258676;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fcZgRHu5Ak+GSKRV6L1lnt9up/CL+/N1GeGpuSpGPKk=;
  b=UDI2jFWEhrwhokxgQF2zv0ySuWanfMkvpG2OedqdeuO+yoBrTvpuUq5y
   3XqT0AWoL1j+UMzU23EwRjEhQhrRgFD1i83v8MWLSFcUk6zVSoAO6E8Au
   jrTUPeoiBbuMk5K4BeUxQdCr9wlNeUpj1azCDgEfuOEoApoPF3NvirnY5
   /eSqBCygZFa9AVz2O8HVTCuDkBxS8paSVS9FYlgPqh6u9ilwWNFKsMTqk
   MfVzu3vtQJhz9sSY9Sdim3N4rLSuElEr4qcECL3N/IvuRLRl29a2LaOML
   7eKqjPQrLev2eV8Z89a3S+nyj0LzfGHQo84tA0DTJRey+SGClv0tq5ptU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289016435"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289016435"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="693076392"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2022 11:04:28 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK1gR-000Jcd-1l;
        Fri, 05 Aug 2022 18:04:27 +0000
Date:   Sat, 06 Aug 2022 02:03:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 c4f36c3ab065065a87d641ca2fd5d5c4eb2bfa82
Message-ID: <62ed5b8d.hnit6HH7cGypNZzd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: c4f36c3ab065065a87d641ca2fd5d5c4eb2bfa82  Merge branch 'pci/header-cleanup-immutable'

elapsed time: 1439m

configs tested: 117
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                        randconfig-a013
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                randconfig-r042-20220805
s390                 randconfig-r044-20220805
arc                  randconfig-r043-20220805
powerpc                mpc7448_hpc2_defconfig
mips                       bmips_be_defconfig
m68k                          amiga_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        keystone_defconfig
sh                          rsk7264_defconfig
sh                           se7722_defconfig
sh                          polaris_defconfig
sh                           se7619_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
sh                          landisk_defconfig
mips                            ar7_defconfig
openrisc                 simple_smp_defconfig
powerpc                      pcm030_defconfig
riscv                    nommu_k210_defconfig
sh                         microdev_defconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
xtensa                  cadence_csp_defconfig
i386                             allyesconfig
m68k                            q40_defconfig
ia64                          tiger_defconfig
mips                           ip32_defconfig
arc                          axs103_defconfig
i386                          randconfig-c001
mips                        bcm47xx_defconfig
arm                           corgi_defconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-c001
arm                  randconfig-c002-20220805
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                             sh03_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         vf610m4_defconfig
powerpc                       holly_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
riscv                randconfig-r042-20220804
x86_64                        randconfig-a014
x86_64                        randconfig-a012
s390                 randconfig-r044-20220804
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220805
hexagon              randconfig-r041-20220805
mips                        qi_lb60_defconfig
mips                           ip22_defconfig
x86_64                        randconfig-k001
arm                  colibri_pxa300_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8560_ads_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                     tqm8560_defconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
