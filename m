Return-Path: <linux-pci+bounces-7096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C68BBF93
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 09:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0923B210A9
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52885680;
	Sun,  5 May 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDAK7KRb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gw6Wwoob"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F93FF1;
	Sun,  5 May 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714893303; cv=none; b=meFFJFMAeWo7MS3ephiyWV/WFdSCSBFqorNPxFY9SYVDBVzX30Y/V5JAkYxpEvLkyrPQa3G7ylyWkpBF4KDGC12J2mxVv7LneG4LKU9M6wAqpqR7hplsEpRemlSoFH2frr1MhtczBmGQwGoN+RK9z59TbaMzhjSy40IqZRdF3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714893303; c=relaxed/simple;
	bh=BVulq7jvYuSNxOCvmVODwOqwRezoCdGLo5njSKRe/DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9e1oIq1R4TkDp583mkOj2g0kgqfh8upb1ORLP0yzBsFQarbEimLnP5LWUXfHyNMVZ1C2hoSwpOhkqijOttluhzppUqgjamAW7UtSGr0FzrtRqgN8XxPsazHyjHDOEueUNC2AVr7OKbDFjiCU21Ub/xDLzf04b1gBEm4yH7lVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JDAK7KRb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gw6Wwoob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 5 May 2024 09:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714893300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPPN98n3jaxZR8yyofe2Aj3eekBABTkauLh4tcAwKyA=;
	b=JDAK7KRbtWNUXclDcXtHA//xuYI+UbDN+sGfixY0JHFlRJ/TQOLd8i8FijYmHUp7XKDEWT
	pgkRD5JmA74lE9gaBiHXkXxGYWdZGTa39B2Mr3YanduB2RBCv29fTGxwY/7g9ePSWxEs3e
	0kJc6isyGtihXl+XdB9yt15z8fwijzQ0TJD1I4FOinGGQMT887qY8+X+Uc8kL/wV6UB1Hj
	Yg+7M/JN7YJyIEhdR3hE/mq68czn63OXcdbuKWfeVngy2JbUB2l3oeKzhP4JM7Svo95PX3
	ZCffDiABwpMolPwe+pquS1UndpWX5IcFuH5MHA8BcUNIhvudc1cwwPu9dbVosg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714893300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPPN98n3jaxZR8yyofe2Aj3eekBABTkauLh4tcAwKyA=;
	b=Gw6WwoobMQRe4UXyd+Nfolnqlj4O4LFHvIsP1eIgFa/HxzS6i7LviYWW2xrneOvR6ORJmY
	0TguC+r/tPC0n2Dw==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <20240505071451.df3l6mdK@linutronix.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjcc6Suf5HmmZVM9@wunner.de>

On Sun, May 05, 2024 at 07:45:13AM +0200, Lukas Wunner wrote:
> On Sat, May 04, 2024 at 06:15:22PM +0200, Nam Cao wrote:
> > If a bridge is hot-added without any bus number available for its
> > downstream bus, pci_hp_add_bridge() will fail. However, the driver
> > proceeds regardless, and the kernel crashes.
> [...]
> > Fix this by aborting the hot-plug if pci_hp_add_bridge() fails.
> [...]
> > --- a/drivers/pci/hotplug/pciehp_pci.c
> > +++ b/drivers/pci/hotplug/pciehp_pci.c
> > @@ -58,8 +58,10 @@ int pciehp_configure_device(struct controller *ctrl)
> >  		goto out;
> >  	}
> >  
> > -	for_each_pci_bridge(dev, parent)
> > -		pci_hp_add_bridge(dev);
> > +	for_each_pci_bridge(dev, parent) {
> > +		if (pci_hp_add_bridge(dev))
> > +			goto out;
> > +	}
> >  
> >  	pci_assign_unassigned_bridge_resources(bridge);
> >  	pcie_bus_configure_settings(parent);
> 
> Are the curly braces even necessary?

Nope. I thought this is the kernel's coding style, since checkpatch.pl
didn't complain. But checkpatch also doesn't complain after I remove it,
so no I guess that's not necessary.

> FWIW, the rationale for returning 0 (success) in this case is that
> pciehp has done its job by bringing up the slot and enumerating the
> bridge in the slot.  It's not pciehp's fault that the hierarchy
> cannot be extended further below the hot-added bridge.
>
> Have you gone through the testing steps you spoke of earlier
> (replacing the hot-added bridge with an Ethernet card) and do
> they work correctly with this patch?

Yes.

> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks for the review. I will send v3 with the brackets removed.

Best regards,
Nam

