Return-Path: <linux-pci+bounces-12702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1196AA36
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140D01F25BD3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A427126BE3;
	Tue,  3 Sep 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEFb0OGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D623D7;
	Tue,  3 Sep 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399163; cv=none; b=aR+NTY16bqLrtlHJ0a6jMqfdHeckLoNh4T3QymZ5mDJT31uZS2MN29sXQcvlr83HRh9U0aP98UOqn80ULxlcTuaw77gOmzQ4JQsgFsOpmlhEgISJHNSUtQTPeHU3yEqYQRVhidh2MELwKlAFNH9RJ3nfrRwBuDzgiU/bw3hhTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399163; c=relaxed/simple;
	bh=1PUjVCqjErd2tSXMz7+npk0yPYPdMQTbhHntugIF9E4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WzRAHFBS2W+njdTQ8Y6k2lDPKTKu0zkNb8rcZUKKcxOhl1NJLJEu9jw2VSDEoSrcupeoLfvlTCRNzn74ghq2+IfT6UBhKAOj/JXfyUtkcMzlyHcfw77LwEK78ENlv1qs+uzsfE7kuP410ofIHSARqcyl+nhxW9yDpQgej9y2iQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEFb0OGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B05C4CEC4;
	Tue,  3 Sep 2024 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725399162;
	bh=1PUjVCqjErd2tSXMz7+npk0yPYPdMQTbhHntugIF9E4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YEFb0OGD6Xk6NFc6FGeJSC7MBhKOOlQV4XpIj0igsjreZXQHcGLCQbsx/LRP/3I+o
	 +qm4hZAy6JYsQuPQlOZAMO+kr6A3y62hFTpc/awuwWdmXjMjcZpIc2vI0qnTHmbOL9
	 SwoCpd6UtUbzqoYTzAxdqKI5p/q3uoo7djbjKCa1KB9Pl+OAfq5jKt6FhrJIcgF2/h
	 qLRCh5xHwJwL8yuRCKCF8Z5uc8QbXKbu3wBEQ9IcLuK9Byd+MhefqE3UtrLbLSPMKy
	 aVdeZdRg6YC2W459wIRs9HgJ0Vqw/tjICZCcwj0wVUYEVtJ8LgiaoIrtis1kd2Vd28
	 Mnoo+4F/cu64g==
Date: Tue, 3 Sep 2024 16:32:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Gary Li <Gary.Li@amd.com>, Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240903213240.GA304079@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>

On Tue, Sep 03, 2024 at 01:32:30PM -0500, Mario Limonciello wrote:
> On 9/3/2024 13:25, Bjorn Helgaas wrote:
> > On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
> > > On 9/3/2024 12:11, Bjorn Helgaas wrote:
> > > ...
> > 
> > > >     8) The USB4 stack sees the device and assumes it is in D0, but it
> > > >     seems to still be in D3cold.  What is this based on?  Is there a
> > > >     config read that returns ~0 data when it shouldn't?
> > > 
> > > Yes there is.  From earlier in the thread I have a [log] I shared.
> > > 
> > > The message emitted is from ring_interrupt_active():
> > > 
> > > "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
> > 
> > Right, that's in the cover letter, but I can't tell from this what the
> > ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
> > MMIO read of BAR 0, not a config read.
> 
> Yeah.  I suppose another way to approach this problem is to make something
> else in the call chain poll PCI_PM_CTRL.
> 
> Polling at the start of nhi_runtime_resume() should also work.  For the
> "normal" scenario it would just be a single read to PCI_PM_CTRL.

It doesn't sound like this is anything specific to Thunderbolt, so
there should be a generic solution.

