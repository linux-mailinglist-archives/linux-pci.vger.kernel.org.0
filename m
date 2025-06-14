Return-Path: <linux-pci+bounces-29808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0967AD9B08
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 09:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B533B68BA
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8204501A;
	Sat, 14 Jun 2025 07:30:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D323DE;
	Sat, 14 Jun 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749886238; cv=none; b=WMOow+6WggHlHU8/8pe/wy2APCRsz/s/oBgaIXViraaSYwTDsVxKofDS9qK3+COhwhlRJyCtMgz3AjF9h9TE65VO9KHC1DX3ml/0k0G2xOeftYkniQAPLn3XHuD17n6SMhyX6MuBBQNBJ8QkGQ09KwIIyMObu3ES379TUScSm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749886238; c=relaxed/simple;
	bh=MadO4gTXr+2Vpe9eCLLAieFLNZEuK8HDNArYqbpaeUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMseGAVE5RwAMjLofKJY9oH9hGghPBS7gSGcNa/qUI5jDKMWONEWxBdAYfJpuMtM0at4pH9qiMot9ttgrE1scn1Sr+bp8gX0M6jsrYn0KIAfA8+//5VJ0NV4/OxNFhr9c3s+r26zzHvomAzb2SAAmF8Int3LEe48vDEvHtE/Lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B908C2C0AD0B;
	Sat, 14 Jun 2025 09:30:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 781C02DEC12; Sat, 14 Jun 2025 09:30:33 +0200 (CEST)
Date: Sat, 14 Jun 2025 09:30:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition
 to drivers/pci/pwrctrl/
Message-ID: <aE0lGcYO1asrwb9z@wunner.de>
References: <20250614052651.15055-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614052651.15055-1-mani@kernel.org>

On Sat, Jun 14, 2025 at 10:56:51AM +0530, Manivannan Sadhasivam wrote:
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,36 +2508,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct platform_device *pdev;
> -	struct device_node *np;

Looks like...

	#include <linux/of_platform.h>
	#include <linux/platform_device.h>

...can also be removed from probe.c, both introduced by 957f40d039a9.

Thanks,

Lukas

