Return-Path: <linux-pci+bounces-17393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EA9DA2DC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A39BB203CC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090A13CA95;
	Wed, 27 Nov 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge/hOaY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6B81AD7
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691540; cv=none; b=Z9KmeWrt22sF2RUOpaossuQkDXmplb6laFd6nIy2dNhkuMmmOREKBKE4c3l5bQvbjQ9WcTg02cAWg/js5ut2H0L7pr4GzP85A2kQl/1CV6+ShkJ3pa6057IEePrLVxT4qm9/w5vZwRSUpc5L8rhmbxFJQmMfxhZRuaSubUzODuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691540; c=relaxed/simple;
	bh=0F0EwpBAAdZeHeZ9hOyQOXhaggBr0hHBWromKUMhm6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL7RZ4bK6WTMPPUDBO+WKlcghVGppVvHOww+TDYCcIyM9aPYySs/rm5OB1pRO9A4sKhik+wkXrTBklJfExqavdQqYD8Ak7nNs52g+pI6SwXWFCtHq5D4wZSggt/arBlVvnDa8713fjKZuwxVxftNoRH/dreVPFnpk2ViYbERWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ge/hOaY3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so5131584a12.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732691538; x=1733296338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yo6+u31WYpDnvTR68dkdjoNLeXTS87+gwXtkDUl+auM=;
        b=Ge/hOaY3BZJtFhDBlIYgjaugzMpZptrz8j5tgdAnSinbFr5gIqwkzb8P9KlZWDGVn0
         QZLUGMM/d0LsMA6uZmjO6FVZmXm6/V9ID11sXxPACEPESp43G8u1TWaJXjI8KLWpXUMx
         mC3sORfinXKuZfgqRwI1bYDyt1g5TW6YU9MUmmyzBYfKnuh8gPj+hl/cMr22SBfgTkfs
         H4dPEur18D/i1MWUzIheJynwGL2vy1QMMBaLR2T0AGPfycgU1nN3rxVtnDlQpIcuBHwX
         Md8LQVVr0+0KgsJkkFn1nojwCLmMFvwENF6plVxia2VBnW7O+EA/y0twCIOyTe1zyqcr
         EuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691538; x=1733296338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo6+u31WYpDnvTR68dkdjoNLeXTS87+gwXtkDUl+auM=;
        b=bOOUqE2cgULvU0/AateweJR7geYNcoLPRSv5PKuOpWoXES0RHiV9aSeW/6Ynn5gxiS
         RZO8l6Zz9EQp5gcR8BEYA5BbynsYPEpYYwYqx67sne7Htzcg+JExV97YJO4zy3ccrjuy
         nP0sgooo4ERJDnv24rsuFm8/GG2/NRxM2DsCyP3FZrYCBXvRmDiMph18pO4wwLuvcWT/
         hORswFrHF+59fYrqEnxPTxLQ0JEwzT0hDQcDKVA5C8HrzE+wlpj2XVVHAklTvAyXYvr1
         iRTFw+n+lutxggMMCe6v1mboI6TwjKLFgxYD/5aqewUX9SnBZz0usYCSgAhA42OFZt0k
         9YLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQKX/nLXvDoQapehElU1jxpKePdtOqGYTjcqk2lg+TyoxQwfNccV0m07dhFxpPxLV3gudKmZ8JjGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWqnmszR0ur5tAFrbM0et3g43gAdbyP2QpFxF1ycke35unqUQ
	6NKiKzoZCDNRXzJHvBTJ9+m8UBFGQi378wil2W+l0qirwIJXBz1Ve/kahMEhvw==
X-Gm-Gg: ASbGncvqaVZCg1Nsq2fTft9otmXmeirHuSVwBSIIx45W1l5Mn4dtoCUF5yLi6AYNh1L
	+nBaIeJr8M0C/Ta1nPXrhntdQw5dpnUBzqRsKFdVakpbtj+av3JDAuXPBea+GQBrjXKen+Zalza
	8NqE/wastPl+Dvo231holsJINAJ3rpRFtRehbEUgaRKaOTFgmjf6PvfhmaXObYji5RYx8mMmDbj
	eVp5s9HeW6K5b4q2xmbnCwSTQ6gO6Eeu/FVUajgV0XjfMmM8lTHZLnpmgkB
X-Google-Smtp-Source: AGHT+IGOpIy++5J4/nF0MkIa+DaZusenv/aTMORh66O5gbGG7y168BBSaAE+d9CzZdchJ32v3qcKHw==
X-Received: by 2002:a17:90b:17ce:b0:2ea:3836:33de with SMTP id 98e67ed59e1d1-2ee08fca651mr3201684a91.20.1732691538442;
        Tue, 26 Nov 2024 23:12:18 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa480e3sm764280a91.17.2024.11.26.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:12:17 -0800 (PST)
Date: Wed, 27 Nov 2024 12:42:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-arm-kernel@axis.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/5] PCI: artpec6: Implement dw_pcie_ep operation
 get_features
Message-ID: <20241127071212.7syxqqxeulof4iay@thinkpad>
References: <20241122115709.2949703-7-cassel@kernel.org>
 <20241122115709.2949703-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122115709.2949703-10-cassel@kernel.org>

On Fri, Nov 22, 2024 at 12:57:12PM +0100, Niklas Cassel wrote:
> All non-DWC EPC drivers implement (struct pci_epc *)->ops->get_features().
> All DWC EPC drivers implement (struct dw_pcie_ep *)->ops->get_features(),
> except for pcie-artpec6.c.
> 
> epc_features has been required in pci-epf-test.c since commit 6613bc2301ba
> ("PCI: endpoint: Fix NULL pointer dereference for ->get_features()").
> 
> A follow-up commit will make further use of epc_features in EPC core code.
> 
> Implement epc_features in the only EPC driver where it is currently not
> implemented.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index f8e7283dacd4..234c8cbcae3a 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -369,9 +369,22 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +static const struct pci_epc_features artpec6_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +};
> +
> +static const struct pci_epc_features *
> +artpec6_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &artpec6_pcie_epc_features;
> +}
> +
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.init = artpec6_pcie_ep_init,
>  	.raise_irq = artpec6_pcie_raise_irq,
> +	.get_features = artpec6_pcie_get_features,
>  };
>  
>  static int artpec6_pcie_probe(struct platform_device *pdev)
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

