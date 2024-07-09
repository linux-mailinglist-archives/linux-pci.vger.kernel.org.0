Return-Path: <linux-pci+bounces-10025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C57E92C548
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 23:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5131C22257
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674C18560C;
	Tue,  9 Jul 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMkTOxIZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE45153505;
	Tue,  9 Jul 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560257; cv=none; b=KIXwiN00/2e1F/Ax/ad17C4gJmUYNECzkd2NGkwKknWIlo9nzTfchVrJhrN7SoMG/Qj4YJ/6X5iNF+7kaW918akQi9MSzydS6W1FaVO/LkH0G7rRnfrgmZKr08ZgYUI9AkUm4XUUrDJr+4lRgXwdqTg3bK7bQM3iqk/hr9x+7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560257; c=relaxed/simple;
	bh=ackfSi8OiTLwz/d7tspezHbK2PcEiMUA3gVdLVR6r2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N+Nh2CM5CI9rBaCYTwVLhAINP024KG+Z7hZZZ9cpHFw0yvBHcwx4u7MK2pxgT0Z6mWRUTVkE/FOBs9UL0Xh0a+sRDTPbQr/iw8EklpC9xsz+Aud3+3E0w4LhazJCzOj45DN17pzrMp2fBKozWgoPgYav67qqFAKwLmRVlVu0VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMkTOxIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E2C32786;
	Tue,  9 Jul 2024 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720560257;
	bh=ackfSi8OiTLwz/d7tspezHbK2PcEiMUA3gVdLVR6r2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iMkTOxIZilL8xjSe62Kc/G9GBGGWn/oPb6Hm1EXxAswCBkN2a78oho7OwaVv37ipU
	 i5Wyimy/vuxTvQm4zBx7EzSB1oKUC+PaAA6uNtIUy1wsiSq5YbG53QFn2LFuPZItkd
	 My99nIZRd5fGn5+urGIXFgg4rfrlyLUqYpJXk3MXldVSjcPpSgruPSVdUsnalweF0X
	 VjDMgfzsLwKSYn+wgeDLr8hPBvF0Y6/vJ2jNKp0gQUFl52NpI3Ierk3abnrdJHlpJI
	 Z3MRnXC7klqlUkTsOy7i+wcCBIqWmY2W/aokZ0gsyZHwfMVOGKZks+49t0CzIQ5zRF
	 b30MlcNfLW25Q==
Date: Tue, 9 Jul 2024 16:24:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Message-ID: <20240709212414.GA195866@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612065315.2048110-1-chenhuacai@loongson.cn>

On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> LS7A chipset can be used as a downstream bridge which connected to a
> high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
> upward port. We should always enable MSI caps of this port, otherwise
> downstream devices cannot use MSI.

Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in PCIe
terms, it is basically a PCI host bridge (Root Complex, if you prefer)
that is materialized as a PCI Endpoint?

I'm curious about what's going on here because the normal PCI MSI
support should set PCI_MSI_FLAGS_ENABLE since it's completely
specified by the spec, which says it controls whether *this function*
can use MSI.

But in this case PCI_MSI_FLAGS_ENABLE seems to have non-architected
behavior of controlling MSI from *other* devices below this host
bridge?  That's a little bit weird too because MSI looks like DMA to
any bridges upstream from the device that is using MSI, and the Bus
Master Enable bit in those bridges controls whether they forward those
MSI DMA accesses upstream.  And of course the PCI core should already
make sure those bridges have Bus Master Enable set when downstream
devices use MSI.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sheng Wu <wusheng@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 8b34ccff073a..ffc581605834 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -163,6 +163,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_HDMI, loongson_pci_pin_quirk);
>  
> +static void loongson_pci_msi_quirk(struct pci_dev *dev)
> +{
> +	u16 val, class = dev->class >> 8;
> +
> +	if (class == PCI_CLASS_BRIDGE_HOST) {
> +		pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &val);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, val);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> -- 
> 2.43.0
> 

