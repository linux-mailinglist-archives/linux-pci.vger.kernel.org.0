Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E162F4C0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiKRMbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiKRMbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E85976F4
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 04:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A91624C3
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 12:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEFCC433C1;
        Fri, 18 Nov 2022 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668774592;
        bh=Mo9FFW10W6140Q80mWIc7QWg+4oDe3M4kxpW3KEW1g0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UNbcdbNJj2O4Ooa1lsRcv7jHADwKnamcOEC5Sd37Qs4nrrh9oTPwNofuYCPejGf+U
         K3rzpV1fDX1LunM8EkedV56xBSC3CwxFQEQYU8ZA52s4LFs7kaxiCPri5+Exbv3dzK
         8fCNWrF4g3EEpFJTzdfMrHafMp2c5wa+Eeo3+aPZSzaS1nG/fbmciGkeoRjveuybG7
         pvhpMS9DkRIiFWfu87tsa1FbtED5Kz3lI9SvRV/Pi8VKGWG6WmTFm0ZpaxeSEjGVEK
         OlI3ha/4Nz7SU/Xlzjq5HktlQ+PqCnMsu4p1BJkC0WQs1TXtS0r1Hx8hVvaXEmORY1
         nPe3Kjdb6HTwA==
Date:   Fri, 18 Nov 2022 06:29:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <20221118122951.GA1263043@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3dI6K8o+j1nE4Lf@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Fri, Nov 18, 2022 at 10:57:12AM +0200, Mika Westerberg wrote:
> On Thu, Nov 17, 2022 at 05:10:34PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 14, 2022 at 01:59:52PM +0200, Mika Westerberg wrote:
> > > PCIe switch upstream port may be one of the functions of a multifunction
> > > device.
> > 
> > I don't think this is specific to PCIe, is it?  Can't we have a
> > multi-function device where one function is a conventional PCI bridge?
> > Actually, I don't think "multi-function" is relevant at all -- you
> > iterate over all the devices on the bus below.  For PCIe, that likely
> > means multiple functions of the same device, but it could be separate
> > devices in conventional PCI.
> 
> Yes it can be but I was trying to explain the problem we encountered and
> that's related to PCIe.
> 
> I can leave this out if you think it is better that way.

Not necessarily, I'm just hoping this change is generic enough for all
PCI and PCIe topologies.

> > > The resource distribution code does not take this into account
> > > properly and therefore it expands the upstream port resource windows too
> > > much, not leaving space for the other functions (in the multifunction
> > > device)
> > 
> > I guess the window expansion here is done by adjust_bridge_window()?
> 
> Yes but the resources are distributed in
> pci_bus_distribute_available_resources().

Yep, sounds good, I was just confirming my understanding of the code.
The main point of this patch is to *reduce* the size of the windows to
leave room for peers of the bridge, so I had to look a bit to figure
out where they got expanded.

> > >  	if (hotplug_bridges + normal_bridges == 1) {
> > > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > -		if (dev->subordinate)
> > > -			pci_bus_distribute_available_resources(dev->subordinate,
> > > -				add_list, io, mmio, mmio_pref);
> > > +		/* Upstream port must be the first */
> > > +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > +		if (!bridge->subordinate)
> > > +			return;
> > > +
> > > +		/*
> > > +		 * It is possible to have switch upstream port as a part of a
> > > +		 * multifunction device. For this reason reduce the space
> > > +		 * available for distribution by the amount required by the
> > > +		 * peers of the upstream port.
> > > +		 */
> > > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > 
> > It seems like maybe we ought to do this regardless of how many bridges
> > there are on the bus.  Don't we always want to assign space to devices
> > on this bus before distributing the leftovers to downstream buses?
> 
> Yes we do.
> 
> > E.g., maybe this should be done before the adjust_bridge_window()
> > calls?
> 
> With the current code it is clear that we deal with the upstream port.
> At least in PCIe it is not allowed to have anything else than downstream
> ports on that internal bus so the only case we would need to do this is
> the switch upstream port.
> 
> Let me know if you still want me to move this before adjust_bridge_window()
> I can do that in v3. Probably needs a comment too.

Hmm, I don't know exactly how to do this, but I don't think this code
should be PCIe-specific, which I think means it shouldn't depend on
how many bridges are on the bus.

I guess the existing assumption that a bridge must be the first device
on the bus is a hidden assumption that this is PCIe.  That might be a
mistake from the past.

I haven't tried it, but I wonder if we could reproduce the same
problem in a conventional PCI topology with qemu.

Bjorn
