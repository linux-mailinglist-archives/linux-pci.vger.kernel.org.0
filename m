Return-Path: <linux-pci+bounces-38733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A45BF0D05
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B1D18A2A97
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C182FBDFA;
	Mon, 20 Oct 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QB69WTGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775752FBDF3;
	Mon, 20 Oct 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959436; cv=none; b=ABZib4OiWxlwy1KoL/7TVGtD8nc6jlONb771DyX95qxaqkoY6zSsbFn7vTku80XMvYPe2msrunUETQhHJI2vCCB+ddvdWah/s0/TqlJVCyjNMgxR7R2//Ny4D5WWc2KbYa+wMo9dNB4TwiQeAaMZY1uhVhwLg+vUt6wkDshwxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959436; c=relaxed/simple;
	bh=GnLXgjSC+XvWVvG6AxTYWUBWwfWinq5PD6eyJ5swlv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cXBEGCufPqrUJem1YAGMgvQGYicxM1w6FvS6Ott8tENXx/KR42ZnjR+FWs+r2tFAzfhyMNmeZekhFZFOAHvpmPDBQvAmzVXxWvtPEAnJI2BzXUicKWKXKM2u8KhdQVZ4SQCVlVK6QiCE0eQinD0KbCivcauhzBmCQH+37FxumRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QB69WTGQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760959432;
	bh=GnLXgjSC+XvWVvG6AxTYWUBWwfWinq5PD6eyJ5swlv4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QB69WTGQfs5tYFLq+cGbUS3xFGghW1esdl+XaqcupXYgMa80T/6lP4BUd0Bpgljeu
	 8uw2vPTwZrTucpdTOheb/DNBoq/lLtjMlCoyb7HtOTa22SbPhtyr2Rj007aD15NL+C
	 9tccL6XzPOEBy3nMMhjnIwLjxCAGehgDNSrYWqkaUv4rioSMvDCD+QVtOMOl3g7VOa
	 D4n/frn1PqhaKRcbUwVIH1no8tJ4dqdDQCIc7VEEYEpZhulSZk84XfgJAlTB66Sh8F
	 7Wv9qQr+oYL7u0zK4k7FzWJdNunslGyLeA69dL++wjjpG+g8XSc8G3rIUryivqff+r
	 AxTCl5QNDSj2A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B99CA17E131B;
	Mon, 20 Oct 2025 13:23:51 +0200 (CEST)
Message-ID: <5d34b941-d594-4386-8235-d8e6c24ba02a@collabora.com>
Date: Mon, 20 Oct 2025 13:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] PCI: mediatek: Convert bool to single quirks entry
 and bitmap
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 upstream@airoha.com
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
 <20251020111121.31779-4-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020111121.31779-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 13:11, Christian Marangi ha scritto:
> To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
> use a single quirks to reference all the values. This permits cleaner
> addition of new quirk without having to define a new bool in the struct.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pci/controller/pcie-mediatek.c | 33 ++++++++++++++++----------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 24cc30a2ab6c..cbffa3156da1 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -142,24 +142,32 @@
>   
>   struct mtk_pcie_port;
>   
> +/**
> + * enum mtk_pcie_quirks - MTK PCIe quirks
> + * @MTK_PCIE_FIX_CLASS_ID: host's class ID needed to be fixed
> + * @MTK_PCIE_FIX_DEVICE_ID: host's device ID needed to be fixed
> + * @MTK_PCIE_NO_MSI: Bridge has no MSI support, and relies on an external block
> + */
> +enum mtk_pcie_quirks {
> +	MTK_PCIE_FIX_CLASS_ID = BIT(0),
> +	MTK_PCIE_FIX_DEVICE_ID = BIT(1),
> +	MTK_PCIE_NO_MSI = BIT(2),
> +};
> +
>   /**
>    * struct mtk_pcie_soc - differentiate between host generations
> - * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> - * @need_fix_device_id: whether this host's device ID needed to be fixed or not
> - * @no_msi: Bridge has no MSI support, and relies on an external block
>    * @device_id: device ID which this host need to be fixed
>    * @ops: pointer to configuration access functions
>    * @startup: pointer to controller setting functions
>    * @setup_irq: pointer to initialize IRQ functions
> + * @quirks: PCIe device quirks.
>    */
>   struct mtk_pcie_soc {
> -	bool need_fix_class_id;
> -	bool need_fix_device_id;
> -	bool no_msi;
>   	unsigned int device_id;
>   	struct pci_ops *ops;
>   	int (*startup)(struct mtk_pcie_port *port);
>   	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> +	enum mtk_pcie_quirks quirks;
>   };
>   
>   /**
> @@ -703,7 +711,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>   	writel(val, port->base + PCIE_RST_CTRL);
>   
>   	/* Set up vendor ID and class code */
> -	if (soc->need_fix_class_id) {
> +	if (soc->quirks & MTK_PCIE_FIX_CLASS_ID) {
>   		val = PCI_VENDOR_ID_MEDIATEK;
>   		writew(val, port->base + PCIE_CONF_VEND_ID);
>   
> @@ -711,7 +719,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>   		writew(val, port->base + PCIE_CONF_CLASS_ID);
>   	}
>   
> -	if (soc->need_fix_device_id)
> +	if (soc->quirks & MTK_PCIE_FIX_DEVICE_ID)
>   		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
>   
>   	/* 100ms timeout value should be enough for Gen1/2 training */
> @@ -1099,7 +1107,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>   
>   	host->ops = pcie->soc->ops;
>   	host->sysdata = pcie;
> -	host->msi_domain = pcie->soc->no_msi;
> +	host->msi_domain = !!(pcie->soc->quirks & MTK_PCIE_NO_MSI);
>   
>   	err = pci_host_probe(host);
>   	if (err)
> @@ -1187,9 +1195,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> -	.no_msi = true,
>   	.ops = &mtk_pcie_ops,
>   	.startup = mtk_pcie_startup_port,
> +	.quirks = MTK_PCIE_NO_MSI,
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> @@ -1199,19 +1207,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> -	.need_fix_class_id = true,
>   	.ops = &mtk_pcie_ops_v2,
>   	.startup = mtk_pcie_startup_port_v2,
>   	.setup_irq = mtk_pcie_setup_irq,
> +	.quirks = MTK_PCIE_FIX_CLASS_ID,
>   };
>   
>   static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> -	.need_fix_class_id = true,
> -	.need_fix_device_id = true,
>   	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
>   	.ops = &mtk_pcie_ops_v2,
>   	.startup = mtk_pcie_startup_port_v2,
>   	.setup_irq = mtk_pcie_setup_irq,
> +	.quirks = MTK_PCIE_FIX_CLASS_ID | MTK_PCIE_FIX_DEVICE_ID,
>   };
>   
>   static const struct of_device_id mtk_pcie_ids[] = {



