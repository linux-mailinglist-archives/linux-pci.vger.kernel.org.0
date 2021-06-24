Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02D3B33BA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFXQS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 12:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhFXQSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 12:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBA20613B3;
        Thu, 24 Jun 2021 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624551366;
        bh=LRAKIyItqZRjNgN2DEdMSx4GcyvU1DlflvVaoGixOWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mlGWialXvl3ChYUFloKtM214TrVMealpz6qozA9XzuCppW+VMdwwEpbnyWWFR7PvT
         YCVTKrFx7/XYPElpLNGoKrpzTCe1YwngiYm582FDGo1Lb0j6oKKUWQWP2160wNDS8Y
         X5md3nm7VwKoffkQ7R+pqB+aXZJKZHypi3ZEL52AZmvW4CL8VROI0G7KkykOGt6tCf
         cuFevnCK5ZAJ8RAT+G35pUoC7E0N+opfC8FKm8GUIOYsUc1VhCUxzfPkyb1KB7RtyU
         iu313vgXCwx3LDAvJvXpOwCgqgQwBYMas5W++/NGeoYsT9j6ugKxUYXJtYMykZWrqn
         GxI9MqBtgqIJA==
Date:   Thu, 24 Jun 2021 11:15:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210624161559.GA3532867@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624152809.m3glwh6lxckykt33@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Alex]

On Thu, Jun 24, 2021 at 08:58:09PM +0530, Amey Narkhede wrote:
> On 21/06/24 07:23AM, Bjorn Helgaas wrote:
> > On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:
> > > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > > supported by the device which does not match the calling convention
> > > followed by reset methods which use second function argument to decide
> > > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > > the calling convention of reset methods.
> >
> > > +/**
> > > + * pcie_reset_flr - initiate a PCIe function level reset
> > > + * @dev: device to reset
> > > + * @probe: If set, only check if the device can be reset this way.
> > > + *
> > > + * Initiate a function level reset on @dev.
> > > + */
> > > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > > +{
> > > +	u32 cap;
> > > +
> > > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > > +		return -ENOTTY;
> > > +
> > > +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > > +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> > > +		return -ENOTTY;
> > > +
> > > +	if (probe)
> > > +		return 0;
> > > +
> > > +	return pcie_flr(dev);
> > > +}
> >
> > Tangent: I've been told before, but I can't remember why we need the
> > "probe" interface.  Since we're looking at this area again, can we add
> > a comment to clarify this?
> >
> > Every time I read this, I wonder why we can't just get rid of the
> > probe and attempt a reset.  If it fails because it's not supported, we
> > could just try the next one in the list.
> 
> Part of the reason is to have same calling convention as other reset
> methods and other reason is devices that run in VMs where various
> capabilities can be hidden or have quirks for avoiding known troublesome
> combination of device features as Alex explained here
> https://lore.kernel.org/linux-pci/20210624151242.ybew2z5rseuusj7v@archlinux/T/#mb67c09a2ce08ce4787652e4c0e7b9e5adf1df57a
> 
> On the side note as you suggested earlier to cache flr capability
> earlier the PCI_EXP_DEVCAP reading code won't be there in next version
> so its just trivial check(dev->has_flr).

Sorry, I didn't make my question clear.  I'm not asking why we're
adding a "probe" argument to pcie_reset_flr() to make it consistent
with pci_af_flr(), pci_pm_reset(), pci_parent_bus_reset(), etc.  I
like making the interfaces consistent.

What I'm asking here is why the "probe" argument exists for *any* of
these interfaces and why pci_probe_reset_function() exists.

This is really more a question for Alex since it's a historical
question, not anything directly related to your series.  I'm not
proposing *removing* the "probe" argument; I know it exists for a
reason because I've asked about it before.  But I forgot the answer,
which makes me think a hint in the code would be useful.

Bjorn
