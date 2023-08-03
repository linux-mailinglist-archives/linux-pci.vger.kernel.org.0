Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267F76DF80
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 07:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHCFBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 01:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCFBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 01:01:39 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B42D7B;
        Wed,  2 Aug 2023 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691038897; x=1722574897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4c1lxsWgP38TF56d0QxLmeGD2mVcoO3Hq9Qvaznk1ss=;
  b=jqjnb86IZcIRwaDRwohSGTSih3HrmZQrYS+/lNtQGzT1rXPqeL2dN503
   g0iWN48oEg5ZsQiSlimoeFYsajnX4h0QtvmTRoAazPJOYQJmu1p00sRnF
   g3z80nCPxbeVQakvWeqDLPOHC1zY39p9Kc1dsRYvS2rEdGyKuf2ghC2S8
   xuoHekE+KJQFPvu1MPYnAQsoHZ0Air50R+l24HtqNLJoRDZxUEJJ32Wm1
   5Hl1GvMw8zBh9EwgzgTELRWroldvKnVDC9hGr4H5VjfDGiEGvppCsOmFd
   lrya/HwLbbsVbR/Y0l1iQB81grZubeb3eoN3pghPuIaLi1f18ZuvA2en2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369770789"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="369770789"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729411159"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="729411159"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 22:01:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 81B8913F; Thu,  3 Aug 2023 08:01:18 +0300 (EEST)
Date:   Thu, 3 Aug 2023 08:01:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Message-ID: <20230803050118.GV14638@black.fi.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802201013.910-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
> @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (dmi_check_system(bridge_d3_blacklist))
>  			return false;
>  
> -		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> -		 * to D3.
> -		 */
> -		if (dmi_get_bios_year() >= 2015)
> +		/* the platform indicates in a device constraint that D3 is needed */
> +		if (platform_constraint_d3(bridge))

This for sure causes some sort of power regression on the Intel
platforms made after 2015. Why not check for the constraint and:

- If present and enabled, use the desired D-state
- If present and disabled, leave the device in D0
- If not present use the existing cutoff date

?
