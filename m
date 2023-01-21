Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE336762B4
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 02:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjAUBgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 20:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAUBgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 20:36:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96C7DF9A
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 17:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674265001; x=1705801001;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rF4eSh4cd47kKxYWTAJJk7JfRMGux7CEnJj7ysFHA7I=;
  b=TuQPGgsf+kgZTnyU6cyZELU09oGkFx/fEbvQXM6cbEbFb2ccGVvBpuxH
   IaVtiMvXyr+MSP+8lqbbgDW8t5K4KLnJxs++R/S4kYFA7H0ngZ9ki7voP
   mBMw9yR152rMm3bz6YwE3ckcu1UvUIeL/N0gGtfWPfpLfqM2sVAakJgO9
   g2q/PD9lk+6tJ8jPvdg/imnoV4VYMYCsX/yZy3U4Ug1kp8r4RiE7xtd/U
   tJGlrzct5JZ2+fjL+Y0z9Lo/JjZJaeQAEutglPKNnHJacDsV3AUtNfHGW
   kkN59I7N2u2bULKzQfyPWshez/dNEUOZr+myb+m9tNqYt1bfKye7Hw1W0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305414646"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305414646"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 17:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="834607367"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="834607367"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2023 17:36:39 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ2oA-0003Dw-0b;
        Sat, 21 Jan 2023 01:36:38 +0000
Date:   Sat, 21 Jan 2023 09:36:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/qcom] BUILD SUCCESS
 677accaee6c3f9953576c81daa34e2b98959627d
Message-ID: <63cb4182.6pi9sidXVTs+DnIG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/qcom
branch HEAD: 677accaee6c3f9953576c81daa34e2b98959627d  PCI: qcom: Add IPQ8074 Gen3 port support

elapsed time: 728m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
alpha                               defconfig
arm                                 defconfig
x86_64                              defconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
arc                              allyesconfig
arm64                            allyesconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
arm                              allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                          randconfig-a016
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
powerpc                           allnoconfig
mips                             allyesconfig
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
x86_64                        randconfig-a015
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-c001
arm                            hisi_defconfig
arm                      footbridge_defconfig
mips                           ci20_defconfig

clang tested configs:
hexagon              randconfig-r041-20230119
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
i386                          randconfig-a011
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     tqm8540_defconfig
powerpc                    ge_imp3a_defconfig
arm                       spear13xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
