Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3157D76D0D7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHBPBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjHBPAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:00:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C32690;
        Wed,  2 Aug 2023 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690988449; x=1722524449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nm7xh9afr3+itg6U0oA7NAvWHcM1bQ1T0gO+IUBX07I=;
  b=DDe3nC+sswx/52P1X+Og1rB/mXr+2hJv1kecU0pMuB0oswyKnExHzbrC
   yJ7c1qIIm5jhAFS4Dp6hFvXXJmP7W48ORFcRLw5tw/DLkw78RCKd8RJBN
   Z6u6UbX83dhNpCCBpRHNDofy/ZjjZj2KFxb6cptfWGqr0QeunMn2W7nTs
   COaBXkTlvmm4Ywl5uMRyZVi22rw17/QeKKwV1iY+ha7ufMhOCPeRmMR5n
   nDLRZKkp17mSUOOci3O6UGV5XXLsYEwpy9GLGJhPX9AGcxioEF4/LSyEF
   2nfDkD7wWtrF4kvb+IpWMx+YNfLYgnW3MP02Q+dyOoVcwFds3wactrPc9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="435931710"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="435931710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1059864191"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="1059864191"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 08:00:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3979713F; Wed,  2 Aug 2023 18:00:40 +0300 (EEST)
Date:   Wed, 2 Aug 2023 18:00:40 +0300
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
Message-ID: <20230802150040.GU14638@black.fi.intel.com>
References: <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
 <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
 <20230802052601.GM14638@black.fi.intel.com>
 <e82ec662-22d9-b331-0880-886bd28624eb@amd.com>
 <20230802143142.GS14638@black.fi.intel.com>
 <0fa90fa4-af41-52c1-0e6f-3ce6a84fa461@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fa90fa4-af41-52c1-0e6f-3ce6a84fa461@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 09:35:35AM -0500, Mario Limonciello wrote:
> 
> 
> On 8/2/23 09:31, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, Aug 02, 2023 at 09:10:38AM -0500, Mario Limonciello wrote:
> > > 
> > > 
> > > On 8/2/23 00:26, Mika Westerberg wrote:
> > > > Hi Mario,
> > > > 
> > > > On Tue, Aug 01, 2023 at 10:17:11PM -0500, Mario Limonciello wrote:
> > > > > > Consequently, platform_pci_bridge_d3() will return false and the only
> > > > > > thing that may allow the port to go into D0 is the dmi_get_bios_year()
> > > > > > check at the end of pci_bridge_d3_possible().
> > > > > > 
> > > > > > However, that was added, because there are Intel platforms on which
> > > > > > Root Ports need to be programmed into D3hot on suspend (which allows
> > > > > > the whole platform to reduce power significantly) and there are no
> > > > > > ACPI device power management objects associated with them (Mika should
> > > > > > know the gory details related to this).  It looks like under Windows
> > > > > > the additional power reduction would not be possible on those systems,
> > > > > > but that would be a problem, wouldn't it?
> > > > > > 
> > > > > 
> > > > > I've been thinking on this today, and I at least have a hypothesis about
> > > > > this behavior.  Perhaps Windows is actually utilizing enabled PEP
> > > > > constraints to enforce what state device should be put into over Modern
> > > > > Standby cycles in the absence of ACPI objects.
> > > > > 
> > > > > In the case of one of my problematic system the PEP constraints for the root
> > > > > port are:
> > > > > 
> > > > > Package (0x04)
> > > > > {
> > > > > 	0x00,
> > > > > 	"\\_SB.PCI0.GP17",
> > > > > 	0x00,
> > > > > 	0x00
> > > > > },
> > > > > 
> > > > > That first 0x00 means the constraint isn't actually enabled for the root
> > > > > port.
> > > > > 
> > > > > Mika,
> > > > > 
> > > > > Could you get an acpidump from one of these problematic Intel systems so we
> > > > > can check the PEP constraints to see if this theory works? Or maybe you have
> > > > > some other ideas why this is different?
> > > > 
> > > > The patch adding this was merged in 2016 and unfortunately I don't have
> > > > any of the ACPI dumps from them available anymore (and do not recall the
> > > > details either). I think these were Apollo Lake-P based systems with the
> > > > initial runtime D3cold and S0ix support at the time.
> > > 
> > > 
> > > I scoured the web looking for acpidumps a bit an Apollo Lake system and came
> > > across this random bug report:
> > > 
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1591307
> > > 
> > > "Intel(R) Celeron(R) CPU N3450 @ 1.10GHz (family: 0x6, model: 0x5c,
> > > stepping: 0x9)"
> > > 
> > > I looked at the acpidump, and I notice:
> > > 
> > > Low Power S0 Idle (V5) : 0
> > > 
> > > That means that Windows wouldn't actually be putting it into Modern Standby
> > > at suspend but would rather use S3.
> > 
> > Same goes for Linux AFAICT. The ones needed this actually used S0ix so
> > the bit should definitely be set.
> 
> OK.
> 
> > 
> > > Considering that result, could we perhaps adjust the check to:
> > > 
> > > if ((c->x86_vendor == X86_VENDOR_INTEL) && !(acpi_gbl_FADT.flags &
> > > ACPI_FADT_LOW_POWER_S0))
> > > 
> > > Or could we quirk the PCI root ports from Apollo Lake to opt into D3?
> > 
> > It is not just Apollo Lake, but all "modern" systems as well (sorry if
> > this was unclear). Apollo Lake just was the first one that needed this.
> > We also have the Low Power S0 Idle bit set in recent systems too.
> 
> Ah got it; I misunderstood it as Apollo Lake was the only one that needed
> it.
> 
> So modern systems that set the bit in the FADT, do they also lack _S0W and
> _S0D on the root ports?

That's a good question. I would think they have those but I cannot be
sure for all the existing ones. I checked the RPL system I have here and
it does have _S0W and the HotPlugSupportInD3 at least.

> Does my PEP constraints theory hold steam at all?

I think it might be worthile to dig into it futher. Not sure if this
helps at all but the matching PEP constraint for the one of the root
ports mentioned above looks like this:

               Package (0x03)
               {
                    "\\_SB.PC00.RP09",
                    Zero,
                    Package (0x02)
                    {
                        Zero, 
                        Package (0x02)
                        {
                            0xFF, 
                            0x03
                        }
                    } 
                }, 

