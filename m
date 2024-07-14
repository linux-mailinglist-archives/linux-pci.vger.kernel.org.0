Return-Path: <linux-pci+bounces-10242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D0930B4B
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A861F21C4A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33F13B58E;
	Sun, 14 Jul 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlIxmah1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gy2t7USX"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58980139CFF;
	Sun, 14 Jul 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720984476; cv=none; b=a+vVt20wg9QJM9E5TqgvKfLrXQT2nhPJ/dnn8L+1KAhq6W2U8vDVWcKYUEQvPS5hw+mN8eJdV/j0lDn0fmYJ0zxsNDz9I7u6eHQPCZGC8AnpBo1XheBLHpPPwPeY6egQMmUrAg9OfQ6eNvFFx4LV7iNxxTwSYJm7KQsGtEhWYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720984476; c=relaxed/simple;
	bh=1wu6UYrjAPhx3AVW6NYcgTybzO4iPr5SVjo/fGYH2R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHRoKKFI8ags6/r+I4sk6Jluy3nLM0CP2yjJnYdOObqmeqe0Q2430MTqDrAQj9oQ3Y05N70QY60mXVsOmWOmz55/QDLLoJnbuQfHBgIEZWp9IvpZ9HquxVnCoedjdvss6dfcFz/XHUcxIcDM1vPA+QXNMqU44Z6gYzsSf1U3Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlIxmah1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gy2t7USX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720984466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wX7ebihwbLcR1RlcOLKvi22zfI0VSJC5ZPkGssGUi0=;
	b=LlIxmah17PKUfrQ03Q0EAPPJY0spuoRqABZ936s4D6KUR0C6e1/C3dq9QSSIHEC6nf9CGx
	C8yZVJQTenvVFc8N2LBm4RGyWJrPCgCCiOJQerSGft/jPFmwwbd66AmcxfWRzjdXduF7ar
	DAqXnneUlV+AEBjRvOmYd16EP6fRLYawc83xAVZW5k9gDz70FidpjxWuWp5jsANBJx+iVn
	BVvuskGf7o4q1aQsICaFS8qpnBr78N8KMOUO1pK2ceDl6KzLDGMEuETXbKIsMyefmgmzL2
	/yc/8mHZqNcRa49tX/YOpLONs+Nsuy60YnqRZjkfMKb0gGyDLgQVDgsVZkesnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720984466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wX7ebihwbLcR1RlcOLKvi22zfI0VSJC5ZPkGssGUi0=;
	b=gy2t7USXGtRNC1O2mA8fojsw4Th1ZwBWy3y9gY8xLyN7A/XbsCPSny+vglOeMP5vgAmRXe
	VoZQY2RSQifU9hBA==
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Krzysztof =?utf-8?Q?Wil?=
 =?utf-8?Q?czy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Jisheng Zhang
 <Jisheng.Zhang@synaptics.com>, Jon Hunter <jonathanh@nvidia.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob
 Herring <robh@kernel.org>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set
 affinity failed warning
In-Reply-To: <20240714122405.27548-1-marek.vasut+renesas@mailbox.org>
References: <20240714122405.27548-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 14 Jul 2024 21:14:24 +0200
Message-ID: <87wmlnrdkf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek!

On Sun, Jul 14 2024 at 14:23, Marek Vasut wrote:
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -100,7 +100,7 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
>  		chip->irq_unmask = irq_chip_unmask_parent;
>  	if (!chip->irq_eoi)
>  		chip->irq_eoi = irq_chip_eoi_parent;
> -	if (!chip->irq_set_affinity)
> +	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_USE_DEF_CHIP_OPS_NOAFF))
>  		chip->irq_set_affinity = msi_domain_set_affinity;

I'm not really a fan of this new flag.

I'd rather leave MSI_FLAG_USE_DEF_CHIP_OPS alone and introduce a
dedicated flag MSI_FLAG_NO_AFFINITY to tell the core code that these
interrupts cannot be steered. Other than that this approach looks sane.

Thanks,

        tglx



