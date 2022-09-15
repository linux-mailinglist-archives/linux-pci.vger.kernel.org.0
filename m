Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD835B937C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 06:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIOESQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 00:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIOESP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 00:18:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3C86B71
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 21:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663215494; x=1694751494;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GnG8PEPxbPxlyL/jKwvTM8wtTnQjYrPCPLD2B5hoCtc=;
  b=nr5UGDckn/mst8sZfLRcSy9S028xN6nCKWOfNxkP3juJOve59svpy+od
   noiuD1n/bHsbuf9IwaAbRucPlXkZfcsICnApwxHs59BsXjviFCCG4H61X
   +EwJeH5KVXnpShXjBu9tz0iMvobHL7c0iUnipJYRJ3DpvBxw5DfHJeq4W
   IvMmcZutntqd4czpREGhpvxlXNezQVAnOFXtBRPKpc1HRflUDS2dUs6me
   syH3xOrZxiW+fPzpGbRbxZJfTeI1lXY+syaaF2HXDoOANsJeP2aOItxZj
   JyfTgVaz5Q/8dsu6I4ftI+ckFuFkL9IGMUNquLo0RbC/GAoP9+AzVo+oI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360346641"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="360346641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 21:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="647671384"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2022 21:18:13 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYgKK-0000r6-1j;
        Thu, 15 Sep 2022 04:18:12 +0000
Date:   Thu, 15 Sep 2022 12:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/dwc] BUILD SUCCESS
 d114ef32ad4cb7d29e3b11ec8323940e62996bb8
Message-ID: <6322a765.OObVhkmgzloPywtt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
branch HEAD: d114ef32ad4cb7d29e3b11ec8323940e62996bb8  PCI: dwc: Replace of_gpio_named_count() by gpiod_count()

elapsed time: 727m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
alpha                               defconfig
s390                                defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
i386                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                                 defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220914
arc                              allyesconfig
x86_64                        randconfig-a004
powerpc                           allnoconfig
arm64                            allyesconfig
i386                          randconfig-a001
arm                              allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                   secureedge5410_defconfig
sh                         apsh4a3a_defconfig
arm                        spear6xx_defconfig
ia64                      gensparse_defconfig
powerpc                    klondike_defconfig

clang tested configs:
hexagon              randconfig-r041-20220914
hexagon              randconfig-r045-20220914
riscv                randconfig-r042-20220914
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
s390                 randconfig-r044-20220914
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
