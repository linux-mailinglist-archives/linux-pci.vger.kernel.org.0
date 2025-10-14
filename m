Return-Path: <linux-pci+bounces-38040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4BBD915C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D3E3A3698
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA362E2EF0;
	Tue, 14 Oct 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TWReYMcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340B2F6583;
	Tue, 14 Oct 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442369; cv=none; b=ZeTiYbYLwbZ4IU/22KjieLr2LX1/MIhDjO4tx9SQj6sJZ7eNJjGHemvNBY6PiwrhUoCVtrQtGFZnwOjCIFeEiJsklnuMSusirXdb4FBzRF1f3K5zxZpPkSdBQBVpDZfeyL9xf4rceC/jDkp6ITiNsjtrTfDpwUMafskQk9umaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442369; c=relaxed/simple;
	bh=zh3gtbXSbad8n/WFENsjqEdQRtU1t+VuBKeLZcIuCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hZISR3xSN8uc1wUFgPOXVaTowizh3iPAUo6h4tdGE+nlZTix7ynYAhQv9xJrI7VXuISOlqIvW7AeXR5k7AWFsPI1a6MJ3rxW0yc4YUZdOG7J0FBrRJR/y9aF6LBjSALAuYFM+qEYPodRiLmui72N4ekCgsX8owZP0Vzxt4pmmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TWReYMcO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760442365;
	bh=zh3gtbXSbad8n/WFENsjqEdQRtU1t+VuBKeLZcIuCyo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TWReYMcOyfclxK+44jSQmchHsdlk6IIef/vqhGJE23lcMjrpnO1Et34zR/cQq9kAk
	 rF+UbcMdgKjdvHYxxYigA1FNNnSZ3nfkkodefswzCN001LJtvDcFzbeXa6Owr7s6iS
	 9qqkgib6MMZl3D+nKgBqOxrHD5fUnuPrRb7+EqtlOF3CWMNmEaxwfKLLK1CAzdFR4A
	 l8Mar11CgfjWBkTS8lRDK2CziF+KrWXUnkTzhes4Ic1hPC5QEg7omk9FlxRTNwsn15
	 yn5LdbSMY6dILtHYJxYEPEhzlfYPFESHmJnhXXqvrF09tA+TzQNy52wKKmcriF2AiQ
	 3u2sVnc+uOG0Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 516D217E013C;
	Tue, 14 Oct 2025 13:46:05 +0200 (CEST)
Message-ID: <675d5338-09f0-439b-b22c-a3d50b243b5e@collabora.com>
Date: Tue, 14 Oct 2025 13:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] PCI: mediatek: convert bool to single flags entry
 and bitmap
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-5-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251012205900.5948-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/10/25 22:56, Christian Marangi ha scritto:
> To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
> use a single flags to reference all the values. This permits cleaner
> addition of new flag without having to define a new bool in the struct.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/pci/controller/pcie-mediatek.c | 28 +++++++++++++++-----------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 24cc30a2ab6c..1678461e56d3 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -142,24 +142,29 @@
>   
>   struct mtk_pcie_port;
>   
> +enum mtk_pcie_flags {

enum mtk_pcie_quirks seems to be a better fit here, as this is used for... well..
quirks.

> +	NEED_FIX_CLASS_ID = BIT(0), /* host's class ID needed to be fixed */
> +	NEED_FIX_DEVICE_ID = BIT(1), /* host's device ID needed to be fixed */
> +	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
> +			  * external block
> +			  */

Also perhaps... MTK_PCIE_FIX_CLASS_ID, MTK_PCIE_FIX_DEV_ID, MTK_PCIE_NO_MSI

> +};
> +
>   /**
>    * struct mtk_pcie_soc - differentiate between host generations
> - * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> - * @need_fix_device_id: whether this host's device ID needed to be fixed or not
>    * @no_msi: Bridge has no MSI support, and relies on an external block
>    * @device_id: device ID which this host need to be fixed
>    * @ops: pointer to configuration access functions
>    * @startup: pointer to controller setting functions
>    * @setup_irq: pointer to initialize IRQ functions
> + * @flags: pcie device flags.
>    */
>   struct mtk_pcie_soc {
> -	bool need_fix_class_id;
> -	bool need_fix_device_id;
> -	bool no_msi;
>   	unsigned int device_id;
>   	struct pci_ops *ops;
>   	int (*startup)(struct mtk_pcie_port *port);
>   	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> +	u32 flags;

u32 flags -> enum mtk_pcie_quirks quirks

Cheers,
Angelo

>   };
>   
>   /**
> @@ -703,7 +708,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>   	writel(val, port->base + PCIE_RST_CTRL);
>   
>   	/* Set up vendor ID and class code */
> -	if (soc->need_fix_class_id) {
> +	if (soc->flags & NEED_FIX_CLASS_ID) {
>   		val = PCI_VENDOR_ID_MEDIATEK;
>   		writew(val, port->base + PCIE_CONF_VEND_ID);
>   
> @@ -711,7 +716,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>   		writew(val, port->base + PCIE_CONF_CLASS_ID);
>   	}
>   
> -	if (soc->need_fix_device_id)
> +	if (soc->flags & NEED_FIX_DEVICE_ID)
>   		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
>   
>   	/* 100ms timeout value should be enough for Gen1/2 training */
> @@ -1099,7 +1104,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>   
>   	host->ops = pcie->soc->ops;
>   	host->sysdata = pcie;
> -	host->msi_domain = pcie->soc->no_msi;
> +	host->msi_domain = !!(pcie->soc->flags & NO_MSI);
>   
>   	err = pci_host_probe(host);
>   	if (err)
> @@ -1187,9 +1192,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> -	.no_msi = true,
>   	.ops = &mtk_pcie_ops,
>   	.startup = mtk_pcie_startup_port,
> +	.flags = NO_MSI,
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> @@ -1199,19 +1204,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> -	.need_fix_class_id = true,
>   	.ops = &mtk_pcie_ops_v2,
>   	.startup = mtk_pcie_startup_port_v2,
>   	.setup_irq = mtk_pcie_setup_irq,
> +	.flags = NEED_FIX_CLASS_ID,
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> -	.need_fix_class_id = true,
> -	.need_fix_device_id = true,
>   	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
>   	.ops = &mtk_pcie_ops_v2,
>   	.startup = mtk_pcie_startup_port_v2,
>   	.setup_irq = mtk_pcie_setup_irq,
> +	.flags = NEED_FIX_CLASS_ID | NEED_FIX_DEVICE_ID,
>   };
>   
>   static const struct of_device_id mtk_pcie_ids[] = {



