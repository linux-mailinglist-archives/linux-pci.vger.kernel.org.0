Return-Path: <linux-pci+bounces-2691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5A83FE49
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 07:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD76C281844
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A84C3A9;
	Mon, 29 Jan 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjKKo1xA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EA4C3CD
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509627; cv=none; b=PFjUguVJ0q7gBJ0qOkQNEi8/CLWHflQiyJuvcPu+RoOjpD5zquJ5Cy1VPr8goAuNrjDTzT3dS7ZFwukST1pucACh5rdcFldApKYE5DyNvf6hYTcZZZsbcSI8ePwhZnBdVrO7djHwCl9yuA8DmULmAB2rEOEQyTIyFxgOktacr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509627; c=relaxed/simple;
	bh=3cmvS1dej2+Av/+m0kgJSejIHfdLW0Z9C1ATiQOtdSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWyi/YAk1Zyy7BugALYnjtBSmeXO3evcPxQ41RBSr9K5dOowxCUlG+hQkc15phzjRI5nKprdX7PuC6J+b/TBubxj6+FhLvXnJecNSXE7SOIITnwTGZrcfbxwoJ3knFDUCRoI4vgdGtZZ67NCkFQwcvqix3MBzu2wVkQmmIwqUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjKKo1xA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783def87c8cso156569885a.0
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 22:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706509625; x=1707114425; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DUvX778P3/PqRVJZI5ZsV8yVSi77JnF2V5Csluo6QQI=;
        b=mjKKo1xAC8UasFqWKHMwTURe2p2iZnilL1cXhKEYrmTZtZmPAV9cxeSEFpf5DdMFAP
         QuqP336Q/VQL+C/ilO9JsCRvKusHE4gSA4DRsV2DIHBMY++U+EH+uq1hOeIXQhE/6x7x
         UqjampTPVJyQxz86i33lRXzR1xn0ZFPHplr0vjj9XP/SgDS+2qgGfpaaWTpSTH8kitbj
         RwdfNlhfh9oDZ6T2SMZ8NHp+bUq83y77ed2FEvGrchuM8KfzAlWz4l19XbsaCc9z2kd1
         t111Zzqq6ByNuBOa4LDAzhj5vCXtVonDcjgwHRMnUCbdoIOJptwXFcaEaIEYiWdfM6J4
         KLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509625; x=1707114425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUvX778P3/PqRVJZI5ZsV8yVSi77JnF2V5Csluo6QQI=;
        b=rOkRbnSlhYS/GBiG90KFlNKsS3pTXQ1v08FISYDA8hkAajzu6OnshAO0aSHC6Nk4UL
         +ZQjntLUETr2Tv3CCjgWrpaboA3xY5DKzwrpNn75JFdpeoqMIQAucXZr2imYPPJLCwWM
         Xdjmb8JmPZD0Zxv2cTYALUSbFAQU9BHuKgLCy/wwjix3s3SKL8hJzUaf8hP/s4MM0+NZ
         YCqiOAL2nZ619d0TLLCHWepNC2DDj4UpvSuwJLXxzUjeo5/PZcHnD77Z6ZuYeH33zDTy
         mzqOrJDrmHJYeekjLZyccFtGqjw8VOw31UFVg3tjmy+CNPJmUdGeka6synnF3ARZB2zc
         mm4Q==
X-Gm-Message-State: AOJu0YxhSgyfD/KfJA4GuiO/zaZV2IMqV9SORWUTR2+RcYomDdvCDk31
	0TJe7bTBaZ6MK8964x4nfMooIGvucaLYgQTWgp6XOy9xykT0gmtEVfVxnumcuA==
X-Google-Smtp-Source: AGHT+IF/BPL6BdDKJTLaOWONcCAoHTNzp9EYs37/HhexmPp7eGE5bwm0ZsPYQj4FvJ1feG7u+M+rdg==
X-Received: by 2002:a05:620a:191d:b0:783:9662:bd1a with SMTP id bj29-20020a05620a191d00b007839662bd1amr5147052qkb.36.1706509625063;
        Sun, 28 Jan 2024 22:27:05 -0800 (PST)
Received: from thinkpad ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b00783f9bb4c89sm914271qkh.123.2024.01.28.22.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:27:04 -0800 (PST)
Date: Mon, 29 Jan 2024 11:56:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240129062654.GB2971@thinkpad>
References: <20240124092533.1267836-1-ajayagarwal@google.com>
 <20240124092533.1267836-3-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124092533.1267836-3-ajayagarwal@google.com>

On Wed, Jan 24, 2024 at 02:55:33PM +0530, Ajay Agarwal wrote:
> In dw_pcie_host_init(), regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where .start_link() is not defined the code ends up
> spinning in a loop for one second. Since in some systems
> dw_pcie_host_init() gets called during probe, this one second
> loop for each PCIe interface instance ends up extending the boot
> time.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> This is actually patch v6 for [1] which I have made a part of the
> patch series.
> 
> v4 [2] was applied, but then reverted [3]. The reason being v4 added
> a regression on some products which expect the link to not come
> up as a part of the probe. Since v4 returned error from
> dw_pcie_wait_for_link check, the probe function of these products
> started to fail.
> 

What happened to the previous thread [1]? You did not resolve my comment there
and posted a new series. You are not going to make progress if you skip
responding to review comments, sorry.

- Mani

[1] https://lore.kernel.org/linux-pci/20240120143434.GA5405@thinkpad/

> [1] https://lore.kernel.org/all/20240112093006.2832105-1-ajayagarwal@google.com/
> [2] https://lore.kernel.org/all/20230412093425.3659088-1-ajayagarwal@google.com/
> [3] https://lore.kernel.org/all/20230706082610.26584-1-johan+linaro@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7991f0e179b2..e53132663d1d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (!dw_pcie_link_up(pci)) {
> +	if (dw_pcie_link_up(pci)) {
> +		dw_pcie_print_link_status(pci);
> +	} else {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_remove_edma;
> -	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +		if (pci->ops && pci->ops->start_link) {
> +			/* Ignore errors, the link may come up later */
> +			dw_pcie_wait_for_link(pci);
> +		}
> +	}
>  
>  	bridge->sysdata = pp;
>  
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

