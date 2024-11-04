Return-Path: <linux-pci+bounces-15916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D89BAE47
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CB01F231D0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096318BC21;
	Mon,  4 Nov 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SkyG/7Ua"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7718B48A
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709498; cv=none; b=Vw1r6pnlx+jJFoUBBAIZVh+hmm4qpDC1B3gT+4P1c3vZQ3IzdGlha/+ke1nod53y5/4nOmeE5itt3uH1hknVRZ1Va7sg8rERwPALPliAfa6a0AQ7SHz5pAGZNm4F04/zYqqMBZrcORHFf3UlfHzhtx0FrM+IuIvWAcrE0icUGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709498; c=relaxed/simple;
	bh=G/X0h+8/yRif+x6UMM4PsGQCOAGV7mUsPioWsd9Uy1Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkOMHJb/vlM31ZXV+N9Pcl7SUZtlLMrSMXkqTK4qN+uU38jtwVri8Ma3h2Yc1WfyoJPX27J2GxlAqkTbs1iHHz+0fJHWRSPsCV2I94PnebqIxf4lIRW17QfXLtdxOjxREzxA/bXoEEhUQVc+m0M7crJKk0RavGMwq4z0/vwe32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SkyG/7Ua; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so55105131fa.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730709493; x=1731314293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eDl7nTDHYrLpfTOtxAhIDxo7Jm/MGY+3YDpczmW7gs=;
        b=SkyG/7Uag6F8YZQJo1FATaSWqUNH1DRrzqdy0DIdWjXLnt8IsLjABIk6XH7CBrYKsy
         E/n3N9bAor8V2YJl6fl6pQRLyDVCLPjMphzXO39XwrywXwFYwso/BllS7CGpnhXVD+lG
         1As12TxBzS8FBtiSUuLsSKUNk271wAiLtYm+KmA9zCVhROflG+7d9hZYZfEX3FEXW1+y
         ElRHtcGnXZGolSSv/r53Ao5l8uy845SmsEncYBv7SyY4tyksWGqUMHGOSkoUuFt9SIGo
         O8xWXMI1q8VNosdNLirSOfvyNd0eJNWEzBMIqKvVeqf1d+P/9Gy5MtM05VFy6Svp8lP4
         ldUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709493; x=1731314293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eDl7nTDHYrLpfTOtxAhIDxo7Jm/MGY+3YDpczmW7gs=;
        b=nLPavymyNgIZPGYuDqIwBkvSXlCBvJVriG3d20LcpfiySNSHQtXJUcec8JEBN7wLyZ
         1G1Y5/vu/nT07yoVp9GtXszdDVfUCRfQ5k41oh4b1GFVxWQtz170YLxfpwH4zwEJ7svY
         LSfwc5YCuu1+8u8LKRIJaoR/BacTkoAOlYW9S/DjA05FqeGtqc1WHizUO19QqBBk4CKU
         MJ/W8pHkeC/mmCI1X2pnPEikSO79ARaCnFooTbWty+xoG+pSslQ6c7j5IM6wQvZxmQK6
         HaYWKFPH6CUDpF77rWSHNbHrISstrWIe7RSWx79FamK5+g+uRac62lvx4lS3Y0YNrryR
         S3MA==
X-Forwarded-Encrypted: i=1; AJvYcCXiPiwt5P6ChX/qFyciR39b6ONN7sJFSYklgIjWWW86K/5IHdOUB6O2Nao4YKzZFkiyViMzPnolzio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKkLc+xkEFjFU/XsiH8vGuLEDfTDVeRbGB1Dg45Q0OB2IqRfQ
	sN7VagVNipdOS8hZVj8D2QXEB151/Wf7SMEehs0uw0o+72e6XmEdIU1zQ9yGF/c=
X-Google-Smtp-Source: AGHT+IFBeEZRJog8jSvCZbczChA6E0/8cPss+uc4uzyQS1f/pQYOfuO7Wtjy7JqnNnrKVyUSvAin5Q==
X-Received: by 2002:a2e:a589:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2fedb7c9c38mr69759771fa.23.1730709493472;
        Mon, 04 Nov 2024 00:38:13 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e9ceasm522722066b.96.2024.11.04.00.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:38:13 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 4 Nov 2024 09:38:39 +0100
To: Herve Codina <herve.codina@bootlin.com>
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
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <ZyiID11EbNIwyYOP@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
 <20241104090623.53f73d75@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104090623.53f73d75@bootlin.com>

Hi Herve,

On 09:06 Mon 04 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> On Mon, 28 Oct 2024 15:07:22 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> > incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> > bridge, the window should instead be in PCI address space. Call
> > pci_bus_address() on the resource in order to obtain the PCI bus
> > address.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> Tested ok with my LAN966x PCI device.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>

Thanks for testing that!

Regards,
Andrea

> 
> Best regards,
> Hervé

