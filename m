Return-Path: <linux-pci+bounces-16770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E519C8EC3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8E528484E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5219CD08;
	Thu, 14 Nov 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k86e9dLW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BB18FDBB;
	Thu, 14 Nov 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599160; cv=none; b=lIGEye0WFhEccOj9bkPSZ3og4l6UWuoRK1uJ/PqCPp1hGdR6XwWWddBlxWZoUsjfeQYUxwQKcmfx64MjVef4aZ1QBtnMC9E6WgdBQshPoS+5OcJVUeVs4vmilf1GDXjDinXj/6d3+nD5k6clAyeZ34qIefUna0Jc7GxAmWn9Q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599160; c=relaxed/simple;
	bh=5z0brDtQRBtx4SXaYJbzWU/yguAU4LV0GO74WH+JMqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOVmXscUo0LlqbrQf+Vov8Ks/F0PNDAwflLplure3/sinECVk0HiDHu3AhnYZKGNG8tQjWkRSvd7lgreGSq84B+XJlTYencPn8oBQc1dUYrT7h9GHnZXrmjANlkq5RsfTPLiDqDVGTTHAyvOLEwiCgNOjIs9mJHpaqTDehzrnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k86e9dLW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEE96240003;
	Thu, 14 Nov 2024 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731599155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVd4FspoJAAUQaVK/sgQzSkqs6EdCPL13NCZ5VJz7fw=;
	b=k86e9dLWi4x6VwQGxiSQmmGbjdenEI5HBux7FE811k8PyybyCldwAMpyPuqWzwDU2Lbrho
	UCNzU7O+/ZTUoNfquKTMmylkmIOHrPl26ZTsLBnKx+asr2x09Co4u5vNxgvNCQnRNhDnWG
	rP4b1xH0xRIEr4RMwgM3W2c7Om/R0rRdfFnCbzYWzMXQMYE9KmayoQoqy6htuEteElsEaW
	jzn2NLBRtT1oIoazJGbNRdNJnNn0yPJmkDlI+Koz96A73l89zgJ+8R9w4fJjDDU4cCpus+
	zpwTzL7aNZvPKLHp/kCJfB0t/CVPqcvSFIssh2fwzvOdLJe0nt1igDDesUFfJA==
Date: Thu, 14 Nov 2024 16:45:51 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <20241114164551.46664f5d@bootlin.com>
In-Reply-To: <ZzYWso5jLkUMehQ6@apocalypse>
References: <20241108094256.28933-1-andrea.porta@suse.com>
	<20241108110938.622014f5@bootlin.com>
	<Zy3koxz4KnV39__V@apocalypse>
	<ZzYWso5jLkUMehQ6@apocalypse>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrea,

On Thu, 14 Nov 2024 16:26:42 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> Hi,
> 
> On 11:14 Fri 08 Nov     , Andrea della Porta wrote:
> > Hi herve,
> > 
> > On 11:09 Fri 08 Nov     , Herve Codina wrote:  
> > > Hi Andrea,
> > > 
> > > On Fri,  8 Nov 2024 10:42:56 +0100
> > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > >   
> > > > When populating "ranges" property for a PCI bridge or endpoint,
> > > > of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> > > > In such PCI nodes, the window should instead be in PCI address space. Call
> > > > pci_bus_address() on the resource in order to obtain the PCI bus
> > > > address.
> > > > 
> > > > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > > This patch, originally preparatory for a bigger patchset (see [1]), has
> > > > been splitted in a standalone one for better management and because it
> > > > contains a bugfix which is probably of interest to stable branch.  
> > > 
> > > Nothing to say for the patch itself.
> > > 
> > > Just here, you mentioned "see [1]" but you didn't provide the link.
> > > 
> > > IMHO, this is not blocking for applying the patch but, just for other people
> > > looking at this email in the mailing list, can you reply providing the link?  
> > 
> > Thanks for pointing that out, sorry about that. Here it is:
> > 
> > [1] - https://lore.kernel.org/all/f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com/  
> 
> Do I have to resubmit the patch with the referenced url fixed or is it
> ok as it is?

This reference is after the '---' marker line and so will not be present in
the changelog once the patch is applied.

For this reason, I don't think you have to resubmit the patch.

If you need to resubmit the patch for any other reasons (resent because
the patch was applied, modification needed, ...) resubmit it with the
referenced url fixed.

Best regards,
Hervé

