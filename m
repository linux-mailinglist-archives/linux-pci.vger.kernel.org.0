Return-Path: <linux-pci+bounces-16242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EC9C08BB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79182B23031
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049B212D2D;
	Thu,  7 Nov 2024 14:17:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BA212D16
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989072; cv=none; b=gwdW4PSMH4nPvdPM/4hJuj8SvtO/syrYY9SKzgUpsyF3VhLTjJVHx9qNRlefhqWpejPw44RmjdXDmxSrrFEbu5p+I0jWpcwDGbU9jnkfB2ubqBIzoYU6pcqxM9Tj8wG04jTq71SmlnvMlFfiyWEawQnOvn9+0lWKjThjqlvtovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989072; c=relaxed/simple;
	bh=rrWDaP6KlllODxsfeLIwF8b7UiCLWLUZGjSPTK7BuX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OToylsG1ghVm3Fn03DOMalhEh9VTbywB53pFcGOYdxpetT5FR0iiJiIIJj0KGNbgy8lPxC1BFkcZ+fkw4rn6O2Kb0CX5MdKW5EnquL4co5fDrybnrf+g6Nrnss5nV8szkUXO1nurN1a4vk450pwEdyJwzXDnocUHVqxKUZ/KiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7AB753000A468;
	Thu,  7 Nov 2024 15:06:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 691C11783C; Thu,  7 Nov 2024 15:06:57 +0100 (CET)
Date: Thu, 7 Nov 2024 15:06:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv3 1/5] pci: make pci_stop_dev concurrent safe
Message-ID: <ZyzJgaEOJOKmh_xw@wunner.de>
References: <20241022224851.340648-1-kbusch@meta.com>
 <20241022224851.340648-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224851.340648-2-kbusch@meta.com>

On Tue, Oct 22, 2024 at 03:48:47PM -0700, Keith Busch wrote:
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -31,18 +31,16 @@ static int pci_pwrctl_unregister(struct device *dev, void *data)
>  
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
> -	pci_pme_active(dev, false);
> -
> -	if (pci_dev_is_added(dev)) {
> -		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> -				      pci_pwrctl_unregister);
> -		device_release_driver(&dev->dev);
> -		pci_proc_detach_device(dev);
> -		pci_remove_sysfs_dev_files(dev);
> -		of_pci_remove_node(dev);
> +	if (!pci_dev_test_and_clear_added(dev))
> +		return;
>  
> -		pci_dev_assign_added(dev, false);
> -	}
> +	pci_pme_active(dev, false);
> +	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> +			      pci_pwrctl_unregister);
> +	device_release_driver(&dev->dev);
> +	pci_proc_detach_device(dev);
> +	pci_remove_sysfs_dev_files(dev);
> +	of_pci_remove_node(dev);
>  }

The above is now queued for v6.13 as commit 6d6d962a8dc2 on pci/locking.

I note there's a behavioral change here:

Previously "pci_pme_active(dev, false)" was called unconditionally,
now only if the "added" flag has been set.  The commit message
doesn't explain why this change is fine, so perhaps it's inadvertent?

Thanks,

Lukas

