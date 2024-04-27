Return-Path: <linux-pci+bounces-6727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EA8B452B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76A91C21968
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8A42062;
	Sat, 27 Apr 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geIda5Gu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209E8BFC
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207646; cv=none; b=lJCG1PxOpue191m5C4MMzFmAnMLFcjpIdmaeint9kMEbSB5u3Hw1jrY8uCTwZh1bZR8ayNhw+HN126dEOKEMX1+wg7NsppfC8lkfVjuFcufafrg5CQS0h+wDZDJZoqG7lpktNachJzfsG31bPi7PGIiTJTqqPHqtH5ZtvLBmHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207646; c=relaxed/simple;
	bh=opzsk3KbWdUcsDAGrr0mjmV+Ees95gaFUnLHAk7uYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFQJJoEGXOijSwNQnhZFr4JMMkB77vkisUDPFAzzm73+XF9Vglm4c9c3woJtD/B68kDp7fvrLiGhebthCaCbRIoNMIvFIStm82weEnPMoQPbHN8YUaodd17S0u7oi7oj+wfXufuXN7hb+GTSXkzFzDFk4aE+EQzq/fHNiEDLDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=geIda5Gu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so26226685ad.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714207644; x=1714812444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RrloM48uDUpeaAw5cm9XDyBz0ypDNTLMvn080FMn1GA=;
        b=geIda5GutSf1aGdh8HLQn9G1mmZMsXJ24MlRYf6yVorGyGIpdfpDagyNJXCPL8N2pH
         dcATlkQyywzzLs4T3TSsgG1c64tU/Fifo9PBQfqAC5YdB7xZZNJoLvhrnDbvS6ALLiJZ
         4ScRydLowlRMG4ETwJn+t9G2goFWXrD3T9PtmbVPO3ht5kJXARDrxysfxxzezwfIHoQu
         hDaUKs4H09rAlHc6+9ryLZMocpv2PJEeTp/Cvkx8s84Sy20zzkcqdjTKQtZxfGX9xJLF
         wOARsda8MA/AuFK1q6XNqeXGG9gjec++sdAcGW66dP7INyP2GsyjGjQ71+mntAf3Uy7b
         ITcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714207644; x=1714812444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrloM48uDUpeaAw5cm9XDyBz0ypDNTLMvn080FMn1GA=;
        b=ggQR4misq7T4xsn9r35qHdTxqGDNmSJO4dcwkJNjjEGElS3QLb0e/cySoa7zi1t61d
         gYipaNJ7xlGPjFTO8zGJ9E6JtRGlGa2y6kGfXM7juJyLnF0jDZ9Sk7PreHKeWlOkswV5
         /Ih0jKoibVlB5R5CYodvKCx16UywBl71S2fHvmC+yFEZdh7xo42lbCV6ykj8omavcSvj
         Uo459B1zGLKaEWWxGTSpMrrceDLFG/IK+nI4PH/1N67ybBlsCsGXxW8JzbuttIG9JWX9
         CmCq0f+vepVd5O5VFVDZm7qKGOINmsJ7gZTn86HGocdULOYvC7GAdd7be2QDQCwP91Kc
         VDIA==
X-Forwarded-Encrypted: i=1; AJvYcCUcZhhQxWn+6uL2bi0oy1K3unv6w16QntBRml9jbu5tjj49yjAV6Pp8iDmtiDciItBw/ySqv/qKgP6KEVQkiM71cYAIOzePhVUO
X-Gm-Message-State: AOJu0YzmjjVifmWKlDe8DzTFbpiVFtR4HYE4bJyLiWHLSd9op6+0egNl
	/AAnLawW/WP07DazHewSq9WKdAEsZvTotKekUM91X4G6ozCoYGyDjmGgk1nB4A==
X-Google-Smtp-Source: AGHT+IGesKZO5rYvQ6ydH5sTslIBruP1og5SUrJwUccA8/imWknzBveKZuuJwbrYkycK+keVpUpZ5g==
X-Received: by 2002:a17:903:228a:b0:1e0:b60f:5de3 with SMTP id b10-20020a170903228a00b001e0b60f5de3mr7831646plh.7.1714207644230;
        Sat, 27 Apr 2024 01:47:24 -0700 (PDT)
Received: from thinkpad ([120.60.53.237])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001dd69aca213sm16542547plt.270.2024.04.27.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 01:47:23 -0700 (PDT)
Date: Sat, 27 Apr 2024 14:17:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
Message-ID: <20240427084707.GE1981@thinkpad>
References: <20240329051947.28900-1-amishin@t-argos.ru>
 <20240425092135.13348-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425092135.13348-1-amishin@t-argos.ru>

On Thu, Apr 25, 2024 at 12:21:35PM +0300, Aleksandr Mishin wrote:
> In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Add return code processing
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..5c6786d9f3e9 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -382,17 +382,22 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
>  	} while (val & DBI_CS2);
>  }
>  
> -static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  {
>  	u32 val;
>  	u32 num_viewport = ks_pcie->num_viewport;
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> -	u64 start, end;
> +	struct resource_entry *ft;
>  	struct resource *mem;
> +	u64 start, end;
>  	int i;
>  
> -	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
> +	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (!ft)
> +		return -EINVAL;

-ENODEV please.

- Mani

> +
> +	mem = ft->res;
>  	start = mem->start;
>  	end = mem->end;
>  
> @@ -403,7 +408,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	ks_pcie_clear_dbi_mode(ks_pcie);
>  
>  	if (ks_pcie->is_am6)
> -		return;
> +		return 0;
>  
>  	val = ilog2(OB_WIN_SIZE);
>  	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
> @@ -420,6 +425,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
>  	val |= OB_XLAT_EN_VAL;
>  	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
> +
> +	return 0;
>  }
>  
>  static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
> @@ -814,7 +821,10 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  
>  	ks_pcie_stop_link(pci);
> -	ks_pcie_setup_rc_app_regs(ks_pcie);
> +	ret = ks_pcie_setup_rc_app_regs(ks_pcie);
> +	if (ret < 0)
> +		return ret;
> +
>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>  			pci->dbi_base + PCI_IO_BASE);
>  
> -- 
> 2.30.2
> 

-- 
மணிவண்ணன் சதாசிவம்

