Return-Path: <linux-pci+bounces-14164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FA99804D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F4F1F255AE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05A21C9EB8;
	Thu, 10 Oct 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0WJ2CfD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1581C9DFD
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548551; cv=none; b=N9ifY+0FgAKSuOBjnPWLu626giLMonI7lNjLbfD4EpExQctZ7MDmZtKfgZKM/n/4coHwxkXBXPRGxE3u6UVj/Rzg4JbhqMeZFrNA2i00s/QTtIex8d1i0klNBnnNlyIr/7oVDTJ+ZQtJ0lrLpygYnqOWhgl1NSDddbQ6ld0ZWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548551; c=relaxed/simple;
	bh=P+6xdOmGSnhZHLK7VqC2v5HN4gFGIaSng43lr0KZusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKylx4ySQhnnJvbqdQRKUxLnimg5X2mMhdNjw6zdeMb5K/PhYmZ0pcbs9z8greDVJjKcdx4KZvrqBK43gXWQPP4RLzYO7ZGpRbO9RFsH5Azgm3iy7cpao80nqafsrhlpZvWCGIneVPbXTUlrHcsVrEA+2NFPZUMoDsTw6zNIzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0WJ2CfD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b8be13cb1so6722405ad.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728548550; x=1729153350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/pgoD5+pGJUHfH2jhcRczvJs6RkTR2OA0EF0YYfHvU=;
        b=H0WJ2CfDGqUh62NdCS8Tvb7EnL0I5HXIRTC1siH0PelA/EuQxjuBc9+xPkZlGSWQHX
         nFRwGh0OadmCQHl3Nr6rfQEe9yzRviP4aAREwkD/lnC6k2JckpTwF0kO5ixsNaN7AC0g
         F3G/hDi/pWWk2gT3NomMBdWyrN5kzRGehXMoM7MbpFcvuBf44D5A/BqnBR8HTFRvL5TK
         sIQ/ldFC4RtZA4FR4vcCkUP+MsRIwkujuE74TDQxEbObLNSOqjQWLBtoZ1NmoFwwZzei
         g6vO0nV7apIsLh1/h3Z1EzgAmcJLWX5BXDNQpMDwGbHPvpiMnYVVMgX+rAUt7fD5OkuY
         Rulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548550; x=1729153350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/pgoD5+pGJUHfH2jhcRczvJs6RkTR2OA0EF0YYfHvU=;
        b=KY5qIA1yVYrlwKO1DvlQtLf/xVz0vpxEuaT0cMoVQa0+kG8HnKyx5n5G+YwcKt14TB
         aRen7gMqE1weBbcGY0OTTtc31k3/UroZ3GUm7G/zlfY8yMajWs1LJwbJNWBnfO4ou0ez
         Ke1eeJB2UY7VXCEAS56QnUx2K3qtN448GXCbl/Y3UIaRdoF4H/MedwpgEJJvF8kmW9Fl
         cFwhsv2y63QpNZIXbzKlkDh5lp5r0m/ARzZuZ545PKZbbfQz/Q2hg+AVEpx4EawnpF8i
         Cz7tiPD0jkuopX/qb1F60SK4HPftjcZX/ZHw/0zsqoiqjA9v8zCTZCWsWedR4nrr3xWa
         exbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ray6tAmkYvKcOxph6cmIfauCSMmhvmBnr/i1VUTg3Kt/jzTb+I2Qor0+h7NTL+c4Rf9jKvJqzVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAq8X4vCRRIkyIiMn7tYOr5CJowFNzvoi4W82ftaqqID+CSsH
	wciyiShcHzd9J2CwU2WKlDe/GCgOEmftIirbBqqUMQNhMWZRDOmxuiLLtoIgtw==
X-Google-Smtp-Source: AGHT+IFYSDTOtXUXl+WIXVJmekFxzNnhZkb/wYZhSsxhNInJ/W+A4oIQnUJ53qqTLcgidQ16e+Gi4Q==
X-Received: by 2002:a17:903:22c8:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20c6377c885mr86173885ad.27.1728548549670;
        Thu, 10 Oct 2024 01:22:29 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e747fsm5329925ad.143.2024.10.10.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:22:29 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:52:23 +0530
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
Subject: Re: [PATCH v3 08/12] PCI: rockchip-ep: Refactor endpoint link
 training enable
Message-ID: <20241010082223.amfboyuegxwdo5gf@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-9-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:14PM +0900, Damien Le Moal wrote:
> The function rockchip_pcie_init_port() enables link training for a
> controller configured in EP mode. Enabling link training is again done
> in rockchip_pcie_ep_probe() after that function executed
> rockchip_pcie_init_port(). Enabling link training only needs to be done
> once, and doing so at the probe stage before the controller is actually
> started by the user serves no purpose.
> 

I hope that the dual enablement is done as a mistake and not on purpose...

> Refactor this by removing the link training enablement from both
> rockchip_pcie_init_port() and rockchip_pcie_ep_probe() and moving it to
> the endpoint start operation defined with rockchip_pcie_ep_start().
> Enabling the controller configuration using the PCIE_CLIENT_CONF_ENABLE
> bit in the same PCIE_CLIENT_CONFIG register is also move to
> rockchip_pcie_ep_start() and both the controller configuration and link
> training enable bits are set with a single call to
> rockchip_pcie_write().
> 

But you didn't remove the existing code in probe() that sets
PCIE_CLIENT_CONF_ENABLE.

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 11 ++++++-----
>  drivers/pci/controller/pcie-rockchip.c    |  5 +++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 7a1798fcc2ad..99f26f4a485b 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -459,6 +459,12 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
>  
>  	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
>  
> +	/* Enable configuration and start link training */
> +	rockchip_pcie_write(rockchip,
> +			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
> +			    PCIE_CLIENT_CONF_ENABLE,
> +			    PCIE_CLIENT_CONFIG);
> +
>  	return 0;
>  }
>  
> @@ -537,7 +543,6 @@ static int rockchip_pcie_ep_get_resources(struct rockchip_pcie_ep *ep)
>  
>  	ep->ob_addr = devm_kcalloc(dev, ep->max_regions, sizeof(*ep->ob_addr),
>  				   GFP_KERNEL);
> -

Spurious change.

- Mani

>  	if (!ep->ob_addr)
>  		return -ENOMEM;
>  
> @@ -648,10 +653,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  
>  	rockchip_pcie_ep_hide_msix_cap(rockchip);
>  
> -	/* Establish the link automatically */
> -	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> -			    PCIE_CLIENT_CONFIG);
> -
>  	/* Only enable function 0 by default */
>  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index c07d7129f1c7..154e78819e6e 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -244,11 +244,12 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
>  				    PCIE_CLIENT_CONFIG);
>  
> -	regs = PCIE_CLIENT_LINK_TRAIN_ENABLE | PCIE_CLIENT_ARI_ENABLE |
> +	regs = PCIE_CLIENT_ARI_ENABLE |
>  	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
>  
>  	if (rockchip->is_rc)
> -		regs |= PCIE_CLIENT_CONF_ENABLE | PCIE_CLIENT_MODE_RC;
> +		regs |= PCIE_CLIENT_LINK_TRAIN_ENABLE |
> +			PCIE_CLIENT_CONF_ENABLE | PCIE_CLIENT_MODE_RC;
>  	else
>  		regs |= PCIE_CLIENT_CONF_DISABLE | PCIE_CLIENT_MODE_EP;
>  
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

