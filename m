Return-Path: <linux-pci+bounces-27532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E5AB2143
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 07:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76249E475F
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 05:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E4019AD90;
	Sat, 10 May 2025 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwQXlXbp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC978F24
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746854341; cv=none; b=gY2cD9uIFC+jeAimpJjRX0fTUgxMOWoouc2ThkUi7NWx/HdhsqYbVqS7siDEAY4ug1iprh/hD1y8uEA5rrHBf4mq6J0v/erc1th3nSKTGXkDmEHYTr9OrKcZAriF0qzRC8dMWUxsx/fNbCfuBwuOyI94WAA1VS+mzQXRmu/j5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746854341; c=relaxed/simple;
	bh=76T5UwJajciv+5KU8yAbC7WVnk5b6DjPtTgufl/eT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE4iabChtWmF+hqnWxIFK0S2F6hVhzVA8hQRZibdXavn255OWAKdKlxbGoQW4DriNcZU5chJXnfDUXhWJD76/1chcafhM+N56F2i8aZ5Ucf92XR8Fv//kKKtbddToEvFrTILbEWQ6U4cyrRqNCwTL0zB5gJH6e0CNzKXtcS7F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kwQXlXbp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso692737f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 22:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746854337; x=1747459137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPJs0SAm+KWy8iiStDcoiQ0ya+FPtzPKeqCBhvqJ8Tg=;
        b=kwQXlXbp4Fa5uvBGZ8DqDjaqFVQbOtuEp3K5mFo49fSVeDlO2M5GZM93xrno2h2pf8
         QsEIqM/2a07IaAbrJbaHyCHMVNbbWlXjh7SirBokucHgeDs8Ra+16rmIHSAHugEqGIEx
         BgkOllpRPeCsk9MW/twI6PHS1jCygl7rpZ20DSY8GNFo/179qjZN1J9A12LoeCP9QHC4
         Ipv7B0/NBkMC8OWjZ3bTyEUjSejAjSr31pfttaqob/53okxLZgsE2c9ADNF8Q8iO3SWw
         HmQJYEuRds1Dyl1wRRzoP03HU092+4TpaVlyFEVmX9gH9T5/4y0naTPWQbAVnw67T7z9
         7WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746854337; x=1747459137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPJs0SAm+KWy8iiStDcoiQ0ya+FPtzPKeqCBhvqJ8Tg=;
        b=rnMDViqNAcNJftT026U1K5Ps7m/Z/LbjCgdKVhACd92HXvJTt8RcT51fjEDKyx6BLa
         3lVfA4dgJGFsSxpKegDC1iCJedTxvC3VsH8aZcljosL3CBAvOVlwjKeX65up7OPYqKsb
         2g5mvQGFEt0Ds3NoXw8zj7o+MyQpYOFm8odRdP2xDChjkvZPJX4528m8cQ2r+ZJggpnF
         PUN3uNcRHsco1K9ZoZLZeMX33eiDh5QG5M4GvpgbB9xe3NRoQxr8hh+0I3jLWoq/SE5z
         J7wnvqmmVpxhuknnnHOB2tw2R2SreSPuxIc1mgioNdyiMtzmoqbN1TsOWi2wAaWuTZtH
         Yrgw==
X-Forwarded-Encrypted: i=1; AJvYcCXtAWUsI9MtkE7GwA6o3T3C6JOGy62/7eL5EOxaKe1zU6YSRQK8VFimdcrYecEsfHzaCP43tMKTnnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8CmW1vMt8UaunuVX+Uocv7v11s230gWTxF17OHS+yUN0MPaV
	bTL7i6cMqr8wHKgdVjdM0L49CHn1RTeVz+xDuFG3VIJExdrPrbd8poaFY3WzMg==
X-Gm-Gg: ASbGncsN5UzRnKVHuLL/DdrxUUXi9WgDKSoH+H0fu/VjE6aY0FryuJAkZv2BlxImeVE
	wpy+NpWz9pxryznN5i9EG0oFCvGRHuvx73Zmfm/HhwI7t3lHhlakjwIXVThkLK1WDXbxaaBRYV4
	igS17lf36rKYmnv1nBzDcdyXL1sL4RsbMBQb420kZQN2FORaXWtYxdjSw8k2RV28war0f6scSyp
	uywWukDRm/jqmgr2iolMoXmh8lzARMpFQf1oZVYAUebaBUo7lIl1d4+hdX4n6Q5iK/TdeLhxO6L
	MK3ZySOK2An7cITRK0yqV1/s6I6TVemHsPBVUfT8dSvuJemLjYEgr7thMPdPE1mobE3RNVa5CpI
	MAgna2lQUZvcPVF6QQ7PeXE1T62Bk5/BRSQ==
X-Google-Smtp-Source: AGHT+IHVJVk7Mhjam6g3QnKtJUb9VCcchPBmtRYjyvpoUa11jXjBzs1+C+Ts6P0d1bBomDaLw9WLKA==
X-Received: by 2002:a5d:5f56:0:b0:39e:dce8:1c07 with SMTP id ffacd0b85a97d-3a1f64a43a5mr5182223f8f.46.1746854337503;
        Fri, 09 May 2025 22:18:57 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec0e4sm5239317f8f.40.2025.05.09.22.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 22:18:56 -0700 (PDT)
Date: Sat, 10 May 2025 10:48:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	kw@linux.com, robh@kernel.org, thomas.richard@bootlin.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: ep: Use FIELD_GET()
Message-ID: <yqbq7lgaxwf6lc55e5pe6x7zjnehmmde2imhkvwz5hrsk4ztoa@yrkltzbmxph4>
References: <20250428124230.112648-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428124230.112648-1-18255117159@163.com>

On Mon, Apr 28, 2025 at 08:42:30PM +0800, Hans Zhang wrote:
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value. No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Applied to controller/dwc-ep!

- Mani

> ---
> Changes for v2:
> - The patch commit message were modified.
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1a0bf9341542..f3daf46b5e63 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -256,11 +256,11 @@ static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
>  		return offset;
>  
>  	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -	nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
> +	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>  
>  	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
>  		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -		bar_index = reg & PCI_REBAR_CTRL_BAR_IDX;
> +		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
>  		if (bar_index == bar)
>  			return offset;
>  	}
> @@ -875,8 +875,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  
>  	if (offset) {
>  		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> -			PCI_REBAR_CTRL_NBAR_SHIFT;
> +		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>  
>  		/*
>  		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
> @@ -897,7 +896,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  			 * is why RESBAR_CAP_REG is written here.
>  			 */
>  			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -			bar = val & PCI_REBAR_CTRL_BAR_IDX;
> +			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
>  			if (ep->epf_bar[bar])
>  				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
>  			else
> 
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

