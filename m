Return-Path: <linux-pci+bounces-16510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B419C5027
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B0C1F20FB3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B4320B1ED;
	Tue, 12 Nov 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzx3ukmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6A20BB44
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398411; cv=none; b=slE8Tke/deGaNQPYL061UqxmTNglMdFdBTs++G5alwNNvc6+YgerUsmtJHf6wu6DHrv1VlnsdPmEkBkXPMofq+hx+7Ywi8HfeCNnZjBxmax2O6y6Urk3l0jtpIJ5TKJwa+p5iU/4dZBZmCv7DGJgNh37m21/IygEek50sWrtoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398411; c=relaxed/simple;
	bh=t59seX+hJq4lNhKVPVYwYRzwgOYtQeQTWXsroLhzZlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7HfggZd/PVIHNBGcZw7TtdIwu4iFbfqj5iWB7a7utB+e8MHse2dhuDRffxbT3SFZTv/2ZJTyNz2/vLm7tVWNwhWzWQDr41Nz+V2xy7+Y3ILs4j2P7GXe3xZzGJmDJgBpfrRL7Tg6xmdAbl78fnZOJxO4ZWidflRFmIV5+PE5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzx3ukmF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e31af47681so4315333a91.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2024 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731398407; x=1732003207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5BvAkAKztYW6xCj+mZI8U7st+LWYK/vV8FsPRMq38w=;
        b=vzx3ukmF42t/n4MrptWLCY//4YsHUmZfa9vSYwWZO0pinmOruTbhzqm5njO6XucdXi
         pb8Hd2NPogWBVpwEsYILaEjtt7Fg16k3MCkJAdAaXNrmO2sMKYZjE1ImDjS29r85g/d3
         8XhLOd30y525PJWlPM6aMl60NOXsY5uknXUTzMCaoenFLnPJmkBTw9mZeelNj7XwAXJG
         um/Q4P9wvsBD0QHYK9CcQPSSHNL2v7o6SpDGiMC0k9b5rDZHcPj17oAiEiRFcp0kPwqk
         pWDlKamUOXB8/5n2C1DEX7NV3zllkGzj2MtUZuCWdAH/tZ0F6Sm/3bh1s0lf/Id56d3a
         wriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398407; x=1732003207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5BvAkAKztYW6xCj+mZI8U7st+LWYK/vV8FsPRMq38w=;
        b=Kvy8tqzCXp8oMKWgZ7MacAC80/xlPC3GJohEzEwnXJtqawuKv+Ep9PDEMS+3V6w/E/
         dm6juG7Tct1BDx/tWDqm8wVT70fDC35yijkiJ0u8QqGW/KKjnzMOXkqtYrBoi8FzCQOy
         XYJ/HqAriklZkiZGPl5okOBQrxagmy6xREBABIkxRz7A0Cwp+HxHT1XKJsUbh1UOocxK
         sDUPQ7IF/oitsX973nI05SJeHV1Asg5IrRbvMSLacHMpApq8S3zepVG1IFG9XvpoLsA5
         E6xuGQa2/HABC0DNp15VdWQLLAKxlRFp0hX4Ppr0jqvSmkxZShB46TqOeq8sI31zkM0z
         2Lxg==
X-Forwarded-Encrypted: i=1; AJvYcCUZcOCsAtLTX+XVWbUETN9AeYsQxUtojw5itKpLTwLcvztwuReHzgFZBms9EfT7dWO0sGJsmi+X49o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1II+TOVXVUNRBNvJxKRL49jbKVl6B7X8TO3Pmbz7qUt8SKXSH
	qkpr9Mn7wZXdZ5U8U6TM+N2c/OPIj1/maxmrolcui/X5k59u4K2TrwLuxxOxDQ==
X-Google-Smtp-Source: AGHT+IEl2XL5FCKVfnW5u6LivJkD4NnNJy29pjQKJz1cJx2jS0MCN9K5ShRz8rqcump7HIgEqbQkbA==
X-Received: by 2002:a17:90b:3808:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e9b16824admr20274247a91.13.1731398407154;
        Tue, 12 Nov 2024 00:00:07 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde1b8sm87828335ad.60.2024.11.12.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:00:06 -0800 (PST)
Date: Tue, 12 Nov 2024 13:29:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] dt-bindings: pci: armada: add system controller and
 MAC reset bit
Message-ID: <20241112075959.jatez7wwiukymj2t@thinkpad>
References: <20241112065229.753466-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112065229.753466-1-jpatel2@marvell.com>

On Mon, Nov 11, 2024 at 10:52:29PM -0800, Jenishkumar Maheshbhai Patel wrote:
> Adding Armada 7K/8K controller bindings optional system-controller
> and mac-reset-bit-mask needed for linkdown procedure.
> 
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>

Please send the patches as a series if they are all related.

- Mani

> ---
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index ff25a134befa..a177b971a9a0 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -24,6 +24,10 @@ Optional properties:
>  - phy-names: names of the PHYs corresponding to the number of lanes.
>  	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
>  	2 PHYs.
> +- marvell,system-controller: address of system controller needed
> +	in order to reset MAC used by link-down handle
> +- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> +	needed in order to reset MAC used by link-down handle
>  
>  Example:
>  
> @@ -45,4 +49,6 @@ Example:
>  		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <1>;
>  		clocks = <&cpm_syscon0 1 13>;
> +		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
> +		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
>  	};
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

