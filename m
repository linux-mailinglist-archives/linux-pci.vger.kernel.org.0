Return-Path: <linux-pci+bounces-25126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85846A78929
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529147A4530
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F520E6E3;
	Wed,  2 Apr 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ei0k1jCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005420B7EA
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580235; cv=none; b=Opjk7ufFQqVH3Gow27+ctNTARMI2igpfhdQ6ffKlS9eX77jgGylJDlCnnb6MLKm4cdoLygpurUs288Q/8iV8G7Af141ftBiBLLfCdwfVlfobSkhGQ+RpOaA5s/Cm/tWCGdeLUJuWGpJxPR7p6Q9iD5e4Upxsg5epICtzcPt5iZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580235; c=relaxed/simple;
	bh=DLQlBqvTK+aXl8wePtnMml4HsqZJZsCT2FHuFkJm1JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkWpu7dixrpsR+zkmu1iYqpxK5t+QTOTf7SrgEQEvcxwcUV4nk75r5XTfWt+JbwclgmrbOM04kak68VlLHswCjdYa2BYL8Vf0aX4JNJD+AFg1VoiSeqEWkNKYqBAs+CNLkjRkOr9cgQvURqcZqmu5CR4QBwc26IgvsLggh9C9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ei0k1jCF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so103899795ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743580233; x=1744185033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNRTveRWVnz/0Xab+/KRVxCYrU4EE4wnJe0gfE8ybMI=;
        b=ei0k1jCFXUKENb707sRwgp4Bd2nJBV4m1lAj/8QLk9nbhvjo5HOBIPHHdLYZbcKysG
         tk3hYwD0UUaQ505BMqy9yVNL8aURmJgsVEzk6u6/HzPFYuBDyEpsFfi42aImukPHPOki
         ZfhxZUF3CoNanfGynEHYq9Bdwj92RGrFiGZJ0GGMILo9eT+I/Q8kbuaNQx9IkjuTZQM8
         GqE/ZMCW2zjWcU0aZEPm1awIdb6wBlqBgtwy234AomR9r6yY6WMFYvZX1oHZ388Y7oiS
         o2FcTiozOuK+Z2s1R0spw+UIRmnG1szhiS+sCFlQVSITLz2THqIHmLWrS+EFnlglhGEo
         6kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580233; x=1744185033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNRTveRWVnz/0Xab+/KRVxCYrU4EE4wnJe0gfE8ybMI=;
        b=BWGK1mnJchzyyRagCb5c1CK656tiFsoAz4a4PAtCzyscNWvdkLhsItuGOWRi/CtfxI
         n7eapWfqpfB0YciBSW35COQGglyjdmJGbSfYGOlnw28lGuMPM/wQ4B8mKEi/VaHJjYwd
         hH3AsUXHkLqfe5/qlhcYNTZwiUq4vzLNKBBnqI8BbAx9sm/5QWIeV4jozbfpqNAzlqcd
         kZm9WXLODYsx6jSdhHfVeu+UjJSUSq4tH2FOEFrd+Jaun4ggKAUHVHv7jLhAZWNCsUPm
         p6PguETYgsokM3Hq7azevEnUIX3Dc2iTBMJvHK4tJSuotAz4+SefoBT79sAq5EL3WtWj
         xkPA==
X-Forwarded-Encrypted: i=1; AJvYcCVLADWk1NjPfRDbn4OoE2kz0An9DNwJ/WOYRM3mdDEpwrxfPsSbxeaMgjThd5dnR6ei0J8iMPJH7+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVDtrHzeTkLwdVjLJHMic6WKV+mFGGQO8Zyz48Q92B8gRmj4s
	bghgf0URN7rqQkJZdK182ps2Xn8G8Z6SiLJ3nRvcht13tKSYkR1q9XjyeAoOIA==
X-Gm-Gg: ASbGncuWAl7O0g6IKdx/pIDfUMkLeYaNr5k8R69O7V1wiUP5BuUavLY8lKxvVS9BTOU
	1DGKogqCSaSnDAhrXsQatXoRe7lQLfPr7KJtOIsktMDnG1dB0Wmnt6cnDe0W1vonEyGXv7Gq3zi
	G4DQMj8uluXhHE2yBG/z+zw1PQW+dSqc2mLXcoEJASBoUpm+K237l5dl/L71d3A7aWTKcoF5u4A
	Dyc+lQlGmj9/s2wcBxtXCTi8renAc6APs7LCRqplNW8XyIrrq+445iPoyoh0GchuXVPil5ZtxET
	R0BdsWpa7R3wfXYfWymhtG4mtVKMvP6R63oZhDxk4GDnRNnETpjZDGcs
X-Google-Smtp-Source: AGHT+IFbubLAcjIJmVW9Uzpo+2aLIIImOvMRGz22sNIc9vozaKUYwfB1hQ+2S1SCz/Ds6z7MJbmaXA==
X-Received: by 2002:a17:903:2405:b0:220:efc8:60b1 with SMTP id d9443c01a7336-2292f9e5226mr246523465ad.39.1743580233121;
        Wed, 02 Apr 2025 00:50:33 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71b2sm102550355ad.18.2025.04.02.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:50:32 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:20:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip-ep: Mark RK3399 as intx_capable
Message-ID: <io3meoai7vhaxipgcxx3bjfmnwuudwxgwj55z4dh3m4zn5tf3l@w76fcj2mevlq>
References: <20250326200115.3804380-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326200115.3804380-2-cassel@kernel.org>

On Wed, Mar 26, 2025 at 09:01:16PM +0100, Niklas Cassel wrote:
> RK3399 can raise INTx interrupts, as can be seen by
> rockchip_pcie_ep_send_intx_irq().
> 
> This is also in line with the register description of
> PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
> Description" of the RK3399 TRM.
> 
> Thus, mark RK3399 as intx_capable.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 85ea36df2f59a..626f6b31b0f66 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -694,6 +694,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
>  	.linkup_notifier = true,
>  	.msi_capable = true,
>  	.msix_capable = false,
> +	.intx_capable = true,
>  	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
>  };
>  
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

