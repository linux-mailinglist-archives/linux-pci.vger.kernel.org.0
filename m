Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135E76F930
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 06:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDE6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 00:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHDE51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 00:57:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D344226;
        Thu,  3 Aug 2023 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691125045; x=1722661045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zv6jrObCLXXL7z7o+6S0fuwMVmrDPxirojj7p4zaW2Y=;
  b=dSIk7QwGkqMl2NCms050TzcWpbs2dvuiRJAdEc/n2mezlvv+6Q0SI1cz
   TzDO0EWp3FTcS2Vwe1b87HU6xIp2HKuwqH3Ov0qHDkmM41SAxZJ21gEwb
   iio1hlS+5edAqN1/5oScmH0dP7y2Ylp+R4FVJexVTI/Y294lk4xlGwEd7
   PhsOSvd33waqqwXEGzHxn6gg3SYh+IUb8Hd27VySwNCTPYi5F65lma1J6
   8PedsYfG0dNvF3uObi2jkt3kJ4xvSZb34OXoVaWxJn5eges5o2Tw/x2RO
   TxkRrc8NpqgnfIUkY5eTyV0/T2zwl+XJKl/a0Zuq1ipy4mQK7GSdunbl8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373712039"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="373712039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723491701"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="723491701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 21:57:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRmsL-00AWC0-0S;
        Fri, 04 Aug 2023 07:57:21 +0300
Date:   Fri, 4 Aug 2023 07:57:20 +0300
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
Subject: Re: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI
 target state fallback policy
Message-ID: <ZMyFMJ/lQKgYZgqa@smile.fi.intel.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-4-mario.limonciello@amd.com>
 <ZMx+4CxT/b8ShiWR@smile.fi.intel.com>
 <f864f6ef-29ae-8cb6-b46c-ee0f32c32fe7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f864f6ef-29ae-8cb6-b46c-ee0f32c32fe7@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:37:10PM -0500, Mario Limonciello wrote:
> On 8/3/23 23:30, Andy Shevchenko wrote:
> > On Thu, Aug 03, 2023 at 08:02:29PM -0500, Mario Limonciello wrote:

...

> > > +	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);
> > 
> > Does it make sense before the below check? Why can we be interested in the
> > _exact_ negative values? (Note that non-printing is already a sign that either
> > we don't call this or have negative constraint.)
> 
> There are two different negative values that can come up:
> -ENODEV or -EINVAL.  Both were interesting while coming up with this series
> because they mean something different about why a constraint wasn't
> selected.
> 
> -ENODEV means the constraint wasn't found.
> -EINVAL means the constraint was found but something is wrong with the table
> parser or the table itself.  I found the table parser wasn't working
> correctly originaly thanks to this.
> 
> Maybe now that I've got it all working you're right and this should go
> after the error checking.

Or maybe moved to the acpi_get_lps0_constraint().

-- 
With Best Regards,
Andy Shevchenko


