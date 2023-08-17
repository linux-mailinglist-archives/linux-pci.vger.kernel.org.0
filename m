Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D577F004
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 07:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbjHQFEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 01:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbjHQFEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 01:04:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A481BF8;
        Wed, 16 Aug 2023 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692248661; x=1723784661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTyYGw616Ly+01F1y0uYgaWLYZdfcDwkVsZCg+gqhM8=;
  b=Dq5p9aarNndCNRhZTbenyhxGo1HFVTt5CNZKkjP91mNko5qfYGgI0FMF
   e+rDIym8kaL7Jg5dkUZ66y+819LwXsgW4Km0zhx4JhpbQrxvfHmj+aP0e
   knuhO/KFcoyo9BbFJXj+fRaQRzP2iujCeD0vztGhac51XETzI3A3Mxhqh
   ok4haTSLL152/GFcb9O9yi+9UEkhMWSkNHpWVjJ872FWZ4lWf/5IUZ6Sg
   d6PkZDbFMT8W6xMFxi3H3VDoX8/umKzRBLWABsBG0EkqWGfUbj8McKGj0
   k8itlr6V4B9AgTKZK9JQG/Lfwpdot7CXMWyYlKk1OdXz89SVTJE++Ycm2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375478323"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375478323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 22:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848747890"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848747890"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 22:04:17 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWVBB-0000o1-02;
        Thu, 17 Aug 2023 05:04:17 +0000
Date:   Thu, 17 Aug 2023 13:03:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
Message-ID: <202308171239.xQFwhccA-lkp@intel.com>
References: <20230816204143.66281-10-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204143.66281-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2ccdd1b13c591d306f0401d98dedc4bdcd02b421]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Add-comments-to-clarify-some-ifdef-statements/20230817-061259
base:   2ccdd1b13c591d306f0401d98dedc4bdcd02b421
patch link:    https://lore.kernel.org/r/20230816204143.66281-10-mario.limonciello%40amd.com
patch subject: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for PCI devices
config: i386-randconfig-i063-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171239.xQFwhccA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171239.xQFwhccA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171239.xQFwhccA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/x86/s2idle.c:306:67: sparse: sparse: restricted pci_power_t degrades to integer
>> drivers/acpi/x86/s2idle.c:306:45: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted pci_power_t [usertype] target @@     got int @@
   drivers/acpi/x86/s2idle.c:306:45: sparse:     expected restricted pci_power_t [usertype] target
   drivers/acpi/x86/s2idle.c:306:45: sparse:     got int
   drivers/acpi/x86/s2idle.c:312:13: sparse: sparse: restricted pci_power_t degrades to integer
>> drivers/acpi/x86/s2idle.c:318:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int state @@     got restricted pci_power_t [usertype] current_state @@
   drivers/acpi/x86/s2idle.c:318:17: sparse:     expected int state
   drivers/acpi/x86/s2idle.c:318:17: sparse:     got restricted pci_power_t [usertype] current_state
>> drivers/acpi/x86/s2idle.c:318:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int state @@     got restricted pci_power_t [usertype] target @@
   drivers/acpi/x86/s2idle.c:318:17: sparse:     expected int state
   drivers/acpi/x86/s2idle.c:318:17: sparse:     got restricted pci_power_t [usertype] target
   drivers/acpi/x86/s2idle.c:522:13: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/acpi/x86/s2idle.c:522:33: sparse: sparse: restricted suspend_state_t degrades to integer

vim +306 drivers/acpi/x86/s2idle.c

   303	
   304	static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
   305	{
 > 306		pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
   307	
   308		if (pdev->current_state == target)
   309			return;
   310	
   311		/* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
   312		if (target == ACPI_STATE_D3_HOT &&
   313		    (pdev->current_state == PCI_D3hot ||
   314		     pdev->current_state == PCI_D3cold))
   315			return;
   316	
   317		if (pm_debug_messages_on)
 > 318			acpi_handle_info(entry->handle,
   319					 "LPI: PCI device in %s, not in %s\n",
   320					 acpi_power_state_string(pdev->current_state),
   321					 acpi_power_state_string(target));
   322	
   323		/* don't try with things that PCI core hasn't touched */
   324		if (pdev->current_state == PCI_UNKNOWN) {
   325			entry->handle = NULL;
   326			return;
   327		}
   328	
   329		pci_set_power_state(pdev, target);
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
