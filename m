Return-Path: <linux-pci+bounces-10841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9693D2D5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8700E1C20B0B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061417B428;
	Fri, 26 Jul 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMJHi9U+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUqgh+WZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963517B41B;
	Fri, 26 Jul 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995809; cv=none; b=id/faFU5NPDDoJlH0yCBuF4qW0xpxl9X4l3tR62hqVTA9+wHySKtNn+jsNdBo8zOhBC7r/nkQG1Qi2K3YUrZo2nfMskNwNklnYjdo7589uyQmJu0qz0GsReFqZl4BvzMBKBTrSWJ8+0dvnypHaANpp4pDvK0zpIQjfsJ1KPGk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995809; c=relaxed/simple;
	bh=PlMRijtqCm0MZ6n79QOvrnKsNAELqQTM+5n/uBS9kZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVE4nVmhVn91aVbCsOqCKfX3phKTtXskJfjkEoXRI/ciqFarJuQcwS8BTN8ERndAdMg7Eym5ZWCQB4CAS+IyQ+w/HWFM3JtSQO+V3Vq533OU9gxOoeRTC7bju3siNmdmdqMJFEGYkMlv9U7GBAvsblG6vxQPuSP6PWQmFlnMBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMJHi9U+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUqgh+WZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721995805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PlMRijtqCm0MZ6n79QOvrnKsNAELqQTM+5n/uBS9kZA=;
	b=hMJHi9U+xbjwzcO3srL9iaOPH7Y2McTHyRrgfTZs3Wndxtaogpvsk4tCVs40q5um/oJLQ3
	O6+2510Rm46HWKKYfW970fbKc6AXzyhTMofsK2vFdM7p1oRXAe7aix1HFoNLovkn3M5XE3
	gLxe1ZkWXMZYWzbLpiVG6ISrcWYUEYf6EobQXEzO9+VTZBuJiG/aGdzcXpTTGPJ/MDtDjV
	Sl4KRlUETXh9R6dt1hwlt+HeJ3KgQ2vcFHEA0+51fbVG72wkyR/kIfR3BU9xcI8fK457y+
	TTOCJ9KMRj7tKsFsPpMU+2IqUEhxCZneLI1atXLNYVTX9WxNGbwMRbGJ1CcaVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721995805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PlMRijtqCm0MZ6n79QOvrnKsNAELqQTM+5n/uBS9kZA=;
	b=GUqgh+WZUy9cUP3jH6HAQmwLB6N/rSRN+ld5YbX5w3t7JPVliPs2jdOAEv/aETNlXUk4lg
	EueW8xtjf15dmGCA==
To: Bjorn Helgaas <helgaas@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Pali
 =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Aleksandr Mishin <amishin@t-argos.ru>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Anup Patel
 <apatel@ventanamicro.com>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Daire
 McNamara <daire.mcnamara@microchip.com>, Damien Le Moal
 <dlemoal@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Jim Quinlan <jim2101024@gmail.com>, Jingoo
 Han <jingoohan1@gmail.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Jon Hunter <jonathanh@nvidia.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Joyce Ooi <joyce.ooi@intel.com>, Karthikeyan
 Mitran <m.karthikeyan@mobiveil.co.in>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Marc Zyngier <maz@kernel.org>, Michal
 Simek <michal.simek@amd.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Rob Herring
 <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 00/15] genirq/msi: Silence set affinity failed warning
In-Reply-To: <20240724154314.GA800620@bhelgaas>
References: <20240724154314.GA800620@bhelgaas>
Date: Fri, 26 Jul 2024 14:10:04 +0200
Message-ID: <87wml8uzfn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24 2024 at 10:43, Bjorn Helgaas wrote:
> Happy to apply this series via the PCI tree given an ack from Thomas.

Here you go:

Acked-by: Thomas Gleixner <tglx@linutronix.de>

