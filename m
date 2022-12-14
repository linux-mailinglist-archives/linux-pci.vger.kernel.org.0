Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD564C43C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiLNHIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 02:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiLNHHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 02:07:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FA6558
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 23:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671001664; x=1702537664;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g6uwxm6FOWSBhxFVFnEdCPzmekPpl+iW8qdyTUd6kQE=;
  b=kXiV2ek94HiAWdF3gY/ExOenpyjW+X4lwUnBX1LcVJvVTDEV5bSMb5Tl
   sgO5AxWlRdR0rnHi6y2yqCFQhW8laE7n5vUYAN/M5vexjD/9GeF+QbTao
   U4I5Zv9cfOI5SWseimwS+qV6/FC9O2rv7j4BNaQE5fxLzhCOvqe8zbVuj
   kNZ1c1BjKFy+gAxSKKCJdXKSotVh3ld1Z7LfY/ymf2PRjE08sLjtD1b2a
   qJ8qXPHis8rQgzNwIlkQwumON772SE6aV+2N3cY3pGq/coYvPmIhNLuIm
   4M8nqVV9enrmauGG8ztZqdVCUdBifigG+iAT73qEgvczblBd+qSm1TFyG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="301752658"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="301752658"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="712404805"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="712404805"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2022 23:07:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5Lrh-0005Ha-0j;
        Wed, 14 Dec 2022 07:07:41 +0000
Date:   Wed, 14 Dec 2022 15:07:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:v6.2-merge] BUILD SUCCESS
 f64171fdd171789e545bd90addac25f4c0e51668
Message-ID: <63997632.qzuqIGdcA8SA0p5y%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git v6.2-merge
branch HEAD: f64171fdd171789e545bd90addac25f4c0e51668  Merge branch 'next' into v6.2-merge

elapsed time: 720m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20221213
arm                  randconfig-r046-20221213
arc                                 defconfig
m68k                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
s390                                defconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-rust
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                        randconfig-a015
s390                             allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm                              allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r045-20221213
hexagon              randconfig-r041-20221213
riscv                randconfig-r042-20221213
s390                 randconfig-r044-20221213
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
