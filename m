Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB526DEBD8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLGeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 02:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDLGeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 02:34:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4159C5
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681281240; x=1712817240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4wNKUUTYK71tU/wbxLVnosWcHOrc34RwoP8L/4AM4gQ=;
  b=XYlrtxW1rwp9JH9mNc40VkIz8WOTsA3S14lrlBdw+obXz9K+di53WYoh
   yF4opShSoevTaNDOB6KuWEuxeIqw2DjQoyxp4/1hAlXlOakwgoXKFtBQj
   +B0vUZDKUOJpyP0wwu2Zz9jZXTHJobqrBYDcTdey+EKP4QXQwRAko9fVD
   6MQfKJopMB6OwFDTlJYI7cwuix08KMbb/QhUnDUkEQxToV8A6pcY+Spet
   6vJEGNEDiXGURS4IlJnw8BdXWz+42vdEhbTMwA45/GIqgh0qtRXfGExFs
   O1Tu/wD1QPc+r0Aydr/CpVSQVqc2u+N83Q3FRy88sLL1qWV/OOfcAO5Km
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343818467"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="343818467"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 23:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666231973"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="666231973"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 23:33:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmU3J-000XNf-1d;
        Wed, 12 Apr 2023 06:33:57 +0000
Date:   Wed, 12 Apr 2023 14:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS 606012dddebbc4123d51a2223e2b26ed6c746696
Message-ID: <643650ab.acyvYam943Ux0b3I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 606012dddebbc4123d51a2223e2b26ed6c746696  PCI: Fix up L1SS capability for Intel Apollo Lake Root Port

elapsed time: 725m

configs tested: 20
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
