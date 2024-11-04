Return-Path: <linux-pci+bounces-15912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0829BADA8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0384F281977
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598319D07C;
	Mon,  4 Nov 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WZTLngU3"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92F18C038;
	Mon,  4 Nov 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707598; cv=none; b=ZnlzMT9oaPmvGy0L6bnJmH0VQ9C4TsDwFv2k/emAS9HZeN6+5amy0F/CoOYKGTr5uDSlCJS/HosGZ/xpgxoD1L9sJdn3tuI3V4i1y/b31Szr+bqcG2mq0wCmi5rFeVEoTNWFmVeIe+LiW+V16+Vh/mgmOs9l4GOhsQVU17wQ/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707598; c=relaxed/simple;
	bh=ovlxMEF1fdY8GrNXop7zVMItJBA531CYe2fyXnuBqYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwqtyqTSbILDtfMPY5kTI/Xy1pYv1VP17Sr4dNv9IFF4JH32FGfpNe8Jew3527l0uIcmg2lNucqSTc+efKI9E2sO4HZvZSqc4h+4xrmHcIpOtN8iSNANwtV+Wi+joKTJzS1i89MI06y1+eQWpyC1IioQ2Ce4Cb9lW5tHv+avw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WZTLngU3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FA7DC0006;
	Mon,  4 Nov 2024 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730707587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3ntq14sieQxa1nhBG/basKlbuGIdYqCF0ESPB8PElU=;
	b=WZTLngU33wA/P1ULCFNo2JgdIohqG7zwdBL8zM67L7WMw9uEJiGJ9vs/OEHt1kdDHJa3QH
	1RDHwkC98KU6BybAQtrUfrhAa/EyKK7JFMlLJ1jVtsenVJZXYmui7HcXnZRUyksclcqJnP
	8Kxn7QV/GcKQat03HHpO1AUb86XPr0H8Kmt31fxqcq3vxWSwm3lGDQ0aUWlv3Wa45ECESx
	fLoTMGLcZQEE66wwOMWKZkgmalP6q6Xix7rUtKvVYj5nQGbsZLApYLepj0aGZStJ78Bb6t
	AkKE3j/Lt/y/SNGcvYbq8UX14Bj/rv1riWsKEyNWSVzs0YnpwrMeLhHeIgT7KQ==
Date: Mon, 4 Nov 2024 09:06:23 +0100
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
 <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU
 bus address to dynamic bridge nodes
Message-ID: <20241104090623.53f73d75@bootlin.com>
In-Reply-To: <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
	<f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
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

On Mon, 28 Oct 2024 15:07:22 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> bridge, the window should instead be in PCI address space. Call
> pci_bus_address() on the resource in order to obtain the PCI bus
> address.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Tested ok with my LAN966x PCI device.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

