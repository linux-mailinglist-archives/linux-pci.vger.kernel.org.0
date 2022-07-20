Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7872B57B6F6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiGTNFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 09:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiGTNFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 09:05:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72E13CF4
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658322345; x=1689858345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RhrXmYM/xc1PfwLPezL2mGg4/YUtB6bmFor6pznlw7c=;
  b=HODpjubihHLec9/STI0tcdWp/eELADrhCKAiLigZEY+qjwRkHrJgn5W6
   031Y3AS5+ROz4SlN6AVTJHchKS+SZuveVzOkXFmhPqgzj0TgM07vWjH+z
   hni69XKDVECjebVfhHcbI8r/JgToaq1FNQAbuUAhrH2gxsn1BmoS8oQLx
   YaMPlhZF5AJ+fLVkseu5pX9lEHiU11U1PLCNigKU46CGPVulG0WM7Zn24
   qjGgZI/jRiX1JemtjpvlU66IMsw5nu+q1L2QMW/x87P3KJgG/3GTrDI3Q
   nD7we25GNLuXC73E1KM/IBy6eQY8MkwcycHM3hiHw8JqtrKIWB25vK1hx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="285535999"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="285535999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="630765957"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2022 06:05:43 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE9OZ-0000Wd-20;
        Wed, 20 Jul 2022 13:05:43 +0000
Date:   Wed, 20 Jul 2022 21:05:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/imx6] BUILD SUCCESS
 d2a81963491e7a5e0e0a8655ed028b4c9151d82e
Message-ID: <62d7fda3.dUuzZFoWDYwGMhVN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/imx6
branch HEAD: d2a81963491e7a5e0e0a8655ed028b4c9151d82e  PCI: imx6: Support more than Gen2 speed link mode

elapsed time: 903m

configs tested: 45
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64               randconfig-a013-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a016-20220718
arc                  randconfig-r043-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                 randconfig-a001-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a004-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
