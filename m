Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8657747B219
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhLTR2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLTR2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 12:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A7C061574;
        Mon, 20 Dec 2021 09:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 774E0B81038;
        Mon, 20 Dec 2021 17:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED387C36AEA;
        Mon, 20 Dec 2021 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640021330;
        bh=HtxJW1aGRyANiNJ/JEzvWBH30x0/FnOKHutc3073TbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jE3Tgn7I9iEHdQIAf5yH1Xls3yup7ZARMr+YoxYRkmuE+WtbjL6uggRSu3wzaCuKO
         A+zhrv/3T4N2K1l29T2KSdKNqmzw6qnxI5Kq0s2P0PSOj36PHaqtIihgx2vhCZxfXR
         9tFUPDRI7B+Qqsbh5yVsuIE68OdZY9GpXFthv6auMAhCj9ecS+BwV5SmQaWfyMWhhW
         GkHI2xiI5g3RWjB6hiPPIDiM260bgs+Oz5pcOe6cN5XDVRd8UlPTE7AJZhDdZdAJrp
         En2k2o0HFbpDvrqsO0sHtQnHfxFjF5EHEq5weyGsFNYqm0txc7HiQmaEyWAFWzekDX
         ctJ3ueQTs8BuA==
Date:   Mon, 20 Dec 2021 11:28:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Message-ID: <20211220172848.GA1006510@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5432c30fd597a68feaa935054205da90519a769f.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 01:24:00PM -0800, David E. Box wrote:
> On Thu, 2021-12-16 at 11:26 -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> > > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > > 
> > > On Tiger Lake and Alder Lake platforms, VMD controllers do not have ASPM
> > > enabled nor LTR values set by BIOS. This leads high power consumption on
> > > these platforms when VMD is enabled as reported in bugzilla [1].  Enable
> > > these features in the VMD driver using pcie_aspm_policy_override() to set
> > > the ASPM policy for the root ports.
> > > ...

> > > To do this, add an additional flag in VMD features to specify
> > > devices that must have their respective policies overridden.
> > 
> > I'm not clear on why you want this to apply to only certain VMDs
> > and not others.  Do some BIOSes configure ASPM for devices below
> > some VMDs?
> 
> Not currently. But the plan is for future devices to move back to
> having BIOS do the programming.

Since this is apparently a BIOS design choice, it seems wrong to base
the functionality on the Device ID instead of some signal that tells
us what the BIOS is doing.

> > > + * Override the BIOS ASPM policy and set the LTR value for PCI storage
> > > + * devices on the VMD bride.
> > 
> > I don't think there's any BIOS "policy" here.  At this point BIOS
> > is no longer involved at all, so all that's left is whatever ASPM
> > config the BIOS did or did not do.
> > 
> > Why only storage?
> 
> Only storage devices will be on these root ports.

How do you know this?  You say below that there's an M.2 slot, so
surely the slot could contain a non-storage device?  Couldn't somebody
build a platform with a VMD root port connected to a regular PCIe x4
slot?  Couldn't such a slot support hotplug?

It would be very unusual to hard-code topology knowledge like this
into the kernel, since plug-and-play has always been a major goal of
PCI.

> > > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > > +{
> > > +       int features = *(int *)userdata, pos;
> > > +
> > > +       if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> > > +           pdev->class != PCI_CLASS_STORAGE_EXPRESS)
> > > +               return 0;

> > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
> > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
> > 
> > 1) Where did this magic 0x1003 value come from?  Does that depend
> > on the VMD device?  The endpoint?  The circuit design?  The path
> > between endpoint and VMD?  What if there are switches in the path?
> 
> The number comes from the BIOS team. They are tied to the SoC. I
> don't believe there can be switches in the path but Nirmal and
> Jonathan should know for sure. From what I've seen these root ports
> are wired directly to M.2 slots on boards that are intended for
> storage devices.

I guess you're saying that 0x1003 is determined by the SoC.  If so, I
think this value should be in your .driver_data (which would mean
converting it from a scalar to a struct, as many other drivers do).
The current code suggests that 0x1003 is the correct value for *all*
VMDs and all configurations.

I don't understand LTR well enough to be convinced that this static
value would be the correct value for all possible hierarchies and
devices that could appear below a VMD root port.  I would love to be
educated about this.

Bjorn
