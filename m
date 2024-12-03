Return-Path: <linux-pci+bounces-17609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB49E2F95
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CB8164BAF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19E20899C;
	Tue,  3 Dec 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGdF7Wd4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+74efFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A691EF096;
	Tue,  3 Dec 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267669; cv=none; b=F3BgDTKIyJtU3mmlw1UUP0dW+8XzWLg2rW44FFhKWrcuVqmOl/8eLOWF5wmP19mmGSeAd2i0WXubgt71tzCFEUhU9zlFLQt0kd3/R36SMVTZfaeZBnMnATNKeJHEkP6uCXK6WiDn1y0mULQIcqtfrbUnaIfdoMDJnPh4TvDqKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267669; c=relaxed/simple;
	bh=P9I8+Rvwv/9S/ZImA3AtB2up+Y15XK414ln9rAgTeJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BooaobpcC2X/LWRE0z4Xn1bqbvGEwTToGQDbB49lQYytiGy3ul0PaTt7kjG0pjLyMWjyA3MroP7VrTQxB8sloPr+xkj2tWNfjMNtJfzTnRlMDA37IA/m/jUgiLP+VCCSagCFzGcefpBYNfRRr3HuqRjp/a9zEartoT5E+HhGXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGdF7Wd4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+74efFb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733267666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwG8bjCzJpnjiYjQenvpNH701rJgmgaojMUFj2iL/Vc=;
	b=uGdF7Wd4Kue1Y0fcH2j/hkgoB/fhGzmQswuYBdLkhxtekcrOpOWrejr9iW9UiCZYq5AGmM
	0QjZuljhk/UjVn0VvpNp1WxWrpJPU0Qo5wZpmjUL3iGPnoOVty7mBF+suZuYoxsu+xIf9r
	eSx5IBQw/DdQ8jVXNczsF6J/aqQFAc5kTZZ3KrMAuEKM7fEPhwrDKfQUoTkH/PcZzHRoEo
	XL1gCR/AvJqHFyDXyOU0eKIcD1sZ35NXCnRDthGDE00tn64YvMPZGpcS0dXnWxLzZV11fW
	lajQLWKPNR33WvQAu3wnHmWJ1qTZBWxe/WdCirZZUWzNfBtYieLmlmmdEpNkkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733267666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwG8bjCzJpnjiYjQenvpNH701rJgmgaojMUFj2iL/Vc=;
	b=I+74efFbzlOGTz6lDCdzXKlbP5s1uQOdQ+XY7NBpJW/7xbOUY3Tqaz88xFpCQIAOzVf4pg
	DpwZXD4F62cEbYBQ==
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us, stable@kernel.org
Subject: Re: [PATCH v9 1/6] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
In-Reply-To: <Z096wCMFmR7AyfWn@lizhi-Precision-Tower-5810>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com> <87y10wsc6z.ffs@tglx>
 <Z096wCMFmR7AyfWn@lizhi-Precision-Tower-5810>
Date: Wed, 04 Dec 2024 00:14:25 +0100
Message-ID: <87plm8s6jy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 16:40, Frank Li wrote:
> On Tue, Dec 03, 2024 at 10:12:36PM +0100, Thomas Gleixner wrote:
>> Sure, but that's not a fix and not required for stable because no
>> existing driver is affected by this unless I'm missing something.
>>
>> What's the actual use case for this? You describe in great length what
>> fails, which is nice, but I'm missing the larger picture here.
>
> PCI host send a door bell to PCI endpoint, which use platform msi to
> trigger a IRQ.
>
> PCI Host side				PCI endpoint side
>
> Send "enable"  command      ->         call platform_device_msi_init_and_alloc_irqs()
> Get doorbell address        <-         send back MSI address by shared memory
> Write data to doorbell      -> 	       MSI irq handler triggered.
> Send "Disable"  command     ->	       call platform_device_msi_free_irqs_all()
>
>
> At endpoint side, need dymatic response "enable/disable" commands. Of
> course, I can call msi_remove_device_irq_domain() in my disable function.
> But I think it should be symetic in alloc/free pair functions.

No objections, but that's not a justification for a stable backport as
nothing in tree has this problem right now. You add a new use case which
requires it, so only that new use case has this dependency, no?

Thanks,

        tglx

