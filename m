Return-Path: <linux-pci+bounces-32451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE1B0959D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CAC1C4566C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A004F1DB127;
	Thu, 17 Jul 2025 20:19:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC11A314E;
	Thu, 17 Jul 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783596; cv=none; b=HVa6LGqGeDM6i6fcU2INN6HQm7wxpoXsRhv6L6FK4IZP3bCgI5qxNK7qM4ldxye+lmRFDWFwBEq4NxrPw7yMEFjwpOi6JjzRUGBUNmn4bMYlmaKYKI4kMeCljDLpG354/Yhap23UBKihKAqHyRIlGdTGi8xId7kGbued5c99VKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783596; c=relaxed/simple;
	bh=ll4zLSoP/0JpovnjsFh1zK3OUkZpkwvJfmXIVQd06uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr9I7uSoze1QNTa8Ea+zFN+U1XTaTM91+MRCodZcQ0I+eH7RePqhaMHsYkF+hFTqpDZsSl+JhKzg7utHzsntnflGJaJVfyZr61uB/axadPtxl+qiKg5M6QKDJaD1QaFyMWSxTHFVaH19fEjQKHWxIoj542HoBW8xkeOQB4ocyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 979162C0646D;
	Thu, 17 Jul 2025 22:12:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7BA6044FAC7; Thu, 17 Jul 2025 22:12:03 +0200 (CEST)
Date: Thu, 17 Jul 2025 22:12:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <aHlZE18kPuHuDtTT@wunner.de>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717091025-mutt-send-email-mst@kernel.org>

On Thu, Jul 17, 2025 at 11:11:44AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> > On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > > At the moment, in case of a surprise removal, the regular remove
> > > callback is invoked, exclusively.  This works well, because mostly, the
> > > cleanup would be the same.
> > > 
> > > However, there's a race: imagine device removal was initiated by a user
> > > action, such as driver unbind, and it in turn initiated some cleanup and
> > > is now waiting for an interrupt from the device. If the device is now
> > > surprise-removed, that never arrives and the remove callback hangs
> > > forever.
> > 
> > For PCI devices in a hotplug slot, user space can initiate "safe removal"
> > by writing "0" to the hotplug slot's "power" file in sysfs.
> > 
> > If the PCI device is yanked from the slot while safe removal is ongoing,
> > there is likewise no way for the driver to know that the device is
> > suddenly gone.  That's because pciehp_unconfigure_device() only calls
> > pci_dev_set_disconnected() in the surprise removal case, not for
> > safe removal.
> > 
> > The solution proposed here is thus not a complete one:  It may work
> > if user space initiated *driver* removal, but not if it initiated *safe*
> > removal of the entire device.  For virtio, that may be sufficient.
> 
> So just as an idea, something like this can work I guess?  I'm yet to
> test this - wrote this on the go -

Don't bother, it won't work:

pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
the IRQ thread.  During safe removal the IRQ thread is busy in
pciehp_unconfigure_device() and waiting for the driver to unbind
from devices being safe-removed.

An IRQ thread is always single-threaded.  There's no second instance
of the IRQ thread being run when another interrupt is signaled.
Rather, the IRQ thread is re-run when it has finished.

In *theory* what would be possible is to plumb this into pciehp_isr().
That's the hardirq handler.  This one will indeed be run when an
interrupt comes in while the IRQ thread is running.  Normally the
hardirq handler would just collect the events for later consumption
by the IRQ thread.  The hardirq handler could *theoretically* mark
devices gone while they're being safe-removed.

I'm saying "theoretically" because in reality I don't think this is
a viable approach either:  pciehp_ist() contains code to *ignore*
link or presence changes if they were caused by a Secondary Bus Reset
or Downstream Port Containment.  In that case we do *not* want to mark
devices disconnected because they're only *temporarily* inaccessible.
This requires waiting for the SBR or DPC to conclude, which can take
several seconds.  We can't wait in the hardirq handler.

So this cannot be solved with the current architecture of pciehp,
at least not easily or in an elegant way.  Sorry!

Thanks,

Lukas

