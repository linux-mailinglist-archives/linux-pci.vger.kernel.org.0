Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792684B42BF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 08:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiBNHXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 02:23:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiBNHXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 02:23:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52A593BC;
        Sun, 13 Feb 2022 23:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644823409; x=1676359409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8986kutyorRgf8bSEArW0prD8GIGUUBjn9XYUWWmt7s=;
  b=cI5FS3OYnwVA8/4ykXuuYVG6eg8BbHJoTuBWkmpoSmHcwN7xayIVpyLA
   curiE5ShLwcBdnd5KgjiEJFwtA5qEvqlzP0LFXf9o+ZUn20dZrzsV6BSm
   R4ZGwKs7pRqolm+/OoE4X2nfo63LIIBSjtofW0FXOMp4sYvRMWZSOCHun
   3Wx9XSe67/gHeRLrBQr/XD157ZwqM8afjRGP0+pG9Ooxbb2a1NGvnF6Nj
   3LuyH15qr1u5ZVa+fz2wL39LopTyWt1qrwdkuZ6kRzxc8X6gDrZaHjWoR
   X/W/zyywSdWH7MVZ6j4zxF/DMkkBIVJIvGKtXOHbwiRxseARsVJ0f4fGI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="229995260"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="229995260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:23:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587076655"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:23:25 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 09:23:22 +0200
Date:   Mon, 14 Feb 2022 09:23:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 03/12] PCI: Move check for old Apple Thunderbolt
 controllers into a quirk
Message-ID: <YgoDauh7rd18OvrM@lahna>
References: <20220211193250.1904843-1-mario.limonciello@amd.com>
 <20220211193250.1904843-4-mario.limonciello@amd.com>
 <20220213091920.GA15535@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213091920.GA15535@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Sun, Feb 13, 2022 at 10:19:20AM +0100, Lukas Wunner wrote:
> On Fri, Feb 11, 2022 at 01:32:41PM -0600, Mario Limonciello wrote:
> > `pci_bridge_d3_possible` currently checks explicitly for a Thunderbolt
> > controller to indicate that D3 is possible.  As this is used solely
> > for older Apple systems, move it into a quirk that enumerates across
> > all Intel TBT controllers.
> 
> I'm not so sure if it is only needed on Apple systems.
> 
> 
> > @@ -2954,10 +2960,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  		if (pci_bridge_d3_force)
> >  			return true;
> >  
> > -		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > -		if (bridge->is_thunderbolt)
> > -			return true;
> > -
> >  		/* Platform might know better if the bridge supports D3 */
> >  		if (platform_pci_bridge_d3(bridge))
> >  			return true;
> 
> The fact that Thunderbolt PCIe ports support D3 is a property of those
> devices.  It's not a property of the platform or a quirk of a particular
> vendor.

It is in fact platform specific. For instance the non-Apple systems
without "HotPlugSupportInD3" property have not been wired to support
entering/exiting D3 runtime so putting these ports into D3 may actually
lead into problems as we are in non-validated territory.

> Hence in my view the current location of the check (pci_bridge_d3_possible())
> makes sense wheras the location you're moving it to does not.
> 
> 
> > +/* Apple machines as old as 2010 can do D3 with Thunderbolt controllers, but don't specify
> > + * it in the ACPI tables
> > + */
> 
> Apple started shipping Thunderbolt in 2011.
> Intel brought the first chips to market in 2010.
> 
> The date is meaningful at the code's current location in
> pci_bridge_d3_possible() because a few lines further down
> there's a 2015 BIOS cut-off date.
> 
> Microsoft came up with an ACPI property that BIOS vendors may set
> so that Windows knows it may put a Thunderbolt controller into D3cold.
> I'm not even sure if that property was ever officially adopted by the
> ACPI spec or if it's just a Microsoft-defined "standard".

AFAIK It was invented by Intel Windows folks but Microsoft "documented"
it. We use the same property in ChromeOS (and therefore Linux) too so it
can be thought of as "de facto" way of declaring such port. 
