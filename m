Return-Path: <linux-pci+bounces-28760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BDAC9996
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2173A6D0D
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9622CBC0;
	Sat, 31 May 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylc+03+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8DEAD0
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673280; cv=none; b=e5qfmCpUt78O1WBQBs2toGSCVgY9Y8ufGRe2mqzy+yw9+h8qPVY1y+WZ13N4ol5sHPEq3DCsMNqlLOoGsTugnICZRtqKvPMA4t3n7L+ph8WITZk9Z5Ofraj4YZ/Mxa6wzsAR/ZH2qOD6q01S6x93jurbrJoNYlnNZ3whJEdBJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673280; c=relaxed/simple;
	bh=PxqLSl97DPtvTPB898IUtAJwGFBFE77MDz7ZltuLPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIamdbvFgvKkLnYDMmt9vkTEIIqWmMPvWEm0AQpevRDDD77uU8bzfIZmWYi2WpWJwX2bxVSC9v0UzRvG1vC91mVwQz+6F6B0+2lkauGy7RbcS/KxkDPTMtuD0V1hbBwxM8HMeZeNj6Ir5fS3ESn7BE9kmt0P+mZu3eluigrjEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ylc+03+K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23539a1a421so9361145ad.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748673277; x=1749278077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+/uxe3dxQ0IvY8GTZXqERCIfLVfCSKGis8G08eVtFY=;
        b=ylc+03+KiScnkk50XNtkecrT3Fu7ptKFYavhAF2OjsuBFoOo7PpDVY1NDw1AXtjZda
         jMrGxE2zP72BvB+JStmRHsJoNQKwo8HsyF0KH0BfjEyIhIv4gdHELCKas/a+qqyLLlzh
         gLorVV8IGNWwpGOStSDUW/6b+N335kbIMGd+iJuS3y1mV7ikruocOfpQeVr6zoFzva0n
         MhaWgPoe7/XNv6rEWCazMD9vfMO7FXrs8jwtJbh/pSHILhHx/l0CImCSLPTQa+LG2/Eb
         1UXhhkF3G20aOPPUG+RaCsyCUZp5d0MPABezn3bSZRubz2KOcxaRwNOu1oMahun4L6Mb
         V4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673277; x=1749278077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+/uxe3dxQ0IvY8GTZXqERCIfLVfCSKGis8G08eVtFY=;
        b=aX6twqzCSsCry8k273N3Lkon/9bqrtGtOgkRzenzqEbYbbrZLHmLN0tjM/wCzgkeGU
         cBxnVeZMFDEOmLQEkrRM/0O29iAUzyDVuTPQEmdokCqW4cG93YH7COcafWjN9mM0irAy
         WxuywO7xx+aCkfCzvPAWWVWATXIsou7xhtmOcyKbJ5WBasfFfo66qi7MvmjfKqE6RQOt
         pPQJi4DpiQpi2itRGVUXTYsJqiu7t9oyWmdGL2L7684MycxZB03vPkU9jgeyaVxmcMJn
         uJK27AfJ9oR6ot+qaso2/ebIhTXHeNezj4sDhDB7POVpxFrVtC9HTj7Xc/DzVnGFP20S
         OL9Q==
X-Gm-Message-State: AOJu0YyWO3EcKKIceqmObH7BpmC409YoK/I74XRlml2ngfH+Durc8I3u
	N+l3S5mVrt7AuVpFBPBKylr/hti6KiAcoO2KwwPgn4Of/BBFUoEf4FGZ2NJEgAHWJA==
X-Gm-Gg: ASbGncuNX0WcDqIjNh/9v6CwnH3+FMPhx7NAWC06Y0QgEkwW6zzeXhDO/H9SrAfHycL
	JffMszGrWfifg3l9PKC/KNwkPBVeMn1xJi/1mKHA1RVO5LTqwu81xuJ4Qn1b3shXsO1T5oJyEs7
	2XRPR+rJ9b63S7576V/C6scsg2Vq03nPxGjFZSOMBLKbdDnsApFKe66clZEgEGP30anSYmVEoLa
	1SvSPTOcSDro1a11qpnnTTXmBGMcUfGiZ0kvUgBX6jzGal0Gs/Ef4MM6z70xiNGxQknKKmMti98
	uEy1qC7nmSLq6EKrsO54uTlZcHAePITPc/YYeWuTw7zZ7pBpkOOSZkoKsOh0TA==
X-Google-Smtp-Source: AGHT+IFsJ4Pr1gW54/1Cl9dqqBQZUvBXxBB0vHhUwcZ3GY3SQHAiNtVzM3wVxEN3AgJfUEaw7hdMIA==
X-Received: by 2002:a17:903:19c3:b0:234:c5c1:9b70 with SMTP id d9443c01a7336-2355f6de0edmr14474355ad.17.1748673276944;
        Fri, 30 May 2025 23:34:36 -0700 (PDT)
Received: from thinkpad ([120.56.204.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdd0e9sm37348675ad.74.2025.05.30.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:34:36 -0700 (PDT)
Date: Sat, 31 May 2025 12:04:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
Message-ID: <g5rhfbvlx77imub6nn2bx2q6zest3hgsmssjdjrpwqhs2wuan5@uo2ca5asxbpe>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-3-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530224035.41886-3-james.quinlan@broadcom.com>

On Fri, May 30, 2025 at 06:40:33PM -0400, Jim Quinlan wrote:
> By default, we use automatic HW negotiation to ascertain the number of
> lanes of the PCIe connection.  If the "num-lanes" DT property is present,
> assume that the chip's built-in capability information is incorrect or
> undesired, and use the specified value instead.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e19628e13898..79fc6d00b7bc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -46,6 +46,7 @@
>  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
>  
>  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
> +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
>  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
>  
>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
> @@ -55,6 +56,9 @@
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
>  
> +#define PCIE_RC_PL_REG_PHY_CTL_1			0x1804
> +#define  PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK	0x8
> +
>  #define PCIE_RC_PL_PHY_CTL_15				0x184c
>  #define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
>  #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
> @@ -1072,7 +1076,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	void __iomem *base = pcie->base;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *entry;
> -	u32 tmp, burst, aspm_support;
> +	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
>  	u8 num_out_wins = 0;
>  	int num_inbound_wins = 0;
>  	int memc, ret;
> @@ -1180,6 +1184,26 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
>  	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
> +	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */
> +	num_lanes_cap = u32_get_bits(tmp, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
> +	num_lanes = 0;
> +	/*
> +	 * Use automatic num-lanes HW negotiation by default.  If the

"Use hardware negotiated Max Link Width value by default."

> +	 * "num-lanes" DT property is present, assume that the chip's
> +	 * built-in link width capability information is
> +	 * incorrect/undesired and use the specified value instead.
> +	 */
> +	if (!of_property_read_u32(pcie->np, "num-lanes", &num_lanes) &&
> +	    num_lanes && num_lanes <= 4 && num_lanes_cap != num_lanes) {

I think you should drop the 'num_lanes && num_lanes <= 4' check since the DT
binding should take care of that. Otherwise, once link width gets increased, you
need to update both binding and the driver, which is redundant.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

