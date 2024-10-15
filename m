Return-Path: <linux-pci+bounces-14512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225BB99DDBA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 07:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09F428326C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 05:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5A17623F;
	Tue, 15 Oct 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LApnVPVr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F8173357
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971684; cv=none; b=HbDC2yM+zHG2HII7wi6pX/4QVXX7zjs6qcWxkRuwnH8lb5VZcKK7pUqr0RvVJE1O28A5/IvR1uv01KqfcTpwm5mbQYPTZCvgP9hTIt4fueO0MOrP8j52xaw1TrVmgf7lzpSz7HDGB2W5LlJ071J+hXXDh3X+NVp53IW62XzyxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971684; c=relaxed/simple;
	bh=IT+auioFxv3+OZIBud5Fsp7H9caV4TDN8/WEBQ0yHSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpuCy+EZ6ZuTTSC3Vbn9XD7Iex/Dyx6gNyCxJpy54OwGqnD1yUxuHoNwrF1M0ZRv1tNsYsXjECEzydJrO7NDCaz3Khf7zpsiiB35UU27cX/RZyYQqCdu4gMbJ5F1q9Nyp7mEAZkhbEF6J2IdzBaDaZg5HnxFXlXHMtqrPhTjOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LApnVPVr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so3881320a91.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 22:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728971682; x=1729576482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2FhKKTN87gH/FsbwHSaPQNj+PGKF39CR0evIV3VLhpE=;
        b=LApnVPVr5joFfRVtiw1ej7+WBGJj/3oy5zhtyDcvJAG19wDLm0A4uH328Q6K6KSv8o
         O0yF8/qlg8T4oG2aZn0F8p8KSKaiHwk0rUAMzHEx2RDQJfNoRSTftQzWxof7KKU3fW6W
         eb4m1rtlrMi+4l3w10Lf+F4Np9Ztxk4SvIBihvFG0Zlwz49W22ZY9bDU5RY4oxpThUz3
         PI4k0QVMAiTscbSj3WDeAHJpQLC+0X2YNdUOT+5aWCu51AfN+pmR2VUqVxlDkHZbapvD
         VzofrWt+joMZd5EIiXBM03mX9fJOvHgBXvZWfhmgpfLG6YVZ52ve7cEXYSNpgZmtLh7i
         GV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971682; x=1729576482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FhKKTN87gH/FsbwHSaPQNj+PGKF39CR0evIV3VLhpE=;
        b=U2fEzwxMUuNmVK5SJe8ZzFderbDB99WzrUZ2mEy6z7oswnB3YBVmTlHIYYzmLF6U1K
         mEF9Y1lum6Poorp9noXmnpOmpkWt6tqkG3+BjN8auvrsladClwN4h8tQTfKf8+eOfVci
         nbMl0cMfW4H1bEwJ58e+Kqe89hyTfAlNQp8ZkvOUbifk+yRuKZmGojz5mmtuSuhM6duX
         EoVmhH6hZJ2gYEyz2piJuthRpv1djbbapRw80aB1j01t9Pk3ZA6DfBFFFxZTRbFDyPSx
         Eh8XeXF5e5vDg7PZmr4R+o1wRSBAZx3N2MiVif1ey7xULuB0Zwx/cT75uc1REBLnQ+Qt
         3MFA==
X-Forwarded-Encrypted: i=1; AJvYcCUhadC9WiUx+/yz1yf2rM2bhHCLcxP2rTWVPkDA485cs1IbbNT7BMdlKA2LpQJWNzinn4L8/XmM/Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlV5Bsoea/QcaK7i62/+ol64mqV1W1MptQGuQnyQHDhO3D4LCn
	lN20MGvaPFCmKlE0MogfbUAIo7kQhw5NE8bjPSwl40Lhlsoyd8dM7J60e2qDgQ==
X-Google-Smtp-Source: AGHT+IEnhUCFnIrUggbKFNm6VugtK+5i7awXLCAXzEPbKoMxSp01xJuEkszJVTGkZYoCowAYjiCw5g==
X-Received: by 2002:a17:90b:193:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e2f0add938mr17568497a91.13.1728971681961;
        Mon, 14 Oct 2024 22:54:41 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f76180sm640501a91.55.2024.10.14.22.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:54:41 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:24:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] PCI: dwc: endpoint: Clear outbound address on unmap
Message-ID: <20241015055437.lq736d4ocjlb4rtn@thinkpad>
References: <20241004141000.5080-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004141000.5080-1-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 11:10:00PM +0900, Damien Le Moal wrote:
> In addition to clearing the atu index bit in ob_window_map, also clear
> the address mapped (outbound_addr array) in dw_pcie_ep_unmap_addr(), to
> make sure that dw_pcie_find_index() does not endup matching again an ATU
> index that was already unmapped.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 501e527c188e..7f4c082a2d90 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -294,6 +294,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (ret < 0)
>  		return;
>  
> +	ep->outbound_addr[atu_index] = 0;
>  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, atu_index);
>  	clear_bit(atu_index, ep->ob_window_map);
>  }
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

