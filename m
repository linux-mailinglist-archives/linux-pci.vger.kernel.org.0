Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5E641820
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 18:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiLCRbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 12:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLCRbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 12:31:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CAF49
        for <linux-pci@vger.kernel.org>; Sat,  3 Dec 2022 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670088708; x=1701624708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1rWrbXGGbtrkxuYYdOwtDWoSu1Su0d13aPNIqY2NTWw=;
  b=YZL0DGXrTSQkDni76Q2hquatG+uMoAU32KVpoOphk0XWc1m7XFVhc5+l
   CA8aG/LOUkbecbAcK4oR1zPDPZoq61Ya+w6StLEpJjWoBGRNGymOheCDM
   3pIoWczXSq15m/zw8Wok6NhURKa10buP///j1KoDN9k/9fCnH1zmy7o7f
   WgWM3DCt5nblH2thLIwqD6sr4MjnK9gHlmvIM7dkBlMZvuawC6qFUePR3
   d4FgI1CIa8WUNPLkhrJWRlPFmQG2MCvS8ZT3nq43vgghyKL9MfUidWaWc
   U6yPtv95rZo7JjHcUkx57UtQdAZSU/1nfW3YL1CWSZXeBv0Y6fBDYEpJr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="299557315"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="299557315"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 09:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="676151620"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="676151620"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2022 09:31:46 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1WMc-0000Fl-05;
        Sat, 03 Dec 2022 17:31:46 +0000
Date:   Sun, 04 Dec 2022 01:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 8867ce539ca1c481753639a85ff9ceea82257354
Message-ID: <638b87c5.D9gbCrnoDLD17GaC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 8867ce539ca1c481753639a85ff9ceea82257354  Merge branch 'pci/kbuild'

elapsed time: 822m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
s390                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                        randconfig-a015
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                                defconfig
i386                          randconfig-a003
arc                  randconfig-r043-20221201
i386                          randconfig-a005
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
sh                               allmodconfig
mips                             allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221201
i386                          randconfig-a002
i386                          randconfig-a006
hexagon              randconfig-r045-20221201
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
