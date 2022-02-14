Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA24B41EE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 07:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiBNGXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 01:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiBNGXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 01:23:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDF64E389;
        Sun, 13 Feb 2022 22:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644819783; x=1676355783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogk0u9WIs4rRYT5evD6jDJdiJEu7Wt/pIAhA9485lVQ=;
  b=dn49Hn+Z6bxmQOSRDt5xmyCRU7Sfjd3Vhufz8JBluKH8SDoN/ekx/zw2
   xFVAivJgTkMucveliOkX1GZvQFV5VnSiAVMR5PQJ2ldphIwvyaFsp5ijv
   Qahtab4KWBG4RB5nCJdBAoUmm8wvYJYvlbwEa892WNZvgINmuFwUNE8ut
   io2gqqvj7gPN0z8uKJKUoorXXcVTUpqjRs6O/qNNNxMAzH96CVYYnJ49j
   5FEj/AE5sVEZvfLAvejrnGnrrWOTcix5FgsNtIq+s7+vJj98AZIJl44g2
   921uSU+7fcvfuoXrDa8zOBAIb97/VvWo4J5RST6tkxNXZDYeQsfBtNy7Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247618611"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="247618611"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:23:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="527922292"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:22:59 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 08:22:56 +0200
Date:   Mon, 14 Feb 2022 08:22:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH v2 3/9] PCI: drop `is_thunderbolt` attribute
Message-ID: <Ygn1QHF3aGsHpkS9@lahna>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-4-mario.limonciello@amd.com>
 <YgY5N1eVWmi0Xyuw@lahna>
 <20220213083928.GB23572@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213083928.GB23572@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Feb 13, 2022 at 09:39:28AM +0100, Lukas Wunner wrote:
> On Fri, Feb 11, 2022 at 12:23:51PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 10, 2022 at 04:43:23PM -0600, Mario Limonciello wrote:
> > > @@ -2955,7 +2955,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > >  			return true;
> > >  
> > >  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > > -		if (bridge->is_thunderbolt)
> > > +		if (dev_is_removable(&bridge->dev))
> > 
> > For this, I'm not entirely sure this is what we want. The purpose of
> > this check is to enable port power management of Apple systems with
> > Intel Thunderbolt controller and therefore checking for "removable" here
> > is kind of misleading IMHO.
> [...]
> > and then make a quirk in quirks.c that adds the software node property
> > for the Apple systems? Or something along those lines.
> 
> Honestly, that feels wrong to me.
> 
> There are non-Apple products with Thunderbolt controllers,
> e.g. Supermicro X10SAT was a Xeon board with Redwood Ridge
> which was introduced in 2013.  This was way before Microsoft
> came up with the HotPlugSupportInD3 property.  It was also way
> before the 2015 BIOS cut-off date that we use to disable
> power management on older boards.
> 
> Still, we currently whitelist the Thunderbolt ports on that
> board for D3 because we know it works.  What if products like
> this one use their own power management scheme and we'd cause
> a power regression if we needlessly disable D3 for them now?

All the non-Apple Thunderbolt products before "HotPlugSupportInD3" use
ACPI "assisted" hotplug which means all the PM is done in the BIOS.
Essentially it means the controller is only present if there is anything
connected and in that case it is always in D0. Unplugging the device
makes the controller to be hot-removed (ACPI hotplug) too and that's the
only way early Thunderbolt used to save energy.
