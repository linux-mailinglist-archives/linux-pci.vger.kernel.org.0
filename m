Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8512647D83
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 06:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIF7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 00:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLIF7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 00:59:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA547D098
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 21:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670565547; x=1702101547;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lhbAE4ZnEUKrDItDof4ir61UUdmw45vaaflV32XwWaU=;
  b=fySCRcEysCiaFbSOYIaCBnfIxmk1ZPD2ZNG2vEoU3jf5bh3GSSD/RYya
   Ol0DDvWop/WkrVGg/3lGA1h/xVl/qVk1uUgBix/WPXGRzIqCQY6OpWKYb
   juMQrnzC4GsYW2i3VBjPGq3US5Dufl/o1iMybuWQr4nDrGBN9kaL9tSDp
   XEbnqiwahWX7muFIqpRGgDBpZof/j7tqQ6Nr55Q6B2mOIow3i89Y+AeHB
   H4l+u7dtCcdxCMCwEnObriLfMlpL7oAi12k7X6sAhm/9IpHQ+kScyC+uL
   zZ2PGJBVKwb0/YKQPI6J+uTmwVhUO0DzH4JWTp0OUtLO6u8cmypSdVvfr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="317414019"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="317414019"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 21:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="710772407"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="710772407"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2022 21:59:06 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3WPZ-0001fh-2R;
        Fri, 09 Dec 2022 05:59:05 +0000
Date:   Fri, 09 Dec 2022 13:59:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/xilinx] BUILD SUCCESS
 c1ddc3dad85dda4421e852c72f7596cdb10e9fc6
Message-ID: <6392cea8.vKuesOr0SKabhHrM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/xilinx
branch HEAD: c1ddc3dad85dda4421e852c72f7596cdb10e9fc6  PCI: xilinx-nwl: Fix coding style violations

elapsed time: 728m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                              defconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                            allnoconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                                 defconfig
i386                          randconfig-c001
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221207
x86_64                        randconfig-c001

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
