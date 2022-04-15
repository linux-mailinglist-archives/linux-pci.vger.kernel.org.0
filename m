Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352B5030F5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 01:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiDOWRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 18:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiDOWRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 18:17:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04A3A5CC;
        Fri, 15 Apr 2022 15:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B03BECE31AC;
        Fri, 15 Apr 2022 22:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF39C385A4;
        Fri, 15 Apr 2022 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650060908;
        bh=s0Dk+7YpW8NELxA7hL4hxZKqgZ+VVInWF3zxwlrWQ8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mWa9A5pSTPbpb4OH489eFDoOPOebYkSL0TyfWWeXqI9ObwL3QN4NooutjQhdqYfVA
         P31YIk8uoXovQZ4uKieXMISW5jSTGLM32Xp/FF8AjRhIlBDCH+stwfaaxG70ULJGDW
         Wnx/bccL5gl290yieW3KZvj9ou5IwY7CLkW6/mAnyL0gdnJGf1OZwOAL7l7Debe0nE
         4kLZieNBHZALIEGeKkryhv4OgJtotVulutog5aOfM2UmXSRMDcekYDjVYgJ0Om8hRk
         wdi1RQLssP7NH+ncNJsiiJPwJj3GswVYN+ztyfBGWMt30VK8HjFzaiZ3DD3dEpUems
         jw9nHoAprKjWw==
Date:   Fri, 15 Apr 2022 17:15:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Oliver O'Halloran <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <20220415221506.GA851834@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6Fy3L7vijVn4w+6HwRuuTtW5ePrWc04rUc8U8TPT0Re0w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 04:15:47PM -0700, Rajat Jain via iommu wrote:
> On Thu, Apr 7, 2022 at 12:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Mar 25, 2022 at 11:46:08AM -0700, Rajat Jain wrote:

> > > Support the "DmaProperty" with the same semantics. This is useful for
> > > internal PCI devices that do not hang off a PCIe rootport, but offer
> > > an attack surface for DMA attacks (e.g. internal network devices).
> >
> > Same semantics as what?
> 
> Er, I meant the same semantics as the "DmaProperty". Please also see below.

"Support the 'DmaProperty' with the same semantics as 'DmaProperty'"
doesn't help much, so there must be a little more to the story :)

> > The MS description of "ExternalFacingPort" says:
> >
> >   This ACPI object enables the operating system to identify externally
> >   exposed PCIe hierarchies, such as Thunderbolt.
> 
> No, my patch doesn't have to do with this one.

I know, but it's similar, and I'm just hoping we can deal with them
consistently.

> > and "DmaProperty" says:
> >
> >   This ACPI object enables the operating system to identify internal
> >   PCIe hierarchies that are easily accessible by users (such as,
> >   Laptop M.2 PCIe slots accessible by way of a latch) and require
> >   protection by the OS Kernel DMA Protection mechanism.
> 
> Yes, this is the property that my patch uses. Microsoft has agreed to
> update this documentation (in a sideband thread that I also copied you
> on), with the updated semantics that this property can be used to
> identify any PCI devices that require Kernel DMA protection. i.e. the
> property is not restricted to identify "internal PCIe hierarchies"
> (starting at root port), but to "any PCI device".
> 
> > I don't really understand why they called out "laptop M.2 PCIe slots"
> > here.  Is the idea that those are more accessible than a standard
> > internal PCIe slot?  Seems like a pretty small distinction to me.
> >
> > I can understand your example of internal network devices adding an
> > attack surface.  But I don't see how "DmaProperty" helps identify
> > those.  Wouldn't a NIC in a standard internal PCIe slot add the same
> > attack surface?
> 
> Yes it would. The attack surface is the same. They probably only
> thought of devices external to the SoC (starting from a root port)
> when designing this property and thus called out internal M.2 PCI
> slots. But nowhave realized that this could be opened to any PCI
> device.

> > > +      * Property also used by Microsoft Windows for same purpose,
> > > +      * (to implement DMA protection from a device, using the IOMMU).
> > > +      */
> > > +     if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> >
> > The MS web page says a _DSD with this property must be implemented in
> > the Root Port device scope, but we don't enforce that here.  We *do*
> > enforce it in pci_acpi_set_untrusted().  Shouldn't we do the same
> > here?
> 
> No, the whole point of doing this (please refer to the discussion on
> the previous versions of this patch) was that we want to have a
> property that is NOT limited to the root ports only. And we have
> reached an agreement with Microsoft about that.

We need to either mention the fact that we're going beyond what the MS
web page says or (ideally, as you are doing) get the page updated with
the semantics you need.

> > But IIUC, device_property_read_u8() works for either ACPI or DT
> > properties, and maybe there is interest in using this for DT systems.
> > None of these appear in any in-tree DTs, but maybe it is important to
> > handle these in DTs?
> >
> > If that's the case, this code would no longer be specific to ACPI and
> > should be moved to somewhere that's compiled even when CONFIG_ACPI
> > isn't set.
> 
> I think unifying ACPI and GPIO systems to use the same code / function
> to read the properties might be more work/investigation, because
> reading the properties for ACPI system happens much later than DT
> systems (For acpi systems, it happens in pci_acpi_setup() which is
> called much later). Given that no one wants to use this for DT
> systems, I'd prefer for this to be ACPI specific for now, and then we
> can solve it for DT once someone needs it.

I think it's OK to make it ACPI-specific for now.

Bjorn
