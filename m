Return-Path: <linux-pci+bounces-9167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547C914404
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C7D281ABC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8C47F6C;
	Mon, 24 Jun 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R19dKTyZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680D481C4;
	Mon, 24 Jun 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215830; cv=none; b=iWAHSWwQQrJ39kCV8SF0+hAIEt8Jz2atIfT7SswcAFrF7PsoWloUkkRHQm6E/oEOdXOSvWhhvnOBvS6f9s7nMLuvbGBbP6pROWlZY7SJnlXNNKPZiR6MfG9CCi2rib7JbXxYSAfoC4odHI/0qdFVwFNqq3m8oJkSfd4B7ovDteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215830; c=relaxed/simple;
	bh=KlmMThD71Ri51F5dZcgy1vSyJkP6qPTbsfnWV9hwHVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUdVHQAJ7ZSki65eYOztTb6i1Kb5zRTFfZxQESjIOhkv6eHOkZa/YzgkEZ15cNCy/qKp3qC8gYy/GdxOVb7SiYhNrHvnKjof1mcJnp7M87W2ryvvRRcqU6SwFubUscbdG5zvj/Df7Xkjq6Pj8DIrQr9Lp+h5JbtDlARbeaEpBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R19dKTyZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719215823;
	bh=KlmMThD71Ri51F5dZcgy1vSyJkP6qPTbsfnWV9hwHVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R19dKTyZiZnzEISb1VEFACE6BLXvcseT8hqDlsIm7Q09tmbQtZYQ53hCkbmXTJWfd
	 pQBQemxsZCk2U0D9El6g1I8zA9zffG/XyhyomsfRZX4r+FfohHVrcF1VdUOQAUhl/3
	 6C0ko3+o4OOuz+2POk9I79VCo9MrAEOUoHBYG3PlximWZKpHAq+XPKxo8ucze7dXiA
	 PQXjpfOvAePaX+uGSukrWcbHjj1StTeIPAHFwK2BfEOe9CZvjNvOeD+B66jvDH/O7n
	 ghKEwMbw7amd7+rzR1qEH24BHdPIzaabt/M/rO+tCCrSLDK+L+X43gvcDUqFCtEvgm
	 sHE5KiAn+HxUg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F5EE378216B;
	Mon, 24 Jun 2024 07:57:02 +0000 (UTC)
Message-ID: <c63ed7fc-f568-48b1-ad5d-a37b4b475016@collabora.com>
Date: Mon, 24 Jun 2024 09:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] PCI: mediatek-gen3: Add mtk_pcie_soc data structure
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, nbd@nbd.name,
 dd@embedd.com, upstream@airoha.com
References: <cover.1718980864.git.lorenzo@kernel.org>
 <a49a36c4ca336dee909e16865d6fec0dd83b3f38.1718980864.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a49a36c4ca336dee909e16865d6fec0dd83b3f38.1718980864.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/06/24 16:48, Lorenzo Bianconi ha scritto:
> Introduce mtk_pcie_soc data structure in order to define multiple
> callbacks for each supported SoC. This is a preliminary patch to
> introduce EN7581 pcie support.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 975b3024fb08..4859bd875bc4 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -100,6 +100,16 @@
>   #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
>   #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
>   
> +struct mtk_gen3_pcie;
> +
> +/**
> + * struct mtk_pcie_soc - differentiate between host generations

mtk_gen3_pcie_pdata ?

> + * @power_up: pcie power_up callback
> + */
> +struct mtk_pcie_soc {
> +	int (*power_up)(struct mtk_gen3_pcie *pcie);
> +};
> +
>   /**
>    * struct mtk_msi_set - MSI information for each set
>    * @base: IO mapped register base
> @@ -131,6 +141,7 @@ struct mtk_msi_set {
>    * @msi_sets: MSI sets information
>    * @lock: lock protecting IRQ bit map
>    * @msi_irq_in_use: bit map for assigned MSI IRQ
> + * @soc: pointer to SoC-dependent operations
>    */
>   struct mtk_gen3_pcie {
>   	struct device *dev;
> @@ -151,6 +162,8 @@ struct mtk_gen3_pcie {
>   	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
>   	struct mutex lock;
>   	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
> +
> +	const struct mtk_pcie_soc *soc;
>   };
>   
>   /* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
> @@ -904,7 +917,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>   	usleep_range(10, 20);
>   
>   	/* Don't touch the hardware registers before power up */
> -	err = mtk_pcie_power_up(pcie);
> +	err = pcie->soc->power_up(pcie);
>   	if (err)
>   		return err;
>   
> @@ -939,6 +952,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>   	pcie = pci_host_bridge_priv(host);
>   
>   	pcie->dev = dev;
> +	pcie->soc = of_device_get_match_data(dev);

device_get_match_data() can also be used here :-)

Cheers,
Angelo


