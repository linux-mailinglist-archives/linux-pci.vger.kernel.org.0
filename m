Return-Path: <linux-pci+bounces-17026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B99D09D2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16FB28259E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC214A4D1;
	Mon, 18 Nov 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T2bONE88"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D754652;
	Mon, 18 Nov 2024 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912578; cv=none; b=kyE4yFbIHEIIyerw5BHtmZQzOANuNWUhXqH0wHDyBuQufEntm0ABhoCJxwtkx9jviK0pk/ljoq9081cs9o9GAD/ZZxgsy8XT+pWQRHcW85PDng29B4sl732Q0RB/sw8uzoTOkmFhrXa1ctrTY6vsRltWaKnmUeOl4ADTnkEVGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912578; c=relaxed/simple;
	bh=ULUv5k6/b6OAJTH3xB9QMwYTCfFWvEVCAfCK2tBQHLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0dvLixy3t67ckqvrFLUsBdluLllk2P5Uv8IjC9/WCjPJ8TbDYN9EnJF5hipZGdHKqRNYgMZhEfCJe6iu1FvlzyAWg9YNYbRc59VxZeaBu+PbmVSUjhqIJwNdV7ha8nsBOa1qs0wVhm1rCfn8FOMEORbEm+4oE5NsGZy7zoJ+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T2bONE88; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912574;
	bh=ULUv5k6/b6OAJTH3xB9QMwYTCfFWvEVCAfCK2tBQHLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T2bONE88Z4ULg6wAyJSoOW9n3ZS/rl9Ep6AT35B296kM3kG53AP5t9rtGf6M3WY4y
	 9mOOuAiZqaVdG1R4kJBxdNnJXr43ju3/EtI6Kql/RS5whSt9/7enA+wfqXqkH3trij
	 7zNCRqORxVIW3oECjzrBZjW3YQXcmvLJLHz3AsYUMTtZ5hnM1WSqliTfOW5H97QKzt
	 sJ3BYj2ks2k06As8qWScwfooUiYDyXdoCrNApLs9qUn9YoNnFPDdgI5rYje72ev/5G
	 FPC0/vr45+nDBeCsFnA67NOpNmNkXXY6Z7BxXP+BUKV7iabtH+B8AuSZtGyChwhzTF
	 TN/xgiilT9jNw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5958817E1247;
	Mon, 18 Nov 2024 07:49:34 +0100 (CET)
Message-ID: <197fde88-f3eb-4c09-9d49-6450faa150cc@collabora.com>
Date: Mon, 18 Nov 2024 07:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
 <20241116-pcie-en7581-fixes-v3-4-f7add3afc27e@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241116-pcie-en7581-fixes-v3-4-f7add3afc27e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/11/24 09:18, Lorenzo Bianconi ha scritto:
> Add a comment in mtk_pcie_en7581_power_up() to clarify, unlike MediaTek
> PCIe controller, the Airoha EN7581 requires PHY initialization and
> power-on before PHY reset deassert.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 2b80edd4462ad4e9f2a5d192db7f99307113eb8a..dd30530a43b1097871acc9e76a7534f30819432d 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -928,6 +928,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>   	 */
>   	mdelay(PCIE_EN7581_RESET_TIME_MS);
>   
> +	/*
> +	 * Unlike the MediaTek controllers, the Airoha EN7581 requires PHY

Unlike the other MediaTek Gen3 controllers, Airoha EN5781 requires.....

(because Airoha *is* MediaTek anyway)

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


