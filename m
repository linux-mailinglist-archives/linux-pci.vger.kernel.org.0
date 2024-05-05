Return-Path: <linux-pci+bounces-7094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5158BBF60
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 07:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BB51F21642
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764C1C36;
	Sun,  5 May 2024 05:45:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252461878;
	Sun,  5 May 2024 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714887920; cv=none; b=K8EdV1gNNH+Y+gQM7SSaXYubRWZ/0ffaQJ4ju3WRh4LJD/9jU12muXMZxbrwfhugEmldMkXwEXOjpHU5tZQoPqeKaPTUHOuJU0G7TEAlmrtuOWhDCCbHTMvhz1MW+Az3PT0/l0MuwzoVRg5+Oo/uepXoGTee3rIRQoVTCJ+ieVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714887920; c=relaxed/simple;
	bh=iKYqSQ0o1WVtotuE2t0+4AkmIWAyJXmh3LblzVQCMNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+9rcbgqo8mVYITozalu1Ge/apww+gUDBZiSLKulxoQ/O6FvqPz2xe28MClcN3AKijA5zOayJa72DDPjTut3cmUvWkYwTE2HI7sLHlJYV71b1I2a01AnwBfE8hp1x0lGFHsDUAQf1Az4DIYwimPKRJ1MW8btSgM5xQ25aKZyq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B363C30010C93;
	Sun,  5 May 2024 07:45:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 708A448D1A4; Sun,  5 May 2024 07:45:13 +0200 (CEST)
Date: Sun, 5 May 2024 07:45:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <Zjcc6Suf5HmmZVM9@wunner.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>

[cc += Ilpo, Mika]

On Sat, May 04, 2024 at 06:15:22PM +0200, Nam Cao wrote:
> If a bridge is hot-added without any bus number available for its
> downstream bus, pci_hp_add_bridge() will fail. However, the driver
> proceeds regardless, and the kernel crashes.
[...]
> Fix this by aborting the hot-plug if pci_hp_add_bridge() fails.
[...]
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -58,8 +58,10 @@ int pciehp_configure_device(struct controller *ctrl)
>  		goto out;
>  	}
>  
> -	for_each_pci_bridge(dev, parent)
> -		pci_hp_add_bridge(dev);
> +	for_each_pci_bridge(dev, parent) {
> +		if (pci_hp_add_bridge(dev))
> +			goto out;
> +	}
>  
>  	pci_assign_unassigned_bridge_resources(bridge);
>  	pcie_bus_configure_settings(parent);

Are the curly braces even necessary?

FWIW, the rationale for returning 0 (success) in this case is that
pciehp has done its job by bringing up the slot and enumerating the
bridge in the slot.  It's not pciehp's fault that the hierarchy
cannot be extended further below the hot-added bridge.

Have you gone through the testing steps you spoke of earlier
(replacing the hot-added bridge with an Ethernet card) and do
they work correctly with this patch?

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

