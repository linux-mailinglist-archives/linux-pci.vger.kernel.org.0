Return-Path: <linux-pci+bounces-11992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDE95B248
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26ED1C22CE0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0811547EA;
	Thu, 22 Aug 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsi6Qs2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09113C9CB
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320094; cv=none; b=ZJGFnYdrpZc/QeyEgiJadzoik8jnpEcuppPKcfnhgaXtl1zbWt0i4YaaB9k5u09jRWZ7hYN78BM3IXqSwwxM0phK6t17oBDSCNekufABtYedD9w3/XBYw8s8htnf5dCJUKuvkf3yDjsIgVgNcFPsm1IofrJv+bk/KEyuRBWs0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320094; c=relaxed/simple;
	bh=HPLq3U9vgM3C1JwDuvtSsMmeM8JpL5m188wB5bMlF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ottZMlT7kHExJml+hn/3r0EAaW//30kWI1O+OGkyIoYExKLVzoeOe7wxU9Tbwc9evRGS1KrcTSXZlrBnPUTTMNid74Rb4aRVJ1J/Q+LMo5pDi27MA+qZcNDhX3tJWJ1j2Fg91F6Y2TuGEOF2Lq1WudxLGOd4embKPEhWy15NguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsi6Qs2E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-714114be925so514570b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724320092; x=1724924892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iHMbBkdXi5NJJTPpNhoWWdbS6AltG6wqMDn1sGeo94U=;
        b=zsi6Qs2ETRfLYp/StPBygPQNCczPhHor+jPLmrEH3zgHeihhL4sD8bOqClZia2LUpG
         jEXpGGIbiHTG2NsR2WW8RliNQFWotpIll0MMof3AN7rCVreMgObnPT9y3SYXaMitO7o+
         SGzwN669ZFPZQbmlFvA8Y/lNlWuDz5R1BktjXYopO1vkTbvYolGcmP7Hm5oS7g41Ciyh
         +5j84DYECVqwJZI1/Nqej1tdAka7CxyBfiO5ZwmkJHOFNHx2wFFLR+6+wg4jOgKyxOiN
         L1h0Lfg/23f9eZBJZkRmvH1nTrHd3vy/pO3j7wn0XJ0qZVSBw+EYaLqIcoslmsv8Fran
         bFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320092; x=1724924892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHMbBkdXi5NJJTPpNhoWWdbS6AltG6wqMDn1sGeo94U=;
        b=QGVLgFus1P5To4AGTPhdkkk7VkY6lnIbPzWP6GH3C5twOPK0XRiLSzk/qcbE607Dzs
         jEQo9lFWJAp/MunVzoQmwwh72QtIU83JALoHSWyIXIpWWWU/ea5BWhIuuKxgILSDAruR
         Zh9gboZoco/mWz61PfyD4OyVUpenOvy35aesszzOEZXMwwO0n0Ior4xoTNT9vaUF6s9L
         iLebmbZDxQ7djHqSCxVobfYb7mfFpV9WIRILvW/F/K+SzIdnOj2HNcAq93EDrFGOxwS/
         dSdKfKjdnzdLwNJnD1lNkVnsgE/ajvht3tda8aBTGMVM94qTWeMHG1aUhuuS2raM9UFe
         d7vg==
X-Gm-Message-State: AOJu0YxPVgtj8Gy3rYwQK2oL1mzVcGTx4ZtcuM6td0zTk7XIIl/964Go
	vQiof34Yfo3W7+SigfcNpM7PLB9EgliRMc4CNxJ+a/rXzX+4vZmpYp/kombgnTgdUsIrry1q96c
	=
X-Google-Smtp-Source: AGHT+IHmQGzkM/5LVqWLN6gqeOWndfTv82B2bq4udv5mX+XV2uml3djHzbfnKehsBJ3tvpBbTMbTvQ==
X-Received: by 2002:a05:6a00:91c8:b0:714:2198:26bd with SMTP id d2e1a72fcca58-714234507d2mr6579112b3a.11.1724320092032;
        Thu, 22 Aug 2024 02:48:12 -0700 (PDT)
Received: from thinkpad ([117.213.99.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ed96sm1006546b3a.33.2024.08.22.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:48:11 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:18:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820223213.210929-1-nirmal.patel@linux.intel.com>

On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:
> VMD does not support INTx for devices downstream from a VMD endpoint.
> So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe devices under
> VMD to ensure other applications don't try to set up an INTx for them.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>

I shared a diff to put it in pci_assign_irq() and you said that you were going
to test it [1]. I don't see a reply to that and now you came up with another
approach.

What happened inbetween?

- Mani

[1] https://lore.kernel.org/linux-pci/20240801115756.0000272e@linux.intel.com

> ---
> v2->v1: Change the execution from fixup.c to vmd.c
> ---
>  drivers/pci/controller/vmd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a726de0af011..2e9b99969b81 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	return 0;
>  }
>  
> +/*
> + * Some applications like SPDK reads PCI_INTERRUPT_LINE to decide
> + * whether INTx is enabled or not. Since VMD doesn't support INTx,
> + * write 0 to all NVMe devices under VMD.
> + */
> +static int vmd_clr_int_line_reg(struct pci_dev *dev, void *userdata)
> +{
> +	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> +	return 0;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
> +	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg, &features);
>  
>  	/* When Intel VMD is enabled, the OS does not discover the Root Ports
>  	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
> -- 
> 2.39.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

