Return-Path: <linux-pci+bounces-25530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F0A81D0F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54131B80DBD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 06:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBA1DDC0F;
	Wed,  9 Apr 2025 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWeAEPOL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED91DD9AD
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180182; cv=none; b=nXYD02UG46ibtDJB/n+cZzcNkw5OGHp5XR62w9Yed3GwJ7lfW7ATFXbXTxR8g1LrjEuxVsr9WmVLJWjaFNJfs2KhZtZEEmcStSY0DEjm0lk8uSdloQplK2uR/iyHA1v1619h2jsQYo92yywQsPMfpileRAm8TI/++1NQpEgA2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180182; c=relaxed/simple;
	bh=GqY1tsZNSIrPzzrHoXynnaRNG6y6kEra0eAN9CxIYUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUOzP1wa3o5E/JrJWouyFc38vboaCokCg1m+cJPB9PXMFBZAahohpkC1/XlGfJGm20DGreV179EVvqs2IBd02nSBFX38yr+rmXOVPYfRlKFBYcH8ZnfpZFSwlLds9OFV1GGM9BhF/1Is7zS3bdTEoN9URmN5A6kFhm2YAUDueSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWeAEPOL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af9a7717163so6326181a12.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744180180; x=1744784980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=usHmxHbXCM+dAW0xD/QM+lICH9ZjXWjSDlg+5wMOzf8=;
        b=uWeAEPOLzUS1qPqqijnEuIwxXe1YRLDoqQSMCdF6hxOkjNfLCHqEF5EdOqpeFne/nA
         nanOypinBAEiPIQdWFuMUul9DP1eqiDoEH9rfpusWGq8/NDjSUgU4APQnTY/DUshohVT
         ve/8jxUl2BnyMFxNiv26mfeWYg2on9hK4ockTAnbdzq9V9U3hN6nYfTOwUa/FMv32yEy
         aW8AznqAKbJx08ildAdWOIsEifcHDSeVS1RllA7Sr7smmNUmVgL/L0oajpf7S233HjQ4
         SzAyNeD89K0Os3W3961Pk2fIhRZ6LVTJkCA1x79nJiO0M1kk6tVwHAy5uGNUEbS5MK4O
         E98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744180180; x=1744784980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usHmxHbXCM+dAW0xD/QM+lICH9ZjXWjSDlg+5wMOzf8=;
        b=RFPOCZeWzytP/cAxTZ0ifjQhjZvn0DdNEFjs3qOawU4mBNsdSmDGCJOvy96E08Tv4C
         NA3HqE5dIYA8CUr1/s/P7xHiGGRlEuPz8d4UWSSxMMUD9WDmd4ZAtFCOKicslyeijzj2
         ow3ahqJ9sKgj07XmY6muhLx1QJrUolZH7IwAR8XAE3NK/Yk9a7rKwp1VrBKAAOgHSFJH
         MYBsyGZH1xA9i7p5gyVUjL1MCmqLMWYI5Ve5g+4gotkPPDCwbYZQ7OSDqfo+i6o+zRQ4
         XgVRcS/KuyNC5Ww/InYR8jlLEODIzntDI+8iC/Z/CH3XRYTMUE0zOqz3O2A7Jp+MVuDB
         7/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbXfV7f6HHf2cRgMdTQgkkXa0aBWfFg5CffXJyiNiBWle2Oq8u3f8iCBdblHz3E2OL9ilsAPVWnAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxSuWYNMOqV412W1tJM3LA/G32M3Ch/jHo1TRqVVDBq9apW3c
	qiS070TQn7d9dj3wE4F+f2vs5kLQO6LxphDAZcPAwCD56pJdJjM4B3bxOLxlcA==
X-Gm-Gg: ASbGnctDzUimP3yuhxQrgvZvfAwcD2Uy4ZFFBh+FFoHh4cts1sfOI62sDtkbkxopAoZ
	TmQryU+bOz/aCPJEbHAyxYVra+OcvaPbtkrM990GJIc53G7g+VAJwnILLs4pb2xLZ6Yc5fLhF3i
	pqoCUJ3Bx3Wy2DXsMRxM8bMPM5xC6z7KZKQKQognQlBPblPhTz2jpG440H/+e2jlGVoV6Udukuq
	62tDksqBLXKlZAu5h8poYMdFMVX2IwqnJOMIEUtPcD+W3La4KxnhkqHd28COumJC4XX2A8OGwr3
	9g1Edbf4WH8fWbdJF+jqilOeaTAKgvbfxboBG8zEFkxL4ctdgtA=
X-Google-Smtp-Source: AGHT+IFMg3stzRdVMVbjl7VIfmZ5+DK7eVP2nR526pWDqOTgCQzPmJ9NitfwkUXy92kR/MtVTv0MhA==
X-Received: by 2002:a05:6a21:8dcb:b0:1f5:769a:a4b2 with SMTP id adf61e73a8af0-20159195613mr2687257637.17.1744180179850;
        Tue, 08 Apr 2025 23:29:39 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e51f48sm496746b3a.147.2025.04.08.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 23:29:38 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:59:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 18255117159@163.com, 
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com, 
	thomas.richard@bootlin.com, bwawrzyn@cisco.com, linux-pci@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <vaqnrp46asxjiqjefajqfeqcp7kjhcelc2nabilrgjdqevwncj@i64fd7jt5gil>
References: <20250330083914.529222-1-s-vadapalli@ti.com>
 <20250330083914.529222-4-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330083914.529222-4-s-vadapalli@ti.com>

On Sun, Mar 30, 2025 at 02:09:13PM +0530, Siddharth Vadapalli wrote:
> Introduce the helper function cdns_pcie_ep_disable() which will undo the
> configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> to cleanup on their exit path.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> v1:
> https://lore.kernel.org/r/20250307103128.3287497-4-s-vadapalli@ti.com/
> Changes since v1:
> - Based on feedback from Mani at:
>   https://lore.kernel.org/r/20250318080304.jsmrxqil6pn74nzh@thinkpad/
>   pci_epc_deinit_notify() has been included in cdns_pcie_ep_disable().
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 11 +++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b4bcef2d020a..ffd19cb25eed 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -645,6 +645,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.get_features	= cdns_pcie_ep_get_features,
>  };
>  
> +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> +{
> +	struct device *dev = ep->pcie.dev;
> +	struct pci_epc *epc = to_pci_epc(dev);
> +
> +	pci_epc_deinit_notify(epc);
> +	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
> +			      SZ_128K);
> +	pci_epc_mem_exit(epc);
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_ep_disable);
>  
>  int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  {
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 0b6bed1ac146..387174d6e453 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -555,11 +555,16 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
>  
>  #if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
>  int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
> +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep);
>  #else
>  static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  {
>  	return 0;
>  }
> +
> +static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> +{
> +}
>  #endif
>  
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

