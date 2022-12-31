Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD065A109
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 02:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiLaBzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 20:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiLaBzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 20:55:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD6A1A1
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 17:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672451749; x=1703987749;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U5WWpgSvFeZaja7xQjgElV+87RLu+C/IDG8oJKUm7xc=;
  b=bUvPKV7XsbxP4bY2b3ry+9cFb2ShpX8bqLMVETZuZEulmc9/XjHzvXbR
   MUTpMuWF0/uv4vQwoGFHd+RSaDeAJuPtsCEGz3bAbNrF7hVu42A/CNkHl
   yzdsuCKa2gEUjw1UO+Ok/ozx5PIq8nO+OjMk5+hq/0oxMHyAP2Ei6jLEP
   30Av2wtJYwJueEoDq7QPR5P4Z0Sr/R4GLN3t/SHY/kVIAGlpXsZucPOTk
   W4Gs3N4xIKzhc/4BR3dnBsDf3YUrRimG5wOcOlkVpconFaaGG3seseRA+
   31ZrBfhRbPYvojjg80n/2loqT9rLFrNg8/78Q+qMLF26SFddk5Ny7/Cl4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="383574671"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="383574671"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 17:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="655985032"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="655985032"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Dec 2022 17:55:45 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBR69-000Mq9-01;
        Sat, 31 Dec 2022 01:55:45 +0000
Date:   Sat, 31 Dec 2022 09:55:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/qcom] BUILD SUCCESS
 451a7247296b74bf7a5c264bc878a298a8ee8225
Message-ID: <63af968f.F5gBbWkOU0qBo/rD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/qcom
branch HEAD: 451a7247296b74bf7a5c264bc878a298a8ee8225  PCI: qcom: Add support for SM8350

elapsed time: 724m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
alpha                               defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
s390                             allmodconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
s390                                defconfig
x86_64                           allyesconfig
m68k                             allyesconfig
i386                 randconfig-a012-20221226
m68k                             allmodconfig
i386                 randconfig-a011-20221226
alpha                            allyesconfig
s390                             allyesconfig
i386                 randconfig-a013-20221226
arc                              allyesconfig
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
x86_64               randconfig-a014-20221226
i386                 randconfig-a015-20221226
x86_64               randconfig-a013-20221226
i386                                defconfig
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
arm                                 defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a006-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
