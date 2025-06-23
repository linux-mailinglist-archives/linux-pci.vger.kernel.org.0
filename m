Return-Path: <linux-pci+bounces-30344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44116AE35FA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5D1892121
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635521E0DE8;
	Mon, 23 Jun 2025 06:43:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D3155CBD;
	Mon, 23 Jun 2025 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661018; cv=none; b=pW8rnZ3sgG96e/oIkeH9DfNn2CkqIVgoyaFG2ywdqnZjEcsMSHNiG7X2lcgG3Exz7pXNsp3nJK4YjfyexQOD0iXJxjWCUk9UwID4HBu4oO9K3TrvLHxCpb+ggFYsBSQ4Ws35XfTbj1kDfA4IG2AMTtXaUXHbNW1jmp5IB1OQWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661018; c=relaxed/simple;
	bh=9PdGgbGKKUnTTw/LJl5rGRpxzu/5LUDwbLFp/xtn7b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmdmpsY4tY/mYjcvSktotDA7cQAFUEb5mpsQV0sLFQUtuorBzTumhQfQ8GdEjXnfz3VeIugvHQDH3/YT1M94xuVqdJ7+0lJdnwC5dv805xQzkBf5NsOnGa+cozZL2HfqBOFhOCwVmxQOarRSX8M8zcZevXA88q4U6fOEdi9ZUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 053E62C00093;
	Mon, 23 Jun 2025 08:43:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D8717100451; Mon, 23 Jun 2025 08:43:25 +0200 (CEST)
Date: Mon, 23 Jun 2025 08:43:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFj3jUAM42lSyfpe@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>

On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
> > > On 6/21/25 2:05 PM, Lukas Wunner wrote:
> > > > So the refcount decrement happens in pcie_portdrv_probe() and
> > > > the refcount increment happens in pcie_portdrv_remove().
> > > > Both times it's conditional on pci_bridge_d3_possible().
> > > > Does that return a different value on probe versus remove?
> 
> I did this check and yes specifically on this PCIe port with the underflow
> the d3 possible lookup returns false during pcie_portdrv_remove().  It
> returns true during pcie_portdrv_probe().

That's not supposed to happen.  The expectation is that
pci_bridge_d3_possible() always returns the same value.

For this reason the return value on ->probe() isn't cached.

So which of the conditions changes in pci_bridge_d3_possible()
on probe versus remove?  Could you instrument each with a printk()
so that we can understand what's going wrong there?

Thanks,

Lukas

