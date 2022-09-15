Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A615B98CB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIOKbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIOKbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 06:31:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14589912
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663237861; x=1694773861;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DQJQKvT6z9gai7EFA5cXoBn0QAfbw3Kua5Rnar048T0=;
  b=Wz6nbggyuXVJL9wAxN6QPgukW2cKNYxbK2OqyhL0Zb60jQLorwmox7B5
   g3891YWX6Ud1dZyBmbRPzrNcnETCMByNYbefz3P9xgmwF5SInPoUdJWUB
   HkYhC4a2dUO5lenLf5dAd7ZqUL68JIce8VpxQHO/ea+z+IkC6oCjHXsZq
   DKMzajgpRYFZC1lIkfDdXF2IpupUFtjZceCBhsTlX19VZ5D9ABddanntn
   zSBSKl/t8i/0tMAacH/PFa+riP3hNFwcSZv3v5xcb9m5wDEei+if7s2Yg
   rxHS7HOLblUc6b3hmWDPykZ4wuc+U9DRrXGHHXgnR/cMujdh/kbAF3jpI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324937338"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="324937338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 03:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="594765306"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2022 03:30:54 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYm8z-0000Nj-2a;
        Thu, 15 Sep 2022 10:30:53 +0000
Date:   Thu, 15 Sep 2022 18:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 c327b44793ae4197be69c8525871ed753b3c6f5f
Message-ID: <6322fed8.23Vre9Kq8WeYBc2g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: c327b44793ae4197be69c8525871ed753b3c6f5f  Merge branch 'remotes/lorenzo/pci/qcom'

elapsed time: 727m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
arc                              allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                        randconfig-a013
arc                  randconfig-r043-20220914
x86_64                        randconfig-a011
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
mips                             allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220914
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a016
riscv                randconfig-r042-20220914
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220914
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
s390                 randconfig-r044-20220914
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
