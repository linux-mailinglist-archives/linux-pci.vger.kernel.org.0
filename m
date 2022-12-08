Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD4647514
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLHRnz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 12:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLHRny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 12:43:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA391144C
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670521433; x=1702057433;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oEKLsRRBQ0yN5LlVVtDghci81ibifXLAvOKeXjpDid8=;
  b=dDXoFJm9ROvrkr2PB9nm0sSiRi2rqK/qNpESnNauX6kWmr3O41VPA/tv
   SvqIoOWRNJ6XlVoQDhn/WS2ufESoaGnWoW8qvwHZmmrNym0ZMm7Nq5krk
   YQ1UwVkoOXzfIIH5oM9GdOBols8hQpQ7MVxIGSL5w/NADLrCoCBROfApK
   aARnE7aojhHvWvpLpTzd9/79M4au5gy/VAaGcb69sJdCNqJdiF7LdgVKq
   IRfr4xvGtsyba5cFeUCcBdDqD2PXpoqw9KbT7nwfC8y9UYTupVgFO9YmG
   8B1PzV+C617hdeUw3XHCn8QjWKMpeIuZAHx2maEXAoTSxsyluAnjM1xEq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="344285604"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="344285604"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 09:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="647088238"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="647088238"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2022 09:43:51 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3Kw2-0001K7-0x;
        Thu, 08 Dec 2022 17:43:50 +0000
Date:   Fri, 09 Dec 2022 01:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/mvebu] BUILD SUCCESS
 76007ccc5727f86c105e96697e96dcf2df6b1634
Message-ID: <63922240.Kfr+kNmQgbedyE7j%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/mvebu
branch HEAD: 76007ccc5727f86c105e96697e96dcf2df6b1634  PCI: mvebu: Switch to using gpiod API

elapsed time: 920m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
m68k                             allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
i386                          randconfig-a005
s390                 randconfig-r044-20221207
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a014
powerpc                          allmodconfig
arm                              allyesconfig
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
x86_64                            allnoconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
arm                  randconfig-r046-20221207
i386                          randconfig-a004
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
