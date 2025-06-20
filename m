Return-Path: <linux-pci+bounces-30258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3AAE1B5E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C505188645C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E385D515;
	Fri, 20 Jun 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOcYavQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537030E84D;
	Fri, 20 Jun 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424441; cv=none; b=ktVKy2iCXNtftalj9L1r82Za53gY3p193errqfQsxmV+USGZ1WWL5rFb38Xuiqb931LshI/fgm8QU93muvaU+jil60kVa8VtAtK/Ne8G7LViQ0F/EL23WRclBrFYxFtIgOdvO+JIzZiYWMSPzkKjxjFJdv02jOk9gQ/zK5Qh56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424441; c=relaxed/simple;
	bh=nZHsfgLmOj5XfHygs8LAFogHnVsH+7ZJB0SIBGXmy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd6ADFpGlsuYaq6wvshVYlpfKsJW7L3GxmLnLbPyZ7DYPVKnCOHZwfjFg8v8LhTCNfUgdA3AfC8WNJzdYyerRH7TiKDZDlVPI4uv9aKrhe0LdJlq9iUuFcOLhrSpcOCSPOhDhQIjqETAvfCzrjn+XAgQMcW8Q9F6KS+emBiqgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOcYavQW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1247896b3a.0;
        Fri, 20 Jun 2025 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750424439; x=1751029239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSvBaEOwHs3K5QkOUjfhZZACAj/9HP8HSOlO7m0z0Zg=;
        b=MOcYavQWd8UyuYd2ffoZBQ2V4ofSSLYT2J3FP0+t4ReTS1tWCdr+RifMPCHUA5FqIt
         6Rz54BRqZbmbp1IkOkLH5olgxmTWZkvIAYSGoJbZ7z6iL6661d+fbsdS2djLag1Of+Ug
         wNbrUKNtLd0PRNeHSu745nSZgXRSSnHAsA8ZA5SQDk+69NBCNv76m32FymJW4kWjNOpr
         VJN017X5YICuFocBSa00+JVYBEidfisDVIvbD/eSFAhya0cBL2N0FDI89bztphs4BCel
         H0Rm591YibVTl4AP0YTE4DERYrSoK5CKJwc1w0cXxRtu34zbdTlRjiGxGW1N9loJVWEI
         N6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424439; x=1751029239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSvBaEOwHs3K5QkOUjfhZZACAj/9HP8HSOlO7m0z0Zg=;
        b=BKoPCBwXfFWa1cPjJuwui+sKbUROxUQqdPm26JsFaxT3HyYcwf/kuRaEjXFqaoUR33
         X7NmJ772w1rpP1rk5RklIaByHDsbb559FedNcgN8ZolzLmVxmL9UAyCsdE7LLqo9GPC7
         SJwY7gZoaT49anrm8lr6fbOoSbxKtG+lMgv3AUfSnrN5Ik1MLUA0OqbbT/xnx+81vYIz
         AGW8qyChBuAHk/TBjbopZBQf3MECojYRf7uqOsYmbS8fy/BaSGZ/DJ5L4DEkIqSPkKQp
         LRmTzFuRBop9maJLMaBllj68ep3MpoKa+Y3txefkXTUuSS+ybZCAjUYSEJSdsR7GfWGq
         xkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUsReTFN6V3sJ1WNBVT3HKA5OKQLLmoBjFsvStr8+Ima4+tSaLyKuvCcnh81WfDhdb5/IqCGKAALHpe@vger.kernel.org, AJvYcCWER98QQ2o4jZ4Z1aX4V+vQFTi5ezTOKG8CQBdyVYfTUs15gAqXq/ZZzhlIJnGUQuKFzApfqQoQU1/no2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SdouvQY4dTIaE7i86WM34Ip4tAAfHgOfJ+SBtUEiILS7cKp+
	W58vVCOzll6jdbksCgpdpC6ke4GJD8wuo2hx4F90iQOHRD3aGpqiIuNw
X-Gm-Gg: ASbGncssir2kIozFaLze2DhVdBKcELqS2wNCiYyWKbpbMoi2LELyrroKGhttV0jnBHK
	c7eD4l8bNV8/tZ34u4UELwGX3+atFpQ4mJ5T0107NmbWgDcvU7Sg650W7evxyYPk/spzTAxvv/D
	qem3hSyD31MozkLnXx9Dhvq91LXWvtIBDV0LmUFWiFRcNLhCovaiAOFKQHg+v8w6MSCRQzzZSTZ
	ScbOw9r229v5hWPooWMX23cLMe4m0YzY/P3wvc9ifrAF3mARlYEHpkpi8r7QPm1nG02UsaieVfB
	h7OYNH8nYCsFSAcvASiLu2/xtM3AGorFdpZg5JE3K/N+juB+aw==
X-Google-Smtp-Source: AGHT+IH769Yhqpe3IGCT87lyXbykB6q9+9qjkxaYFu3oBfVpD+WnzrOHIxyf03fBlIyFkkLBax0GxA==
X-Received: by 2002:a05:6a20:748c:b0:218:5954:1293 with SMTP id adf61e73a8af0-22026de98cfmr5302329637.34.1750424437536;
        Fri, 20 Jun 2025 06:00:37 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cab9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a69b973sm1994049b3a.157.2025.06.20.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:00:36 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:00:30 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
Message-ID: <aFVbbnl9UscGQoqC@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
 <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com>
 <aFVTdYWxuq9YzVQR@geday>
 <413e7ed5-fc4d-4e4e-9cb4-234c41db267b@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413e7ed5-fc4d-4e4e-9cb4-234c41db267b@arm.com>

On Fri, Jun 20, 2025 at 01:47:35PM +0100, Robin Murphy wrote:
> Ah, I put that print at the top of the function - on second look now I
> see that there's an awkward mix of per-lane and global data, and pwr_cnt
> is actually the latter. Sure enough, moving the print past that check I
> only see it once.

Hi Robin, thanks for re-testing and no worries.

> 
> However, I still don't think blindly enabling all the lanes is the right
> thing to do either; I'd imagine something like the (untested) diff below
> would be more appropriate. That would then seem to balance with what
> power_off is doing.

Thanks for the suggestion, I'll make sure to test it appropriately
before sending v6.

Thanks!
Geraldo Nascimento

> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index bd44af36c67a..a34a983db16c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -160,11 +160,8 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   
>   	guard(mutex)(&rk_phy->pcie_mutex);
>   
> -	if (rk_phy->pwr_cnt++) {
> -		return 0;
> -	}
> -
> -	err = reset_control_deassert(rk_phy->phy_rst);
> +	if (rk_phy->pwr_cnt++)
> +		err = reset_control_deassert(rk_phy->phy_rst);
>   	if (err) {
>   		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
>   		rk_phy->pwr_cnt--;
> @@ -181,6 +178,8 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
>   				   PHY_LANE_IDLE_MASK,
>   				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +	if (rk_phy->pwr_cnt)
> +		return 0;
>   
>   	/*
>   	 * No documented timeout value for phy operation below,
> 

