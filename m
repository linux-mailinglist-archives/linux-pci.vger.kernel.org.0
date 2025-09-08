Return-Path: <linux-pci+bounces-35671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0EB491E1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E880A189B531
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275430B500;
	Mon,  8 Sep 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBS/Rsse"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD222A4EB;
	Mon,  8 Sep 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342515; cv=none; b=krePh76x6YgMjV9UztuTQFa/rxncX7e0G3nXWmVtLWMMkZy1uSG5D9GWeL+4xO/uuw/dOOeac23jgVnK51ZkrI1uZrFVmsa5kpvcsZ45j8iwYcj9pXZRSXCLyEkLPPcOmpcpyuPx4jt/XIxI795fywcRCTdsVllfXWL9g8NaIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342515; c=relaxed/simple;
	bh=QA8+1tr7brTem22zB+pPbb3Pb/1XaSIDYubStR1J+c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9h1vUkiyGhrXG2qi6p0IMMyzK5eQ+l05MRgA2UcJVRhhGeqWYFU45OrL5V2DArWVYzwYzGLF59HY5XWQtWEWu2F5PFLEnkyYMrFFLzy3gQlizpZeJgKonYZi9Bz7b8zg0Li596l2e8cqVTMSnw7E0H8GiFE9o7L0CsBYwV/Bmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBS/Rsse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F82C4CEF1;
	Mon,  8 Sep 2025 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757342515;
	bh=QA8+1tr7brTem22zB+pPbb3Pb/1XaSIDYubStR1J+c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBS/RssesVLX/VJuLdbwuauXCp03O+vb5iBteVppwG8XWw5JLrnwqRGjbcD6uI3If
	 MbUR4xwEEj0zSfxeWEY3sYsI+AkUMpVhLJGvsaMfS4Azp9JIR8CF5qsqTs5VAsS2nn
	 5d5wpyksQDJFegCKprTXVt6aH0twfYOCyCDr0oXc=
Date: Mon, 8 Sep 2025 16:41:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>
Subject: Re: [PATCH v6 RESEND 00/11] Improvements to S5 power consumption
Message-ID: <2025090839-desktop-ladder-c2f7@gregkh>
References: <20250906143642.2590808-1-superm1@kernel.org>
 <2025090852-coma-tycoon-9f37@gregkh>
 <af78dfb4-de61-4b8c-a131-cf39a4c3c4b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af78dfb4-de61-4b8c-a131-cf39a4c3c4b0@kernel.org>

On Mon, Sep 08, 2025 at 07:39:07AM -0500, Mario Limonciello wrote:
> 
> 
> On 9/8/25 4:19 AM, Greg Kroah-Hartman wrote:
> > On Sat, Sep 06, 2025 at 09:36:31AM -0500, Mario Limonciello (AMD) wrote:
> > > A variety of issues both in function and in power consumption have been
> > > raised as a result of devices not being put into a low power state when
> > > the system is powered off.
> > > 
> > > There have been some localized changes[1] to PCI core to help these issues,
> > > but they have had various downsides.
> > > 
> > > This series instead tries to use the S4 flow when the system is being
> > > powered off.  This lines up the behavior with what other operating systems
> > > do as well.  If for some reason that fails or is not supported, run their
> > > shutdown() callbacks.
> > > 
> > > Cc: AceLan Kao <acelan.kao@canonical.com>
> > > Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> > > Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> > > Cc: Eric Naim <dnaim@cachyos.org>
> > > ---
> > > v6 RESEND:
> > >   * Resent because Greg said he was ignoring it and would like the whole
> > >     series to be able to review.
> > 
> > Messy, but wow, I'll trust you all that this actually works properly.
> 
> Yes; I double checked from a UART log all devices (now) went to correct
> state and from power measurement hardware the respective drop in power.
> 
> I will note I have a sampling bias of hardware being x86 AMD hardware.
> Some of the testers of the series also tested Intel hardware which had
> similar power consumption problem, and I know there were improvements there
> too.
> 
> We probably will have to wait for linux-next for non-x86 hardware coverage.
> > No objections from me, but I don't want my ack on this as I don't know
> > how to maintain it :)
> > 
> 
> I mean - if all goes well even a failed S4 flow should fall back to old path
> shutdown.  I *did contrive some failures* in an earlier version of the
> series and confirmed in the UART log it emitted the printk that it was
> falling back to shutdown.
> 
> I had two ideas that maybe could help for regression risk though:
> 1) I could add a shutdown= kernel parameter.  I'm not sure what words to use
> for the two paths but the idea would be if someone had a shutdown failure
> they could isolate if it's due to this by adding the parameter.
> 
> 2) I could make a Documentation/ file explaining some examples how to get
> the shutdown log saved to pstore in case they don't have a UART available.

This second one is probably the best.  A new command line is not going
to probably be used and just be a pain to maintain over time.

thanks,

greg k-h

