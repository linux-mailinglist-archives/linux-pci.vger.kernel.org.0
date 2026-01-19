Return-Path: <linux-pci+bounces-45195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C677D3B30B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34EE930C3CCD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4928B4E2;
	Mon, 19 Jan 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qODxsMCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F02E762C
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841374; cv=none; b=afc7d3zjNq1QWKlSYPLOec/+tyHtT2iI6Wz1fBwntZo2MextpszXKm57eFhhHWuj0FtfPCeDjhwXRJfZFeZZkHgFVEx68B8pSFkdy5sElBwuPzt4Ne0SeboL23cF4aofbRbgTlu2w9x/huYUdNT2+KPJwPeTFg9D8gGt2g/dklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841374; c=relaxed/simple;
	bh=k1FvgBS3Py29dGl+fmxY4hqjo5AxP0UD6grp5Fwco2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHsUdKp5HJcTjQ/mQzrpZ/F7VrBtY/wpB7qgdKLwvFe3wOIg0VzaXWOXPEY5aR5ylbGBy/bQKFz2fYuuTfMhPWLoRYVBTZX6v5hUSKPNmBushh3MJ41zhBZ9iKDIYGcCDyf+wNEkmr8xiOrZgHRzjY1SyoVNRy0eaVgCicCy2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qODxsMCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C0C116C6;
	Mon, 19 Jan 2026 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841374;
	bh=k1FvgBS3Py29dGl+fmxY4hqjo5AxP0UD6grp5Fwco2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qODxsMCBQ77LhuxFtst0GkAvcxi3j+o7cCXAwXM1gtD85zbMIH2snlH0Fsj2W/86A
	 yTa3K1ExOLDQ9Ioh9kkOJ7SfWdmZ+0kC9EijU74qoDQXgmBY3L/FCZazzVfmheW9AH
	 UhHrQ4246n/Iaj0xoma2xlmSNntYtfyRbtMXd6ooRlxpESQe15Jvl/tGV2A9S3Bcdr
	 926hCH5OX9MvXh1VVeVP0/GkFeI9s8ZpEgo0vgdC0seHxgc6b1HkJp8sMh+CoFuPVR
	 4wVqWoHXNNTyvVm9Q9t5CSdrQPwQleUC8DnD+no5KdYabHd91osokGQOQUZA8K0IlJ
	 JoL/WUwlzn0zQ==
Date: Mon, 19 Jan 2026 16:49:29 +0000
From: Will Deacon <will@kernel.org>
To: Jess <jess@jessie.cafe>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: Avoid reporting incorrect "missing
 "reg" property" error
Message-ID: <aW5gmRDAlqR0Ii5S@willie-the-truck>
References: <20260119050745.27650-1-jess@jessie.cafe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119050745.27650-1-jess@jessie.cafe>

On Mon, Jan 19, 2026 at 06:06:45PM +1300, Jess wrote:
> When the function pci_host_common_ecam_create() calls
> of_address_to_resource() it assumes all errors from that callsite are due
> to a missing "reg" property in the device tree node.
> 
> This can manifest when running the qemu "virt" board, with a 32-bit kernel
> and `highmem=on`.
> 
> After the following calls:
> of_address_to_resource()
>   -> __of_address_to_resource()
>   -> __of_address_resource_bounds()
> 
> this overflow check can fail due to PCI being out of range:
> if (overflows_type(start, r->start))
> 	return -EOVERFLOW;
> 
> This leads to the very confusing error message:
> pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
> pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
> pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
> pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
> pci-host-generic 4010000000.pcie: missing "reg" property
> pci-host-generic 4010000000.pcie: probe with driver pci-host-generic failed with error -75
> 
> This commit gets rid of the confusing error message.
> 
> Link: https://www.qemu.org/docs/master/system/arm/virt.html
> Signed-off-by: Jess <jess@jessie.cafe>
> ---
>  drivers/pci/controller/pci-host-common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index c473e7c03bac..04e1fef70c9c 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -31,10 +31,8 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  	struct pci_config_window *cfg;
>  
>  	err = of_address_to_resource(dev->of_node, 0, &cfgres);
> -	if (err) {
> -		dev_err(dev, "missing \"reg\" property\n");
> +	if (err)
>  		return ERR_PTR(err);
> -	}

Maybe it would be better to print something more useful rather than removing
it entirely and leaving the poor luser guessing why their PCI isn't working?

How about one of:

	"missing or malformed \"reg\" property\n"
	"failed to parse ECAM base address from device-tree\n"
	"failed to get ECAM resource\n"

Will

