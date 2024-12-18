Return-Path: <linux-pci+bounces-18715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304EA9F6A5D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345971888447
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8A1C5CD5;
	Wed, 18 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1X68Rp2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HV5Tkha6"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE301591EA;
	Wed, 18 Dec 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536923; cv=none; b=jRy5i4y+qYYD9W57H+HSa4KAbW6L22bfvB7RtjazFXAXMzSueTUf0LjqGgBGbA6mx77btyrkE9LDfQ25Gf8n0Dnh5lN4qRYKG3ZBHnIJ77rkcCWshZPvHW0z29ubx7LvzKliUOAfNluTz5Eukhpa48zB5VFQEJFw6iHC7Suj+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536923; c=relaxed/simple;
	bh=v4KW4a2ZzlYBR6IC0xswaOVeQ/17SYlckND+fC435AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BirqQHeboetknatg0ncs8+nxnHsKfRhFlXENT19FOuFNdQB2pjoYKuLs8DTO4nYovgNi0W2QnbHZnO5UXCMnXMazpF4YuNUAingANErKRwV3dcwVXei5fX3oHbKRLOoyJN/MIVIit2gpLmxlLVZoiWL5V2xhEwQH9BAqDHeyOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1X68Rp2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HV5Tkha6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 16:48:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734536920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BWnfq2GsOph6VXBhPi2FwPjHFapGP6iY3zUQsVIzY=;
	b=1X68Rp2uBsj3cF2PEUpk9Tv/iPcgUWK+PcMgbi27ryPKAlD0xfygNiojMlzxqEFWZt+rst
	Rzccb00d00TR4fucEYLFreAZM5ZdfqQkbREAmc1gOiV6QAjsfJBDJV/+EzIJEekG3QnWH3
	U7AvKvHOqG1odKwlk6vjazezINBnGQwIgRg6u0Tb73BLE6glH5scaUoWI0fIRpky9v97PU
	e8ibIKkD/H6GLChUdbA7bQ4ld2G0Hd3IlqOwlAWiCt5GDnExVBVa9o0stvzFnl5RuTkSeY
	UZ02mZTUWYPG8eZLu9K/UZ/OdnZkQAUceaKyTCC7opGogAjwmUZS9/cqOKpDgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734536920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BWnfq2GsOph6VXBhPi2FwPjHFapGP6iY3zUQsVIzY=;
	b=HV5Tkha6pPbyQo/o16Yy9gmnRf0MKAK5+o0S1l0XuydsqdNiGNlD8rIPb2xjKft98wyn9V
	TKScU9Ma7zYR6/BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, lgoncalv@redhat.com,
	bhelgaas@google.com, jonathan.derrick@linux.dev, kw@linux.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com, robh@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <20241218154838.xVrjbjeX@linutronix.de>
References: <20241218115951.83062-1-ryotkkr98@gmail.com>
 <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>

On 2024-12-18 08:36:54 [-0700], Keith Busch wrote:
> On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
> > PCI config access is locked with pci_lock which serializes
> > pci_user/bus_write_config*() and pci_user/bus_read_config*().
> > The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
> > serialized as they are only invoked by them respectively.
> > 
> > Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
> > for their serialization as its already serialized by pci_lock.
> 
> That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
> won't help with concurrent kernel config access in such a setup. I think
> the previous change to raw lock proposal was the correct approach.

I overlooked that. Wouldn't it make sense to let the vmd driver select
that option rather than adding/ having a lock for the same purpose?

Sebastian

