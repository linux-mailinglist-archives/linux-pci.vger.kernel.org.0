Return-Path: <linux-pci+bounces-33224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D91B16BD0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 08:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A243818C650E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088224466F;
	Thu, 31 Jul 2025 06:00:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F5242D64;
	Thu, 31 Jul 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941605; cv=none; b=hwcQ3jOw5OLPlyBJ1GTELUS+GrJkcUhxnRqW7DAh7DjC1gTcGnZH00yZWxJNNjlxxH1HBcdmjrb+XQBGb4LUAm9hj64TPPnjPeVKgi+amzLmssHPjAAmAfChd5bCZgPhju4GqoNOusIbGZrJfubrZVV53TWmOFZaa7YjKdDHICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941605; c=relaxed/simple;
	bh=qzx2HM+xJ8zdEsDI6WUZDT8nLtsbo7xOZ/EvbnECIj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaO336d5unVwpCVsepk2nFi/HZF2YqVWYnINmU9f+CyqewnD+SUpPRlbnKUBge4aZ/Yx7TKWBdOlPoZ09gnrMKoFIhc/p49ua4xxqb5Vx/fNhbWqnaIML87FAeZwAAYLEa8XFYWfoBdirgiHb7J5893EwFfpAR10/ihQRsopgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4BAB92C06649;
	Thu, 31 Jul 2025 07:59:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 270192A9D4D; Thu, 31 Jul 2025 07:59:59 +0200 (CEST)
Date: Thu, 31 Jul 2025 07:59:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 05/16] PCI: PCIe portdrv: Add interface for getting CXL
 isolation IRQ
Message-ID: <aIsGX3wPKN-PdXis@wunner.de>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-6-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730214718.10679-6-Benjamin.Cheatham@amd.com>

On Wed, Jul 30, 2025 at 04:47:07PM -0500, Ben Cheatham wrote:
> Add a function to the CXL isolation service driver that allows the CXL
> core to get the necessary information for setting up an interrupt
> handler.
[...]
>  static int cxl_isolation_probe(struct pcie_device *dev)
>  {
> -	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
> +	struct cxl_isolation_info *info;
> +	if (!pcie_is_cxl(dev->port) ||
> +	    pcie_cxliso_get_intr_vec(dev->port, NULL))
>  		return -ENXIO;

The re-wrapping of the if-condition shouldn't be here, it should be
wrapped the way you want it in the patch *introducing* the if-condition.

> +	info = devm_kzalloc(&dev->device, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	*info = (struct cxl_isolation_info) {
> +		.dev = &dev->device,
> +		.irq = dev->irq,
> +	};
> +
> +	set_service_data(dev, info);

No, the irq is already saved in struct pcie_device, there's no need
to duplicate that.

> +struct cxl_isolation_info *
> +pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev)
> +{
> +	struct device *dev;
>  
> +	dev = pcie_port_find_device(dport_dev, PCIE_PORT_SERVICE_CXLISO);
> +	if (!dev)
> +		return NULL;
> +
> +	return get_service_data(to_pcie_device(dev));
>  }

Just retrieve the irq from to_pcie_device(dev) and either return it
directly or through a call-by-reference parameter.

Thanks,

Lukas

