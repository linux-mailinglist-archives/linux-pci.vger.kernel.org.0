Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4E6467A3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLHDSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 22:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLHDSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 22:18:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D645800F
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670469509; x=1702005509;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U1YsfuFHNgE+wqCSt4H+jXT87e6jdEU0Gty3gsBBToA=;
  b=d83BLz+uNP9+7YAkQRgaijDufnIiMYxQuzB3OHpnCDLuEaYCQT38ciUo
   +7O/L2Pkoiu7YSBnaWo2rlme3cC4cWW8uXrVhEYFXiIJGplXinK9FXy5B
   tSFjHVpYT6hPBWKhQorfqVcW2vov5uHiWXU5bHnkZrvBNk0omGOZaqAbR
   rYJc5DmFyHF/5fAa9bGWSbNRC2fsfx4NKn3r0RD5ph8UndmLJnqDadh6j
   HznqFhhFwQRIxmz44d73UUuNTqsBFAnY2b4+pfKUn7eURmVEWBsGVYBVm
   Iajp0sBSCRqmpWpfmlX7VdRhBStLNY+JNwwcSCbI2MVZd6gOMeHuRZOkq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318199824"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="318199824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 19:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="789137949"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="789137949"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2022 19:18:28 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p37QZ-0000mX-1F;
        Thu, 08 Dec 2022 03:18:27 +0000
Date:   Thu, 08 Dec 2022 11:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 6d4671b534f6c084e92ef167a52dc47e55f636c4
Message-ID: <63915780.OTkyTcXeD5zZ8BpX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 6d4671b534f6c084e92ef167a52dc47e55f636c4  PCI: pciehp: Enable Command Completed Interrupt only if supported

elapsed time: 723m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
powerpc                           allnoconfig
m68k                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221207
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a005
arc                                 defconfig
sh                               allmodconfig
x86_64                        randconfig-a015
s390                             allmodconfig
mips                             allyesconfig
alpha                               defconfig
ia64                             allmodconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20221207
s390                                defconfig
s390                 randconfig-r044-20221207
arm                                 defconfig
i386                             allyesconfig
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                            allnoconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
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
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a014
arm                  randconfig-r046-20221207
i386                          randconfig-a002
hexagon              randconfig-r041-20221207
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221207
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
