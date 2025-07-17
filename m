Return-Path: <linux-pci+bounces-32472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C540AB098A9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67FB168EFF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B324110F;
	Thu, 17 Jul 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvSSS9Hd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38749641;
	Thu, 17 Jul 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796257; cv=none; b=leFYnNanpFa69dNx8QHoL18dexMVbDTsSmoz90GQUA2eioYTh+KCxhY8x/rTSXgQ4/fouPf+1SJAXQlUG1WPq1SySKskCmzwAaXW8+rpVThKoSX0DUn0rUd6iqVeVeThVRKxpjar9tX1Q7B5nQ3n5VymOvvpbtljSGDHbJhsccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796257; c=relaxed/simple;
	bh=yBQKMNb9DUXYd65FGm7e8gSB0moGjWwDMSH57CnD83s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H3wOji1Ja4HIWotOpu/LaKycJoa98UFF/TXbKPJHuxms33fniZ9pP6sxO/EMtg4GD9SCVs7j99wNXlr7ToLww9iapO69I5AppBEex56sVbhWhfD1ndRgqpfpV3qoI9T+gfOsVG6fYytxfhl8T0JilX0Qwf6UjtHMdzrN96Ehgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvSSS9Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFECC4CEE3;
	Thu, 17 Jul 2025 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796257;
	bh=yBQKMNb9DUXYd65FGm7e8gSB0moGjWwDMSH57CnD83s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qvSSS9HduJBUOlQa9uG4CkAI+RiOqYTQvUxJalwfD8SIjIEsWHtgVhSHnAnvw9GmO
	 b7p9AkBnWADZRC0/CVIxf5cmnTHAzmJlB7ri6y/mzXjGwWxwuV/Xj9KJl4WNXiY9fN
	 4YVZYtUupcbd880X3zGusjHieRY5x/JtIcCsouKc6Iw4Cv0VP2psC/8pblUuSeId2j
	 L9UKIb2x5q0pdoVKLagWQBs+ClgJwxkWgUEyiRwMmIWATAUNilg3kVvyrgMIiVdV/u
	 e9TjOmxb4TbPBVqwTr7x3fGVspeLB353mi/MXw35B285pBl8ranuBey3ZBcZ6XG4dm
	 SbdxBA+P3UA4A==
Date: Thu, 17 Jul 2025 18:50:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: lukas@wunner.de, anil.s.keshavamurthy@intel.com, bhelgaas@google.com,
	bp@alien8.de, davem@davemloft.net, ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naveen@kernel.org, oleg@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	tianruidong@linux.alibaba.com, tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250717235055.GA2664149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717232758.24605-1-mattc@purestorage.com>

On Thu, Jul 17, 2025 at 05:27:58PM -0600, Matthew W Carlis wrote:
> On Thu, 17 Jul 2025, Bjorn Helgaas wrote:
> > - slot_name() (which I think comes from make_slot_name(); would you
> >   want something else?)
> 
> afaik it ends up coming from the Slot Cap Register "Physical Slot
> Number" bits.  I brought up the slot to just say that I was happy to
> see it & that it is useful for our purposes & why.

I don't think slot_name() is directly from Physical Slot Number
because there's nothing to guarantee that is unique.  I think
make_slot_name() starts with PSN but does add things to make sure the
name unique.

> On Thu, 17 Jul 2025, Lukas Wunner wrote:
> >> and IIUC, it would be helpful for you to add:
> ...

> >>   - USP/EP Vendor/Device ID
> >
> > There's no 1:1 relation between link or presence events on the one
> > hand, and enumeration of hotplugged components on the other hand:
> > The link may go up but the kernel may fail to enumerate the
> > component, e.g. because it was yanked before it could be
> > enumerated, or because the kernel has run out of MMIO space or bus
> > numbers.
> > 
> > Hence this would have to be logged through a separate tracepoint
> > in pciehp_configure_device(), not by changing the tracepoints
> > added here.

> Ok I think its reasonable to use a separate tracepoint that would have more
> information about the EP.

So I think your idea of adding current link speed/width to the "Link
Up" event is still on the table, and that does sound useful to me.

In the future we might add another tracepoint when we enumerate the
device and know the Vendor/Device ID.

Bjorn

