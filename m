Return-Path: <linux-pci+bounces-6554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2C8ADFC0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489101C21B09
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60520310;
	Tue, 23 Apr 2024 08:31:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3C79D3;
	Tue, 23 Apr 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861097; cv=none; b=Of95e05QGBC9O2Vi3Jpk+2nObBgS+a4r0Bk/Xa7yYWv6ivumcA1ulD6kCnkrcuurycENiP88G9aLnbzA91+KR972FK2Y+Z5O9RyylZrY/hzcVWc0IZRllNJoXLIa2kbIPFJWESpCCGEZ6Ahw8e3dsqwuAleiR304oXWHVVzMzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861097; c=relaxed/simple;
	bh=8x0r0T5MB8m4NAc+KSUCSNVRU7J7wJFu67VI65GGPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBCZzp2COg5WGNcWFjjKgQ47qm4MdPCN80Aw7ocS8QgCP2kCuTGH/hQ/w+aA5XbjS22mOlZU9eKEGpJjprnPRfPywYM7SOtTTxElqZwLvgCheNluxyUoa4gKAuIGB6owDaXn18j6nxfbwLJEgapZQnwgQ56aiKeMtn9yZ1vpYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D411C28141EB1;
	Tue, 23 Apr 2024 10:31:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CDA7B4C5F0; Tue, 23 Apr 2024 10:31:30 +0200 (CEST)
Date: Tue, 23 Apr 2024 10:31:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <Zidx4lV2303H88R_@wunner.de>
References: <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423053312.GY112498@black.fi.intel.com>

On Tue, Apr 23, 2024 at 08:33:12AM +0300, Mika Westerberg wrote:
> I think what you are looking for is that anything behind a PCIe tunnel
> should not have this applied. IIRC the AMD GPU or some code there were
> going to add identification of "virtual" links to the bandwidth
> calculation functionality.

I guess I could resurrect my correlation patch:

https://lore.kernel.org/all/f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de/

The last time I forward-ported it was for v5.13.  I still have that code
running on my development machine.

The problem is that it only allows lookup from tb_port to pci_dev.
I'd have to add a pointer to struct pci_dev to allow lookups in the
inverse direction.  Though I think we have such PCI companion devices
for CXL as well, so such a pointer could be useful in general.

I'm knee-deep in PCI device authentication code but could probably
dedicate a weekend to the correlation patch if there's interest?

Once we have correlation, we can expose more precise bandwidth
for virtual PCI links in sysfs.

Thanks,

Lukas

