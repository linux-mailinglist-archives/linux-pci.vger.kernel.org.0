Return-Path: <linux-pci+bounces-23867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0872CA63290
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A253B587A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FDB1A0BE0;
	Sat, 15 Mar 2025 21:13:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE1197A8E;
	Sat, 15 Mar 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742073180; cv=none; b=q5VDmYCnlUoVWb4klJCLGtPSe8MxgHO9bTRIB5B7ofsNW6vPeT3mV5AJB6+hu8tOHHOtxP9MKLbXR3adk1WsQjWcKi0yMjY+d1JFNgo9+jBJQPCO2opWyaa2S373IqR9AteeLy+ZN9/Z3DhFRtRA79kmlI+GBZ6aV8xSAINectM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742073180; c=relaxed/simple;
	bh=DgGL/JgFUQpUq9OIXVfSqWVLaGTnhUc8MCtaagt/zX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlBGem9h9BrPpuUWV2VhJBObORKOMFy9hIlztCTSfAMxbnGZ+z4tG2pfExB1xoEpj7iVzHWdSIX283ibNkD+2nT61CkZSj/b7PPz/ljdD+13HpnbJ8yvTGVeiWjWtHIKX0t1/LVa9n1piWI8TlPikKz/+5qb2uujw32vczxEFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6E713100DA1BC;
	Sat, 15 Mar 2025 22:12:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 39DF711229; Sat, 15 Mar 2025 22:12:48 +0100 (CET)
Date: Sat, 15 Mar 2025 22:12:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: proxy0@tutamail.com
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Pci <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] PCI/hotplug: Disable HPIE over reset
Message-ID: <Z9XtUH55s9OZAPvK@wunner.de>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
 <20250313142333.5792-2-ilpo.jarvinen@linux.intel.com>
 <Z9Wjk2GzrSURZoTG@wunner.de>
 <OLQ9qyD--F-9@tutamail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OLQ9qyD--F-9@tutamail.com>

On Sat, Mar 15, 2025 at 07:57:55PM +0100, proxy0@tutamail.com wrote:
> Mar 15, 2025, 9:28 PM by lukas@wunner.de:
> > After dwelling on this for a while, I'm thinking that it may re-introduce
> > the issue fixed by commit f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock
> > between reset_lock and device_lock"):
> >
> > Looking at the second and third stack trace in its commit message,
> > down_write(reset_lock) in pciehp_reset_slot() is basically equivalent
> > to synchronize_irq() and we're holding device_lock() at that point,
> > hindering progress of pciehp_ist().
> >
> > So I think I have guided you in the wrong direction and I apologize
> > for that.
> >
> > However it seems to me that this should be solvable with the small
> > patch below.  Am I missing something?
> >
> > @Joel Mathew Thomas, could you give the below patch a spin and see
> > if it helps?
> 
> I've tested the patch series along with the additional patch provided.
> 
> Kernel: 6.14.0-rc6-00043-g3571e8b091f4-dirty-pci-hotplug-reset-fixes-eventmask-fix
> 
> Patches applied:
> - [PATCH 1/4] PCI/hotplug: Disable HPIE over reset
> - [PATCH 2/4] PCI/hotplug: Clearing HPIE for the duration of reset is enough
> - [PATCH 3/4] PCI/hotplug: reset_lock is not required synchronizing with irq thread
> - [PATCH 4/4] PCI/hotplug: Don't enable HPIE in poll mode
> - The latest patch from you:
> +	/* Ignore events masked by pciehp_reset_slot(). */
> +	events &= ctrl->slot_ctrl;
> +	if (!events)
> +		return IRQ_HANDLED;

Could you test *only* the quoted diff, i.e. without patches [1/4] - [4/4],
on top of a recent kernel?

Sorry for not having been clear about this.

I believe that patch [1/4] will re-introduce a deadlock we've
already fixed two years ago, so the small diff above seeks to
replace it with a simpler approach that will hopefully avoid
the issue as well.

Thanks,

Lukas

