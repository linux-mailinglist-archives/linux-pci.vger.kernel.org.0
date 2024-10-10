Return-Path: <linux-pci+bounces-14156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B49997F1F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038391C23C2E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB51CC8A3;
	Thu, 10 Oct 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qg9OL8hX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE391CC160
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544160; cv=none; b=ZI2EwPofmnSdQ49P2jDrEvZIcTuT52xzvXqOFgyk0pGIbuMYa8/mfbfDCouYOq1TItqT5RrgMckxYjwa0yCJiEv+KstQXyoqDvfpC7uiT7ImhqU8a8kNV+zzXwSEoRdCMWGRHdlmdXmFTgx8sPNMWv71JxiAwaS6jpHB7kaN+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544160; c=relaxed/simple;
	bh=T0eZ+0kPAfmI4/sVOtVFpHudEWC+M3+NOzXYfOsnsqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogeIHtQl6cekjkquQDYXwWAf3spLSc8HD+R7ZCiB22soOXC58Ymi8/I1NL9QpqTGkQhuTZ5jklD/VQvs8clio7KAqoRk/5PiFyM8LfC7F4WkCqZjisHa8qIQGj1t47/ZjXgz8J1EUrwYTLP8yBNvGK9r95BX3Ut1+wa1w7bPU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qg9OL8hX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ba8d92af9so4397035ad.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728544158; x=1729148958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJtJaWjtNg9tO3T0sp+J+HlaXqzFt2qZA6ek8LhkKYA=;
        b=Qg9OL8hXF45H8yaEqpNxJORRjLqMx/R+407i1gP0R5CzYVbkDnYQbg/7Fk3hMKEA7E
         vsdAJHlvRWnNFsqQReg5pGcYpW97lPd9r54WgD+PNKFFZdbK0ITg1LN55Ue8qE8yRxXC
         PKa7vV6UxhxfRJIZsDfYL6KoVEpyBr1KhERyla8pG0DOBVO5oXewSuoHRJLl4miGnTYo
         6lNgfW/jpcSsujCTwCokYYamfqz6kxdJjsl5FGjZnviZBkL0tSukWM+sBj85vrsqRD4Z
         bEsMZI4T1B6BPHXp3fZNZCffLb0kbNTPSzHxYGa0NRWwSi13Lt+8d6wdzqGnU3X6SV8W
         2kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544158; x=1729148958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJtJaWjtNg9tO3T0sp+J+HlaXqzFt2qZA6ek8LhkKYA=;
        b=taU6lE06UPvqXCfHsKWhUBnJgd21kNCBm2RsKt+oajAeAn4M0LaUWJd0qX1ZrftTrD
         8kEPaAsjX1lGif+votWi2R6INhkCH7S/auUNBDFySkP0yCj7fSrGx/6ghMoHUtXsy398
         S3P7AxnuAgvhfLLr9oNIyZCJykQyck8Dc1aJQiRcWaPClsmOsmRFF5HXobLzNU/Duoo2
         OpqPWZqxe8Joith4w1Mns25+jOWjhBr/gKUHZYnuv+8Ih2f2eQY4yermnYJUmUVVTvJ8
         n3jy0naQPgCpIKV3pa0WFqj7RCf+nAySj8LGd5rtoE54xvZ3ZmxD9f+s1OKMq/t3chDd
         9iJw==
X-Forwarded-Encrypted: i=1; AJvYcCVs1U4T7nvmVpB4dfhR/Z+DVjSVzVjDnsx4i1GCwcnhd9tUz2i91q7zzZGZVu2UFEEyxnZ3htvPe7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKI0+3ql/u+B9IixOGDyc/H5H9G9WnvvezwCfq2amF/4aYzYTU
	KomoLsefv9mDXsQvcdpUHGuUtZ3P3vnGazfHJnTvS4FHObpqXqKFIATJKRMRrA==
X-Google-Smtp-Source: AGHT+IEw4gY867tOo7DZxusBWqPRTN9yJ5jJLOtJDZX1qHIb6njHxYctb5N835g6n5vxSmfx6RjECA==
X-Received: by 2002:a17:902:f681:b0:204:e4c9:ce91 with SMTP id d9443c01a7336-20c636eb0b2mr73514025ad.7.1728544157915;
        Thu, 10 Oct 2024 00:09:17 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c215ed4sm4216135ad.217.2024.10.10.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:09:17 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:39:11 +0530
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
Subject: Re: [PATCH v3 03/12] PCI: rockchip-ep: Improve
 rockchip_pcie_ep_unmap_addr()
Message-ID: <20241010070911.ozwrpho3wddb4ezf@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-4-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:09PM +0900, Damien Le Moal wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> There is no need to loop over all regions to find the memory window used
> to map an address. We can use rockchip_ob_region() to determine the
> region index, together with a check that the address passed as argument
> is the address used to create the mapping. Furthermore, the
> ob_region_map bitmap should also be checked to ensure that we are not
> attempting to unmap an address that is not mapped.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 5a07084fb7c4..89ebdf3e4737 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -256,13 +256,9 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u32 r;
> -
> -	for (r = 0; r < ep->max_regions; r++)
> -		if (ep->ob_addr[r] == addr)
> -			break;
> +	u32 r = rockchip_ob_region(addr);
>  
> -	if (r == ep->max_regions)
> +	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))

Having these two checks looks redundant to me. Is it possible that an address
could pass only one check?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

