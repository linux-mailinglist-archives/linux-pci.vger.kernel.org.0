Return-Path: <linux-pci+bounces-14157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672E997F35
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CD61C212ED
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD981CEAD6;
	Thu, 10 Oct 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onhr9qUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC41CEAC2
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544445; cv=none; b=qMS6UcPr+QmquslXuaTLAiMj8f/e5Nry8zabqyKUTebeAR5U7IHWxQGZs0zDC0DCjEW3izDeIZzZtPO2BJ6zmWFIqrPVZH3fdMDFt0Gfl+mCoOFIlA1hJWjzpnWuiXfub9d9tIU1Bx4qSC2hj8mguFBjIHDVCMX9XXbTPB+FFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544445; c=relaxed/simple;
	bh=4iOxIX8IGVA18xlHD/m26tJRWtsCYBqt+n68Y532fQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/ajESZAYB4MJ/vfoOTyarAUYLFceha20zsiUmhASUf2q7aWsKuvEeOvbnSNtUG26de9Vy+LAilJYF5IvBg1pap5ARUZ2fbrk0nkFtNlGLOBOzVW17Ir0iPXCD4EL7bYrtV04DJTy8pjjoWf/Jva40bPl+YvSMtW101qymg6+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onhr9qUk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e15fe56c9so511898b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728544443; x=1729149243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5sDmeUpbgEUKwxwRuUhCja4Dxuub8EV9vOw4/pjad+c=;
        b=onhr9qUkK1H5gq6+B0GcCuK4zg5MR8ziVlzWm6jBNNilYGClNAB5zh5JpIpGdzRLJV
         4UTzMXnZfMD7SCv8tJG3QdXfJ0Flc0krzKf64AcG2k8gM7wPVYMkAXwVIicQO81AldPs
         edJrHCwcalv4oQ2idDaOX9P/SWO+EGVfEeKmT7O6V/I+l6/bh31pSd41945vbv5/UYki
         98Tv7TQnEDWu074iO71pdpNXrGLfNwStVQInerOwR0cBl3uDKRQG+23wDNrXl1zqG/Xw
         GkjLADjw1Bu0jhPGwkXEAKraNt7OoKERP0HDgOJITL35ws3ewlm7wvfZ1v25PntIsyl0
         v0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544443; x=1729149243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sDmeUpbgEUKwxwRuUhCja4Dxuub8EV9vOw4/pjad+c=;
        b=mL+ypKV99p8A4Sl1di03rZaV6jtuRLmZux31mkMPktjGkBjB1hUJnsUNG1jUUT9GoP
         AMo7l4LgX2XQy70BdCS3O6vDFa5AG99OlHOLPvh/gJp017y6q5AZ0g1UMVV5bHltvaC5
         KxH6suUt2Ofkj8oAWtWVsT0LuSQQH4OzPqUbZi7qvoEwQwbNSiSmg945YlPEBMZGa9ap
         c9b5eTg8B5G3POHlqW750TWZsQ6Gsw8W2tgNuAfQPB9YsteZG+KolDbBkWc5zhqymWzg
         Y5qGO14EYPsTVRL+WMxvky6S/zMnMnUdPwAWuRrkP/68KuCUvwD+5HNRH3mCZQXqYUrJ
         HHdw==
X-Forwarded-Encrypted: i=1; AJvYcCX6zl9q0XZ3k0o1W0AVcvAWpzKeSOuWElHAG1ULFMA6z8SNChIZLKhc3LIKO1VIVGf/604gIIzSfik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQmVXOGQQ1zyHRDAY1hiMtDe4gRX+8ittzRLAXCb8YMqDb73I
	oUllICPSkEAipjHLE97r0afuUKiuTvHFyDtwMFuWX4tB2GkQLolFORbe8Nyesw==
X-Google-Smtp-Source: AGHT+IEO0BjF4lnOqXZimpvv6/cR8GzLT8i2pb0ODWlwAKixhY/VBPqgnDGQ91Lcitig4AdIMRVtXg==
X-Received: by 2002:a05:6a00:180e:b0:71e:9a8:2b9a with SMTP id d2e1a72fcca58-71e2680ad36mr4297170b3a.23.1728544443338;
        Thu, 10 Oct 2024 00:14:03 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496816esm385681a12.89.2024.10.10.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:14:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:43:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 04/12] PCI: rockchip-ep: Improve
 rockchip_pcie_ep_map_addr()
Message-ID: <20241010071357.c3kck3rxdhvy6m67@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-5-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:10PM +0900, Damien Le Moal wrote:
> Add a check to verify that the outbound region to be used for mapping an
> address is not already in use.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 89ebdf3e4737..edb84fb1ba39 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -243,6 +243,9 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct rockchip_pcie *pcie = &ep->rockchip;
>  	u32 r = rockchip_ob_region(addr);
>  
> +	if (test_bit(r, &ep->ob_region_map))
> +		return -EBUSY;
> +
>  	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
>  
>  	set_bit(r, &ep->ob_region_map);
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

