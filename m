Return-Path: <linux-pci+bounces-21921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA49A3E2A0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F3F7A9086
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185D212B0B;
	Thu, 20 Feb 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YBA/LN7t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAD20DD47
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072801; cv=none; b=U8knH33BldPQ9yS3cukc31BO/7NzUGLgMJrp4+RP596IMcEaMt6Ii28bjKgFHMNA0tch5DpPVmpbQQ4pQAEfMy8FAz7RE3VrcaWCVMRx8o718WwJ18pXyoPViLFp8Mb+o8fBzgJP5yPeeodna32zciQAuBtd6PlJ98lTarYRmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072801; c=relaxed/simple;
	bh=tdSgk07Qmyb1E0a1lw0F1X8xB3gcZzChTJbUZHLvlvw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXNi/96+G+l9ph3tQjTPwQKXIE6SsQajmc3fSYCrZygFhZp++AwszbMxiU/rb/ahpADF4jQmodUPVmpyZQDkSwtuPgqA8C5pPyws6ImWSBWBwYZ7VwzBSp2PHwQYSImTJcgY/jf+W+mlRBUSvX8jkXRgoWZENLf5Ta1YYlccTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YBA/LN7t; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so4362934a12.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740072797; x=1740677597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANYY81S4UUbSzxGp9vX0hw/u/obOtXq2bTCgGH3coGw=;
        b=YBA/LN7thNd0kfJi6YUgXpWSohTH4hfKCGstG7P6rVOIvoqYVImMOkWF2SLD/TvS3l
         zpzriDHW07QsPXQXaeYTV7dArcZpAMR00SnpouK21pHa8IZMfcHCKN9aIW0tYLBti9nL
         8TcxgOH9SH9ZtwiVdF78otXhfJo0Db4W2ZMF41U/afSvTQIYgGrNe3dk6luNCA2iE42X
         G0IfBQ4yS/WJwvG6cnMYDSRA4b7cl4AVk0fLBiedZQkYQdjIaBUZE6rSUso+xS9LIAf9
         tllmocprm5GBV2KAAwnWvpRF5cqADPVnBL/l7qrNdktdMSYVjojg4vzhoU0OCcwZLthF
         3HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072797; x=1740677597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANYY81S4UUbSzxGp9vX0hw/u/obOtXq2bTCgGH3coGw=;
        b=FHy1R3zM9s6aSuxL4tO2LjCrDwt7kzS34z02C07rijrZ7Nf/6a+887W5wRQn3NUYag
         N33yTc9ovhdlZTldTp+SxLdrsc9EAIgc3i/VgEDD3dd7yUFu6F2HEKv9rKNhCUmw7WZi
         0F6rLf8KuK/GAzzdISj7RsnO8PImG4Iz268XCqfGgg4EOstvpjb37Ne0beyn8u955j2g
         Fs0ThzHspWyWgdZWYFTy5NIhwsDO1ORTALvjiSmKmsE8jwLGTM71ho0sIXxwIrvuknIH
         Ju2KVBeFnpFz0VoSS0BtHMuDkT0o8qifoduSlzCCEop/O9cE6JbO4w7JynVRqdhLZqPU
         i93w==
X-Forwarded-Encrypted: i=1; AJvYcCUK0kcydPp1QwBPkSkKgpUaPihi94RdZl6uiPzDG0qhpsN74563tKbUShyaKMj6QbelJhlF0dZFO7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxde0pBCjompgz6Ql0xAIBuZnq5TwSlBxbAOfkqNTgyocBISe5q
	HfH9+LLW0ZoK7yhiS2RetjdU0nYGeYy3k2chZr3mi4WXGRbqZJ9WinDNczbLbOU=
X-Gm-Gg: ASbGncs92xuBLWA+2ltSpoypRX+PhwTdEY4UXDQUP4atSlxB57O1x3u5DlyZiPgwbP3
	N07+LKiia/+HwDEiyub4kBwBzrdZ5AWb+4jBqPCZrJij5VSuYvljxgHyIm8/mUpcTSQN30Juzn8
	P3dTl5HGmmcm+DZvaxkqlhL+jauITs4I2qUXMweX8iZQSLWJjgTJ6LyuB1mvRlxxNWf67tOCPIg
	j7Ra18pkhfgbVhLz4rtFH7dEqicl/1vPKNVEoCQO/crLb8sZTOf/04xFK6kWjr4RF5wJOgbrQqF
	xh2duz5REM89y5wi6dUuQzyxhGYMvnj0KtnrKbVx2qeNKdrS6ul4WASxQy0=
X-Google-Smtp-Source: AGHT+IFcZuFtypbIC0ocwrn0UjtnE5zIzW4WQOLazDAdOMAwrDA8BDnjnnZ6hgx+i5rr6QtaeBrAFg==
X-Received: by 2002:a05:6402:524b:b0:5de:50b4:b71f with SMTP id 4fb4d7f45d1cf-5e0a12baa86mr3394933a12.12.1740072797358;
        Thu, 20 Feb 2025 09:33:17 -0800 (PST)
Received: from localhost (host-79-41-239-37.retail.telecomitalia.it. [79.41.239.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e076048c05sm5023923a12.35.2025.02.20.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:33:16 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 20 Feb 2025 18:34:21 +0100
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z7dnnW4npJmfOVE0@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
 <87525350-b432-40b3-927c-60cd74228ea4@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87525350-b432-40b3-927c-60cd74228ea4@gmx.net>

Hi Stefan,

On 15:21 Sat 08 Feb     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> > The RaspberryPi RP1 is a PCI multi function device containing
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.

...

> > +static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
> > +{
> > +	struct rp1_dev *rp1 = irqd->domain->host_data;
> > +	unsigned int hwirq = (unsigned int)irqd->hwirq;
> > +
> > +	switch (type) {
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		dev_dbg(&rp1->pdev->dev, "MSIX IACK EN for irq %d\n", hwirq);
> This looks a little bit inconsistent. Only this type has a debug
> message. So either we drop this or add at least a message for

I think that this is indeed asymmetric. That warning says
that the 'special' IACK management is engaged for level triggered
interrupt, which is mandatory in order to avoid missing further
interrupts without the performance loss of busy-polling for 
active interrupts. This is explained in par. 6.2 of:

https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf

The point is that we're not stating the type of the interrupt
(edge/level triggered), but we warn that we're enabling a mechanism
useful for one type only (level triggered).

> IRQ_TYPE_EDGE_RISING, too. Btw the format specifier looks wrong
> (unsigned int vs %d).

Ack.

> > +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> > +		rp1->level_triggered_irq[hwirq] = true;
> > +	break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> > +		rp1->level_triggered_irq[hwirq] = false;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> It would be nice to document why only IRQ_TYPE_LEVEL_HIGH and
> IRQ_TYPE_EDGE_RISING are supported. In case it's a software limitation,
> this function would be a good place. In case this is a hardware
> limitation this should be in the binding.

All ints are level-triggered. I guess I should add a short comment in
the bindings.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct irq_chip rp1_irq_chip = {
> > +	.name		= "rp1_irq_chip",
> > +	.irq_mask	= rp1_mask_irq,
> > +	.irq_unmask	= rp1_unmask_irq,
> > +	.irq_set_type	= rp1_irq_set_type,
> > +};

...

> > +		irq_set_chip_and_handler(irq, &rp1_irq_chip, handle_level_irq);
> > +		irq_set_probe(irq);
> > +		irq_set_chained_handler_and_data(pci_irq_vector(pdev, i),
> > +						 rp1_chained_handle_irq, rp1);
> > +	}
> > +
> > +	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id, rp1_node);
> > +	if (err)
> > +		goto err_unregister_interrupts;
> > +
> > +	err = of_platform_default_populate(rp1_node, NULL, dev);
> > +	if (err)
> > +		goto err_unload_overlay;
> I think in this case it's worth to add a suitable dev_err() here.

Ack.

Many thanks,
Andrea

> 
> Thanks

