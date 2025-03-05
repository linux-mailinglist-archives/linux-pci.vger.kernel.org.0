Return-Path: <linux-pci+bounces-23017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D1A50E38
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7255188E81B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD1265618;
	Wed,  5 Mar 2025 21:57:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAB2571C6;
	Wed,  5 Mar 2025 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211857; cv=none; b=Rquon8wcHx3hvbJTn+ap1RlcXy/9XD1Ka7qaFZIabZ3+pFBE+VlGugk74+BpkRohbSfLm62qgLFvM7ASjUA+eOqOQ0H1gMII8EXAVckSkG0TRUwtIQnQnVPVCnb6xoyrfmbkyJ5dJdQDdC6+QP8unEjm9fY9mUQTJxa877sCGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211857; c=relaxed/simple;
	bh=pXA55zWb3OLx17xkUOLHzdtk1lZRc2oejxk9utsYbcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPf+szcXlj+PkDx8fx1wMyo+UqkHk6JCtSwr7O2fv0P1pNNSLnPZ8mRDUBugfx5sekORocg7GENsF27/OHUAK8NYX444VZzq5IHQKRyfLX32V6cfTh/lUFqntTYgrqrgCOYOvB4zqFLdm6JDC1x6JivnhHW55KJMcdANvjH8WQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22113560c57so137423925ad.2;
        Wed, 05 Mar 2025 13:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211854; x=1741816654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5oLj+118MekjPiNQhRObsqao3JOH+wuRmhMOoWyOZI=;
        b=lSA8E3FkoOTtRoNF39xTPLwpfw5dljYujIsdGtqLChKKl1a0pC1OpnahfFleIkLxtH
         nfqKe2CHgnnGTID7LdWS7YSVpTY+QE8s4f7IHqc35A6bW2f19Y5DgmSLYiLLONLlJ81E
         9geTuhREoIiOMvTwGcBeGiRw+7IN5C8VUVT0KzvQ6MfBMb/yg0W1kd3DoqaWqtyDksf8
         PwKRkkCXlEe9cugn3abFkHI7ev5gDJAl00Vub7JgQBhCx7jA+lKGh1Lr6BWhP3ylGWTM
         mZOtAtEb3EaEx1iHZENT/nuYrbFZuc3jzq19VIO+Ho/BVemkZTtf+ZhEyiKKHteLaOmc
         OJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MvpFMj59JwBOZyHyV1NHBbUi4HaScU+c0P8pBPT5xFkAYsrhXKo4RZxMCAbQJC0rWPzCveg+VcikflgVqgQd0HY=@vger.kernel.org, AJvYcCVbZABflsbLXbvzMbCphfnxasfjQ6bw9HoxRTpmYC6kywAQ/SMS3cxQQoJudvgE4xEwF35y1Yr57XmptjJF6POPZw==@vger.kernel.org, AJvYcCWjOLSRvfQPX6S1OVVXJbG66WvqTi4hjO1oUOd/1Nuzz2Ea9Z4kUG6+xCDoJ3b1h9xb1pz54uUcvMJC@vger.kernel.org, AJvYcCXPJY7YFyFhQ0ZxAY82ipll/qgrYdO/y9o7FMLqv5OY27oUCveJ/BurhhycXGspRCcb7cIZFgkVQgbAWvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUezAjq7czkwR2Y0OD6+8HkTr+zL79MD9Dkr0L5dqwHHfjHMf
	KqsWlqztjXi5z/Guig6VhQ8IONk0ox7SY/yQD4/hFQ9GN47aTJvk
X-Gm-Gg: ASbGncuLRtlSkjybb30jQXWK2bHsM5jgohT+oW5OulD68lIR7hsA3B6BAEBJS1t+9Wr
	OBbbuk7Q1QxOkGc9BAoOiNh7gXB4yGAbqFDVqD+ofaJJJ2FFy8YjJkb/+azZD2sqb9a+hJ+Tw+1
	eowfgUyrK2QA/xbtFJkGGd9pPRKdFIOhhBrOtawXyVMPdTVXCcXFXbWZsRIfVMby/evqRt47ygy
	iD3ir6QZYAex9H5ZYYVucjSsDudWGYx61BLjcahnrT4bZEc7oUD2lXLM4w2J7ANL0ogDSTpR5jm
	9PWLUmtY76SRT49727Q2h0UYmmKtEwsGi7OtQWO9yfmPMBWfSANxq2WXtAd3dt5uVx40E8kmpSc
	BS9A=
X-Google-Smtp-Source: AGHT+IGuIOJavdPgCJ9sCafNt1cSRA420lYDVSVad8g7o0o+KgD598cgIajBU5IrPyUL8MNnaUygNQ==
X-Received: by 2002:a05:6a21:1f81:b0:1ee:d6ff:5abd with SMTP id adf61e73a8af0-1f34947e736mr9366143637.14.1741211854471;
        Wed, 05 Mar 2025 13:57:34 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7dec415asm12522672a12.54.2025.03.05.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:57:33 -0800 (PST)
Date: Thu, 6 Mar 2025 06:57:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250305215731.GL847772@rocinante>
References: <20250304171154.njoygsvfd567pb66@thinkpad>
 <20250305173826.GA303920@bhelgaas>
 <20250305182833.cgrwbrcwzjscxmku@thinkpad>
 <20250305190955.GK847772@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305190955.GK847772@rocinante>

> > > > Even though debugfs_init() failure is not supposed to fail the probe(),
> > > > dwc_pcie_rasdes_debugfs_init() has a devm_kzalloc() and propagating that
> > > > failure would be canolically correct IMO.
> > > 
> > > I'm not sure about this.  What's the requirement to propagate
> > > devm_kzalloc() failures?  I think devres will free any allocs that
> > > were successful regardless.
> > > 
> > > IIUC, we resolved the Gray Hawk Single issue by changing
> > > dwc_pcie_rasdes_debugfs_init() to return success without doing
> > > anything when there's no RAS DES Capability.
> > > 
> > > But dwc_pcie_debugfs_init() can still return failure, and that still
> > > causes dw_pcie_ep_init_registers() to fail, which breaks the "don't
> > > propagate debugfs issues upstream" rule:
> > > 
> > >   int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > >   {
> > >           ...
> > >           ret = dwc_pcie_debugfs_init(pci);
> > >           if (ret)
> > >                   goto err_remove_edma;
> > > 
> > >           return 0;
> > > 
> > >   err_remove_edma:
> > >           dw_pcie_edma_remove(pci);
> > > 
> > >           return ret;
> > >   }
> > > 
> > > We can say that kzalloc() failure should "never" happen, and therefore
> > > it's OK to fail the driver probe if it happens, but that doesn't seem
> > > like a strong argument for breaking the "don't propagate debugfs
> > > issues" rule.  And someday there may be other kinds of failures from
> > > dwc_pcie_debugfs_init().
> > > 
> > 
> > Fine with me. I was not too sure about propagating failure either.
> 
> What if we do this?
> 
> diff --git i/drivers/pci/controller/dwc/pcie-designware-debugfs.c w/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 586a9d107434..fddf71f014c4 100644
> --- i/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ w/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -162,7 +162,7 @@ void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
>  	debugfs_remove_recursive(pci->debugfs->debug_dir);
>  }
> 
> -int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +void dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  {
>  	char dirname[DWC_DEBUGFS_BUF_MAX];
>  	struct device *dev = pci->dev;
> @@ -174,17 +174,15 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
>  	dir = debugfs_create_dir(dirname, NULL);
>  	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> -	if (!debugfs)
> -		return -ENOMEM;
> +	if (!debugfs) {
> +		dev_err(dev, "failed to allocate memory for debugfs\n");
> +		return;
> +	}
> 
>  	debugfs->debug_dir = dir;
>  	pci->debugfs = debugfs;
>  	err = dwc_pcie_rasdes_debugfs_init(pci, dir);
> -	if (err) {
> -		dev_err(dev, "failed to initialize RAS DES debugfs, err=%d\n",
> -			err);
> -		return err;
> -	}
> -
> -	return 0;
> +	if (err)
> +		dev_warn(dev, "failed to initialize RAS DES debugfs, err=%d",
> +			 err);
>  }
> diff --git i/drivers/pci/controller/dwc/pcie-designware-ep.c w/drivers/pci/controller/dwc/pcie-designware-ep.c
> index c6e76a07c2c9..11ff292ca87d 100644
> --- i/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ w/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -838,9 +838,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> 
>  	dw_pcie_ep_init_non_sticky_registers(pci);
> 
> -	ret = dwc_pcie_debugfs_init(pci);
> -	if (ret)
> -		goto err_remove_edma;
> +	dwc_pcie_debugfs_init(pci);
> 
>  	return 0;
> 
> diff --git i/drivers/pci/controller/dwc/pcie-designware-host.c w/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2081e8c72d12..6501fb062c70 100644
> --- i/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ w/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -548,9 +548,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->post_init)
>  		pp->ops->post_init(pp);
> 
> -	ret = dwc_pcie_debugfs_init(pci);
> -	if (ret)
> -		goto err_stop_link;
> +	dwc_pcie_debugfs_init(pci);
> 
>  	return 0;
> 
> diff --git i/drivers/pci/controller/dwc/pcie-designware.h w/drivers/pci/controller/dwc/pcie-designware.h
> index 7f9807d4e5de..dd129718fb41 100644
> --- i/drivers/pci/controller/dwc/pcie-designware.h
> +++ w/drivers/pci/controller/dwc/pcie-designware.h
> @@ -815,12 +815,11 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
>  #endif
> 
>  #ifdef CONFIG_PCIE_DW_DEBUGFS
> -int dwc_pcie_debugfs_init(struct dw_pcie *pci);
> +void dwc_pcie_debugfs_init(struct dw_pcie *pci);
>  void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
>  #else
> -static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +static inline void dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  {
> -	return 0;
>  }
>  static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
>  {
> 
> I think this would be fine, especially given the rules around debugfs and
> a quick look around Git history to see what the prefernce would be typically.

Changed dev_warn() to dev_err() per Bjorn's feedback off mailing list,
and squashed against the current code on the branch.

Thank you!

	Krzysztof

