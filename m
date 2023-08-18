Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F7780F89
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378295AbjHRPro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbjHRPrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 11:47:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C9D1;
        Fri, 18 Aug 2023 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692373637; x=1723909637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dsp15DJuvg/19dkcRHjDlD9vhqjZOtetuQSlHcRi4Xw=;
  b=N4o969dAsJn1lrRNostyXygx9G7LvxmcAroIh57MgXRSQgk3+zavAO2/
   /RBZG2W+TwYDZ+EMWcCd2BbOUyQWF87RfYHI8DYfQgxisAa0p9LE6x51z
   2tzZg64fm1REgZ42PTHc+PGAozD4XViWjoMh6YRqx4WcW3/d7Jq7OfYg3
   6akuiOJg0DZzrDhEJ0ld5iKXvwjU1P62IPdMbgb2erlIzMlTJ8YnCZZmd
   8FYIdBTz/jCkWg8F19Sgf2kUddLXpiLD0yPRlI6KFe9TcWbq1mYoO1aPy
   kqLoDSUisUR/gYYSm9gkPZEQlxQmKS3YNn9rYUjHdcujSYe0v4SPjNk6n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372031498"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372031498"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="805211180"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="805211180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 08:47:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX1gt-00EVC0-2I;
        Fri, 18 Aug 2023 18:47:11 +0300
Date:   Fri, 18 Aug 2023 18:47:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Message-ID: <ZN+Sfx8uTWuM+CHp@smile.fi.intel.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-10-mario.limonciello@amd.com>
 <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
 <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com>
 <0ed1f73e-3931-4e22-ac7a-22ce57094d67@amd.com>
 <CAJZ5v0jdqHeEFNbxTvVPHnC6uUVYmXKNVGZNMnSDVQDCyhCvNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jdqHeEFNbxTvVPHnC6uUVYmXKNVGZNMnSDVQDCyhCvNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 05:38:15PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 4:04 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> > On 8/18/2023 05:47, Andy Shevchenko wrote:
> > > On Fri, Aug 18, 2023 at 10:31:03AM +0200, Rafael J. Wysocki wrote:
> > >> On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
> > >> <mario.limonciello@amd.com> wrote:

...

> > >> I think that some overhead would be reduced below if this were taking
> > >> a struct acpi_device pointer as the argument.
> > >
> > > Hmm... Either you need a pointer to handle, which involves pointer arithmetics
> > > or something else. I would believe if you tell that ACPI handle should be passed,
> > > but current suggestion is not obvious to me how it may help.
> >
> > To Rafael's point about overhead there are potentially "less" calls into
> > acpi_get_lps0_constraint if it's a 'struct acpi_device' pointer because
> > it won't be called by caller for any devices that don't have an ACPI
> > companion.
> >
> > >>> +       struct lpi_constraints *entry;
> > >>> +
> > >>> +       for_each_lpi_constraint(entry) {
> > >>> +               if (!device_match_acpi_handle(dev, entry->handle))
> > >
> > > Here we retrieve handle...
> 
> Which uses ACPI_HANDLE() to retrieve the companion ACPI handle for
> dev. This checks dev against NULL and then passes it to
> ACPI_COMPANION() which resolves to to_acpi_device_node() on the dev's
> fwnode field and that involves an is_acpi_device_node() check and some
> pointer arithmetic via container_of().  Of course, this needs to be
> done in every iteration of the loop until a matching handle is found
> (or not), and because dev is always the same, the result of this will
> be the same every time. If this is not pointless overhead then I'm not
> quite sure how to call it.
> 
> Now, if struct acpi_device *adev is passed as the argument, the check
> above reduces to (adev->handle == entry->handle) which is much more
> straightforward IMV.

Yes, this is fine, and if we move out dev_dbg() call, the suggestion makes
even more sense. I agree with your arguments.

-- 
With Best Regards,
Andy Shevchenko


