Return-Path: <linux-pci+bounces-12184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA195E7E0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7594C1C20D93
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41C6BB46;
	Mon, 26 Aug 2024 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AEEWUaVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-216.smtpout.orange.fr [193.252.23.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B41119A;
	Mon, 26 Aug 2024 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724649643; cv=none; b=GqZ9nz8XDIG68I+EKxNtOSe/c85nB8gt3CMZc4SDskhDYiOA+PfJmcGtJClt7+QdokQ17Gg5d/bgTAT2yezvXR7QwPr0nCSj7zTH2ga90yToiXa/d8YKbloczihW72NLiB+6FKZnWJ9EqB5m1XPdQePH6EefJ76KLWymbOJ96kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724649643; c=relaxed/simple;
	bh=QiWMXJx68T2eZQGlIhU8f0J6nqvIrnHErtNXUeJYRW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6MosJXnrUkNDH9MZaU2wZj5Ik2bE1x+c4gx+1Tu9pntA+1hJxA21wqQz2cuDTAcv/hcEHeJMOT5cqM9Xjk4hbmnMyARBv/+QB4pJ5qZtXYSguGhD9B6Ho3nUwBF0rgsV6nis6PsTo3YxwL6sgKbULlGVr1oRzmR4zvOKBHDWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AEEWUaVc; arc=none smtp.client-ip=193.252.23.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id iS9TsnCcaQaX2iS9UsdFMQ; Mon, 26 Aug 2024 07:20:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724649631;
	bh=CH+bBxw77VqZtgxGPhNCgBVlMeEijoG6oGf3XZxn4ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AEEWUaVcW/k4nrIWY0fO2bvS2w2Y6Im41BOX00GDC82RDfJZfoZgLpJcQiyLPvcur
	 HMdW8qXdCHPNpKEWGV0AQMKpIZn1dfF272B3EEl9lrb3Ck5Lh3GAOaeb2fLRlp8DDW
	 J1m2cxnOjMkwCDXdGIwhqY8Bvqw55db79XwfxWmGTDHyxARfcCYdsdmy/ZthQS3jJ5
	 GbhNvqgSz2wXtllw2wduFi7K099ufd1n611fmXyIvDr3EuyYApJl3vPYB/sylQaqCY
	 LKiNyTBxLTprRyJHRJzfBUOuxlOETwfAc+6UannW7dxCqmeO3LcUJL1XDbW/4KlMUm
	 IRIdlRa8Pck/g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 26 Aug 2024 07:20:31 +0200
X-ME-IP: 90.11.132.44
Message-ID: <d148c29a-6ffa-4f6b-8468-534b2b3a7c7a@wanadoo.fr>
Date: Mon, 26 Aug 2024 07:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: armada8k: change to use devm_clk_get_enabled()
 helpers
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240826020038.2205146-1-bo.wu@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240826020038.2205146-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2024 à 04:00, Wu Bo a écrit :
> Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
> cleaner and avoid calling clk_disable_unprepare()
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
> 
> v2: use dev_err_probe() to handle error return
> 
>   drivers/pci/controller/dwc/pcie-armada8k.c | 36 ++++++++--------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b5c599ccaacf..9708a6fde545 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -284,23 +284,17 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>   
>   	pcie->pci = pci;
>   
> -	pcie->clk = devm_clk_get(dev, NULL);
> +	pcie->clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(pcie->clk))
> -		return PTR_ERR(pcie->clk);
> -
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret)
> -		return ret;
> -
> -	pcie->clk_reg = devm_clk_get(dev, "reg");
> -	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
> -		ret = -EPROBE_DEFER;
> -		goto fail;
> -	}
> -	if (!IS_ERR(pcie->clk_reg)) {
> -		ret = clk_prepare_enable(pcie->clk_reg);
> -		if (ret)
> -			goto fail_clkreg;
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk),
> +				"could not enable clk\n");
> +
> +	pcie->clk_reg = devm_clk_get_enabled(dev, "reg");
> +	if (IS_ERR(pcie->clk_reg)) {
> +		ret = dev_err_probe(dev, -EPROBE_DEFER,

So ret = -EPROBE_DEFER after this line.

PTR_ERR(pcie->clk_reg) instead?

CJ


> +				"could not enable reg clk\n");
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
>   	}
>   
>   	/* Get the dw-pcie unit configuration/control registers base. */
> @@ -308,12 +302,12 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>   	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
>   	if (IS_ERR(pci->dbi_base)) {
>   		ret = PTR_ERR(pci->dbi_base);
> -		goto fail_clkreg;
> +		goto out;
>   	}
>   
>   	ret = armada8k_pcie_setup_phys(pcie);
>   	if (ret)
> -		goto fail_clkreg;
> +		goto out;
>   
>   	platform_set_drvdata(pdev, pcie);
>   
> @@ -325,11 +319,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>   
>   disable_phy:
>   	armada8k_pcie_disable_phys(pcie);
> -fail_clkreg:
> -	clk_disable_unprepare(pcie->clk_reg);
> -fail:
> -	clk_disable_unprepare(pcie->clk);
> -
> +out:
>   	return ret;
>   }
>   


