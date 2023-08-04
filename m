Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD4B76F9CB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHDGHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDGHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:07:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F53C16;
        Thu,  3 Aug 2023 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691129256; x=1722665256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=npPKe6GlwGsYMSaSyoznMCFJXnIfabPEXvr8yANVB4Y=;
  b=lqUC3Eb690BjEZ2lWBRGkE/3PGmhpcUdsu2i+OuoVjAxqfvkEmZgsQ2y
   v1hYLOsKR0PRni7Ov+t+N2IPesu5kqWBY+w3qxg7Sz25MtlDQ0+2lrG25
   QVYRlTpYYB//IdvhpIwHr8oOaONkhxevkpuivwtJb1GLAkmLNoDU9MNHl
   eJNOrR6j0ObuEx7y7DoE5e5Nn3KmQ0WGQRYkfYqV3Ohz7s9EHdvggJKaS
   Fj+uhxH0CXy+6oJlgr8UWuYXcG4Ca74FmaO0v45XcHKY4kL5vfZyDTbVq
   fSMWER6vst5S3SXXvp5zw1YSNOKS4WNfqJR3gi0Oce3R6+Z8A7eoEL8nO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="360129154"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="360129154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976413473"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="976413473"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 23:07:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C69BF170; Fri,  4 Aug 2023 09:07:43 +0300 (EEST)
Date:   Fri, 4 Aug 2023 09:07:43 +0300
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
Message-ID: <20230804060743.GA14638@black.fi.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
 <20230803050118.GV14638@black.fi.intel.com>
 <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
 <20230803151454.GZ14638@black.fi.intel.com>
 <208afe43-2539-156b-971f-89233598b687@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <208afe43-2539-156b-971f-89233598b687@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 10:18:07AM -0500, Mario Limonciello wrote:
> On 8/3/2023 10:14, Mika Westerberg wrote:
> > On Thu, Aug 03, 2023 at 06:38:45AM -0500, Mario Limonciello wrote:
> > > On 8/3/23 00:01, Mika Westerberg wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
> > > > > @@ -3036,11 +3044,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > > > >    		if (dmi_check_system(bridge_d3_blacklist))
> > > > >    			return false;
> > > > > -		/*
> > > > > -		 * It should be safe to put PCIe ports from 2015 or newer
> > > > > -		 * to D3.
> > > > > -		 */
> > > > > -		if (dmi_get_bios_year() >= 2015)
> > > > > +		/* the platform indicates in a device constraint that D3 is needed */
> > > > > +		if (platform_constraint_d3(bridge))
> > > > 
> > > > This for sure causes some sort of power regression on the Intel
> > > > platforms made after 2015. Why not check for the constraint and:
> > > > 
> > > Are you sure?  I saw it as an explanation of how Windows could put the
> > > systems into D3 when there is no other PM related ACPI objects.
> > 
> > I'm concerned if there are no PEP constraints on some of the affected
> > systems this now leaves root ports into D0 then, no?
> 
> Do you have any idea if any of the affected systems were something that
> didn't ship with Windows?  Like an Apple system or a Chromebook?

Some of them, at least the Apollo Lake ones were used in IVI systems
that did not run Windows IIRC.

> If so; I'd think it's better to treat those as "quirks" rather than make a
> blanket policy from the timing.

It is possible that the quirk list ends up being rather big (or not) so
it may be considered something that is painful to maintain.
