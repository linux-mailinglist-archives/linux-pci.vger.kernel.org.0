Return-Path: <linux-pci+bounces-4846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B587C898
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04F31F22836
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFA8F70;
	Fri, 15 Mar 2024 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCPwQdMe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3210A2A
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481674; cv=none; b=CEFTms6/7NAZsal1JOmVcoK/SvZRU1ttwqu7CNtRd7/+oKX6tAeE1OWISh5qQto/VJTizPFzWXTWct2jLiVmyPixHFW+VculDjPMGiID1HydhEWLAou555USNnqmqTMM6Uw57xlJssesoc0DtJw0WSlBuxPTw95otVgmEYuNY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481674; c=relaxed/simple;
	bh=daVoSmObSrfg1QjjQYNcdfXUMn/5sgo/USgfh7As+Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUy7c+CttSRY/KMjf65VlPnk4hknkD+KMEMqRWI5lWfs866jM90LrxVkIEgY+kqAIgOdrb1zPehdYaIOypoeZWHaMKRhqi2Ouudk9cN3645uFXNS87SsDWLXJW5JphYLr/FlQK0VXKmXhr80n9IqJ7EiGp7Z1B2/+WHD277twI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCPwQdMe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcab44747bso11481855ad.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481672; x=1711086472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evB9YSInt1wBu30FM2sA2EdAsArYbmamc1Tzyv+soTo=;
        b=sCPwQdMebD5Un2jS53s2WdKdADWDMb0zq7gwrj17r9wo5usaMSQm7XEtA9vhbTq/td
         0AGKekx0eZ1awfg/cnCojk4kOgZ7VjdAGpJeUIaFOIFFnehlyhlEvuuAg6ZldYlD9svF
         e66oxuURtvlYYrSle+ElqAZ13YNDk2eXLAL6C/1VQE1rvR8M47PMCJb81rEs9pT7AEYz
         vUPDcEmEKJQbCiLWd9HOr4EiP64ZGL0XnECk7HK5rMKbgBK9sWZOHOBIjktNeyK8rij+
         R7bkMIxoj+PlAgVePR0J9r+OAaDyBcOcBbKYlBnUMpX6k2Qv0Q5NameGNmQqBNuqlNjO
         SyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481672; x=1711086472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evB9YSInt1wBu30FM2sA2EdAsArYbmamc1Tzyv+soTo=;
        b=BKVc2H/YNC+GIfOWEnDtGZOasrgoib1luvK3ofQnA54rwZUYZWKFswqJrKycfAJq3T
         opL0mHGYc1bBDUpQInj8+lDaJ8z3rc1TD/cOptL7d+kuHr6k7zq0zXpdYytar5spRqum
         nxBHh0Mvx2BSUpWI/u4zL0xbwoZlOZnsfC/Q+9w2CRBLIB10I+/OhhHq4uY46VoEipff
         kn1PrDPFOTzccSQhIigdIdOHVvmkmSDeCZzGVYUqB5Zn/KHVrh6lajQC81l67YW4l79w
         TvRITp5S39H+iWDFac2/Dj1eME6tHy3J7CxPGfvp2iJWvi7RB8+r8Hr0qXrZvJNFPjgW
         JijQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlYp++3r++z0rCsiuR2upkx/bO9u3R7dWZsigzsmX2TB2+yi5T2N26K5S9xBqPOrpk7FpXtpBnbyfE8I+rG9xo/5OKyiihG04U
X-Gm-Message-State: AOJu0Yw9J11ExvMdE7aIZP4HEFXI0Bj8HPjkN+W60A2N4ZI0bN8J6Xt/
	hUp1Eh55jKaeJuFuri782hOoH+7McA1S6pHX7Pt7qhL2WOatXspjZep5dpZoPQ==
X-Google-Smtp-Source: AGHT+IH5FGOJy1/ELRcNbboAtyIhu4pD/osvArG1/SL+m6+BAiaezD8IuyA/T+x4U5h+3qdgCPUiCw==
X-Received: by 2002:a17:902:c401:b0:1dd:7de5:7ac4 with SMTP id k1-20020a170902c40100b001dd7de57ac4mr5531812plk.38.1710481672484;
        Thu, 14 Mar 2024 22:47:52 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001dca99546d2sm2808048plg.70.2024.03.14.22.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:47:52 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:17:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <20240315054745.GH3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-9-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> is invalid if 64-bit flag is not set") it has been impossible to get the
> .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> requested to be configured as a 64-bit BAR.
> 
> It is however possible that an EPF driver configures a BAR as 64-bit,
> even if the requested size is < 4 GB.

2 GB

> 
> Respect the requested BAR configuration, just like how it is already
> repected with regards to the prefetchable bit.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Ah, I missed this one. But the same comment as previous one applies to this
patch also.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index c9046e97a1d2..57472cf48997 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
>  	} else {
>  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> -		bool is_64bits = sz > SZ_2G;
> +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
>  
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

