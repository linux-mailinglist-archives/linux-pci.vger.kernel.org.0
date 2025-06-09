Return-Path: <linux-pci+bounces-29234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D1AD2223
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8087A3451
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF01FBE8B;
	Mon,  9 Jun 2025 15:16:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633815DBB3
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482197; cv=none; b=m2U48vribyMB4l4324PYMZYZ+U7qXNcZZL5c0wE6BWFZGVPflKGlDYl5RzDNN0OUlrX9HqJp1L57H4KPrHUNuYvH1CaN/PBsLqratusH/mZQHgKbFlr/RHaNBOn+RVSERT0dfQ1u1Hk+1F63ct3whqfelYQu3ouTz/Ej2pgKeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482197; c=relaxed/simple;
	bh=B+Ys2g5kqyW1HnmXhyNYw869FNzbMKe6OmFZB4ZBpOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDvvbVgnuIr0cgVO/O9G6ZfGO+9Pwi+WXWJ8mwjiysXQ3/+/k0mZBxpvIQNzFvyETnbbInBkIgpHZakHq00aMo2ThwZT8V+YiFjeBV6Xvt6pE/xgb69MSZP0hMaRZpvYaG/IwfNNE1xw0z1pljumX881iD6rqU/knwInQ1SA6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4016D2C0666B;
	Mon,  9 Jun 2025 17:16:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 258B635A1BE; Mon,  9 Jun 2025 17:16:33 +0200 (CEST)
Date: Mon, 9 Jun 2025 17:16:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/4] PCI: Fix runtime PM usage count underflow
Message-ID: <aEb60TkaaLZ3kKIT@wunner.de>
References: <20250609020223.269407-1-superm1@kernel.org>
 <20250609020223.269407-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609020223.269407-3-superm1@kernel.org>

[cc += Rafael, Mika]

On Sun, Jun 08, 2025 at 08:58:02PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> remove issue a "Link Down" and "Card not detected event". The PCI core

Nit: s/remove//

> will treat this as a surprise hotplug event and unconfigure all downstream
> devices. This involves setting the device error state to
> `pci_channel_io_perm_failure`.
> 
> When PCI core gets to the point that the device is removed using
> pci_device_remove() the runtime count has already been decremented and
> so calling pm_runtime_put_sync() will cause an underflow.

Where has it been decremented?  I think this needs to be identified
and a Fixes tag added.

> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -479,7 +479,8 @@ static void pci_device_remove(struct device *dev)
>  	pci_iov_remove(pci_dev);
>  
>  	/* Undo the runtime PM settings in local_pci_probe() */
> -	pm_runtime_put_sync(dev);
> +	if (pci_dev->error_state != pci_channel_io_perm_failure)
> +		pm_runtime_put_sync(dev);

Usually pci_dev_is_disconnected() is used in lieu of checking for
the error_state directly.

Thanks,

Lukas

