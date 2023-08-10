Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36889777C91
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjHJPrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjHJPrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 11:47:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4067226A9;
        Thu, 10 Aug 2023 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691682470; x=1723218470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQFPUxO8iLe1qVYO9TeDEyOetiCvWzFEQmGWwEcD6lE=;
  b=Oko4c06fN84h3+fnljGX+ux5yNkVKtsBD5ynNZdHdxzoHHP9FND8HUau
   eCbhJRM9Nziqzy1Byqv71Hd0Hz5BCFQ2h7uOlnDYKZGLMVZVuWJzIkBCA
   rKsxf3k7kUfdeeD4YoVSwurEbrJvAv4ul8J2Xo2QjG2guFzfqRbTMsUrU
   pzG/BxVdiiewF3yL2HS27zyfK/PXW7P3NgqwhJiY4truBKpDNJpp2QWlL
   gzURoiPJpjyG8Kqy7rr3N511oVUyqOY4fo7kXVZmbkoFrW7Xzb16iMap0
   n4tvOCQ0zUt8z4aVhOHF7LKr6lNVOy/pl1p66CzoAqLd/K9rfc+ecoLLm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375152381"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375152381"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846443238"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846443238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 08:47:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU7t3-007XhA-0n;
        Thu, 10 Aug 2023 18:47:45 +0300
Date:   Thu, 10 Aug 2023 18:47:44 +0300
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
Subject: Re: [PATCH v11 6/9] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Message-ID: <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-7-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185453.40916-7-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:50PM -0500, Mario Limonciello wrote:
> Other parts of the kernel may use constraints information to make
> decisions on what power state to put a device into.

...

> +int acpi_get_lps0_constraint(struct device *dev)
> +{

> +	int i;
> +
> +	for (i = 0; i < lpi_constraints_table_size; ++i) {
> +		static struct lpi_constraints *entry;

static?!

Seems to me with the code in lpi_check_constraints() this actually can be first
(separate patch maybe with conversion of the mentioned user) transformed to

#define for_each_lpi_constraint(entry)
	for (int i = 0;
	     entry = &lpi_constraints_table[i], i < lpi_constraints_table_size;
	     i++)

> +		int val;
> +
> +		entry = &lpi_constraints_table[i];
> +		if (!device_match_acpi_handle(dev, entry->handle))
> +			continue;
> +		val = entry->enabled ? entry->min_dstate : 0;
> +		acpi_handle_debug(entry->handle,
> +				  "ACPI device constraint: %d\n", val);
> +		return val;
> +	}

So will become

	struct lpi_constraints *entry;
	int val;

	for_each_lpi_constraint(entry) {
		if (!device_match_acpi_handle(dev, entry->handle))
			continue;
		val = entry->enabled ? entry->min_dstate : 0;
		acpi_handle_debug(entry->handle,
				  "ACPI device constraint: %d\n", val);
		return val;
	}

> +	return -ENODEV;
> +}

-- 
With Best Regards,
Andy Shevchenko


