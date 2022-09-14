Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20625B8183
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiINGdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 02:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiINGdt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 02:33:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C361705
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663137228; x=1694673228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=04L9jRxHuV2QoLeCvax48rPM0QL6/QH4kldJsMQtaT8=;
  b=Hf5u3ncRvCj7Reb1FYIXV+oIctb5JEy0K68Pa9mj1PGLFu/Yxqqf82n4
   22GTp8NcxMvqGiNUFVhnazYChfVsV/088TU1UZgpY6pu3CYNGUNxQnTrv
   1y/yrF/0l4Wl1bVpocBT+wEBjtY0cf0ptgkRC5NuChqvudTFA36OOTPAs
   G+0xUWOXZdacJuva+i5EUhKbxdEzjYCyKdN641r+IIkC5wXo+v7XtEMii
   4VB68QnaqkVsb9NIw1H98P+Ru0eE5NlxcNmUdsU7d4N6YEXvGFQKsk0gP
   AkQn73Gnvn6+F0omTKlP5x4PSryv2EptSydRPmv89aBpZLybKCQVqqwmr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="295935823"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="295935823"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 23:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="649958445"
Received: from lkp-server01.sh.intel.com (HELO f00d1ee8958c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2022 23:33:46 -0700
Received: from kbuild by f00d1ee8958c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYLxy-00002t-00;
        Wed, 14 Sep 2022 06:33:46 +0000
Date:   Wed, 14 Sep 2022 14:33:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aspm] BUILD SUCCESS
 fbc72991fa98ca26bbab7158777ecdbfefb91364
Message-ID: <632175a9.siT7ePYhE3HkGw0C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: fbc72991fa98ca26bbab7158777ecdbfefb91364  PCI/ASPM: Save L1 PM Substates Capability for suspend/resume

elapsed time: 729m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-a001-20220912
i386                 randconfig-a002-20220912
i386                 randconfig-a004-20220912
i386                 randconfig-a003-20220912
i386                 randconfig-a006-20220912
i386                 randconfig-a005-20220912
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20220911
arc                  randconfig-r043-20220912
arc                  randconfig-r043-20220911
s390                 randconfig-r044-20220911
i386                                defconfig
arm                                 defconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
x86_64               randconfig-a001-20220912
x86_64               randconfig-a004-20220912
arm                              allyesconfig
x86_64               randconfig-a002-20220912
x86_64               randconfig-a005-20220912
x86_64               randconfig-a003-20220912
arm64                            allyesconfig
x86_64               randconfig-a006-20220912
ia64                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20220912
hexagon              randconfig-r041-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912
i386                 randconfig-a013-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
i386                 randconfig-a014-20220912
i386                 randconfig-a015-20220912
i386                 randconfig-a016-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a015-20220912
x86_64               randconfig-a016-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a014-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
