Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA2787F3B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 07:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjHYF0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 01:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjHYF0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 01:26:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A61FE4;
        Thu, 24 Aug 2023 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692941160; x=1724477160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aI6BWUAP+LSvDVU35aySOQGiA1HZ2NfjXkBNcqq4AeE=;
  b=Z0G+n1Wi81D+63XUA3DPf2g1H0V3vZAXV9+3GJoDiirHwgSsKlq8CaSH
   RIwohCUHn/qkTJNw10pCyiDb9Wh5/xLkUbARzQwX3wy8kuM1s8XaoOtFx
   jklpe1Y0/Q2WimZaAm0S/Cuug9y53f5UxL/vw1TexRwX6COghZxMLK6OY
   1HFmA8IgoUrE5qNZeOliDExxoFdtft3nDFWVZP1+m7b3UMxN59D5ZZOqT
   G0gSWcEc1L+zQTuXE3ZXV9cGOSoXuF8pFQYube2LM06xTRwwFLMA0wg3j
   9n63mpw8G4rEKRW6/mAW7mtnMBHkTOcDhaXkTG7kwv/dCBE5+fKonlkoM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440978245"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440978245"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 22:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881045210"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 22:26:01 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZPKV-0003Ei-26;
        Fri, 25 Aug 2023 05:25:55 +0000
Date:   Fri, 25 Aug 2023 13:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v14.b 7/7] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Message-ID: <202308251347.C2sdb28f-lkp@intel.com>
References: <20230818194007.27410-8-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818194007.27410-8-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc7]
[cannot apply to next-20230824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Adjust-ifdef-for-_lps0_dev-use/20230821-113922
base:   linus/master
patch link:    https://lore.kernel.org/r/20230818194007.27410-8-mario.limonciello%40amd.com
patch subject: [PATCH v14.b 7/7] ACPI: x86: s2idle: Add a function to get constraints for a device
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230825/202308251347.C2sdb28f-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251347.C2sdb28f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251347.C2sdb28f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/s2idle.c:311: warning: Function parameter or member 'adev' not described in 'acpi_get_lps0_constraint'
>> drivers/acpi/x86/s2idle.c:311: warning: Excess function parameter 'dev' description in 'acpi_get_lps0_constraint'


vim +311 drivers/acpi/x86/s2idle.c

   301	
   302	/**
   303	 * acpi_get_lps0_constraint - get the LPS0 constraint for a device
   304	 * @dev: device to get constraints for
   305	 *
   306	 * Returns:
   307	 *  - ACPI state value for constraint.
   308	 *  - Otherwise, ACPI_STATE_UNKNOWN.
   309	 */
   310	int acpi_get_lps0_constraint(struct acpi_device *adev)
 > 311	{
   312		struct lpi_constraints *entry;
   313	
   314		for_each_lpi_constraint(entry) {
   315			if (adev->handle != entry->handle)
   316				continue;
   317			return entry->min_dstate;
   318		}
   319	
   320		return ACPI_STATE_UNKNOWN;
   321	}
   322	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
