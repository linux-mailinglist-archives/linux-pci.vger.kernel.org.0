Return-Path: <linux-pci+bounces-27848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A7DAB9A4A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236445016D3
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A122FF35;
	Fri, 16 May 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RLxPr1Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oLKTdzY"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432D1FFC77;
	Fri, 16 May 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391773; cv=none; b=R8u0J9VN092fVhzG/t5sTy4g/RpzPxS9zDk4ZgUG4i8FCf1V4aXjM1h88Cy1W8jF8q3prcDnGm7KJ6zpP8a8rXrSNm+AfdWguqKJYRNI7tXCwXqBg9Dr+xBphcffjHO5gbblk4zjumGQDqGi5YgKj737VOMgIJk4wHT4mzt6mQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391773; c=relaxed/simple;
	bh=k7z0nyLTl3M/OnuL4GUytgYuYQUznOTN8vHlNfbph00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fu+OKhTB2wsNni5Ia7L1YNBAjik5oMnKuL6cv4gxhpy067SsFvAvAKLsHXQOGKaGHu8nV7q1TFYkNv2N/6yVS7QMJas1qIgUeupx5r3PH6/Ubnqz16SQzWUpAvulIYD3wsA7+KS0OmwuWBWM6YkxgCFeYCfXUpxHjX5lkt5t0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1RLxPr1Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oLKTdzY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747391769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNXHKgY/p/PBj8nWmVezncK3qsEuUPE+7qreXPSODDI=;
	b=1RLxPr1Q9YViq4P+Jja3DlqdCVwBVmWrMrNcUPXvUM4KIlrHHK35QAQKQmJ+GMSHh17VD4
	JdB0bNnjpgEO4rPTed52PZWfl/IjnniVQMUmZ0jMLj7b0f+eK/SUvhs3RCdxdBGIbkJECX
	fHAv6ttd9E9MPHKU/BkNXnRX1bAF8rg8YRZXAZL7NHm2UhmhQe9PLUD0ZmgyviJorKbEsx
	/RLCosFge+POjP2rFVlevwcREJ7zypSc31JDoV6OTuBui7LUMjVdJeJKCp7I2htFire8gX
	agjaLYLAfVoAGIjD7tWFHS9m/xDCXAD3Z71oC/XsIbWvOKttr+gOntew0viVRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747391769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNXHKgY/p/PBj8nWmVezncK3qsEuUPE+7qreXPSODDI=;
	b=0oLKTdzYeoyAQaupzKJHMQaqCATV4QiFRcxE/YtfoE7dRBBu+UjOGl26a4IIutckivtwUL
	x+oxx97OFqNxVrDg==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Toan Le <toan@os.amperecomputing.com>, Alyssa
 Rosenzweig <alyssa@rosenzweig.io>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 3/9] irqchip/gic: Convert to
 msi_create_parent_irq_domain() helper
In-Reply-To: <20250513172819.2216709-4-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
 <20250513172819.2216709-4-maz@kernel.org>
Date: Fri, 16 May 2025 12:36:07 +0200
Message-ID: <87h61kj10o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 13 2025 at 18:28, Marc Zyngier wrote:
>  	if (!v2m)
>  		return 0;
>  
> -	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
> -						   &gicv2m_domain_ops, v2m);
> +	inner_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
> +			.fwnode		= v2m->fwnode,
> +			.ops		= &gicv2m_domain_ops,
> +			.host_data	= v2m,
> +			.parent		= parent,
> +		}, &gicv2m_msi_parent_ops);
> +

This really makes my eyes bleed. 

 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
-						   &gicv2m_domain_ops, v2m);
+	struct irq_domain_info info = {
+		.fwnode		= v2m->fwnode,
+		.ops		= &gicv2m_domain_ops,
+		.host_data	= v2m,
+		.parent		= parent,
+	};
+
+	inner_domain = msi_create_parent_irq_domain(&info, &gicv2m_msi_parent_ops);

That's too readable, right?

No need to resend, I just hacked up a few lines of coccinelle script to
eliminate this offense.

Thanks,

        tglx

