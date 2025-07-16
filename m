Return-Path: <linux-pci+bounces-32338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD76B08087
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D374556806B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7D6290BA5;
	Wed, 16 Jul 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxhFmUcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294B1DE2AD;
	Wed, 16 Jul 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704942; cv=none; b=MOJSy/f+GB5aybguJRHgOXakC7SLKkS3fLMR9Ys8HtFHNpQB/WJd3fFx4fxnOaGcDjU2aFDMhcjEZKVVUqXLHkNUn6KyCUUS8h+X0VX29PJa4TDs+ZI8pdwP/xi1hCh61xTm7yKxPXFUHObcppldhl1kJvXRxpwYBaQ4u4JlAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704942; c=relaxed/simple;
	bh=/K8c9O3faeP5vT2aL2aOt7LnXFCGLEyAU4ITOMMFYzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fyTGpizmH67LacewQK7jZHIm/nk+O1yjDDq/lCC1uR9oMNKnWRbR22gY0DnBQuFm6JUalTnbXHrWKTnvsK/L7BUS/SoZ3OP2gj6MhqF5Bo9LMp8AKBQ/yX0AsMu2p310XCVZX8Vjg5Dm7ByFAdUSMrNixbEVuspdf37ohem8Lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxhFmUcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17132C4CEE7;
	Wed, 16 Jul 2025 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752704942;
	bh=/K8c9O3faeP5vT2aL2aOt7LnXFCGLEyAU4ITOMMFYzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FxhFmUcgz5lIBObgaOcFPRX1BPALU5DeVSI2wSOl8YZwa2oYSVm/tHRNsx33k5W2T
	 oUJA4FDhGAo7j1z8cX8xOlkj6/wmhVyfPHu1x+piN+eM2k6nO0wkYPXU/Wr+hX28mJ
	 myYN2zHEX/PlnQOUclwCOVJM/XUN9DQSvf4ilargewdAF1dxW10cKNnaQ8jcvX73HY
	 OiZlf+PMnxs7Ay6+Nf14nc/x5l0JqD6H6kV1ZrFJPCDKiDkAoEDUyyBdfH6auzzRKv
	 BGQ0qQ2xp6DH1XZ5R+yTOP1NBYZ+chZ47nsgh5g4Wc0hhcP7N+T7QLfgVE3l5K5uUN
	 tB+cEQgJ3aNEw==
Date: Wed, 16 Jul 2025 17:29:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250716222900.GA2556670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715022111-mutt-send-email-mst@kernel.org>

On Tue, Jul 15, 2025 at 02:28:20AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 14, 2025 at 04:13:51PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 14, 2025 at 02:26:19AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > > > > At the moment, in case of a surprise removal, the regular
> > > > > remove callback is invoked, exclusively.  This works well,
> > > > > because mostly, the cleanup would be the same.
> > > > > 
> > > > > However, there's a race: imagine device removal was
> > > > > initiated by a user action, such as driver unbind, and it in
> > > > > turn initiated some cleanup and is now waiting for an
> > > > > interrupt from the device. If the device is now
> > > > > surprise-removed, that never arrives and the remove callback
> > > > > hangs forever.
> > > > > 
> > > > > For example, this was reported for virtio-blk:
> > > > > 
> > > > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > > > 	   complete,
> > > > > 
> > > > > 	2. Now few requests are yet to complete, and surprise removal started.
> > > > > 
> > > > > 	At this point, virtio block driver will not get notified by the driver
> > > > > 	core layer, because it is likely serializing remove() happening by
> > > > > 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> > > > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > > > 	for requests completions to arrive which it never gets.  So
> > > > > 	del_gendisk() gets stuck.
> > > > > 
> > > > > Drivers can artificially add timeouts to handle that, but it can be
> > > > > flaky.
> > > > > 
> > > > > Instead, let's add a way for the driver to be notified about the
> > > > > disconnect. It can then do any necessary cleanup, knowing that the
> > > > > device is inactive.
> > > > 
> > > > This relies on somebody (typically pciehp, I guess) calling
> > > > pci_dev_set_disconnected() when a surprise remove happens.
> > > > 
> > > > Do you think it would be practical for the driver's .remove() method
> > > > to recognize that the device may stop responding at any point, even if
> > > > no hotplug driver is present to call pci_dev_set_disconnected()?
> > > > 
> > > > Waiting forever for an interrupt seems kind of vulnerable in general.
> > > > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > > > forever for interrupts?  That doesn't seem artificial to me because
> > > > it's just a fact of life that devices can disappear at arbitrary
> > > > times.
> > > > 
> > > > It seems a little fragile to me to depend on some other part of the
> > > > system to notice the surprise removal and tell you about it or
> > > > schedule your work function.  I think it would be more robust for the
> > > > driver to check directly, i.e., assume writes to the device may be
> > > > lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
> > > > never wait for an interrupt without a timeout.
> > > 
> > > virtio is ... kind of special, in that users already take it for
> > > granted that having a device as long as they want to respond
> > > still does not lead to errors and data loss.
> > > 
> > > Makes it a bit harder as our timeout would have to
> > > check for presence and retry, we can't just fail as a
> > > normal hardware device does.
> > 
> > Sorry, I don't know enough about virtio to follow what you said about 
> > "having a device as long as they want to respond".
> > 
> > We started with a graceful remove.  That must mean the user no longer
> > needs the device.
> 
> I'll try to clarify:
> 
> Indeed, the user will not submit new requests,
> but users might also not know that there are some old requests
> being in progress of being processed by the device.
> The driver, currently, waits for that processsing to be complete.
> Cancelling that with a reset on a timeout might be a regression,
> unless the timeout is very long.

This seems like a corner case and maybe rare enough that simply making
the timeout very long would be a possibility.

> > > And there's the overhead thing - poking at the device a lot
> > > puts a high load on the host.
> > 
> > Checking for PCI_POSSIBLE_ERROR() doesn't touch the device.  If you
> > did a config read already, and the result happened to be ~0, *then* we
> > have the problem of figuring out whether the actual data from the
> > device was ~0, or if the read failed and the Root Complex synthesized
> > the ~0.  In many cases a driver knows that ~0 is not a possible
> > register value.  Otherwise it might have to read another register that
> > is known not to be ~0.
> 
> To clarify, virtio generally is designed to operate solely
> by means of DMA and interrupt, completely avoiding any PCI
> reads. This, due to PCI reads being very expensive in virtualized
> scenarios.
> 
> The extra overhead I refer to is exactly initiating such a read
> where there would not be one in normal operation.

Thanks, this part is very helpful.  And since config accesses are very
expensive in *all* environments, I expect most drivers for
high-performance devices work the same way and only do config accesses
during at probe time.

If that's true, it will make this more understandable if the commit
log approaches it from that direction and omits virtio specifics.

Bjorn

