Return-Path: <linux-pci+bounces-16316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E89C19FE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 11:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A132328217C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AC1E0E15;
	Fri,  8 Nov 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o7pO4ipd"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAB13A27D;
	Fri,  8 Nov 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060594; cv=none; b=ngWUhAMnjYpMD7txMmM813eotcSjbloX96BRgLcKxGbhNTm9ITArgjvalbw1UTx8uFBA9+mPv+YZyMxWYzWZOpGneteeWQXUuLZM7r7ee5nNsPwMoKLygX8pHgfmCAB5IS5OHQUtkYKW84w1FqFqb2Ys3WQVzSMZE3z0wj65zN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060594; c=relaxed/simple;
	bh=/Owre8X2bmyFdWdh5IzgAEzR4u/DVf5RnbdecLrI8gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glWOhjDKA0webCd4ysQSF+paDdRT35EPeYGFTpVVwBqx7RnRioObthglULoDvTubDOmtGdqfVrNnf1NL1qQE5bI3QYlDK6wUC3cc0R40UKREx8TgBttXLG/xy46jjyksRbox6xZ2jX2Dq0SbMMuGoM+SoB4icF7JWZa6FfNR3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o7pO4ipd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A32631C0004;
	Fri,  8 Nov 2024 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731060583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zo9a3WX+AKY7z29IK1TOw93r3Q+54c84vMyZ0f7WcbU=;
	b=o7pO4ipdihEntoMdvZqFEKJjTRZ7/CeS3sgg7kh+laZ9rFh+g4vs5Sps91RvX9Vvuy0DVU
	+Fu3Am+YaWELSYw33/fpYLgb/sFnkcQF3P0w7jllmxDrVQ5bA/0b2g5TFhKrygAOPEFi5P
	WD3Lwb4z6eVmrjDHe8uYBFLQyZ0hXBeC+CUDP0ErV6zCzvvTSYDDyUq1c61/HEjPHydjzY
	cNEkSE+2xQ00+zc2gUacgr93r35achp3BRsCupJlsrBkrJAfVWpF49gK/8zBO4npsf9QCH
	54tRNmFjjkDcnBPe668b5XKqzVMMcu6Pec56U8mD2mUzXMQ8NZQu0a2VpkEX1Q==
Date: Fri, 8 Nov 2024 11:09:38 +0100
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
Message-ID: <20241108110938.622014f5@bootlin.com>
In-Reply-To: <20241108094256.28933-1-andrea.porta@suse.com>
References: <20241108094256.28933-1-andrea.porta@suse.com>
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

On Fri,  8 Nov 2024 10:42:56 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> When populating "ranges" property for a PCI bridge or endpoint,
> of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> In such PCI nodes, the window should instead be in PCI address space. Call
> pci_bus_address() on the resource in order to obtain the PCI bus
> address.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> ---
> This patch, originally preparatory for a bigger patchset (see [1]), has
> been splitted in a standalone one for better management and because it
> contains a bugfix which is probably of interest to stable branch.

Nothing to say for the patch itself.

Just here, you mentioned "see [1]" but you didn't provide the link.

IMHO, this is not blocking for applying the patch but, just for other people
looking at this email in the mailing list, can you reply providing the link?

Best regards,
Hervé

