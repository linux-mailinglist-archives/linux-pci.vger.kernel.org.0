Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF162B72E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiKPKH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 05:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKPKH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 05:07:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371A8F
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668593277; x=1700129277;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=m1i47KDNpTit9EdLE9uBGpBjYdn8S1mfJLn+0dZ7jQo=;
  b=D39A3oPVR0sq4u/dVJuil9UqxI4Ij/qukF7Uz7seDitDE9KI+QaHHo7k
   BTTDXPhY2MTsvIAlc+TFqpcDA3cOyW7v9IJmKhAiy/M8x6mzfBtSVA29U
   eVgQRPE5QM8TMcBG/ceJCr46qHhz+Tdg/FsjIqpx3XJG7NtXA66WEErhh
   ONgm1nvXJQ4nntiFHv6W4JU/gH0eLCb67q9gWUht9IHqA8234g/SohV+k
   aIymmFJlhIP256xEVyUJwaBZRFv5T4a+416RTpIYC9Bo5Tai66OTyYJd1
   6x4t975DnY5ppEgClsIaxHijQQ/goHFMS5a2Jmsx1Sd8NZT5uAVNpnMWz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="313655245"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="313655245"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="670439759"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="670439759"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 02:04:58 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovFHt-0002Eb-0f;
        Wed, 16 Nov 2022 10:04:57 +0000
Date:   Wed, 16 Nov 2022 18:04:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/kbuild-pending] BUILD SUCCESS
 72b5e7c401a146bed3ec292c3bfe6fedd572497a
Message-ID: <6374b5af.ny40d70+Hnpmow8w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/kbuild-pending
branch HEAD: 72b5e7c401a146bed3ec292c3bfe6fedd572497a  PCI: Allow building CONFIG_OF drivers with COMPILE_TEST

elapsed time: 720m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221115
m68k                             allmodconfig
riscv                randconfig-r042-20221115
x86_64                        randconfig-a013
arc                              allyesconfig
s390                 randconfig-r044-20221115
x86_64                        randconfig-a011
alpha                            allyesconfig
x86_64                        randconfig-a015
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
i386                 randconfig-a001-20221114
i386                 randconfig-a002-20221114
ia64                             allmodconfig
i386                 randconfig-a003-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221115
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221115
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
