Return-Path: <linux-pci+bounces-11740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9B954245
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0D728836C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4981AB6;
	Fri, 16 Aug 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3KshPEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC6839F7
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791771; cv=none; b=dKC83Q4emHhG6g/anLLmAe1ZQuwv2VThlWPQNybhvfAMTktGx4E8JfHUB/XeQZzNWZeR+NTcYGSFNISrjfA3/MOKus1JmpIaQkalv/DgBpehTrL+UJwc6b07sB92iBskb97rFj/+PU0N0deM6TMR1vT3K10fTSSrIyUO1+BYe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791771; c=relaxed/simple;
	bh=Ink2gD/nTViZpjsrRGnQ7qam2nLz4NZOfHv30m+P8Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzULp+jcR8kVk7ILI7vztO29Mtgd8hm7UADyt4ZgIwUvS/7f/UYLH8cpyfZJpfEz+8no69qIYLHnGWQd1YHgziWHncTW7WL++C2wk7v50Ydgof4eiCOieP9MA1QKULIgUkkw0FfDay1qanLuoTtc7nbpnzFz/LjzTp7MHZEX+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3KshPEM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27022a3536dso171416fac.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723791769; x=1724396569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2Z+3RNB2QpPIGic+9pjYyfWRgiiZ2uqgv5Hgxzn04Y=;
        b=v3KshPEMj79gJv8K+fRWcjFug8+l3kSrJhScYpWvvIDpIbDbFg+ihAXVXITlE7KVnP
         UK3QCMvCeVjkcTth12pdN6RPXEHxM7u/WDjl+eoLzkEiJB41NC7duPhCbHLEkThW0Qzy
         XtoCliCTtAfFdwHVMBDJZjfcJuwwNzvjXXQ86VudCV0qrtLVvKg2rhlQNkXWoZIsCXjz
         MFJZ4F1VgLPse9FGUIxqrxY9FK3VLc6ceqcf1T9fgwcpm2RALzD9FimqKGGNqTYuaxz7
         FXf5Iip5NMqZ2BJxo2pK1GLExcoI1NRg6PeFUWuwrGjDCNXxK8D5Sw/OC32OQlzPKC8N
         i0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791769; x=1724396569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2Z+3RNB2QpPIGic+9pjYyfWRgiiZ2uqgv5Hgxzn04Y=;
        b=LpTInLxpg4pfkiJseS84VpXBfvs0OUUuJm7SY3mH30LhjcoNjarWsG9kowuoQMyumZ
         sJOkypBpt/q9yMolSMVWoUtrsK8rApfA656e9/OoXmQushJr3FJOW+x5W0XwKubEUvT8
         0gYifhh8dmq2aBsJtSinElZGw72vonX6axCk0jwUfjFE94tAEH6x5SlQ9mMA+PJSQ5Sq
         GLfMFCuikQz73DPKtD44vtaInFikq4fdUimRYbyjj17/1+/1/6XjjJtWqPYStf348WeL
         0FuwPnZvp1xP9r/9RFCdD7lRWO3ZCKdtNqBu9EvBhj7SjThbMHcdPOS86yXrEAmf7hO0
         WWCg==
X-Gm-Message-State: AOJu0YxXH31aEyCjIHmO/1kkLYO7H9betjrGE816FhkKW/PyZavCXu4z
	mVPuypMQP3Is7EH/+s5tnmTEh7xfv+0+5SCYsn3rmRvkGIxa/osHEPndi6MYlw==
X-Google-Smtp-Source: AGHT+IFNDYdQwGyEIqqhP9q7fz+e2TnS80Sfaxe+R84yxpxfEKiriLW+niboArdJkp12iogF4qfi0w==
X-Received: by 2002:a05:6871:6108:b0:261:1e3f:777c with SMTP id 586e51a60fabf-2701c3deca1mr2054038fac.27.1723791769013;
        Fri, 16 Aug 2024 00:02:49 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1708asm2031815b3a.154.2024.08.16.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:02:48 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:32:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/13] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240816070242.GI2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-5-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-5-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:17PM -0400, Jim Quinlan wrote:
> Refactor the error handling in the bottom half of the probe
> function for readability.  The invocation of clk_prepare_enable()
> is moved lower in the function and this simplifies a couple
> of return paths.  dev_err_probe() is also used when it is apt.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..790a149f6581 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1613,25 +1613,23 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clock\n");
> -		return ret;
> -	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> -	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->rescal))
>  		return PTR_ERR(pcie->rescal);
> -	}
> +
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> -	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
> -	}
>  
> -	ret = reset_control_reset(pcie->rescal);
> +	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
> -		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
> +
> +	ret = reset_control_reset(pcie->rescal);
> +	if (ret) {
> +		clk_disable_unprepare(pcie->clk);
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n");
> +	}
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
> @@ -1678,6 +1676,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  fail:
>  	__brcm_pcie_remove(pcie);
> +

Irrelevant change in this patch.

- Mani

>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

