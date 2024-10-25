Return-Path: <linux-pci+bounces-15346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B39B0B12
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFF5B20E71
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147620F3D9;
	Fri, 25 Oct 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z24RvjrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8A20F3D7
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876557; cv=none; b=dL3se8DPP057KdtVjBdraTfeUrbP3+drZQ6izTZz+ChRgQ0MhGQUzNpMuH3DiGisqvoEPTK/GGXT+PVrlOGiz25HJHP+chtfxWOmTw5T5bWyUppnyu5hCXAav8OReY/HDnd8BDWwmYdHax+MXoo+Ka/svG5CnDy+Hb9N1/ckn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876557; c=relaxed/simple;
	bh=yNREZ1KWcRzZAJcWPj3CZ/19R5KrhNNzuyPaua8tY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNvkfccrRZ5LtSijG2IVvdmZyG2OZYHMbWu7chR2HZm3aGt++hb6CzaNpXG+nDcyhnEbAKNjgXczFtKee18jFySMrXCQMDmuLyd5O0FRCBPoHb8YqnNyreD/4EL/AuCJBYCYEs7vdh7m6thHS40taSpZfTH5Av0uKMbWbLSd5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z24RvjrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01168C4CEC3;
	Fri, 25 Oct 2024 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729876556;
	bh=yNREZ1KWcRzZAJcWPj3CZ/19R5KrhNNzuyPaua8tY7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z24RvjrApipy4MXX63Sdft5xs+kd5v0O+AllznrCEwt/1MJvnvW/H3tz6ZAnZZHbw
	 Bh14tY00VqDZLO/80YOlxLiA6rnEHiH80i3fe9k7M0MwMNg5oUH/HgjQhQuqiuB/kT
	 RT1L29XKVuR5lIP53DOA0r9J+xeZVBUxhAPaTfmq2+RnvN6yHxtQhAqnmB69Npmh3e
	 Q9NwLTtblV+Sne9UxefdOqzGzx70tnrn+w1gq0O4uVwpH3G8w3Xebmbhb/ip4M2euo
	 ZadTmByZrNqsrl3JdsPBmW4AdWhy66y+L0x2SrDSR0APBrXY5VGQ82lchF0BUHM2Do
	 ERVyIotdgXJGA==
Date: Fri, 25 Oct 2024 11:15:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Alex Williamson <alex.williamson@redhat.com>,
	Amey Narkhede <ameynarkhede03@gmail.com>,
	Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] pci: provide bus reset attribute
Message-ID: <ZxvSSQ6zh45TiwLh@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025145021.1410645-1-kbusch@meta.com>
 <20241025165725.GA1025232@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025165725.GA1025232@bhelgaas>

On Fri, Oct 25, 2024 at 11:57:25AM -0500, Bjorn Helgaas wrote:
> [+cc Alex, Amey, Raphael]
> 
> On Fri, Oct 25, 2024 at 07:50:21AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Attempting a bus reset on an end device only works if it's the only
> > function on or below that bus.
> > 
> > Provide an attribute on the pci_bus device that can perform the
> > secondary bus reset. This makes it possible for a user to safely reset
> > multiple devices in a single command using the secondary bus reset
> > method.
> 
> I confess to being a little ambivalent or even hesitant about
> operations on the pci_bus (as opposed to on a pci_dev), but I can't
> really articulate a great reason, other than the fact that the "bus"
> is kind of abstract and from a hardware perspective, the *devices* are
> the only things we can control.

If you prefer, this could probably be a pci_dev attribute specific to
bridges. Maybe we call it "reset_subordinate" to make it different than
the existing "reset" attribute.

> I assume this is useful in some scenario.  I guess this is root-only,
> so there's no real concern about whether all the devices are used by
> the same VM or in the same IOMMU group or anything?

Yes, definitely root only. The concern for misuse is real, so must be
used carefully. If you have binded drivers that are not ready for this,
it may get confused. The same thing could happen with existing
function-level resets though too. Making this operate on the bus just
has potentially larger blast radius if you reset the wrong bus.

It is still useful. Ioctl VFIO_DEVICE_PCI_HOT_RESET also eventually
calls __pci_reset_bus(), but this gets the same thing without having to
bind all the functions to vfio.

