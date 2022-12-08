Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3E6467A4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLHDSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 22:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHDSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 22:18:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE343205F
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670469510; x=1702005510;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1xq4lcxYX0rj0wXsmLaSamfxP1sOqC1NT9bxUxwwtaM=;
  b=FvcDL8StezMFkhdg1XStJnmjoKLNn/+z0ga1/jRndFXEPnUgwaOsXweM
   NYiRp0CZhiTRDIasQUwc+2BHCCFetOLYlCW8041Xgh75Npe43+HMTzq1R
   4pzrxlRy9BKcbGptwAFjg1HL2Ng4cv0mpHGlFME8lWn1x+GqSYCNEoKHl
   sRFUv7nkUD46O75S5KJ9r85arhVygRrfA2SjRIeGR1ByOyPvUZZyY/1fw
   LitYm0cJda3BJYt8ejgtmdFcWSZQKEYJNbyiBAVp6Avk2QQ/Gu4AsEnSl
   KmbuJvSl2fhu3kIdRXWop7HY3YwHLzUZ6Pn+0nEQYiytVaT2PxG34otND
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381353213"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381353213"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 19:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="715429913"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="715429913"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 19:18:28 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p37QZ-0000md-1T;
        Thu, 08 Dec 2022 03:18:27 +0000
Date:   Thu, 08 Dec 2022 11:18:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/aardvark] BUILD SUCCESS
 7ccb966779645636679a723588b7bae4f0a8d7d5
Message-ID: <63915777.P25X4L+2wYpV51zw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/aardvark
branch HEAD: 7ccb966779645636679a723588b7bae4f0a8d7d5  PCI: aardvark: Switch to using devm_gpiod_get_optional()

elapsed time: 723m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221207
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221207
x86_64                          rhel-8.3-rust
powerpc                           allnoconfig
s390                 randconfig-r044-20221207
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                        randconfig-a015
sh                               allmodconfig
arc                                 defconfig
x86_64                        randconfig-a002
x86_64                              defconfig
s390                             allmodconfig
i386                          randconfig-a001
alpha                               defconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a003
s390                                defconfig
i386                                defconfig
arm                                 defconfig
i386                          randconfig-a005
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
s390                             allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
