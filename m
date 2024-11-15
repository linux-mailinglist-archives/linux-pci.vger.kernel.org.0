Return-Path: <linux-pci+bounces-16875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53329CDE53
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FA42825AC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3071B0F24;
	Fri, 15 Nov 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTXylMh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D983BB22
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674238; cv=none; b=Ot2XplLTkl4H8iucWTQz5jGwhgyZu+Ay5m4phw1DVXuAAbqwlB9YeGtq97m6kpvKukmzt+IeFQ7r61AbmKfwCcX1s2cS6sSwaSAcepAlyZBhL8T6KjreB1O8g3ZoTahswOUjrpJh+ple8/Ue2JOUWDJwAgDcLNZyOYHdeya9BKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674238; c=relaxed/simple;
	bh=KFoEAm/MJ+CkguhUJbBAaimlQkz8xrheRwjZW3ZKxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN6GspNb0x/eOONg1WklA91o23bTAQ8LnicvGRAlND1Lg4GOHePxTuy8c8Oqiq5TaCDzUoWcqgjVFo3Ov39s4ZLQBYuXpdAFpInQxYbMS5vRoZIarugzwcackj7ERx9Tk4NOvOWajR3sQS/9UcCQ8pBfeeVEww3rzrkiAGYjHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTXylMh3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso1393493b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731674236; x=1732279036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9d3SL9vH2e3pgLXSrAw/DmX0mWevotMaQ8nhbnV7C+c=;
        b=DTXylMh3y5zg+OPEmB/aieN6q7xMuiYJ5l6wc5mCRtb7YPLIteVnZntkVvBK6SJ6BK
         glh8tGxirFO6VuSNme4ZI4FZs5oYFqrE7OViMRR80nPuD6XuM/caVw1kNf5BPt7KNm1M
         gmPcs+6WeEjhSmH8X6uDJj9BkAXqqkalb5d8h87hrYe3LJFUNcKumwwNGP+xFvQicga2
         Yr0FS/dweOmAte92AFRR8NyGIPH48mgklbAMoLOHMWSZcVI/Icw5S+CQRIBr54ZY1Q4k
         LVkPrZb9mTwsYQcVISIxiChtXvKqkEGN8+mb81DA/ZHt7j+GUqYJnTYX0A2EnmXOGPXl
         ZsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731674236; x=1732279036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d3SL9vH2e3pgLXSrAw/DmX0mWevotMaQ8nhbnV7C+c=;
        b=fTIFUuTDZRGXMmldWqPi9Na5S14bOQX+iCTULkPLwRPoruP+tYqRs+7cB/ZVevln2Z
         TqhAbBY+HTIU0lERMEr4Zb7mxLWnp7TDKuy2U8mm1H3QEk8IF7t16CAMMtI7nWzmwhxE
         VYoT77PygVBGuHD9SpxJrKYUZzeUyD4LagkGnylNVPkLrMaCfJeftxq3v0EBMD6pflEi
         XcfhxspytoFL7f4JISila/98kdu225SctTdjO6M6F/9UPyvAW1Z2fVhoLxWd3nI2mlcZ
         CvQdwwCxIfjXYR+lUAtYar9iwtYKZ0aHA/EWMyi3HALt3uxmNg+kgoC4io3h7fbIZZs3
         BNhA==
X-Forwarded-Encrypted: i=1; AJvYcCUrc57UIV2yoYw4+CA6Paj9F0CFDmPTsRL7DxHs+K7R/UtuNWYEtwJbGgdQ4R2WLLujH2zUveuW9pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxrUD/rvXL7/TZ/WR1tOJ2LAYfbl4cdIeyOm/bWst7DetaW8U
	VtQsyL8RU7rqzdC2dOaEvN+ejyRtSfhCQ9BpCBaqFbtu2N4O1bo22gCmxpvkdw==
X-Google-Smtp-Source: AGHT+IFQSkHpmOGv/LSYibpTXHi0sXyBiyJoTKFZ11di0ptf1fGsM/SheI+/mVrvRrtADmFkp80Y8g==
X-Received: by 2002:a17:90b:17c2:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2ea154f5ee9mr3269168a91.10.1731674236386;
        Fri, 15 Nov 2024 04:37:16 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c51esm2703383a91.39.2024.11.15.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:37:15 -0800 (PST)
Date: Fri, 15 Nov 2024 18:07:07 +0530
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
Subject: Re: [PATCH v2 3/4] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <20241115123707.in4x27ub4wtwdggh@thinkpad>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-3-0ea3a4af994f@kernel.org>
 <20241115090231.nwmxl6acspxqflpc@thinkpad>
 <ZzcRG3OInXZ2TP-Z@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzcRG3OInXZ2TP-Z@lore-rh-laptop>

On Fri, Nov 15, 2024 at 10:15:07AM +0100, Lorenzo Bianconi wrote:
> > On Sat, Nov 09, 2024 at 10:28:39AM +0100, Lorenzo Bianconi wrote:
> > > In order to make the code more readable, move phy and mac reset lines
> > > assert/de-assert configuration in .power_up() callback
> > > (mtk_pcie_en7581_power_up()/mtk_pcie_power_up()).
> > > 
> > 
> > I don't understand how moving the code (duplicting it also) makes the code more
> > readable. Could you please explain?
> 
> Hi Manivannan,
> 
> this has been requested by Bjorn in
> https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26110282
> 

Ok. The description needs to state the reason i.e., the
reset_control_bulk_assert() is moved to make it pair with
reset_control_bulk_deassert() in mtk_pcie_setup() and
mtk_pcie_en7581_power_up().

Btw, could you explain why reset_control_bulk_deassert() is present in
mtk_pcie_setup()?

- Mani

> > 
> > > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > > complete PCIe reset on MediaTek controller.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek-gen3.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > index 8c8c733a145634cdbfefd339f4a692f25a6e24de..1ad93d2407810ba873d9a16da96208b3cc0c3011 100644
> > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > @@ -120,6 +120,9 @@
> > >  
> > >  #define MAX_NUM_PHY_RESETS		3
> > >  
> > > +/* Time in us needed to complete PCIe reset on MediaTek controller */
> > 
> > No need of this comment. Macro name itself is explanatory.
> 
> ack, I will fix it.
> 
> Regards,
> Lorenzo
> 
> > 
> > - Mani
> > 
> > > +#define PCIE_MTK_RESET_TIME_US		10
> > > +
> > >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> > >  #define PCIE_EN7581_RESET_TIME_MS	100
> > >  
> > > @@ -867,6 +870,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > >  	int err;
> > >  	u32 val;
> > >  
> > > +	/*
> > > +	 * The controller may have been left out of reset by the bootloader
> > > +	 * so make sure that we get a clean start by asserting resets here.
> > > +	 */
> > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > +				  pcie->phy_resets);
> > > +	reset_control_assert(pcie->mac_reset);
> > > +
> > >  	/*
> > >  	 * Wait for the time needed to complete the bulk assert in
> > >  	 * mtk_pcie_setup for EN7581 SoC.
> > > @@ -941,6 +952,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
> > >  	struct device *dev = pcie->dev;
> > >  	int err;
> > >  
> > > +	/*
> > > +	 * The controller may have been left out of reset by the bootloader
> > > +	 * so make sure that we get a clean start by asserting resets here.
> > > +	 */
> > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > +				  pcie->phy_resets);
> > > +	reset_control_assert(pcie->mac_reset);
> > > +	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> > > +
> > >  	/* PHY power on and enable pipe clock */
> > >  	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> > >  	if (err) {
> > > @@ -1013,14 +1033,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
> > >  	 * counter since the bulk is shared.
> > >  	 */
> > >  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> > > -	/*
> > > -	 * The controller may have been left out of reset by the bootloader
> > > -	 * so make sure that we get a clean start by asserting resets here.
> > > -	 */
> > > -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> > > -
> > > -	reset_control_assert(pcie->mac_reset);
> > > -	usleep_range(10, 20);
> > >  
> > >  	/* Don't touch the hardware registers before power up */
> > >  	err = pcie->soc->power_up(pcie);
> > > 
> > > -- 
> > > 2.47.0
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்



-- 
மணிவண்ணன் சதாசிவம்

