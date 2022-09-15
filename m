Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E435B937D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 06:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIOESR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 00:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIOESP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 00:18:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67886B7E
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 21:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663215495; x=1694751495;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0V20asSiJAYcU36ubIrV8x7m1uih7k0V10NS75MlZYw=;
  b=PHKvaWcAm3Eqsu793kwViIcdxkrKWuOPG7CY0UzoY+8fHjf5bHF3rvVg
   QZkEwscefdYF+a1RGKSWjSTw6enwTnCIKK0xgaOSkZDFhMqyg7BHwNHZm
   l860riFDsDxmZDnCY0oH3ie6DTogxx/DGJvp2w2j0qXZe/jIqs/boqX1Y
   pOeI/BWnC+c2lYNkx7++JkS4Wxa6X4j9AH3yl5oDeSVsrvsdrz4PPzHXj
   Wb2yHNSFzl/SniiMVbhrV6B61V0rNPjq4NZxS2GQTsNLeHgjxYDHVGu3e
   ytM6cDdHIUu8lXFmVYucNar3Ur6VEpfIgrtS+sYeRFInmrklSBSMq01uN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299419584"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="299419584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 21:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="568266873"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 21:18:13 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYgKK-0000r8-1q;
        Thu, 15 Sep 2022 04:18:12 +0000
Date:   Thu, 15 Sep 2022 12:17:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/apple] BUILD SUCCESS
 a6b9ede1f3dfa5477791ad92d11f60f50998b689
Message-ID: <6322a76c.b8LvkuDgfz+vMvNg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/apple
branch HEAD: a6b9ede1f3dfa5477791ad92d11f60f50998b689  PCI: apple: Do not leak reset GPIO on unbind/unload/error

elapsed time: 727m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
sh                               allmodconfig
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a004
arc                  randconfig-r043-20220914
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                   secureedge5410_defconfig
sh                         apsh4a3a_defconfig
arm                        spear6xx_defconfig
ia64                      gensparse_defconfig
powerpc                    klondike_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220914
hexagon              randconfig-r045-20220914
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
riscv                randconfig-r042-20220914
s390                 randconfig-r044-20220914
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
