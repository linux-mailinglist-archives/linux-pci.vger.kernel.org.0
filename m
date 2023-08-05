Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A98770F42
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjHEK2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEK2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 06:28:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0B1720;
        Sat,  5 Aug 2023 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691231308; x=1722767308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVfb3JB7QtBW09CuF/PCWHT3fU9lGly+9ZR4LMS3zpc=;
  b=WjduYPg919N5rBrJqF9Jz8Oc7DN2VvS0+bnE41RfG/vBGJ3KucyIXQOp
   AvAKJokPElId+tsShP2VRZQvjTOQauTJvZqhf4wf7TZIL1PHmsl2u11eR
   IBxExfdi4gO7CGjwlHqIcbR6ADLL5z+UG8mp1EjuCpmKK4mLQiMHaK2Wc
   JTFTh4jXRRc30eh8bHkBVXaF9mr4vyHkMorhterJMpXwEPq+lOXJhXvxB
   7CBrjyNEH7QJF91vEjS6wJSHJbzHrwCwDoyLyOCeDUdb2yaLaENEjacTS
   845xhogrhLYym6lhl3Hh5aGWMJiGgCShSPEUdu/Myo9S8xvjUn9KnE9Ns
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367762426"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="367762426"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 03:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="1061070411"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="1061070411"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2023 03:28:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSEWG-0003Rr-17;
        Sat, 05 Aug 2023 10:28:24 +0000
Date:   Sat, 5 Aug 2023 18:27:35 +0800
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
Subject: Re: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target
 state fallback policy
Message-ID: <202308051831.tHlat46E-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on pci/next pci/for-linus westeri-thunderbolt/next linus/master v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Add-comments-to-clarify-some-ifdef-statements/20230805-050559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230804210129.5356-8-mario.limonciello%40amd.com
patch subject: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target state fallback policy
config: x86_64-randconfig-r072-20230730 (https://download.01.org/0day-ci/archive/20230805/202308051831.tHlat46E-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308051831.tHlat46E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308051831.tHlat46E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/pci/pci.c:1117:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1117:36: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1117:36: sparse:     got int
   drivers/pci/pci.c:1267:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [assigned] [usertype] state @@     got int @@
   drivers/pci/pci.c:1267:15: sparse:     expected restricted pci_power_t [assigned] [usertype] state
   drivers/pci/pci.c:1267:15: sparse:     got int
   drivers/pci/pci.c:1269:50: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1269:69: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1317:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1317:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1317:28: sparse:     got int
   drivers/pci/pci.c:1392:16: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1392:35: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1392:52: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1392:70: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1414:15: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:1414:15: sparse:    left side has type unsigned short
   drivers/pci/pci.c:1414:15: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:1426:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] current_state @@     got int @@
   drivers/pci/pci.c:1426:28: sparse:     expected restricted pci_power_t [usertype] current_state
   drivers/pci/pci.c:1426:28: sparse:     got int
   drivers/pci/pci.c:1457:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1457:21: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1459:18: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1459:26: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1482:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1482:22: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:1840:38: sparse: sparse: array of flexible structures
   drivers/pci/pci.c:2416:44: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2679:52: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2680:22: sparse: sparse: restricted pci_power_t degrades to integer
>> drivers/pci/pci.c:2729:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] constraint @@     got int @@
   drivers/pci/pci.c:2729:20: sparse:     expected restricted pci_power_t [usertype] constraint
   drivers/pci/pci.c:2729:20: sparse:     got int
   drivers/pci/pci.c:2730:13: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2737:21: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2737:33: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2904:20: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2904:38: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2927:49: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:2927:67: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci.c:4894:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4894:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4894:13: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:4899:13: sparse: sparse: invalid assignment: |=
   drivers/pci/pci.c:4899:13: sparse:    left side has type unsigned short
   drivers/pci/pci.c:4899:13: sparse:    right side has type restricted pci_power_t
   drivers/pci/pci.c:1064:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1064:24: sparse:     expected int
   drivers/pci/pci.c:1064:24: sparse:     got restricted pci_power_t [usertype]
   drivers/pci/pci.c:1064:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted pci_power_t [usertype] @@
   drivers/pci/pci.c:1064:24: sparse:     expected int
   drivers/pci/pci.c:1064:24: sparse:     got restricted pci_power_t [usertype]

vim +2729 drivers/pci/pci.c

  2684	
  2685	/**
  2686	 * pci_target_state - find an appropriate low power state for a given PCI dev
  2687	 * @dev: PCI device
  2688	 * @wakeup: Whether or not wakeup functionality will be enabled for the device.
  2689	 *
  2690	 * Use underlying platform code to find a supported low power state for @dev.
  2691	 * If the platform can't manage @dev, return the deepest state from which it
  2692	 * can generate wake events, based on any available PME info.
  2693	 */
  2694	static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
  2695	{
  2696		pci_power_t constraint;
  2697	
  2698		if (platform_pci_power_manageable(dev)) {
  2699			/*
  2700			 * Call the platform to find the target state for the device.
  2701			 */
  2702			pci_power_t state = platform_pci_choose_state(dev);
  2703	
  2704			switch (state) {
  2705			case PCI_POWER_ERROR:
  2706			case PCI_UNKNOWN:
  2707				return PCI_D3hot;
  2708	
  2709			case PCI_D1:
  2710			case PCI_D2:
  2711				if (pci_no_d1d2(dev))
  2712					return PCI_D3hot;
  2713			}
  2714	
  2715			return state;
  2716		}
  2717	
  2718		/*
  2719		 * If the device is in D3cold even though it's not power-manageable by
  2720		 * the platform, it may have been powered down by non-standard means.
  2721		 * Best to let it slumber.
  2722		 */
  2723		if (dev->current_state == PCI_D3cold)
  2724			return PCI_D3cold;
  2725		else if (!dev->pm_cap)
  2726			return PCI_D0;
  2727	
  2728		/* if platform indicates preferred state device constraint, use it */
> 2729		constraint = platform_get_constraint(dev);
  2730		if (constraint < 0)
  2731			constraint = PCI_D3hot;
  2732	
  2733		if (wakeup && dev->pme_support) {
  2734			pci_power_t pme_state = pci_get_wake_pme_state(dev);
  2735	
  2736			/* pick the lesser of any specified constraints */
  2737			if (pme_state < constraint)
  2738				constraint = pme_state;
  2739		}
  2740	
  2741		return constraint;
  2742	}
  2743	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
