Return-Path: <linux-pci+bounces-7081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9288BBD52
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F9CB21543
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14EC5BAFC;
	Sat,  4 May 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ed/EGp+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430421E871
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842109; cv=none; b=QpvKb6hQSQqaAwXN8YK+5WlxaCRrQoAnLP1Mfur0dzcGmQqIv0xDIcdcl6vQA4wOacpNa/aPMVWll5NuR9QOQnfH63WW7hqTgzF6d14MwkifG52/V3DSo+K10vwIGVxCfio2+uaLUKRfG04F/cRuG9puSVsnlXAyyZRjgs4BBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842109; c=relaxed/simple;
	bh=Ui289m/aD+ifRYLXt9sDXS8DUyCLcvxnyweT3Q+LgHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVmDoGMZQL+5/2LK5oIuOXMOtE33/HRZg9R9Ei54YLZmsL04cV6HHMXnFEUtT+qT7uVv8bBZF7UfmAD0Gp9V2urBlH6O6MazEgkghUZ6uIz7oPWBNwltXU0EX46z5qgnr7uFJVa6oiSu9yrIDuev+MAQ0XCF1OtJHvrOlvMyk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ed/EGp+I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f30f69a958so532039b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714842106; x=1715446906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANbQzLbC04OT96qrkLQKxGMSo5LbgtdU/enMtsBUeUQ=;
        b=Ed/EGp+IeDo/igMDy7R6cZHQVwMcUksysOSOMFs8d491hHusOTh4aNR5JjSdETXXYj
         RhQY1RMxj2X3pveQ6c7LqD9mwRye2Cer3jWwFCKX8XhfcAzEA04c5HBOcnalECXbyneB
         q6Tpye+gy6NbcZMpGnF/9TxgUOh50G3x1CSbaFoKRWOBPhe038lWYq4VkyKfXPFs1GuC
         mdZNQJU1QKAJDFiCVwV2jGYxAPGilSx7mxJIM4uEgqsXyut9aLVTf1f/2gDwl8lt+/BB
         lBY6cMEGjbEWR3WN88sLgBEBlb8MYMDcam0oegcob/+/BLDlrNvOA3yvsi6ki0CwqRqc
         LbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714842106; x=1715446906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANbQzLbC04OT96qrkLQKxGMSo5LbgtdU/enMtsBUeUQ=;
        b=IzWWn5fjMzM03Y9KRswZMszYCX+HhYC+sSdXQbBxakzUrwHsfY185WhxqS+rnD9OJO
         e8fQUfumtDPy87UfZmopxcZWhbpxGP5EtkHYg9o4EurURaLX9bLeDf0bgxiXct6xLDaP
         z/XyogdL3JtLFHzelTeSvjXO8zXp7LJSJBmqyIaZ7SU51W0LOuRCn07FLod4ULAmD2sX
         Ms5xCO5om1UzA3836SZIU4LCg9umhVpUJykSAM/w4uQHt+5u6gcp1yWrwyXjGRY0nRMG
         M903qooFn26c5dsCGExNoxQQW59x+A91RUqDuUrJMnU4P+biPbmKEBofFAQnDAiJMUu7
         OyVA==
X-Forwarded-Encrypted: i=1; AJvYcCUkr7L7vpwsbZ4b7c4c1UkXNTV5UZY5sAnPkDo+XLnrGxTE+d88IU7fDE++9zRhqR8fQi0MZjuOn5hwUbJSAprT9TxbknDJFtO6
X-Gm-Message-State: AOJu0Ywm68czZmZLuj6Ha2tV8rTRexYt5fawoERMna4X6p+f/hyoXxQr
	RKvgTdzyPO+tjFudsHMHrPmgCXnMl7M1lvH7yyZV6otdQD2xbeN5Eye9PJFKZQ==
X-Google-Smtp-Source: AGHT+IFoYFMT+P/n6MbXuyw0mxYc/wmFkYedDEEx3BgEqvaXl/D4ZN745Jr5wrhk+w+gEEPdlTJu0g==
X-Received: by 2002:a05:6a00:92a5:b0:6e6:946b:a983 with SMTP id jw37-20020a056a0092a500b006e6946ba983mr6518136pfb.10.1714842106223;
        Sat, 04 May 2024 10:01:46 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id ls30-20020a056a00741e00b006f4123491d2sm4954233pfb.108.2024.05.04.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:01:45 -0700 (PDT)
Date: Sat, 4 May 2024 22:31:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: dwc: keystone: Fix NULL pointer dereference in
 case of DT error in ks_pcie_setup_rc_app_regs()
Message-ID: <20240504170139.GB4315@thinkpad>
References: <20240329051947.28900-1-amishin@t-argos.ru>
 <20240503125726.46116-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503125726.46116-1-amishin@t-argos.ru>

On Fri, May 03, 2024 at 03:57:26PM +0300, Aleksandr Mishin wrote:
> If IORESOURCE_MEM is not provided in Device Tree due to any error,
> resource_list_first_type() will return NULL and
> pci_parse_request_of_pci_ranges() will just emit a warning.
> This will cause a NULL pointer dereference.
> Fix this bug by adding NULL return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

One nitpick below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> v1->v2: Add return code processing as suggested by Bjorn
> v2->v3: Return -ENODEV instead of -EINVAL as suggested by Manivannan
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..381f7b2b74ca 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -382,17 +382,22 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
>  	} while (val & DBI_CS2);
>  }
>  
> -static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  {
>  	u32 val;
>  	u32 num_viewport = ks_pcie->num_viewport;
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> -	u64 start, end;
> +	struct resource_entry *ft;

s/ft/entry

- Mani

>  	struct resource *mem;
> +	u64 start, end;
>  	int i;
>  
> -	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
> +	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (!ft)
> +		return -ENODEV;
> +
> +	mem = ft->res;
>  	start = mem->start;
>  	end = mem->end;
>  
> @@ -403,7 +408,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	ks_pcie_clear_dbi_mode(ks_pcie);
>  
>  	if (ks_pcie->is_am6)
> -		return;
> +		return 0;
>  
>  	val = ilog2(OB_WIN_SIZE);
>  	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
> @@ -420,6 +425,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
>  	val |= OB_XLAT_EN_VAL;
>  	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
> +
> +	return 0;
>  }
>  
>  static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
> @@ -814,7 +821,10 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  
>  	ks_pcie_stop_link(pci);
> -	ks_pcie_setup_rc_app_regs(ks_pcie);
> +	ret = ks_pcie_setup_rc_app_regs(ks_pcie);
> +	if (ret)
> +		return ret;
> +
>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>  			pci->dbi_base + PCI_IO_BASE);
>  
> -- 
> 2.30.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

