Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F462170A7C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 22:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBZVch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 16:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgBZVch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 16:32:37 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BBC2072D;
        Wed, 26 Feb 2020 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582752755;
        bh=xtQ2TMfaNOrQEbDZlEBHw0t0nxOTWe9NjEAljciHdKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cMPRjxYlquwIpHOQ4HX9USQz4vebxqi7Kvzl7GSeLM9Egj2YBcCzWE7FxgVX5CLVk
         T72/CMbnZM8fZY0uTYzPPWBYYhTKEB5zr65bTsI9cvGWpfgewZJ5nmIdnkxBojvW2p
         K+7/D5BBx+0pS8lakFmIFs6wu89wdYirtCpWQr5U=
Date:   Wed, 26 Feb 2020 15:32:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v15 4/5] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200226213233.GA168850@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c961e365-6a5b-01f7-091a-c374848943fe@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 10:42:27AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 13, 2020 at 10:20:16AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ...

> > > +static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> > > +{
> > > +	struct dpc_dev *dpc = data, ndpc;

> > There's actually very little use of struct dpc_dev in this file.  I
> > bet with a little elbow grease, we could remove it completely and just
> > use the pci_dev * or maybe an opaque pointer.

> Yes, we could remove it. But it might need some more changes to
> dpc driver functions. I can think of two ways,
> 
> 1. Re-factor the DPC driver not to use dpc_dev structure and just use
> pci_dev in their functions implementation. But this might lead to
> re-reading following dpc_dev structure members every time we
> use it in dpc driver functions.
> 
> (Currently in dpc driver probe they cache the following device parameters )
> 
>   9         u16                     cap_pos;
>  10         bool                    rp_extensions;
>  11         u8                      rp_log_size;
>  12         u16                     ctl;
>  13         u16                     cap;

I think this is basically what I proposed with the sample patch in my
response to your 3/5 patch.  But I don't see the ctl/cap part, so
maybe I missed something.

> 2. We can create a new variant of dpc_process_err() which depends on pci_dev
> structure and move the dpc_dev initialization to it. Downside is, we should
> do this
> initialization every time we get DPC event (which should be rare).
> 
> void dpc_process_error(struct pci_dev *pdev)
> {
>     struct dpc_dev dpc;
>     dpc_dev_init(pdev, &dpc);
> 
>    ....
> 
> }
> 
> Let me know your comments.
> 
> > 
> > > +	struct pci_dev *pdev = dpc->pdev;
> > > +	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
> > > +	u16 status;
> > > +
> > > +	pci_info(pdev, "ACPI event %#x received\n", event);
> > > +
> > > +	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Check if _DSM(0xD) is available, and if present locate the
> > > +	 * port which issued EDR event.
> > > +	 */
> > > +	pdev = acpi_locate_dpc_port(pdev);

> > This function name should include "get" since it's part of the
> > pci_dev_get()/pci_dev_put() sequence.

> How about acpi_dpc_port_get(pdev) ?

OK.

> > > +	if (!pdev) {
> > > +		pci_err(dpc->pdev, "No valid port found\n");

This message should be expanded somehow.  I think the point is that we
got an EDR notification, but firmware couldn't tell us where the
containment event occurred.  Should that ever happen?  Or is it a
firmware defect if it *does* happen?

In any event, I think the message should say something like "Can't
identify source of EDR notification".

> > > +		return;
> > > +	}
> > > +
> > > +	if (pdev != dpc->pdev) {
> > > +		pci_warn(pdev, "Initializing dpc again\n");
> > > +		dpc_dev_init(pdev, &ndpc);

> > This seems...  I'm not sure what.  I guess it's really just reading
> > the DPC capability for use by dpc_process_error(), so maybe it's OK.
> > But it's a little strange to read.

I *think* maybe if we move the DPC info into the struct pci_dev it
will solve this issue too?  I.e., we won't have a struct dpc_dev, so
we won't have this funny-looking dpc_dev_init().

> > Is this something we should be warning about?

> No this is a valid case. it will only happen if we have a non-acpi
> based switch attached to root port.

I agree this is a valid case (as I mentioned below).  My point was
just that if it is a valid case, we might not want to use pci_warn()
here.  Maybe pci_info() if you think it's important, or maybe no
message at all.  I don't think "Initializing dpc again" is going to be
useful to a user.

> >   I think the ECR says
> > it's legitimate to return a child device, doesn't it?

> > > +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
> > > +	 * determine ownership of DPC between firmware or OS.

> > Extend the comment to say how we *should* determine ownership.

> Yes, ownership should be based on _OSC negotiation. I will add necessary
> comments here.

Why are we not doing this via _OSC negotiation in this series?  It
would be much better if we could just do it instead of adding a
comment that we *should* do it.  Nobody knows more about this than you
do, so probably nobody else is going to come along and finish this
up :)

> > > +	dpc = devm_kzalloc(&pdev->dev, sizeof(*dpc), GFP_KERNEL);

> > This kzalloc should be in dpc.c, not here.
> > 
> > And I don't see a corresponding free.

> It will be freed when removing the pdev right ? Do you want to free it
> explicitly in this driver ?

Nope, you're right.  I always forget about the devm magic, sorry.
