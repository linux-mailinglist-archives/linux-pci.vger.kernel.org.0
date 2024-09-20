Return-Path: <linux-pci+bounces-13317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50297D2C8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CE4B207B8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BA23A0;
	Fri, 20 Sep 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfR9q1AI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24BDF58
	for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821182; cv=none; b=JBPeyUuDxz+H/qbOkUedhzN2605y9eKr71XPtzZ8tUuskp7h+lKnEmjcGlgDrbDxAjlFKsG3fMVuX84peWqOogHn/0fTA42SU16xap7KnVN38xggueO3iJUBLm1rjijTznzZUQ+SLK/KhQmjHlfR1qKleJhYv2QyYIVjxyF8X4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821182; c=relaxed/simple;
	bh=AO4+xnSF1tH3MJYpSjKgX14ht4ppR+X+p+D3K9kiXoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axBFp7WUxjMVjyLaFSvYG/2nMFv9+aBv1MHTUTdUPFdXDa7WXwZw53SigsIZmNYsLRP1BlMxxnJX8QBBF+GJLIA7awMTfY4P5fZ4BkiIwqSryitLD5JiwxRi3Aktt8StoKlAvXNGvq5+ufgVTtCHUepKPVocxAphTFSSBOgLR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfR9q1AI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so2321543a12.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726821179; x=1727425979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ypxja65TLBp+p3wOd2ob3HsV+twNi7uaZxdgqA5Jp1c=;
        b=sfR9q1AI1Gz1qf1O8u2KMj4Tn7aSHUT/hUAMTCZiD48SJpAbAadlj227PAH8zj4c0/
         WNUTU2R2d+hOOS2HybZZgI6B4TD0p/2Trk0D131lXz/x7+tQrzzfOl2OjzG4C0lh36Xj
         LerpaZlT9fUStB+iqcSLj6gxyAFhszW7Bj0hsZVZwUk3kpiy9hHuL3efs1tqfGmcaLAS
         jCguDxO1VdirgYrOsAgy6I/k1othEjm74Vz6pq8q0d6WECJjRzU/PkH8tmv/9DuRV6rK
         iH6NymxDcMICoguJ9is3uPHnB0NHbcv2yAsssRrLjJb/Ssvf30QJR4sdfS2uOyR7+V7f
         e2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821179; x=1727425979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypxja65TLBp+p3wOd2ob3HsV+twNi7uaZxdgqA5Jp1c=;
        b=kRat+PEE+GIDwwiediYj/xgnWueYt3p+8HDjILX30RVQ3QYaLiqnqzoUjqk4/1mGEN
         0tTfxOm7rsY6F/SryW9WBpMzCJL6XAr2b4SAb31aa7UEyOjYFnfG1doh5pToyEp1X8oA
         1NnKy4UOv4SjutNICdxvTAgGRRBFCMkYUC15l4DzqPYlEsZJWTIySct9MvMNqFIcXQTe
         ijvw9TwRf7H677JO2Lj/SK9TQMN8gLVIfcR4SfslN4Ekb0zRonBszVziecQTpTfL9GHU
         euGY4lS0eE2gF2FyElEObPV22FRCZ2Qn6uK/E72lF0hdiPpAiC7JB9AESC2rgiLPjC8y
         crwg==
X-Forwarded-Encrypted: i=1; AJvYcCXpPaCvFXnxEMPHqopGvZ7swpyZLdlCWRuBPDisUBP4Rc1amCiJr84QJaPGJ+BOU/jOQn14vdYLX7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDED7vus1NGcycduUjxrjqz2powf1cTQVbcUe1kD7yEeAUMd9O
	Zro9SBcNW1s3BJvTzkzaqGGtYzrzKAVkqB094mWXvhJMOLy7Qno9Wub5MVRihw==
X-Google-Smtp-Source: AGHT+IFq7Wvo6OUssiEuoXNyxmZPYl1dqhcKaVsaBSfeoLsRvO9Zn3liui9Ko4IRJJHTky3kgLZblQ==
X-Received: by 2002:a17:907:f151:b0:a86:7021:1368 with SMTP id a640c23a62f3a-a90d5613552mr156399966b.21.1726821179454;
        Fri, 20 Sep 2024 01:32:59 -0700 (PDT)
Received: from thinkpad ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3b9csm826017566b.140.2024.09.20.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:32:59 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:32:58 +0200
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
Subject: Re: [PATCH] PCI: qcom: Skip wait for link up if global IRQ handler
 is present
Message-ID: <20240920083258.rpxr6kd4onsbu73c@thinkpad>
References: <20240917-remove_wait-v1-1-456d2551bc50@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917-remove_wait-v1-1-456d2551bc50@quicinc.com>

On Tue, Sep 17, 2024 at 04:16:20PM +0530, Krishna chaitanya chundru wrote:
> In cases where a global IRQ handler is present to manage link up
> interrupts, it may not be necessary to wait for the link to be up
> during PCI initialization which optimizes the bootup time.
> 
> Move platform_get_irq_byname_optional() above to set bypass_link_up_wait
> before dw_pcie_host_init() as this flag is used in this function only.
> 
> And also as part of the PCIe link up event, update ICC and OPP values.
> 

This has to be a separate patch.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            | 7 ++++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..e0ddfaf9f87a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -531,7 +531,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	}
>  
>  	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);

Add a comment to clarify that the link up delay is skipped in the presence of
Link up IRQ.

This flag is not a way to just skip the link up delay for arbitrary reasons as
attempted before.

> +	if (!pp->bypass_link_up_wait)
> +		dw_pcie_wait_for_link(pci);
>  
>  	bridge->sysdata = pp;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e518f81ea80c..7fe0e9b1b095 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -348,6 +348,7 @@ struct dw_pcie_rp {
>  	bool			use_atu_msg;
>  	int			msg_atu_index;
>  	struct resource		*msg_res;
> +	bool			bypass_link_up_wait;

How about, 'linkup_irq'?

- Mani

>  };
>  
>  struct dw_pcie_ep_ops {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 88a98be930e3..bcb8c60453ba 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1552,6 +1552,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		qcom_pcie_icc_opp_update(pcie);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);
> @@ -1686,6 +1688,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0)
> +		pp->bypass_link_up_wait = true;
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> @@ -1699,7 +1705,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_host_deinit;
>  	}
>  
> -	irq = platform_get_irq_byname_optional(pdev, "global");
>  	if (irq > 0) {
>  		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						qcom_pcie_global_irq_thread,
> 
> ---
> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
> change-id: 20240911-remove_wait-ad46248dc9f0
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

