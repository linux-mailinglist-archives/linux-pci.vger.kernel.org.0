Return-Path: <linux-pci+bounces-16847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D59CDB10
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02AA28301E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64818A921;
	Fri, 15 Nov 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzH8NSTg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88274189BA2
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661549; cv=none; b=fuwKLwjQZ38S+5l5xx0E4vRLd3nMe1TatO2syI6zbH019frUexonx3BBK/95CKncK722lBlp7Irzeh8G/CnKR4BZlwcF2PnaM8vWq7ags33Unr6ykdClRN6m78xE2PWqU10elYVSwewdVc6RQEi0i5gmDQM8FjR9KKmik1eZrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661549; c=relaxed/simple;
	bh=xkQNwjafmgKtlFOzqQzgNxkConFfayeyELccqw2oJgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCuv9G6zTMzMvWLbeTpYzuYUAEy0Z+zvfCLqsqF60VxpMjELaAwj3Sc7Li7Of6cqwrez4IN2T88JRvpS00RKXx6TejeIfOnxL4AJqHNTC+9CgXU1u8AAQQYbrISYTA0CdOQPlidRbPE9mrif8UJjVuex962L59DSgOQQiU+viJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzH8NSTg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca388d242so16890365ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731661547; x=1732266347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vlc2jQEHSnRz323s6X4ls2WiMLcG19WhHp5TCCtCt1Y=;
        b=WzH8NSTg9UJ9q7dGMDbWy30Ioblzmy1iKjmbUwNE763rn3jo5Sl+R8h/NDSz9T05yt
         4NcHEPROI0zHBUUpI/GmtuDtYmLUJJEg+dl88ZlV5Q3+1iduO9nN7RnVKrdSAzMfDocG
         gH/Qbf7GvaIUDdLrJbdsMk0PxPj4duSETNeNjgzw9W2RQMdofPcOmS8Lwj8UFw5EtZUr
         6G6s4cCCOFZ6X2upWl90ZJBenFAPJvCxIYIdNFLrRBQIRXZqcdbu36BmZnnIjVhioz4c
         GGf/EkowZJNPl9O/qj4mZFSEPMo3xZehrQFs0YZISmmA2gAH92fpmJhUvXEzNStSKDv2
         sZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661547; x=1732266347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlc2jQEHSnRz323s6X4ls2WiMLcG19WhHp5TCCtCt1Y=;
        b=e5r0N57U6NbTs8gE/P+iXUTHcgb7OZ2nE5tqOrdnZnY6exUlQRk8Kd1xm31I5EvnJ1
         y47O3OaUjp4Mf7CAHMEkrP/UsJsdTf9sJAA1Nlng6kPj8zzMbZzdhXmthW5ndHpfKUdS
         9/2tr5BDwwRakVcLVCQ8iCBgfdVg0P6HWUejcUrZ6Ga0vvnMQ79yuZPwEoX4cfyCAMZB
         wJQcF7d5fxPVlGoLv7/9CyHjCVbkIlTdg3adS0xzFX/CAiqn+D6mJcLmf2NOf1B7anRH
         Dnvw/HZTHmAwZz4VN29Hw9Lbh8Tb5OejOfcfPabVcDRAqjuHaVUwZxH0sqsICEIIcj+g
         4qSw==
X-Forwarded-Encrypted: i=1; AJvYcCU/DZsA2W+n3eGJbSnWXHIo4W8QIawItyZ3iGw6K6gGGpkxx5D9qF1riWJuk8mPvdZIQWNJ89sxQ5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyT4n4cEVifkcuqt+uakS8ogHYs6LbHVUUCaV/w+/Z3gebSeeb
	jGeWcf7SvKY77DCoBmYSiCeB1WwSzeFtCE3P/0nfMukxvIh6Mldsjo97O1Eej7VpP5nL3mXanS0
	=
X-Google-Smtp-Source: AGHT+IEPnyKbtklUqZrKwBgsowtsFMFCMVl2PnJWMT7KygVn0rUWNJaaV7mVXWA6FXcxMjDgHklzTg==
X-Received: by 2002:a17:902:fc4d:b0:211:31ac:89eb with SMTP id d9443c01a7336-211d0d5f589mr24586035ad.11.1731661546846;
        Fri, 15 Nov 2024 01:05:46 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4685bsm7912705ad.201.2024.11.15.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:05:46 -0800 (PST)
Date: Fri, 15 Nov 2024 14:35:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] PCI: mediatek-gen3: Add comment about
 initialization order in mtk_pcie_en7581_power_up()
Message-ID: <20241115090538.3yx7vr5oeckz46uq@thinkpad>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-4-0ea3a4af994f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109-pcie-en7581-fixes-v2-4-0ea3a4af994f@kernel.org>

On Sat, Nov 09, 2024 at 10:28:40AM +0100, Lorenzo Bianconi wrote:
> Add a comment in mtk_pcie_en7581_power_up() to clarify, unlike MediaTek
> PCIe controller, the Airoha EN7581 requires PHY initialization and
> power-on before PHY reset deassert.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 1ad93d2407810ba873d9a16da96208b3cc0c3011..c9981013e59d18ccd3294acdcbd536dd95a0e436 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -884,6 +884,10 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 */
>  	mdelay(PCIE_EN7581_RESET_TIME_MS);
>  
> +	/*
> +	 * Unlike the MediaTek controllers, the Airoha EN7581 requires PHY
> +	 * initialization and power-on before PHY reset deassert.
> +	 */
>  	err = phy_init(pcie->phy);
>  	if (err) {
>  		dev_err(dev, "failed to initialize PHY\n");
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

