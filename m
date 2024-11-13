Return-Path: <linux-pci+bounces-16681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FD9C7A11
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431BC1F21390
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96600201011;
	Wed, 13 Nov 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj7uk/Cy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD77E111
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519504; cv=none; b=To6fauhDoDjykOC+CvXFpUA4tOBrMB7+1BFQLYEMP4AHnJ32FtritZIZYnMqIRxq9wqYDZLOnrqn2Aptl79H7/Bud3NVJxT0pIj5CuIm7Mh8nHxRU4CACVEIcbcb7Dt681DKcjhKJtTXQfzpwrz0YvZR9ZWvy6afhdEmbvvJC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519504; c=relaxed/simple;
	bh=XcmuGxQ+lEuYXQBQ7q6CmInHfLNiLlOoFBAUSlNEibE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE8aMtZ6kmswQ7VWJrqSf/z6IhsvfnXQphSjc3dNuR97LmjbIAe24SIV2uU1Ix9x+KRF5f40YUzECCwiYxc9Lo1/Jny+yhhnUYJhlDRENRULCIyzsTr27uLgenX8/sycoKIGF4mM4CD2ocVafDQhTHgTNSB2Rw4k4H++p+fKjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj7uk/Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877C2C4CEC3;
	Wed, 13 Nov 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731519504;
	bh=XcmuGxQ+lEuYXQBQ7q6CmInHfLNiLlOoFBAUSlNEibE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dj7uk/Cyd0RW95H2xZZozoHBcRT9H2aMDWy5gEWR5YR4htAQPrLWjmRBU13xbkJSs
	 fLwtSNmFrhZjGNajL5zoIO8f287nBdfX0b4I5b7XJVeplXxQWbB6UGDNpdEbXqagiI
	 yP8EKvn4zyNYwLKCS8pCvXtZMl2zVR3QtXE9K5e5CGzHfz3G6Yfqf0u4RX38rkFzKl
	 o4NIfvXn3+4WGR+YTk1EkcILi3VRbFOKdEYkNtH0UqeE+6DFjgmImMqHu35RPTklVO
	 usTxn5RdxWHz+FBX5YFXf6voReDZj5TlCsNgl0fxidZ5JUQIwmV9V65zgXMgZLn4hb
	 q2P/cFR6TUAsw==
Date: Wed, 13 Nov 2024 10:38:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <ZzTkDVKI-v1TBRdO@kbusch-mbp>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <20241112231623.GA1866148@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112231623.GA1866148@bhelgaas>

On Tue, Nov 12, 2024 at 05:16:23PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 25, 2024 at 03:27:54PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Resetting a bus from an end device only works if it's the only function
> > on or below that bus.
> 
> Can we clarify this wording?  "Resetting a bus from an end device"?

What I mean is, if you find a device you want to reset in the sysfs
hierarchy, and find its reset method:

  /sys/bus/pci/devices/<D:B:D.f>/reset_method

If you request "bus", it only works if it is the only function on that bus.

I agree my commit message there is a bit unclear, though. I was a bit to
deep in that code when I wrote it.
 
> I guess this has something to do with pci_parent_bus_reset(dev), which
> declines to call pci_bridge_secondary_bus_reset() if there are any
> other devices on the same bus as "dev"? 

Yep, exactly.

> pci_parent_bus_reset() is only called from pci_reset_bus_function(),
> which is used by the "bus" and "cxl_bus" reset methods.
> 
> So I guess the point is something like:
> 
>   The "bus" and "cxl_bus" reset methods reset a device by asserting
>   Secondary Bus Reset on the bridge leading to the device.
>   pci_parent_bus_reset() only allows that if the device is the only
>   device below the bridge.
> 
>   Add a sysfs attribute on bridges that can assert Secondary Bus Reset
>   regardless of how many devices are below the bridge.  This makes it
>   possible for users to reset multiple devices in a single command.
> 
> I omitted "safely" because this doesn't do any checking to ensure
> safety, so I don't know in what sense it is safe.

By "safe", what I mean is the device is locked by the kernel, config
space is saved and restored on either side of the reset, and the
attached driver (if any) is notified this action is about to happen and
when it completes so it do whatever quiescent and restoring actions it
needs for a bus reset.

I can't say this is universally "safe" since it's a bit optomistic to
assume everything affected by this action is going to work as the pci
driver expects, but the alternatives (setpci) don't coordinate anything
with the kernel, so it's "safe" relative to that :)

> It seems like this is partly just a convenience, to reset several
> devices at once.
>
> But I think it is *also* a new way to reset devices that we might not
> be able to reset otherwise, e.g., if there's more than one device on
> the bus, and they don't support ACPI, FLR, or PM reset, there
> previously was no reset method that worked at all.  Right?

Exactly! I have multi-function devices in a switch hierarchy where this
unfortunately is really the only way to do it. They don't support
resetting individual functions, so SBR is the only way we have to
reliably reset the device.

