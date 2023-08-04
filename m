Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948E176F8FD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 06:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjHDEcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 00:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHDEcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 00:32:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BF4207;
        Thu,  3 Aug 2023 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691123522; x=1722659522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJe+ZjrTP/JP+VXI8jilEO7qsiVKQxoM6ZPJF8o+fN0=;
  b=Mt0UTBtpQNneZWgjJORTvJMr2dstPiHKykJ3V2yT3McTn6DRq/qf2+Gg
   IZ/GDu7+ITeRmxsXn4uxBsKd1d6+hHzNzOzZujghf5nw1CqZjknosGmcQ
   p1UZKnklXce8Z1ufljZK0Y5/itDczOodW7vlO1Vubh+zQbJKRFHmoyF+O
   SVMvwnf6LJft/MnPAFLNfq9LN6xS3/nnxaJw2qP0xDsspadUWvUVO2+aw
   2soy5glGYlhJUoTJl+Sn4cbPbTxxjXBDyQNtNRmdzd3q9nlmI+RwU9ocL
   61EpjBZZafiFMBeJKtdMez8l4eO7bqeMsLwRlBNloK1ES8gQGveqZR6Z+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370052788"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370052788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873207746"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 21:32:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRmTl-009fQr-1i;
        Fri, 04 Aug 2023 07:31:57 +0300
Date:   Fri, 4 Aug 2023 07:31:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v9 2/3] ACPI: x86: s2idle: Adjust constraints logic
 building
Message-ID: <ZMx/PXV/tBC9OhJT@smile.fi.intel.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804010229.3664-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 08:02:28PM -0500, Mario Limonciello wrote:
> Constraints are currently only stored when enabled.  To enable
> the ability to check if constraints are present they need to be
> stored even if disabled.

...

> @@ -120,8 +121,7 @@ static void lpi_device_get_constraints_amd(void)
>  			if (!lpi_constraints_table)
>  				goto free_acpi_buffer;
>  
> -			acpi_handle_debug(lps0_device_handle,
> -					  "LPI: constraints list begin:\n");
> +			acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");
>  
>  			for (j = 0; j < package->package.count; ++j) {
>  				union acpi_object *info_obj = &package->package.elements[j];

Unrelated change.

-- 
With Best Regards,
Andy Shevchenko


