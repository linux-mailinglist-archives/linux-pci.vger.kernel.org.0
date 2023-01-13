Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E205668EF8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 08:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjAMHTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 02:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbjAMHT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 02:19:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621DE74595
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673593458; x=1705129458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jNC9BbuUJx0FUD84sy73dzcIWIOQPP03qUVpNAyWTGU=;
  b=KMC9aD3bOs/ll5bYjprkPO72SpnEvcafqlTxJn4W9svPTYdqirOBUz5J
   yTlV6WIQmInOzPGkYkXVIBrCDDHRPqVvPBHv2Jle8Zkd4TIjoi628TQPu
   cVdjncGXbzlyM2RCwgE5LSPQVaixj/CsEyflNZmG9Li+0gV2aMjpI3vLh
   m2Y6K93Szzh6myr5IhDtYMpGe0rtzh6DhgAJetCz8tMyCWhfRVXTJz4nC
   zzL8Q/uMttbePH75zgqVqf6x2pXEkScEV7bnjjSXF79BlGkxfSuLezIDu
   z67euncbCQU6/M+OLFDua6IS+J7lpxfqijl9yuiXO5czw8fHndhO5VL/y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322632781"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322632781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 23:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="721424148"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="721424148"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2023 23:04:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGE6l-000ArU-1e;
        Fri, 13 Jan 2023 07:04:11 +0000
Date:   Fri, 13 Jan 2023 15:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aer] BUILD SUCCESS
 bba5065963f8ade14f3caa5b0f5b4a53d3054dfd
Message-ID: <63c1026a.u0U6Q+tdXYuGAEdO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aer
branch HEAD: bba5065963f8ade14f3caa5b0f5b4a53d3054dfd  PCI/AER: Configure ECRC only if AER is native

elapsed time: 724m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
mips                             allyesconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
powerpc                          allmodconfig
arm                                 defconfig
arm                           h3600_defconfig
arm                               allnoconfig
alpha                            alldefconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                        realview_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
powerpc                      walnut_defconfig
s390                             alldefconfig
mips                       rbtx49xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
