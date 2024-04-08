Return-Path: <linux-pci+bounces-5884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E3389BF4D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F621F216CA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24337BB1F;
	Mon,  8 Apr 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P39HssVx"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776C7BAF7;
	Mon,  8 Apr 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580221; cv=none; b=fVDxnpo4DOHywN2cgif/mkinq+8VGyAERYHplLr4tswAdW8oQu78rKWsH2RJzxvx6bOk73ovStqHv/2axqQtT1ygZEym3YJendHRoyquV4pLBwJURB7XKrvpGQ+S2kBOvlzpEJeHWrJRhbCUniKTimE86+DVooDkrFRrrRvUbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580221; c=relaxed/simple;
	bh=EHeLp8BG4YmTJLnNGQoteg6h/bg34plAh2da3ELzups=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyVBOjsObLAHZY5VCuZIEXwXaRZbMaae0sDJ6L2CN2ghg+4/FlzmeaIUhvG+UoGcfPT0p4VXrPSCRBHMLjFAHJIYC23O2VA2mAFIghXTTDZ5xh46BtQB4IlErAZG/lg7+NAEahCaHBieBKkWUDooUNsCImmvyGxkJTa1YYGTxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P39HssVx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D7FE1BF20A;
	Mon,  8 Apr 2024 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712580217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGb9QvvQMCEnKLy7lBueRK3Kn722zA1+bA5mCoVE8rc=;
	b=P39HssVxYttUmscR0T1RCbh+Ar5Zyp6gJsubxF/YeXwhBAOewcWkqNvdfiixNBpB3RAXEf
	aDgp7/CyW/dlEdtQIcERESZbyIPT91AEsoRNCS7CLdAbHVjTTpDRFQwMX8N/sdZEibqisa
	yRfe7jHJ+YXRpfujhylFClFi0Otsiir1CMhIC43a6WBn+eF0Jh3VkmWHR2J6xlUymaLac1
	Yp1jC8akzBD/l3MO4WQ85R4RQgdmlsS1/qHvZ4uKxEQ+RERtX9JI5lqyVte5fxD/wGZNyQ
	N1vA0A8Jw+mPRwvXTayIpPZpOkJ5aNK7QTaXzIUbv9fZ72IwV2D/Pf8gHY5XLg==
Date: Mon, 8 Apr 2024 14:43:35 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 Stefano Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20240408144335.5e9b6a2b@bootlin.com>
In-Reply-To: <20240325153919.199337-1-herve.codina@bootlin.com>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Mon, 25 Mar 2024 16:39:13 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> 
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created. For each PCI devices a struct
> device is already present (created and handled by the PCI core).
> 
> Creating a new device from a DT node leads to some kind of wrong struct
> device duplication to represent the exact same PCI device.
> 
> This patch series first introduces device_{add,remove}_of_node() in
> order to add or remove a newly created of_node to an already existing
> device. Then it fixes the DT node creation for PCI devices to add or
> remove the created node to the existing PCI device without any new
> device creation.
> 
> Compared to the previous iteration:
>   https://lore.kernel.org/all/20231130165700.685764-1-herve.codina@bootlin.com/
> this v3 series rewrap commit log.
> 
> The potential issue related to the sysfs of_node symlink added after the
> sysfs PCI device is visible from user-space (raised during the v2
> review) is maybe not a problem according to Bjorn:
>   https://lore.kernel.org/all/20240319165430.GA1233494@bhelgaas/
> 
> IMHO, the discussions started with Rob around the interrupt-controller
> during the v2 review are out of the issue this specific series tries to
> fix. Some modifications are needed for the interrupt-controller topic
> but should be done in a specific series.
> 
> Best regards,
> Hervé
> 

I have received no feedback on this v3 series.
I know maintainers are busy but I would like to be sure that this series was
not simply missed.

Best regards,
Hervé

