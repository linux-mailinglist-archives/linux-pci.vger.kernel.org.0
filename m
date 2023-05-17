Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535807068C1
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjEQM6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEQM6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 08:58:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480692D73;
        Wed, 17 May 2023 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684328283; x=1715864283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pFCGdaUiZ35dGVV0+KTHsJ5y2FJpK7N77Y7pmbvylYw=;
  b=KKZ3qWD4OiBn4mTECwibL5YUbJyebHBOZrztKNRJm/JC+KrKVx7z04PV
   1jf0hsOAfE9n7EJ8ZdlytqMc7AStYLZKCsRjMIadHdoWGNX3PBBHnchBu
   VPDn9tLZPeQlb9XSIbchSkXSWeRut1lTz+MQNaGSRRafzAb0oWfIyd9Z7
   A7Cpvxrq+YjY+mjdUsituNGkQul1F1mwG9ZrzUbCX7Wdf1V8gW5y0OS5q
   4AytxfehGQgJAVfAtMxbUQ4PHsa91elH25FNqt6ARCliZHJcmMaFbsDGJ
   ntPLko65X8jNmRdLF+bZ4OG3ARm+dY9KbYGw0sACBfKpkQJLYWk0dgDUv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438094654"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="438094654"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 05:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771447279"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="771447279"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2023 05:58:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E8FD3618; Wed, 17 May 2023 15:58:11 +0300 (EEST)
Date:   Wed, 17 May 2023 15:58:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Limonciello, Mario" <mlimonci@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Message-ID: <20230517125811.GG45886@black.fi.intel.com>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
 <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
 <20230517071527.GU66750@black.fi.intel.com>
 <8e7e23dc-f01b-6f78-f383-7706795e386e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e7e23dc-f01b-6f78-f383-7706795e386e@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 07:33:17AM -0500, Limonciello, Mario wrote:
> 
> > > AFAICT the actual issue is entirely a wakeup platform firmware sequencing
> > > issue
> > > while in a hardware sleep state and not PMEs.
> > > 
> > > It's only exposed by putting the root ports into D3 over s2idle.
> > But there are two ways to enter s2idle (well or the S0ix whatever is the
> > AMD term for that). Either through system sleep or simply waiting that
> > all the needed devices runtime suspend. There should be no difference
> > from device perspective AFAICT.

I should correct that the wakes may be configured differently, though.

> On AMD all devices in runtime suspend and SoC entering system
> suspend aren't the same state.

Okay.

> > > As an experiment on an unpatched kernel if I avoid letting amd-pmc bind then
> > > the
> > > hardware will never enter a hardware sleep state over Linux s2idle and this
> > > issue
> > > doesn't occur.
> > > 
> > > That shows that PMEs *do* work from D3cold.
> > > 
> > > With all of this I have to wonder if the Windows behavior of what to do with
> > > the root
> > > ports is tied to the uPEP requirements specified in the firmware.
> > > 
> > > Linux doesn't do any enforcement or adjustments from what uPEP indicates.
> > > 
> > > The uPEP constraints for the root port in question in an affected AMD system
> > > has:
> > > 
> > >                      Package (0x04)
> > >                      {
> > >                          Zero,
> > >                          "\\_SB.PCI0.GP19",
> > >                          Zero,
> > >                          Zero
> > >                      },
> > > 
> > > AMD's parsing is through 'lpi_device_get_constraints_amd' so that structure
> > > shows
> > > as not enabled and doesn't specify any D-state requirements.
> > AFAIK this object does not exist in ChromeOS so Linux cannot use it
> > there.
> OK that means that if we came up with a solution that utilized
> uPEP that it would have to remain optional.

Right.

> > > What do they specify for Intel on a matching root port?
> > I think the corresponding entry in ADL-P system for TBT PCIe root port 0
> > looks like this:
> > 
> > 	Package (0x03)
> > 	{
> > 	    "\\_SB.PC00.TRP0",
> > 	    Zero,
> > 	    Package (0x02)
> > 	    {
> > 		Zero,
> > 		Package (0x02)
> > 		{
> > 		    0xFF,
> > 		    0x03
> > 		}
> > 	    }
> > 	},
> > 
> > I'm not entirely sure what does it tell? ;-)
> 
> It's parsed using `lpi_device_get_constraints`.
> 
> So should I follow it right this means for ACPI device
> \\_SB.PC00.TRP0 the constraint is disabled.
> 
> It's described as
> Version 0, UID 0xFF has a minimum D-state of 3.

I see, so it needs to be in D3 for this "constraint" to be valid.

> That means my idea to try to only change D-states at
> suspend for enabled constraints won't help.

:(
