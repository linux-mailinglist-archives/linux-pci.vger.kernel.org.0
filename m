Return-Path: <linux-pci+bounces-12016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A545095B895
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47951C21AB2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F21CBEB6;
	Thu, 22 Aug 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="neM6rCS1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487B1CB329;
	Thu, 22 Aug 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337356; cv=none; b=L/xhq6zQ8cbPd+F1iCDcpS/G/YkpoQP9Zg+PSgOBsn02Xjn+rQDt8zyVKsFhag0fXv/O8ImhMR8XwrngjHc3WyeEVA2UXAM5wNA43oRfoEUFzN52nXdZlpd+cRfXtfUV3kS+MkWNC0UZ8l56fAQIFBiu19NQBFxuPItHxAOlZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337356; c=relaxed/simple;
	bh=PjN1v1ZgupBNIKpW9Fc12Vy49RxRfMabNrj+qsYjiGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds0r7gITdJFGumD135IJpRCfXL45rYtg3G3yy7Kuy0bikCMYdIW0bIMJ/zcDHYpKGB5teNbjQ/SeXrkEP3Mz+cEcegnuXms8l0APAHqBP7MAsV1z8RO1gLWJBTmQTI/xK0qs2dCQ/yaNn/5M9DOik2UN522IpTn5EnYBoo9vkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=neM6rCS1; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id h8tQstrBMiKc3h8tQsUpzP; Thu, 22 Aug 2024 16:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724337277;
	bh=hgzwBNoQY1MSKy8JqHT/xV1IQZfbcxzXziAOuuVi2Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=neM6rCS1kmMJzPrHHqX9sK83O4PsWimcoBx2ciYUu4jh26tfT2sMCE4s40UqlTBAH
	 4pFKq4KHjULk2fe4+fZ6VRyJeAMgtIfp+oGyCLsXgB/r4SDqjIC/klUcXqwPb+3hQq
	 ADRdhkenk9OWOrEaS8Hwi6UcoL5ewwojw0zKgoHhyvgrV2QhZTBwmYx8O2aZ0e2M88
	 ZbXlyF72bZipSOn5Vm9AiwL51amFk+l6PuHU3X+CkjQbwkYfL10zN0jD1hSy2FovO+
	 n7u40WNIDo7cZt+P9gzfX3w8nCFiCUTY/aW2H2xUer/PM7tucP4iPsw8K9YXBmfbtp
	 C7vH87XzyANow==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 22 Aug 2024 16:34:37 +0200
X-ME-IP: 90.11.132.44
Message-ID: <81de3898-9af7-4ad1-80ef-68d1f60d4c28@wanadoo.fr>
Date: Thu, 22 Aug 2024 16:34:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] vdpa: solidrun: Fix UB bug with devres
To: Philipp Stanner <pstanner@redhat.com>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org, axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 davem@davemloft.net, dlechner@baylibre.com, dlemoal@kernel.org,
 edumazet@google.com, eperezma@redhat.com, hao.wu@intel.com, hare@suse.de,
 jasowang@redhat.com, joabreu@synopsys.com, kch@nvidia.com, kuba@kernel.org,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 mdf@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, stable@vger.kernel.org, trix@redhat.com,
 u.kleine-koenig@pengutronix.de, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, yilun.xu@intel.com
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-8-pstanner@redhat.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240822134744.44919-8-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/08/2024 à 15:47, Philipp Stanner a écrit :
> In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> pcim_iomap_regions() is placed on the stack. Neither
> pcim_iomap_regions() nor the functions it calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the strings on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>   drivers/vdpa/solidrun/snet_main.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..67235f6190ef 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>   
>   static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   {
> -	char name[50];
> +	char *name;
>   	int ret, i, mask = 0;
>   	/* We don't know which BAR will be used to communicate..
>   	 * We will map every bar with len > 0.
> @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   		return -ENODEV;
>   	}
>   
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>   	ret = pcim_iomap_regions(pdev, mask, name);
>   	if (ret) {
>   		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> @@ -590,10 +593,12 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>   
>   static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>   {
> -	char name[50];
> +	char *name;
>   	int ret;
>   
> -	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));

s/psnet/snet/

> +	if (!name)
> +		return -ENOMEM;
>   	/* Request and map BAR */
>   	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>   	if (ret) {


