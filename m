Return-Path: <linux-pci+bounces-44415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED4D0D06A
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450B1301AE0C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB61E8329;
	Sat, 10 Jan 2026 06:11:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E50095F;
	Sat, 10 Jan 2026 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768025464; cv=none; b=T4MtjT7nrqIO36T2IAuXY8I37WMBLPYsNe8OCYtHpVjrU8rRG8WD9njpSpoaene1eZCT2T6Xy8GDCW/06cjcIdV27qcZrHegL3yaiVwwi+LX5SOCqozY/rp4xbgJykVzntvtxmhkEJPtCqIH+aHS9WmDpn0s/3jd3gBx3J7Bt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768025464; c=relaxed/simple;
	bh=zHXg2cJW/jADoc7g2QanJdTj9k1rb5ZjyZEla7HVPUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkgMAKTlIwIl4R6JXXW5U2vs6JfaUnVZRs4KR6ImZRSRbdD6PT+dhS1uzQyv+bjpbW0V8fElswO14XCkJLmWqu8o1sldwcz/E6z8WGMH4vlMREc4qExgisnPs1A2mTUsYGc1uH7eeq2q6iQlN6CpMgQHbDxSkap98VJvQyYVAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 04FD52C06674;
	Sat, 10 Jan 2026 07:10:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CB4B93111C; Sat, 10 Jan 2026 07:10:52 +0100 (CET)
Date: Sat, 10 Jan 2026 07:10:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Allow probing even without child services
Message-ID: <aWHtbGzVRRpa9kd0@wunner.de>
References: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>

On Fri, Jan 09, 2026 at 03:20:13PM -0800, Brian Norris wrote:
> @@ -355,29 +355,18 @@ static int pcie_port_device_register(struct pci_dev *dev)
>  	if (status) {
>  		capabilities &= PCIE_PORT_SERVICE_HP;
>  		if (!capabilities)
> -			goto error_disable;
> +			return 0;
>  	}

This will keep the Bus Master Enable bit set (see call to
pci_set_master() further up in the function), even though
no MSIs are expected from the device.  (I *think* these
would be the only memory writes that a port would perform.)

That doesn't seem right.  If there are no services, it seems
prudent to clear Bus Master Enable again (as is done by
pci_disable_device() right now).

>  	/* Allocate child services if any */
> -	status = -ENODEV;
> -	nr_service = 0;
>  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
>  		int service = 1 << i;
>  		if (!(capabilities & service))
>  			continue;
> -		if (!pcie_device_init(dev, service, irqs[i]))
> -			nr_service++;
> +		pcie_device_init(dev, service, irqs[i]);
>  	}
> -	if (!nr_service)
> -		goto error_cleanup_irqs;

Same here.  Why keep Bus Master Enable bit set and MSIs requested
if none of the port services probed successfully?

> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that
> case. However, the driver *can* still be useful for power management
> support -- namely, it still configures the port for runtime PM / D3,
> which may be important for allowing a bridge to enter low power modes.
> 
> Thus, we allow probe to succeed even if no IRQs and no child services
> are available. This also mirrors existing behavior for ports that have
> no PCIe capabilities, where we'd also probe successfully.

Nit:  Please use imperative mood, i.e. "Thus, allow probe to succeed..."

Thanks,

Lukas

