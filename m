Return-Path: <linux-pci+bounces-15917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CB9BAEA3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F21F218A5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D561ABEC7;
	Mon,  4 Nov 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L6D+oWFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DE1494B1
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710476; cv=none; b=Z7eKIXXUU1Itf7r7wE3Fvg7O+prdNcgJpw3HU0CNd4MtPS8Jhejs537dTgFLn13dOk7U+iM+37tiB1lzf4qp/9Vmx2XmEGsbdIQG1WNNmwIoK0UJmsk3IYeDk9uq7uDjo4+Jd8LEEDt9Qisvac5FzP5j+NMFuOWDbZtdYntBp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710476; c=relaxed/simple;
	bh=J1lybsdywqSajY8+XO5SA+Jx3q7N50JOGpD77qB0vPE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+RLA3TFPNASdK9657vo06B58sfaog0rs71/xsB0K+L8Ku5T0EP1mSIjqNlr+XWgYclQaHVejyjSFHJkyen6yHuGNSIXEhWzFHYCh75+uXWQCu2tl7dv1gm1wlWPN24FQcye7ZrXOCE7bGO1ADVcJI8mRozImJhDCPJfDph+GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L6D+oWFY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0f198d38so682603366b.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730710472; x=1731315272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wVgtF+RQO3Bp9xa0wTFVgwHh2YZ5qiUAa82quET385A=;
        b=L6D+oWFYL/dRJ3QfMl0QDc1JvClifZsvCwEHs30ScF0oZECySUsxPxUVLXQ0joHblQ
         RJIJdofH9n/APZwIgIPcSs6V9tN6/uz+38DZ+b1OgnKKDo99k4TC+/cQAyXpmpGIUigk
         3pLqhBtRPOOrFwOse+8qTeYoHSWOLR30ffATYgoCdl4e6ZL8Hhac2kTnJSDn0U57K9p6
         GLpzEZ5WkIe3bHW+L0Fkp7g1atHUjJ2R+ousYm6dJX1KbHFIwHCkmXxa4Nw60K0AB8kA
         wii2qixJyFbJ4qd5DrdMBKNqKPewui8aC6ySOWOl7vKdU58U9e4xZEpASWnU2kQVNmpB
         fdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710472; x=1731315272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVgtF+RQO3Bp9xa0wTFVgwHh2YZ5qiUAa82quET385A=;
        b=G/JT7d3zfmCu5qNCT6rpY+PZhieLeu8OoSXaRP2yDZpLW0x7Ed0OvbqUTv+Bbex2WH
         H1MvAzUPNvvhz1i5dQAcBhnsWlC3+E/PchoA0tDWuh03kZBsnr2mSg1gR5xMiyUdIy4B
         dtPj1XMuonByEey2GzJqfkLAuSXDhKHodt4YBGKakmdM0NpZgUp+I04R/4Y6id2ZwXzI
         +SsNkBQqekFCCaPm7tsYPlxyH+HgSB+er7hDnPVl+l5kKC3TLytDRXA997RtH41XMZp1
         xcXtx98oqKQD9wtxtoS/mdl7HDAu56RZcoVjIO2OL5NPB5MzIBjf8RNYr7ZoXXYKoY5D
         +qvg==
X-Forwarded-Encrypted: i=1; AJvYcCWrsP+4cePPvDXD3O86Imhv/qfK8lzOPdTZyTmqmP0IyK8DkI21hgfAWIXrBtqXfHeM147T+wYNoRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65OhdVzzriNmbEXCmEhflU6eLKQYzKTAkxJRH95AIfDG3OfEP
	fznn8ykXuMqM61S67xmWwdtd0/KB+prwmrX4ZRhLORvumbJj+a1wY5BcsDXmW3o=
X-Google-Smtp-Source: AGHT+IHHWwU4nmC4hKYGVohwmL7B6wm+EPEOdY9CCLcF+bYsvgn7lE94cff864zN3lJnYIL8UQ8UFQ==
X-Received: by 2002:a17:907:2d0d:b0:a99:61d1:348f with SMTP id a640c23a62f3a-a9e655b9703mr1085525566b.52.1730710471755;
        Mon, 04 Nov 2024 00:54:31 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5669a18esm524386366b.216.2024.11.04.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:54:31 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 4 Nov 2024 09:54:57 +0100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <ZyiL4RnRC1z907Ly@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
 <20241102170908.fa5n6pz5ldxb66zk@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102170908.fa5n6pz5ldxb66zk@thinkpad>

Hi Manivannan,

On 22:39 Sat 02 Nov     , Manivannan Sadhasivam wrote:
> On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
> > When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> > incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> > bridge, the window should instead be in PCI address space. Call
> > pci_bus_address() on the resource in order to obtain the PCI bus
> > address.
> > 
> 
> of_pci_prop_ranges() could be called for PCI devices also (not just PCI
> bridges), right?

Correct. Please note however that while the PCI-PCI bridge has the parent
address in CPU space, an endpoint device has it in PCI space: here we're
focusing on the bridge part. It probably used to work before since in many
cases the CPU and PCI address are the same, but it breaks down when they
differ.

Many thanks,
Andrea

> 
> - Mani
> 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/pci/of_property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> > index 5a0b98e69795..886c236e5de6 100644
> > --- a/drivers/pci/of_property.c
> > +++ b/drivers/pci/of_property.c
> > @@ -126,7 +126,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
> >  		if (of_pci_get_addr_flags(&res[j], &flags))
> >  			continue;
> >  
> > -		val64 = res[j].start;
> > +		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
> >  		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
> >  				   false);
> >  		if (pci_is_bridge(pdev)) {
> > -- 
> > 2.35.3
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

