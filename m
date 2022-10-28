Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1C610867
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 04:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiJ1CsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 22:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiJ1CsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 22:48:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9597BC78E
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666925282; x=1698461282;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3gQaPG9QHRJsZ0YDSxql8xkwP1tX9MRGEJmBfkMJ3p8=;
  b=gJev4ocyvzCQX2ivDcRiISnH1/NuHc/OMC8r4KuBtikmeVHr67Ypez1t
   /GKldB/KbSc3kTONiQZVCk/QFtdOr9UbcR9Blf/wWrbKca+uezWKJZcJ8
   n+5lujyYzU24nd7lq0AWxWJXaY8P4cGRyX3GI2JgnTch6f0K27xFrf6aT
   kwP63KyRTsJ4AtvPBaMSJrnYJGUetsuIfA3VV0aGZbefMPPqGJq0ta53a
   Myv3PqAYsSJCrMlZepK0ATxM0t+z8zAL4C+HBUmhx26fnyrCaoc20X2T8
   E6uF/kR1aoUcqVNWUicKKdZ0qfQ+aeFNT3ksfvPqjWVmimC3/pAYhjjRp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308384916"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="308384916"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 19:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="665915265"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="665915265"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2022 19:48:00 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooFPc-0009Ou-0z;
        Fri, 28 Oct 2022 02:48:00 +0000
Date:   Fri, 28 Oct 2022 10:47:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [lpieralisi-pci:pci/misc] BUILD SUCCESS
 6acd25cc98ce0c9ee4fefdaf44fc8bca534b26e5
Message-ID: <635b42d3.16kbYUlkEE8NXhwi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/misc
branch HEAD: 6acd25cc98ce0c9ee4fefdaf44fc8bca534b26e5  PCI: pci-epf-test: Register notifier if only core_init_notifier is enabled

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
powerpc                           allnoconfig
um                             i386_defconfig
sh                               allmodconfig
x86_64                              defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                               rhel-8.3
s390                                defconfig
m68k                             allmodconfig
s390                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221026
s390                             allyesconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221026
x86_64                          rhel-8.3-func
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20221026
i386                          randconfig-a005
arm                                 defconfig
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
