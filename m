Return-Path: <linux-pci+bounces-24028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8BA6701E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7273AFC26
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4EC224CC;
	Tue, 18 Mar 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMO59ay9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5163207A2E
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291099; cv=none; b=HvouIbfiV3czNz/kg1FLyjCUqLYEzQHhA7b9M7XzWqrJijDYXxLxu8JLoS/yVCNlPYrvce5mm1Rcwx1v2c7ddcvUT7LVrDmXLuewLEQrfj7XDw0l+/bKUagwJaAHPVo0F9Zbu5GlEpyygie9YXQe026c+AUo7QYg2ZOJEXbyAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291099; c=relaxed/simple;
	bh=raGUllWJomob8pRySrj7Qf7XmWKdYOqMKi7Hn0TQG+c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBVLdSAB21st0LL89lTwmI1CwhdYqxVniHt8palQiP0vk03M8n0ozC5V+TeNXTOqXVxk+trgJ2Z72L2KQQB6iq/LcL0GsBqc1njjX15MXzyjeddR8awVuhoyFwGyjrvHYfYGCw0JnRpyfinixSx74D7BRM1RWWUmx0/rJW/nyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMO59ay9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso11682779a12.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742291095; x=1742895895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eInU4xGBu0Mt8Lm17X6zPVhTvmNik5PGbnkQOxA+YU=;
        b=ZMO59ay9fHfT96rInwKCEFW4JQm/ORR0iYosd/bJf9B50nRRSVn2nAWtctgPxWH44J
         06TJT4+3Bd0BZ8vRURy5KhTkv5nCTBYgdDakZI9ZaDOJ+vYhpIpIcdnSh82cryEbpFaG
         MCe0Pj2ZZxOK6GGxk5MZWfKmIKYFNz7ui8fVynMOB0z4zZVMQlQMRvAGEGOYaEkxjKbl
         2iWp4r0grH4J7gVzIPAhZa6gfy+cSsK7cURSC5mivNmgOas8EWvF4qYog2vAx35EF3aF
         Z/hUxzPO3AuBb224graHCQNSxcypA0Db+ALdEsqHf6FzVfus9071ar58oks8O4pGS2pE
         9VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291095; x=1742895895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eInU4xGBu0Mt8Lm17X6zPVhTvmNik5PGbnkQOxA+YU=;
        b=Nvv4r9kFxRYVyNBGC9cgik3xmYGrkYyKj4OyMZpSLJzFPOc7pNuH9s5x8yy/XeV8F0
         KffRh0bdqFYe50+ESghcf98toJqNN2kuP4wQcuoWXncNRcTqlGTL6nSAyU2gSA/+uSvJ
         NXOYEtNJ4RvFRJb+OeoCHJfxRddpacXCc7wLwspxA9YBgKVeU7P5q+ARBPP+Dlz8OpBV
         EeLdpyyjHTC5Xdg311LTTo4gOZ1S5PTjqo9hn91fsQYO+icl836EbajLzVGpelOJT9kU
         f8AJubA+IYgsng4IF42BxtVPea+TPsgFBOJ7X5JmeXbthMIKwD9CRyk+rK5TxBprCHHW
         3RZw==
X-Forwarded-Encrypted: i=1; AJvYcCVbGJUlxBm0IXkPzYZv40+f/RFPNoxm2P8LWp44IaTgYDymLfoERppQ9JU3Moi4xyvpkULr2f6aCo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmomCnkumbgzYsWePkCPSXRx8YTZXR5xTOYmOfVGm2tdWXTodG
	c7thzbP4D3QIY1s0GIG31RGcQ//w7dR1NVeflhQHC1Z9ZiNZKqZS/bk9PZOp4Hc=
X-Gm-Gg: ASbGncsXdjC1wzufJAxWrrIAOwnSXQakPSIBzXgLr9DTeBncemCuELRVUPQAMKtaI4E
	7bS1eDdFPpWH9+SosaTPLJgKE/WQA6MsIX+7xijVNvNSAV+xk1WEd0GaniScOlEBSReSUFw+i7T
	ntRIcMPJKfIFP5IjChnhfkRhJ+MqdRg7aPjzAQMhnkmGOK2rmTSPITmb1ER/UhZMG8w3MwM2QxI
	bRCnEeyMHmeCUW159F7siQCc0SjUMlYbaAMEYf5UGx1lJiBMCweV6XqvWrIuJeaiB6NuFlJcgCX
	G6UXiqbEfISxHl+SIX/w1Rl6/reu1jdzGh+m0uGUcDBdNlRYdKSF4J7WOl0IAtdBaWbSFG0ONsT
	paEu/+5kJ0d3xomU=
X-Google-Smtp-Source: AGHT+IF5nVWbdkGdXhT8Rbx0xwnOfVzY2zNtg2VYzomJ4pLfS9zkgHWMH1EzA7usUUR4N2OG/B9QfA==
X-Received: by 2002:a05:6402:3491:b0:5e6:102a:c30 with SMTP id 4fb4d7f45d1cf-5eb1efcbee0mr3044112a12.2.1742291094785;
        Tue, 18 Mar 2025 02:44:54 -0700 (PDT)
Received: from localhost (host-80-117-53-131.retail.telecomitalia.it. [80.117.53.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169bca53sm7562109a12.46.2025.03.18.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:44:54 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 18 Mar 2025 10:46:07 +0100
To: Krzysztof Wilczynski <kw@linux.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z9lA31gBjpIRHm6y@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
 <20250314083730.GC234496@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314083730.GC234496@rocinante>

Hi Krzysztof,

On 17:37 Fri 14 Mar     , Krzysztof Wilczynski wrote:
> Hello,
> 
> Even though this is not for the PCI sub-system directly, I had a very brief
> look over the code.  I hope you don't mind.

Highly appreciated, thanks!

> 
> As such, a few nit picks, nothing blocking.
> 
> > +# RaspberryPi RP1 misc device
> 
> Would this be better if it matched the "tristate" description below?

Ack.

> 
> > +config MISC_RP1
> > +	tristate "RaspberryPi RP1 PCIe support"
> > +	depends on OF_IRQ && OF_OVERLAY && PCI_MSI && PCI_QUIRKS
> > +	select PCI_DYNAMIC_OF_NODES
> > +	help
> > +	  Support the RP1 peripheral chip found on Raspberry Pi 5 board.
> > +
> > +	  This device supports several sub-devices including e.g. Ethernet
> > +	  controller, USB controller, I2C, SPI and UART.
> > +
> > +	  The driver is responsible for enabling the DT node once the PCIe
> > +	  endpoint has been configured, and handling interrupts.
> > +
> > +	  This driver uses an overlay to load other drivers to support for
> > +	  RP1 internal sub-devices.
> 
> > +/* the dts overlay is included from the dts directory so
> 
>   /*
>    * The dts overlay is included from the dts directory so
> 
> To make the code comment match rest of the style.

Ack.

> 
> > +/*
> > + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> > + * All rights reserved.
> 
>   Copyright (c) 2018-2025 Raspberry Pi Ltd.
> 
> To spell the current year fully, plus update it to 2025 already.
> 
> I would also add an extra newline here to split the two apart a bit.

Ack.

> 
> > +	if (pci_resource_len(pdev, 1) <= 0x10000) {
> > +		dev_err(&pdev->dev,
> > +			"Not initialised - is the firmware running?\n");
> > +		return -EINVAL;
> > +	}
> 
> The American spelling in the above might be better.  But I don't have
> strong opinions here.  It seems more popular in error messages.

I agree.

> 
> > +	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
> > +				    PCI_IRQ_MSIX);
> > +	if (err < 0) {
> > +		return dev_err_probe(&pdev->dev, err,
> > +				     "pci_alloc_irq_vectors failed");
> 
> Missing a new line at the end, but also...
> 
>   return dev_err_probe(&pdev->dev, err,
> 		       "Failed to allocate MSI-X vectors\n");

Ack.

> 
> Or, something like this over this the function name.  Perhaps exposing
> error code could be useful to the end user? If so then something like this:
> 
>   return dev_err_probe(&pdev->dev, err,
> 		       "Failed to allocate MSI-X vectors, err=%d\n", err);

dev_err_probe() should already print the err code, no need to add it.

> 
> Here and other errors where appropriate.

I've changed dev_err() to dev_err_probe() in cases where the error code
is not evident (i.e. hardcoded) from the source.

> 
> > +	for (i = 0; i < RP1_INT_END; i++) {
> > +		unsigned int irq = irq_create_mapping(rp1->domain, i);
> > +
> > +		if (!irq) {
> > +			dev_err(&pdev->dev, "failed to create irq mapping\n");
> 
>   dev_err(&pdev->dev, "Failed to create IRQ mapping\n");
> 
> To make the error message capitalisation consistent.

Ack.

> 
> > +static const struct pci_device_id dev_id_table[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), },
> > +	{ 0, }
> 
>   { }
> 
> Would probably be sufficient.

Ack.

> 
> > +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
> > +MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
> > +MODULE_DESCRIPTION("RP1 wrapper");
> 
>   RaspberryPi RP1 misc device
> 
> To match the Kconfig comment in the above description or the one from the
> "tristate" also in Kconfig.

Ack.

> 
> Thank you for all the work here!

Thank you so much for your review!

Andrea

> 
> 	Krzysztof

