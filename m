Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4471E58A018
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiHDR6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiHDR6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 13:58:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4D6AA2E
        for <linux-pci@vger.kernel.org>; Thu,  4 Aug 2022 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659635911; x=1691171911;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IAoP3BxmWvcY7pbiZOVG5hKW9UcpIJQY8CM70xIzfr8=;
  b=nMe0I0t1fu1kBjm2Nlx4GJNqH5jXtrjnfSawxnAscM2sEjIJYeCFTDNg
   T73bB/DCw/UijIlpuYL3AufoN9P7be2oZKAElB9Cj0iWNQfRVQNlXLl0s
   p96+NUaOo9rzENhWBAFOmvcpDBpZdZDvvZeBxbxZHZ6ThO73RaLNw109s
   cbAi3QhSPATMfHS+EWCb4jqIXSwkIHkcaxzeci8Q2T7qXEYqLVLQv8+T2
   YpLWeiOaVwL08fa2MrL3wTwu4Ckf6HJVvYO6LzyUXcZMeERg6VjsI3INq
   x0GNnWg4kpTxa4HyYVMDgcq+07KYnd/7LNnnykDoYlEwduCSWEN/zX6EI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="269778251"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="269778251"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 10:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671364664"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 10:58:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJf77-000Ihd-1f;
        Thu, 04 Aug 2022 17:58:29 +0000
Date:   Fri, 05 Aug 2022 01:58:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 f4ca87ba21cbd62f479824587ff660a0e576bcd0
Message-ID: <62ec08b7.Bgg+DhdpmiCvyJmn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: f4ca87ba21cbd62f479824587ff660a0e576bcd0  Merge branch 'pci/header-cleanup-immutable'

elapsed time: 1253m

configs tested: 49
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                                defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220803
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
m68k                             allmodconfig
powerpc                          allmodconfig
alpha                            allyesconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
mips                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
arc                  randconfig-r043-20220804
m68k                             allyesconfig
arc                              allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
hexagon              randconfig-r045-20220803
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220803
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220804
hexagon              randconfig-r045-20220804
riscv                randconfig-r042-20220804
s390                 randconfig-r044-20220804

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
