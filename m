Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25F76D013
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHBObi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjHBObh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 10:31:37 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E5EC;
        Wed,  2 Aug 2023 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690986695; x=1722522695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=04PaJ4rNw2KBD/Q8LpUT/AkUkIbasNkvokyMVEZUDcc=;
  b=E42LjCI4v/2m/MVMZN0s5n2h9Gkvx/4ny0II/k+Bk2g6YsT8kxGQkmhp
   ttOrk5pypyIFhIJqPTU2EaAl5AaxqOKIZY0TzHLi7I75je/a1hEwf9YS3
   dplzpwgudDLHkQWpU67/+TTdDfgy+z1zwl7oKx10lRoZrMoeGf/cHmghT
   HxGBc6H9ihcZFwPIYaOpwlauYyk8J9Vw75R8+2pFqj5R4bN20zYl+cYwq
   jIjibnyy1VXC1nUJhDI3FvqoEmVC06N67nHVx6La6zu/vRcPn1pqfVjTj
   5A0eExDypdMJ4h43A80ea/TNHN4Y2E2hyJrTPtu0HYcyDj4+w4PzKqCgL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359637080"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="359637080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722867092"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="722867092"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2023 07:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DC64C13F; Wed,  2 Aug 2023 17:31:42 +0300 (EEST)
Date:   Wed, 2 Aug 2023 17:31:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Message-ID: <20230802143142.GS14638@black.fi.intel.com>
References: <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
 <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
 <20230802052601.GM14638@black.fi.intel.com>
 <e82ec662-22d9-b331-0880-886bd28624eb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e82ec662-22d9-b331-0880-886bd28624eb@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Aug 02, 2023 at 09:10:38AM -0500, Mario Limonciello wrote:
> 
> 
> On 8/2/23 00:26, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Tue, Aug 01, 2023 at 10:17:11PM -0500, Mario Limonciello wrote:
> > > > Consequently, platform_pci_bridge_d3() will return false and the only
> > > > thing that may allow the port to go into D0 is the dmi_get_bios_year()
> > > > check at the end of pci_bridge_d3_possible().
> > > > 
> > > > However, that was added, because there are Intel platforms on which
> > > > Root Ports need to be programmed into D3hot on suspend (which allows
> > > > the whole platform to reduce power significantly) and there are no
> > > > ACPI device power management objects associated with them (Mika should
> > > > know the gory details related to this).  It looks like under Windows
> > > > the additional power reduction would not be possible on those systems,
> > > > but that would be a problem, wouldn't it?
> > > > 
> > > 
> > > I've been thinking on this today, and I at least have a hypothesis about
> > > this behavior.  Perhaps Windows is actually utilizing enabled PEP
> > > constraints to enforce what state device should be put into over Modern
> > > Standby cycles in the absence of ACPI objects.
> > > 
> > > In the case of one of my problematic system the PEP constraints for the root
> > > port are:
> > > 
> > > Package (0x04)
> > > {
> > > 	0x00,
> > > 	"\\_SB.PCI0.GP17",
> > > 	0x00,
> > > 	0x00
> > > },
> > > 
> > > That first 0x00 means the constraint isn't actually enabled for the root
> > > port.
> > > 
> > > Mika,
> > > 
> > > Could you get an acpidump from one of these problematic Intel systems so we
> > > can check the PEP constraints to see if this theory works? Or maybe you have
> > > some other ideas why this is different?
> > 
> > The patch adding this was merged in 2016 and unfortunately I don't have
> > any of the ACPI dumps from them available anymore (and do not recall the
> > details either). I think these were Apollo Lake-P based systems with the
> > initial runtime D3cold and S0ix support at the time.
> 
> 
> I scoured the web looking for acpidumps a bit an Apollo Lake system and came
> across this random bug report:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1591307
> 
> "Intel(R) Celeron(R) CPU N3450 @ 1.10GHz (family: 0x6, model: 0x5c,
> stepping: 0x9)"
> 
> I looked at the acpidump, and I notice:
> 
> Low Power S0 Idle (V5) : 0
> 
> That means that Windows wouldn't actually be putting it into Modern Standby
> at suspend but would rather use S3.

Same goes for Linux AFAICT. The ones needed this actually used S0ix so
the bit should definitely be set.

> Considering that result, could we perhaps adjust the check to:
> 
> if ((c->x86_vendor == X86_VENDOR_INTEL) && !(acpi_gbl_FADT.flags &
> ACPI_FADT_LOW_POWER_S0))
> 
> Or could we quirk the PCI root ports from Apollo Lake to opt into D3?

It is not just Apollo Lake, but all "modern" systems as well (sorry if
this was unclear). Apollo Lake just was the first one that needed this.
We also have the Low Power S0 Idle bit set in recent systems too.
