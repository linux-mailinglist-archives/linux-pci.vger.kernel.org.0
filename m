Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CC61074E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiJ1BgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiJ1BgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 21:36:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440D8A7C1
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666920961; x=1698456961;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XmB5jjOTCkop/KejEE2hGaLusqKIXv7sbphTE7uJ08k=;
  b=GH6ofX/4XewfkvwKpKxfm2tYStSWM2Da1P9v9bWTquPSuZrPEQntUbMg
   OBHgBjchP3QpsXupxLML9npU8a9TgryuCURxkPWBibtfH4ka63JBYBG+7
   w6RIVOckEs4na++q4jD2lyFKPs+kCHrFpz8fI0J4CCQDYl8IVrpwc2uFI
   6P0vBYijCypYHjrVCrAxPNjoK6WPG4oo5Fh4a/wmlV9cXsuQZAbWXeOxQ
   k0Rn8fmn1w2tb79fTZR3GauLm2Z9eBr/5+3BPfbpZ9WujW5eXIAzmsNCW
   aDxg24y5fS0cKshiyue9KpClSfDMXjTKpaMqisPTgEbXDSBSqVDTOFhKX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="309476426"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="309476426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 18:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583759834"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="583759834"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 18:35:56 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooEHr-0009LD-2f;
        Fri, 28 Oct 2022 01:35:55 +0000
Date:   Fri, 28 Oct 2022 09:35:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 442ae919e6ca77354551a7b8717746b44272e274
Message-ID: <635b31d7.51HCcSfhqEiDo/0/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: 442ae919e6ca77354551a7b8717746b44272e274  PCI: designware-ep: Disable PTM capabilities for EP mode

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                           rhel-8.3-syz
arm                                 defconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
i386                             allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
riscv                randconfig-r042-20221026
mips                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
powerpc                          allmodconfig
x86_64                        randconfig-a002
arm64                            allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a012
arc                  randconfig-r043-20221026
i386                          randconfig-a016
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a005
s390                 randconfig-r044-20221026
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
