Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA42D647E5A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 08:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLIHOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 02:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLIHOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 02:14:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CA02FC22
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 23:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670570049; x=1702106049;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WRzcoDIkTysAJxUS9R9v9u5Anp/8tsb0SAyQs5lj06A=;
  b=f9Bz0C2wNmpxdCagls053Vfh7+pLdU0q6z+VSqqKO0cgO/T2iK6514pL
   ziu6ldM+aOQRohyIoT9C5S+gJu1TC7mBiyx0H3VLS8VeAtTpl2qVHBfNp
   bWAC7bwrz75z9nHy99UJ50vTPpvJPdWwrj4IPT36HjbRLc87eh3Z9KwAK
   O3YKh0R8hbDHfj9diaaB9Thr7j5QSmzeWQbUPBG7aJUORAKbuhClKAfxa
   65wLni7qBHYEmN0h5s4Ge/dZkCHv2TmdNpyTEAFJBgoMCKejoWqMLswgr
   y/wPa33HAkFNyC2fcgtVweqgXViZlNr0VPxyR1J6cLWqUMPoe5y/s81OK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="315036205"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="315036205"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 23:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="892562483"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="892562483"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Dec 2022 23:14:07 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3XaB-0001id-0X;
        Fri, 09 Dec 2022 07:14:07 +0000
Date:   Fri, 09 Dec 2022 15:13:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/resource] BUILD SUCCESS
 4aece762789a2277bf9f0eda8b0cd229ccbbc88e
Message-ID: <6392e015.MuOLPKUg3YYXD1WE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
branch HEAD: 4aece762789a2277bf9f0eda8b0cd229ccbbc88e  x86/PCI: Fix log message typo

elapsed time: 728m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allmodconfig
s390                                defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
ia64                             allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
