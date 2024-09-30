Return-Path: <linux-pci+bounces-13628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2854989BDF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C371F21D66
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4F46444;
	Mon, 30 Sep 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iu9eWwdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6D15D5D9
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682560; cv=none; b=QXOZyr65R6LPVT1GUXtkITFwg/PovfTZKxUoY5lo2idE5zrx/wPqM2w4OBuUH2WOJ1tCljX0aRkuChfihLEYZ7YVB8cSY089eNWY8ynomB0/ZSavfeffdLQrsMcWbwIW8yQaxucBUh5QkOQM5hGDur3uzC8TePna8RlT6a0CD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682560; c=relaxed/simple;
	bh=dW442wcQrnsWoIRx3u3fXK9HhjdNrcLrgCPZXDpHuSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq2a7TQfd4SNDAt5GtyP3Ty4ZrK3HJmsxplUSVMLwSGzNQrLvyoBQ9b0m8OzmkpJ37O5wwPYhKZBg1rro9khxdR48AWQX1ts2P60eMDenY7jw6YNWMuIO4Bb6+rWyFvuvbYYiGyAfCdbHQZLimH4g7+qZOHiBn8Bq74CBkevtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iu9eWwdI; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710e01dd554so2313233a34.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727682558; x=1728287358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QEVjYGM26nqNlkdTm5ibxx43RUiqP874UVxr1TR3hmQ=;
        b=Iu9eWwdIUnKazRNv4DV95qDh4rveLeq3d+nJhfUZRj5v9AiL08TyBxuWnzt4f7kVlR
         NZ1+wZTUPKtwn/D7NUYv10xBrXMWErTfMlh67d+rGGKe4Fy1AK3Hl3f1cavqYHoSoCsz
         t5KxsFGAbe+TV0pTueGiQL6jqQS7xi7mOYRlC+07Or9s6YHZ33Vm7MQOiehKTIa2gWKd
         0Pr5jQZQsr330YB1voIJWMrwPqMIxYd6V48E9nrPsykr7H36glVPiZvZirwYRLIuOw0s
         mBxEXOR5cqOpmLSCuAkTknZ4hM0HGKNK8aU8TVmw9tTg5qXsTR/QLpSaIx6T5cT4IWWM
         Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682558; x=1728287358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEVjYGM26nqNlkdTm5ibxx43RUiqP874UVxr1TR3hmQ=;
        b=dFtRWemIOtAaIFXh0XYbF00b7ywC//n97lZCyjHSjsRO1j5sILiDni6NlGawP1zQxC
         1CIvl0p4NUOV3SatwO/Rj5fYIaJ+U2lp7cCO5z87g6ByfnYrYpLgAYX6Yra/i8nbVuAy
         Qul/pkPbN2G0uIj6XjWWKi3j21eSt4SpcJzJzDLWKpW3RCBkOaW9BiKMyteGWsTn+NVP
         FPJaZKrFk9+Q5tkmfemzR7Ko6cqvjUEUaMdc8RUTIbBsuIprtN2ElXVMW2A9acjukqmU
         JVHODMm+P7rpQPl8PC5TbjN7hoDBo3a1ChR+l8emseJbBQA+LmIwlrUtQKNDGGzy9G+C
         QdLw==
X-Forwarded-Encrypted: i=1; AJvYcCUtd7WjSsY5SRRT4P8oJ/vG07eAmHtiv0c5R4+NH9LUPArpJ/RZ3perbNX6Z7M4U/dyqRnVrp4IOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjeN+4gUroFjx5sQOxQor3lGbp5pKXRNwt2yQd9TFiORf6njn
	pPPMUbmNqyCgVTzDwYZpll3+KwnCTvX+VD4oshi1p0Uvd4tD78fSf3TvwRiuag==
X-Google-Smtp-Source: AGHT+IHo3RVYx9uTIdWoPhzPjWCa/YQPIRgywXm16yOmCdDwyIXYL1Cz/Ue2eR1QXjxiVPl1wNxouQ==
X-Received: by 2002:a05:6358:70cd:b0:1b5:ecc9:1e48 with SMTP id e5c5f4694b2df-1becbc966famr355250555d.25.1727682557655;
        Mon, 30 Sep 2024 00:49:17 -0700 (PDT)
Received: from thinkpad ([36.255.17.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc1a3sm5653853b3a.75.2024.09.30.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:49:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:49:10 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: qcom: Skip wait for link up if global IRQ
 handler is present
Message-ID: <20240930074910.yeuujpwqyq32lehw@thinkpad>
References: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
 <20240920-remove_wait-v2-1-7c0fcb3b581d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920-remove_wait-v2-1-7c0fcb3b581d@quicinc.com>

On Fri, Sep 20, 2024 at 03:47:59PM +0530, Krishna chaitanya chundru wrote:

Subject should be modified to reflect the fact that the link up is skipped in
the dwc driver.

PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event

> In cases where a global IRQ handler is present to manage link up
> interrupts, it may not be necessary to wait for the link to be up
> during PCI initialization which optimizes the bootup time.
> 

How about,

"If the vendor drivers can detect the Link up event using mechanisms such as Link
up IRQ, then waiting for Link up during probe is not needed. So let's skip
waiting for link to be up if the driver supports 'linkup_irq'.

Currently, only Qcom RC driver supports the 'linkup_irq' as it can detect the
Link Up event using its own 'global IRQ' interrupt."

Techincally, you could also split the dwc and qcom driver changes into two
patches. One adding the option to skip the wait and another making use of it.

> Move platform_get_irq_byname_optional() above to set linkup_irq
> before dw_pcie_host_init() as this flag is used in this function only.
> 

This is not a valid justification. You are moving it so that the
'pp->linkup_irq' flag is set before calling dw_pcie_host_init() API that waits
for the link to be up. Mention it clearly.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            |  5 ++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..b7d20a1bab0a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -530,8 +530,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_remove_edma;
>  	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +	/*
> +	 * Note: The link up delay is skipped only when a link up IRQ is present.
> +	 * This flag should not be used to bypass the link up delay for arbitrary
> +	 * reasons.
> +	 *
> +	 * Ignore errors, the link may come up later.

Maybe you can move this comment just above dw_pcie_wait_for_link().

- Mani

> +	 */
> +	if (!pp->linkup_irq)
> +		dw_pcie_wait_for_link(pci);
>  
>  	bridge->sysdata = pp;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e518f81ea80c..b850f0a74695 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -348,6 +348,7 @@ struct dw_pcie_rp {
>  	bool			use_atu_msg;
>  	int			msg_atu_index;
>  	struct resource		*msg_res;
> +	bool			linkup_irq;
>  };
>  
>  struct dw_pcie_ep_ops {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 88a98be930e3..905c9154fc65 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1686,6 +1686,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0)
> +		pp->linkup_irq = true;
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> @@ -1699,7 +1703,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_host_deinit;
>  	}
>  
> -	irq = platform_get_irq_byname_optional(pdev, "global");
>  	if (irq > 0) {
>  		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						qcom_pcie_global_irq_thread,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

