Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4C770DEA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 07:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHEFXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 01:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 01:23:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3846B3;
        Fri,  4 Aug 2023 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691212999; x=1722748999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTNNG0obHMz95xVo7VYy0eCJ7d7oTkTiy8k4b3fMJCg=;
  b=Yg1RSTFUdt7mXXJVoqrgF2hzSBCD51rBdndSx22KODbQgZLfxH5pX7Eg
   wVbgPatdQ6vgr4OnthWpgyO3YoKaQml5sG4TtfFApyktwpdRL3WkNHskZ
   wW4Mi9ft+PxPVZVv0pKY5MXVZI2DTNC9TmU0YyYhUVwSuwSXIHruOUJID
   2rGJPwal9VDosGJ8RebhYmJYTvEqxp6DRg27F2rSPxhaGDCgo9k7jMKcW
   Iu54MjbDWf2M6WHpB23WVf/w9KjpZ3d9M13UDNcix3phSQ5IEcKSlH9pd
   sTMVegJeDGcS6ZwQ4digmCDL3mQi5lSEcbeb45J1SJ0dJIhX+f3wdGmoQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370281325"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="370281325"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 22:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733515439"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="733515439"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 22:23:16 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS9kx-0003Kx-2q;
        Sat, 05 Aug 2023 05:23:15 +0000
Date:   Sat, 5 Aug 2023 13:22:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target
 state fallback policy
Message-ID: <202308051340.k7mCXXL3-lkp@intel.com>
References: <20230804210129.5356-8-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804210129.5356-8-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on pci/next pci/for-linus westeri-thunderbolt/next linus/master v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Add-comments-to-clarify-some-ifdef-statements/20230805-050559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230804210129.5356-8-mario.limonciello%40amd.com
patch subject: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target state fallback policy
config: mips-randconfig-r032-20230731 (https://download.01.org/0day-ci/archive/20230805/202308051340.k7mCXXL3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308051340.k7mCXXL3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308051340.k7mCXXL3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pci.c:1090:9: error: call to undeclared function 'acpi_get_lps0_constraint'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1090 |         return acpi_get_lps0_constraint(&dev->dev);
         |                ^
   1 error generated.


vim +/acpi_get_lps0_constraint +1090 drivers/pci/pci.c

  1084	
  1085	static inline int platform_get_constraint(struct pci_dev *dev)
  1086	{
  1087		if (pci_use_mid_pm())
  1088			return -ENODEV;
  1089	
> 1090		return acpi_get_lps0_constraint(&dev->dev);
  1091	}
  1092	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
