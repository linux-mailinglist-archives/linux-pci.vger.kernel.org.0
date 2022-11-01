Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0384D614411
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 06:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKAFHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 01:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAFHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 01:07:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855BA140D8
        for <linux-pci@vger.kernel.org>; Mon, 31 Oct 2022 22:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667279262; x=1698815262;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pXFZ0WCQavwpGhv3dPpIOdHYWTAZ+Q1JeR3sTCBXbHM=;
  b=kn/mnFauD4z4XagG8dvUgqWHRa5WK1y3r0K1Luya0qZcXv+iD1xW4bqn
   dtwiZhPGXet/Luf577iRw8h062VOzVz9Om0ewEvi980URB5JatDPZecBs
   1ywK1tAlR3/rvY4sO5NiWf0L/Uzz7fQzAw42RIPkQcCjY6AZflmVPJunF
   7xqaYJ7fe1cBaIKua3Psz+hYTAlWoR+Rlb40NN4EtSc099ZXT/bmAVi0v
   EInYjFxv+v0cMvJl2L5bGOBJN0U0qEoJuuFtVUIxwm4fJsvfxy7MNXIUb
   rwrSvxuZhfzGy6UhKN/tYDDqKuYSiMX/VloX5NrNkS0GlrD0WvC3JQMnm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373281749"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="373281749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 22:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="667080093"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="667080093"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2022 22:07:41 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opjUy-000DLj-1q;
        Tue, 01 Nov 2022 05:07:40 +0000
Date:   Tue, 01 Nov 2022 13:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:wip/bjorn-22-10-irq-of] BUILD SUCCESS
 e7857fe13ad320a12b4e019c64ddafeae0e465ba
Message-ID: <6360a99b.9vpfVdfwg/V42eGZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-22-10-irq-of
branch HEAD: e7857fe13ad320a12b4e019c64ddafeae0e465ba  PCI: Remove unnecessary <linux/of_irq.h> includes

elapsed time: 791m

configs tested: 42
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                          allmodconfig
alpha                               defconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
ia64                             allmodconfig
x86_64                              defconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a011-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a016-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
i386                 randconfig-a005-20221031
x86_64               randconfig-a003-20221031

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
