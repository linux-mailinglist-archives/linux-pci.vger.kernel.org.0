Return-Path: <linux-pci+bounces-11848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FA957A25
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 01:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6D6B223BA
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E41DF664;
	Mon, 19 Aug 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mERexwoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE8B657;
	Mon, 19 Aug 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111982; cv=none; b=XOF8bEeSb6NicyNCeMncWwAAFrom7/3bUVfTeXF3WP8bWa2T1OOuPShDHNBdbRbuIbrkyZ4Z783Tacmd5+8V1L6hnCvWZ5f+0Ifum0+wMisSiDc51WkVEtWszka42Flo3Tnmwo7mancmy1rHMztXt6NUFwfPRVEWUf1qGmdKgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111982; c=relaxed/simple;
	bh=yuIaNRdT2XsbRktrinM+nAtjGpiDnUSrUd78oiucAek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2J//nk2eWjb5f7nQxAiHogMm1Tjrszgf//tPAvrXPYmGJzRbLMHXGuGGxbvTMyDwiKyBN56bG0ptxneE2X+KeII/szBvp+XurEd3YI1jwYVz0ZUj1kIvhXQPtaowFWJuFMsb7JveSu8rJJt6gmLaUxq2y/F5+JOX5xYHpoEenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mERexwoy; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id g6yfszJBlQRySg6yfszKrO; Mon, 19 Aug 2024 20:19:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724091584;
	bh=i2piStncb9aJgwDrvhVqFSwNM+FZr5qttsR8sW3kpiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mERexwoyPzlfOebBUEnIZsOtSDCyALgn06bAE0XuHJCOZf7MgURweOtCYf6D5ucvJ
	 hMxqf1tym0+N1Yh1Kbtxnt/uiEN5D/QjnWk+qeYU1kf9fnNGIcOfFfUV8ildjug1Wj
	 +AeJZMCJpizoL16BT/5H1yRsJWk4bK4mOJMcJ5w1C1DdkuK+LTxHCusEYR4OwF84Ku
	 +LejUCxpLFrzVaYKQL35SlVlnRKXCLRCjGATL+8fj/YDf1K9GFn7lWZ/Qy8KDoyJRY
	 4PIjpQAMLXkiwAulAoaPdD5hVIViRIDkDDoFS+N0BjfpoxS/HV8fdzvU2do0815ek2
	 I0eIZaE9SrODA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 19 Aug 2024 20:19:44 +0200
X-ME-IP: 90.11.132.44
Message-ID: <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
Date: Mon, 19 Aug 2024 20:19:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, onathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-10-pstanner@redhat.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240819165148.58201-10-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/08/2024 à 18:51, Philipp Stanner a écrit :
> solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> things because it forces usage of quite a complicated bitmask mechanism.
> The bitmask handling code can entirely be removed by replacing
> pcim_iomap_regions() and pcim_iomap_table().
> 
> Replace pcim_iomap_regions() and pcim_iomap_table() with
> pci_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/vdpa/solidrun/snet_main.c | 47 +++++++++++--------------------
>   1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..abf027ca35e1 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -556,33 +556,24 @@ static const struct vdpa_config_ops snet_config_ops = {
>   static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   {
>   	char name[50];
> -	int ret, i, mask = 0;
> +	int i;
> +
> +	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +
>   	/* We don't know which BAR will be used to communicate..
>   	 * We will map every bar with len > 0.
>   	 *
>   	 * Later, we will discover the BAR and unmap all other BARs.
>   	 */
>   	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i))
> -			mask |= (1 << i);
> -	}
> -
> -	/* No BAR can be used.. */
> -	if (!mask) {
> -		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> -		return -ENODEV;
> -	}
> -
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> -	ret = pcim_iomap_regions(pdev, mask, name);
> -	if (ret) {
> -		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> -		return ret;
> -	}
> +		if (pci_resource_len(pdev, i)) {
> +			psnet->bars[i] = pcim_iomap_region(pdev, i, name);

Hi,

Unrelated to the patch, but is is safe to have 'name' be on the stack?

pcim_iomap_region()
--> __pcim_request_region()
--> __pcim_request_region_range()
--> request_region() or __request_mem_region()
--> __request_region()
--> __request_region_locked()
--> res->name = name;

So an address on the stack ends in the 'name' field of a "struct resource".

According to a few grep, it looks really unusual.

I don't know if it is used, but it looks strange to me.


If it is an issue, it was apparently already there before this patch.

> +			if (IS_ERR(psnet->bars[i])) {
> +				SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> +				return PTR_ERR(psnet->bars[i]);
> +			}
> +		}
>   
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (mask & (1 << i))
> -			psnet->bars[i] = pcim_iomap_table(pdev)[i];
>   	}
>   
>   	return 0;
> @@ -591,18 +582,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>   {
>   	char name[50];
> -	int ret;
>   
>   	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
>   	/* Request and map BAR */
> -	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> -	if (ret) {
> +	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);

Same

Just my 2c.

CJ

> +	if (IS_ERR(snet->bar)) {
>   		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
> -		return ret;
> +		return PTR_ERR(snet->bar);
>   	}
>   
> -	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
> -
>   	return 0;
>   }
>   
> @@ -650,15 +638,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
>   
>   static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
>   {
> -	int i, mask = 0;
> +	int i;
>   
>   	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>   		if (psnet->bars[i] && i != psnet->barno)
> -			mask |= (1 << i);
> +			pcim_iounmap_region(pdev, i);
>   	}
> -
> -	if (mask)
> -		pcim_iounmap_regions(pdev, mask);
>   }
>   
>   /* Read SNET config from PCI BAR */


