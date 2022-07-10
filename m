Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8856CC1E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGJA61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 20:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJA61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 20:58:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62E25C4D
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 17:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657414705; x=1688950705;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S/q0NYEaQcOZGWx8MrWYc+46zFgqPxYTyz8+OJPBvb8=;
  b=dPjjz2+9lLXdeqFImm0ciT+wm06sNmbg3SXR+EeWpUDKjwJfh+Ix5wqF
   QRFYDCAgexG03b5fwAXZqml/h3E0fgJXyr7zOleuqPbLYkgl77Gp5V3RO
   FW4JlTvEJmAx6Zy6xQqwXexutF15oGON2SAvW1jhuNOi8E5wpWnC38RrU
   nx69/0IiCzXpSXa9QgbmpZBiDgzk5ynq5ZcXvS3LNo4gkt44CH4PtKN7s
   Zm/UNkoEn6O8l+lwcXaNCfRGrILHqFosQZmqJmMzjIBxA6502GzqbK7qn
   gvxYpiYgCuoD2tHa+Pe6tIyZj7jn2UUiyip7uxaR2by4lhtPmaqEv1UR9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="370780967"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="370780967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 17:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="621660650"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 17:58:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oALHD-000PKu-Dy;
        Sun, 10 Jul 2022 00:58:23 +0000
Date:   Sun, 10 Jul 2022 08:58:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/qcom-pending] BUILD SUCCESS
 47b4ec9d2e605c8dd54b43cb8b9d6bdb6333e8d4
Message-ID: <62ca2420.fRw8XZrP8TNcPyBx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom-pending
branch HEAD: 47b4ec9d2e605c8dd54b43cb8b9d6bdb6333e8d4  dt-bindings: PCI: qcom: Fix description typo

elapsed time: 1528m

configs tested: 55
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
s390                 randconfig-r044-20220710
riscv                randconfig-r042-20220710
arc                  randconfig-r043-20220710
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
