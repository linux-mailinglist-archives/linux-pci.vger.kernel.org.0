Return-Path: <linux-pci+bounces-6981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7C8B92A5
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 02:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFD01F21AD3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 00:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF27E9;
	Thu,  2 May 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kp8qZs/i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJnJ1sG7"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981287F6;
	Thu,  2 May 2024 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608211; cv=none; b=qASusfLfIuwtCQMSWZzrrcfGvXieCX0rJ2YF6uz5TPSAj+BBuL5+ahSWempTx+UHIMAKdMdjhPKFm7kX0DLykPh0BtGKoAAL6f+Jgwn0Gad8D/3/tYGhwH7Zc7FLhQHVGKL8l+dp5BBWe+WEkUEK9rX3nmfPQqtX5zJ8tjH7XH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608211; c=relaxed/simple;
	bh=1sKkjFU96N7WQ/Alcm0gt69fbHMFNm4H/4w/Y1PgO/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DAp1tqmf3A25MfsbZLvqTFbnDlGFC1qtajQfDCyJsrg+Mq0M/KkpBJkCwgqaT/9TuVGDkHkva0mKV/k1i9HvYS9+PaxWnae0k35+ufqZaYgVH2zfCxRnxp3BMrYEUvOBqZsMrNlVEjrBoOayAc9jJsUDpS5gRr0znpAGU6Vn6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kp8qZs/i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJnJ1sG7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714608202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jzCGoAK5gYl8hpdgidkPo+bYHUWqSGYg+U6RVV820=;
	b=kp8qZs/i/NeO7qfmBU3pkT3RZ2CP7BAPeXs2WILS38escNUt21sBZ8FPt9ISkTZMM1JnR6
	TgNk6LX4GPGmIA3aABXnoLlisukSiyZLBGOfl9+ZyZG8xd5tZi1u0ZfCtQYEsTt49JcA6D
	/j1jfLobwICqaaUuO0qwuXKQWrwKtycYAnQiFIY/OnKMOiAMmicgsLedA4tCzQ9pJVQg2q
	/jJlTqpyywNqqyW2lPvaXtcslXk0bDS5bYetRkwKaPskN/jBFFOuJ7iAFQkZe1yIPql96x
	xmckFM53fcT+6ESd0DZF6IQleqJCg5Gd/Yvdf5WZNgIOpKeiGq2fRauCZzbHAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714608202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4jzCGoAK5gYl8hpdgidkPo+bYHUWqSGYg+U6RVV820=;
	b=eJnJ1sG70pSoKYDNmnIMoXYuvS14n1rytkredEJDGF5uaJOItsoLTMSzHeQnrN6W6lovD5
	k+88/oJHU9x5qUBw==
To: Herve Codina <herve.codina@bootlin.com>, Herve Codina
 <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee
 Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/17] irqdomain: Add missing parameter descriptions in
 docs
In-Reply-To: <20240430083730.134918-11-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-11-herve.codina@bootlin.com>
Date: Thu, 02 May 2024 02:03:17 +0200
Message-ID: <87cyq5rsfu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 30 2024 at 10:37, Herve Codina wrote:
>  /**
>   * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
> + * @d: IRQ domain involved in the translation

Please write out 'Interrupt domain'

> + * @ctrlr: the DT node for the device whose interrupt we're translating

Device tree node. And we are not translating anything.

> + * @intspec: the interrupt specifier data from the DT
> + * @intsize: the number of entries in @intspec
> + * @out_hwirq: pointer at which to write the hwirq number

Pointer to starage for the hardware interrupt number

> + * @out_type: pointer at which to write the interrupt type

...

Please align these in tabular fashion:

+ * @d:         Interrupt domain involved in the translation
+ * @ctrlr:     The device tree node for the device whose interrupt is translated
+ * @intspec:   The interrupt specifier data from the device tree
+ * @intsize:   The number of entries in @intspec
+ * @out_hwirq: Pointer to storage for the hardware interrupt number
+ * @out_type:  Pointer to storage for the interrupt type


>  /**
>   * irq_domain_translate_onecell() - Generic translate for direct one cell
>   * bindings
> + * @d: IRQ domain involved in the translation
> + * @fwspec: FW interrupt specifier to translate

Firmware interrupt specifier

Thanks,

        tglx

