Return-Path: <linux-pci+bounces-6229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88D8A4856
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 08:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBDD1C208A2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E91171C;
	Mon, 15 Apr 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHXGqByp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C71EB30
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163692; cv=none; b=EEe1ghhrqxHc/G13omBnanjtfxf58j+druXNJnE5u/UbaSwHvRO84zTmbvQJP5o6Wy0L4EZA+WJ4TpzvxBX9dBZ9zsv/fiYuJs659J3TeSloiUbjbVs94pHIeogiLYnqP6++bFrtjtsLC05mA3O3ZbfrAaXiqX/NnEk2orJ7q+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163692; c=relaxed/simple;
	bh=LpfkBwNHz8dVsTzElnryY5atcPvQ6+zSqkG4yPidzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un7vagkGOkTIskgApUkMvZ1dwpXRmCRxFw8QJzoJqSFhZuQg1oiCi4KVUqlaVpqWSk1llCLST30hHdAnbRUcVL7dX3mJN02V+fba4HvL6qOBu0Ke0HYsGmN8BdZDPRgcMSBcGvUBtmAA/Cwk/+eGaxztHuqguWLHc33GIFblMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHXGqByp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e220e40998so17060345ad.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713163689; x=1713768489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZfTrmJ3nkH0lmhVFsGXCKXFOCzQtRNgTdieJQWRuW0=;
        b=nHXGqByp3Hc79hv9xIBwyfuRRcyw/jEPe20GSHraRKkusMRbABeoyPeuIZxphKDi91
         y3DVYxuQOaUa+qFtjRkjA6WVmLfG6+BisQTbCUf6ijRQ+K6DdKUDCEebDUHIleFw01Ic
         AWqdabxtA/pyhmkckBBJfIbYcPpfH7A3uJxxjMwlALubBCnqUunF3vf2HlrJgs4KJIof
         ONVNyzt6899TzJ/ZIB7/LYnYPY6n6HXmmnt+8hTcy+68WGNrPa+xpx6suHl9YZ+tTlTm
         PMybUN0xZkFRclVsgGfYXzxK+vyxhILG2KCYvmyxjHY/HUuANIe2W2XjvvD8d1E7a7qQ
         x7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163689; x=1713768489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZfTrmJ3nkH0lmhVFsGXCKXFOCzQtRNgTdieJQWRuW0=;
        b=p3xmx7RTGKQ3z/8mjifDjb7RwDdEn35gwbrqW+Yse5tySG1MWvH5sO02cxiY0zi7DD
         esX6dLjAccGjD2KFP+2fJRAjDTx1VjigV1n7fmX5c2eze7LYtpwa7ewIBSxsN/JiBTiS
         Dik5e1EQd4wJDexYb1/J1BvW6OfcZAnAwbGALEPAwHhw5zCfwMPDT8Oi/GPT/MPPSuvV
         /mxXheQwtZ+/jHNDyrl1BWGiuF+6Ow8wod43GhTd+2jMCSZ3/vRP6nbtGuipcsnkuWgm
         PwCDYEZAnDtJOP0uZtbKuUkOAgikt6h00cEr484mh8LnCEaBc9bhMMsbpKDNpzilvW0F
         Pq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUDVBTDz2/QiBrN/TQY/NJRLLF4APOfm1KhWLdl72mQsov1THOQuhMih4nPeKebTbxse+mtUZ7KYs7aW332WJe5l2vhISEjN0Z9
X-Gm-Message-State: AOJu0YxxJXcavSTsZaLeRf5cXq9nIphKmJEqKzRkS8rt9NpQUG5LtdAP
	4t3qcimz4bhWGtIiNNkAwjLWg+CeNw++qlV4Ag97Acrh1JJy5EgWe0bKvzGxUvJch9F9jpMUe1I
	=
X-Google-Smtp-Source: AGHT+IFMdAz67epNVOvLEM90tVo6siYV71SLKcrPT/LwrjIM0/awkOGWGDlJO4QfrJv/BXrXot1XkA==
X-Received: by 2002:a17:902:f68f:b0:1e2:a449:da15 with SMTP id l15-20020a170902f68f00b001e2a449da15mr10533959plg.15.1713163689136;
        Sun, 14 Apr 2024 23:48:09 -0700 (PDT)
Received: from thinkpad ([103.28.246.218])
        by smtp.gmail.com with ESMTPSA id jb12-20020a170903258c00b001e2a3014541sm7172373plb.190.2024.04.14.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 23:48:08 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:18:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] PCI: rockchip-host: Fix
 rockchip_pcie_host_init_port() PERST# handling
Message-ID: <20240415064803.GB7537@thinkpad>
References: <20240412023721.1049303-1-dlemoal@kernel.org>
 <20240412023721.1049303-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412023721.1049303-2-dlemoal@kernel.org>

On Fri, Apr 12, 2024 at 11:37:20AM +0900, Damien Le Moal wrote:
> The PCIe specifications (PCI Express Electromechanical Specification rev
> 2.0, section 2.6.2) mandate that the PERST# signal must remain asserted
> for at least 100 usec (Tperst-clk) after the PCIe reference clock
> becomes stable (if a reference clock is supplied), and for at least
> 100 msec after the power is stable (Tpvperl, defined by the macro
> PCIE_T_PVPERL_MS).
> 
> Modify rockchip_pcie_host_init_port() to satisfy these constraints by
> adding a sleep period before bringing back PESRT# signal to high using
> the ep_gpio GPIO. Since Tperst-clk is the shorter wait time, add an
> msleep() call for the longer PCIE_T_PVPERL_MS milliseconds to handle
> both timing requirements.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 300b9dc85ecc..fc868251e570 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -322,6 +322,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

