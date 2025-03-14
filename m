Return-Path: <linux-pci+bounces-23722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8482A60BDF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E043B6A31
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A21C6FFB;
	Fri, 14 Mar 2025 08:37:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021051A5BBF;
	Fri, 14 Mar 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941455; cv=none; b=XiS+ybfgMnp+g7Wak057o4wD2R3hQ04n2GFP+FPHJaucPCZWrYZxzjW03WfQtyYmGZmDbpBdM2iL7iG6a0iLJQ2TczqN8IfP2OuYOXyXbM93FQw822d/3xh3EVmvuyPdX/vocVk8xmI2Vj/5RHoSS93icBboy841uu+pm577axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941455; c=relaxed/simple;
	bh=zklAdkbt1AGLi6dnH9rR5aH5Uq4X81OHDSMkvSuG5qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+lbHsRzPWOwFR17X1wwVayHBOoavQkAgiA8xtmIaNc0fyuvxzR0p+I3QPI3jY9dnvGVrH4Njstk+eB2zDp7hrlixAPU63JmBR4Jz/OcZNtberGzjNlvBk6fshpYrSqzBMjtt4TGQBLDIlHe9ZQwZimaONahc3Xv2b0b2KqagzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2254e0b4b79so49462435ad.2;
        Fri, 14 Mar 2025 01:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941453; x=1742546253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkyX6SSYfheLZc0I8Te+XAXX22QoX47uyuXFCY8mX8g=;
        b=On/eC+0P63qz6BUbhadp1a74Se2qIUzDufuqT8osgPbNGgeCAkryBz+PGUwkdopuK2
         AbyukJAtXXpCauULe4BUgDD2/lXtbAg2Lxjw7NmDXsIUMXXLT2SA3LXdW1Va/Byvv0o+
         1kPY054qc/4y3KZX4asqtGM1P2YGKmyBN9NrtGEzlMtPDECuwmcxGHSFyqz98P95lCKj
         6NN/p6wwhAY3cRpNzN0bB8hiSxfiSzRjP4DL6E/gCm1TcIfBJ13XmPQFuceLFQ+Aod+R
         YNLyi5q1y6mSVvYLkEjEX36YM1RKv3oPnyev1OGAqq5/B+joo8IsgAsx8MIkQPjdS/2O
         qXpA==
X-Forwarded-Encrypted: i=1; AJvYcCU21O6EnvwncoipYmTFSI8He3uAwRXOCZkTHPnywevi/TFWy9Y67suAHSmuDvskZAotirm9GLxwR5Rf@vger.kernel.org, AJvYcCVKzhWsfg2hEaOlnMp0Ffuf4hn0O/syrBJfxiNbhQQiZQ3d4htPzJoKkvUFs5UjoAdQvXfG72CSGj8APg==@vger.kernel.org, AJvYcCVTjIhE1W9X6OreWJFCDBHDJKEC73HXnLk3uJEgzs66azP/qYPNgcs8Ms4JUa/11pOgOwBsXDGlvboJ@vger.kernel.org, AJvYcCWbEAoTqi1gcMCTm+ayyOLcCQ1JPjuHxVA7FxOMY1k+qaVVcjvS6h2dI8V11atq2cMSNpMn27jSzl8vSoK8@vger.kernel.org, AJvYcCXnwi9LtU5Mu3c2J9he1oCay4ZnGvjLDBdY3RfbrIwZfsuV5GQn3mj2jPC48qX/eFxtPItcBfQAx9oa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Vq8kV6+ZIZhE5PNw7Z+aLxBloIsa3oEtA/LRf/P8BCmu5LjE
	SYfINZlu2tAu2AwqOBNWHU+VDoBU5JpO0cg/KtzWbMm94wruKuWoZ7xegRGWDaA=
X-Gm-Gg: ASbGncswuHJA7XLs5IW0XRXia6g6kiDWNAAPRWmZ2UzN1g2RUu4jXn8hMX/QQObTKZ9
	faqNsKo3tWZ1uluNanTKPXpF7gDiUh5K7/6CNXKNAwStNkkq9xOezHMEzscRJaupUEFR5CX21yx
	cyhGuszHWTzzxxzqaBT4l4ZsE52HajUp4WhIk18kX5b07+TiA7HoVOQEvBRu7r6WptdRavkiARG
	FKx6bWn/RhR1qRbB538ViUmVs0g3AiUioEozthZIwfwy2cTMYG4RovrlUuvOPfA8CYjYyXlvt8D
	Qd072PsM0lUCfQ/5VlqihrtPVDTQrANzzSNPo6A52EfkuFRWeq+kLpxT7XXrWQAUWpEmpAFPjXX
	Vayk=
X-Google-Smtp-Source: AGHT+IG918SBQhjvMeRBJOnKfiU6p+a6y3ckJ/PqZfGFBhVlcJayE1fO2bgYIBBQYyK+PXqeApqP3w==
X-Received: by 2002:a17:903:2b0f:b0:220:e5be:29c8 with SMTP id d9443c01a7336-225e0aee8f9mr28139165ad.32.1741941452931;
        Fri, 14 Mar 2025 01:37:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbe884sm24780695ad.185.2025.03.14.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:37:32 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:37:30 +0900
From: Krzysztof Wilczynski <kw@linux.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <20250314083730.GC234496@rocinante>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>

Hello,

Even though this is not for the PCI sub-system directly, I had a very brief
look over the code.  I hope you don't mind.

As such, a few nit picks, nothing blocking.

> +# RaspberryPi RP1 misc device

Would this be better if it matched the "tristate" description below?

> +config MISC_RP1
> +	tristate "RaspberryPi RP1 PCIe support"
> +	depends on OF_IRQ && OF_OVERLAY && PCI_MSI && PCI_QUIRKS
> +	select PCI_DYNAMIC_OF_NODES
> +	help
> +	  Support the RP1 peripheral chip found on Raspberry Pi 5 board.
> +
> +	  This device supports several sub-devices including e.g. Ethernet
> +	  controller, USB controller, I2C, SPI and UART.
> +
> +	  The driver is responsible for enabling the DT node once the PCIe
> +	  endpoint has been configured, and handling interrupts.
> +
> +	  This driver uses an overlay to load other drivers to support for
> +	  RP1 internal sub-devices.

> +/* the dts overlay is included from the dts directory so

  /*
   * The dts overlay is included from the dts directory so

To make the code comment match rest of the style.

> +/*
> + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> + * All rights reserved.

  Copyright (c) 2018-2025 Raspberry Pi Ltd.

To spell the current year fully, plus update it to 2025 already.

I would also add an extra newline here to split the two apart a bit.

> +	if (pci_resource_len(pdev, 1) <= 0x10000) {
> +		dev_err(&pdev->dev,
> +			"Not initialised - is the firmware running?\n");
> +		return -EINVAL;
> +	}

The American spelling in the above might be better.  But I don't have
strong opinions here.  It seems more popular in error messages.

> +	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
> +				    PCI_IRQ_MSIX);
> +	if (err < 0) {
> +		return dev_err_probe(&pdev->dev, err,
> +				     "pci_alloc_irq_vectors failed");

Missing a new line at the end, but also...

  return dev_err_probe(&pdev->dev, err,
		       "Failed to allocate MSI-X vectors\n");

Or, something like this over this the function name.  Perhaps exposing
error code could be useful to the end user? If so then something like this:

  return dev_err_probe(&pdev->dev, err,
		       "Failed to allocate MSI-X vectors, err=%d\n", err);

Here and other errors where appropriate.

> +	for (i = 0; i < RP1_INT_END; i++) {
> +		unsigned int irq = irq_create_mapping(rp1->domain, i);
> +
> +		if (!irq) {
> +			dev_err(&pdev->dev, "failed to create irq mapping\n");

  dev_err(&pdev->dev, "Failed to create IRQ mapping\n");

To make the error message capitalisation consistent.

> +static const struct pci_device_id dev_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), },
> +	{ 0, }

  { }

Would probably be sufficient.

> +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
> +MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
> +MODULE_DESCRIPTION("RP1 wrapper");

  RaspberryPi RP1 misc device

To match the Kconfig comment in the above description or the one from the
"tristate" also in Kconfig.

Thank you for all the work here!

	Krzysztof

