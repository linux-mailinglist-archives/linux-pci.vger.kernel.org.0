Return-Path: <linux-pci+bounces-19128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C436D9FF06A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18473A0685
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC5137923;
	Tue, 31 Dec 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qU+8xEGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40311C683
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660327; cv=none; b=cj/OOVWdObk7QCsk6dYD5r8oCFkGLDcPrmfLXhr8Iq6/j7GAzsKToPJqusbYSwZ6vft+iQMQe9FTNfJqIbjU1o+PR/luEW1Ju47cvko0Z2YjSC7NFfwo812/uX3ESrr4K5EjMdegZC2nOJA8giyvVhn0wf856N1VIgNNPL/5EuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660327; c=relaxed/simple;
	bh=o/gUTWYn4zL8vZs1eQPLpSfuSLy4PH3XIgBvJWqf00A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou0o/Dyx3G8zloBFACGnG8LA/LHwnB2I5BTBlxUgGk0/7OMTviDgNhQVJFQAN0E8SHtggOzrvhk0HKrXVpLZjOGbM9sxHA0cQUDdHv47iwgI38NDky7TkiMMBZnS/J2YidmWVlKLZ95m9E2lj3ohg0OOKWgm/Te7eyTfiWlQIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qU+8xEGF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21675fd60feso177616445ad.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735660325; x=1736265125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7jrbYeg74O76BQKe1PxZ80+Q7guLGYsTWpYCdBdtVE=;
        b=qU+8xEGF8eJdn7qZNoCSszOHRds87gA9FmXL3PC8hABTQUgD+c/HJIAHOykN3oFVv1
         yWiwDiJCC1w2ky0T8bPW+CmhbLZUYg0rnMSpxxI9XdG3Hj9E5IypKKcgQvq8PVH+R24s
         yuLOE+YWg+SOSHqXacYfhLOz/2hEOqylZ58y5WBBJ6HfUm2qVzMcrFs9Zoy62aBaZFKo
         jNIZzVWlmc8s6Ko3bqdOKWe4nIMrJW4oxSpiUopv2PWx3TeRcMpuMKODnnI0g1E7Lb2Q
         N7ZMngv79jO9ynOHQ475uYszJgJyYL2rkcNht+nPFvAH+mIku9UN74L6RdketXTqS0Ej
         K9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735660325; x=1736265125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7jrbYeg74O76BQKe1PxZ80+Q7guLGYsTWpYCdBdtVE=;
        b=mYqWgE0U0G+de4Fw6GSn4mZN3BM2nz8zyE7q5BwYWpGr0XvLsF+0qBeJ9ECGJDn0Zt
         ZSsAoD34yHb3om1AqWZCxXmFWZrlLMI2WFRIMJBaqPwaju2FkSJHC9DKDTswX9SysNti
         qFF5GF5XwzD4pKDnnPmg2xQcR4byMKG0t6TC4yJNwQ4iiraY6Aahy6mGbPFY9FWzgYEw
         yFONrClt0f5nF5hri6r1d7uKQqNgxOrzdSgywpcAjLxmzNcdR0F+g5oDprlpwILRuQbE
         kuhZc/kIAoCCP38YQTwESF7RTv0iGq/Iv7Lu7xZzUzC4TAr9gs6gNvrC7GUthdamxbdH
         3N1w==
X-Forwarded-Encrypted: i=1; AJvYcCX4MPuh//z2EMv5XMIspK8QDHfxOEvMVykUFvhgQMgrMpR15SUT7n2BiJVPr89y40Q8Ib9xulJ/VgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7S+kkonm0Gj9/AM1krcRNT8O6BD67pqUwkKIaO4OFs4jM7P3
	R6tj+uVmdwYK9patus4dUrUBMKw1UbR+qFA04BaLrn5q+19Cq3zdzvGvEUQ9Ig==
X-Gm-Gg: ASbGnctPPtTp19g/nsoul1NiMcxxXMJgutaRdr1k9+ekabTXAP0h9mhNVNh2fZw658c
	lZ8r/ZnPxnEBWZH+pbawWeeGDy3ZZIr7rstE1ES3DQcqA/1odlqo1ifvc0yRcmkGZftjW1C9D9G
	mS6NX9coFBjFZUWeVXfmOL/WfRCYpB/sHiUHNlnHTrJlgF2PK+yyiN/zKadGX++RXd7Adxm9luc
	Cg/gmQmVRJENPe80h6gA7a96rXQvwePsUjbrzmxHCcShxUCAeCyraSX0211JMuwF3iAHw==
X-Google-Smtp-Source: AGHT+IFJeQNTjSu3Tcy/d88RjR9p6E9hlISKh3WQsLCSC/mh+dyJ/5a2OucJMHL4MATDy3MwYLUUmg==
X-Received: by 2002:a05:6a00:914b:b0:72a:bcc2:7748 with SMTP id d2e1a72fcca58-72abdbde4acmr46615146b3a.0.1735660325290;
        Tue, 31 Dec 2024 07:52:05 -0800 (PST)
Received: from thinkpad ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8162efsm21694516b3a.25.2024.12.31.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 07:52:04 -0800 (PST)
Date: Tue, 31 Dec 2024 21:21:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Reject a negative nr_irqs value in
 dw_pcie_edma_irq_verify()
Message-ID: <20241231155158.5edodo2r5zar3tfe@thinkpad>
References: <20241220072328.351329-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220072328.351329-2-cassel@kernel.org>

On Fri, Dec 20, 2024 at 08:23:29AM +0100, Niklas Cassel wrote:
> Platforms that do not have (one or more) dedicated IRQs for the eDMA
> need to set nr_irqs to a non-zero value in their DWC glue driver.
> 
> Platforms that do have (one or more) dedicated IRQs do not need to
> initialize nr_irqs. DWC common code will automatically set nr_irqs.
> 
> Since a glue driver can initialize nr_irqs, dw_pcie_edma_irq_verify()
> should verify that nr_irqs, if non-zero, is a valid value. Thus, add a
> check in dw_pcie_edma_irq_verify() to reject a negative nr_irqs value.
> 

Why can't we make dw_edma_chip::nr_irqs unsigned?

- Mani

> This fixes the following build warning when compiling with W=1:
> 
> drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
>   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
>       |                                                  ^~
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c683b6119c3..d7f695d5dbc4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -978,6 +978,8 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  		return 0;
>  	else if (pci->edma.nr_irqs > 1)
>  		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
> +	else if (pci->edma.nr_irqs < 0)
> +		return -EINVAL;
>  
>  	ret = platform_get_irq_byname_optional(pdev, "dma");
>  	if (ret > 0) {
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

