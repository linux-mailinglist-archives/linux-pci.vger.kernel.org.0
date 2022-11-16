Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCA62B345
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 07:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiKPG0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 01:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiKPGZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 01:25:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9231D0EA
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668579954; x=1700115954;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zA7zkgFTMvTfVXphfJgjBYB3TE3BHCvLmd5IzQth4iE=;
  b=KwwxOCqDdP6rDgX+p6rPhHgNJTKr6EmGmPDu/j6coEr+cfjYBdSjVKTA
   8QJCNuwk0GyxzhNMTj0aXlWghYFncEtPv261g4V/wzzSu+mEithvdEM/d
   HKMzXIUc54+ewuhj+KyOwWR0rnypshZWKvSUdGBGA0C6VzKhbXXITx8uj
   ggqZpOO6WsImQE7Tch+Uoc10y0D9CPQxQiUsnhbERXQkuJa/FC/gEo2Dv
   PqcmmX1BHQASnPPBCdDzof4HFkZyj+kuH9u0B6hNsLcZtu2vcpExlsA3a
   namBhXch1HVcw0k3gY+EdxqFueHJncvgoVUktuwpODWFr1g80eKiiogdJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311170463"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311170463"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813964903"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="813964903"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2022 22:25:52 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovBrs-00024y-08;
        Wed, 16 Nov 2022 06:25:52 +0000
Date:   Wed, 16 Nov 2022 14:25:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 3d6750ce8b7f20dca801dcdcbeeffea034c759dd
Message-ID: <63748248.XwNCe2gJyo0jWIuE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 3d6750ce8b7f20dca801dcdcbeeffea034c759dd  Merge branch 'pci/kbuild'

elapsed time: 722m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20221115
riscv                randconfig-r042-20221115
s390                 randconfig-r044-20221115
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
