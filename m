Return-Path: <linux-pci+bounces-3817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA5A85D84F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 13:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C792848B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778084F885;
	Wed, 21 Feb 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJl3naKA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E369945
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519970; cv=none; b=fr2cUINyNIgQspY/GsO2GdwggpOMzE+JSO5J8TT0T6YdXLcauARs7YWgJFw2KnznngzfOrK9nKO99gyZDIHUBPsvq0SQf8Dv7yGsCNKfkgjv3n/55MDFulGhaHtDzVFesnawd+ehpuQj/6UXFoXIAKXntteHUyQRCrNLB6qvwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519970; c=relaxed/simple;
	bh=HNyxWr7EE9gBokoWmb5vdFZ55WKFPctc/+54CwSczbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObZuC0dqPbdsPlX/MSq6OUD6Ss7XkVDGcm09vQLC/biUy2K1zhygNZa5crPbwWdgo7XXLG6ypPomAYPjCC0PLaPne+zBlBySxDLMacaMRsGxMclcK3GeZGxqSNarxZRqhcUaTDdhAbAej92FyQ05UlEnjosxVQqmFNLYyYM2wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJl3naKA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so7061021fa.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 04:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708519967; x=1709124767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho//aj72slriik/179M2rojrPuMbpOIAUO4Yxezfrz4=;
        b=dJl3naKAD1+ulkHJJp7TrIpktpfTnSzaWMOzeoxjHnL7zt6T2UJzgIRGygB+x8vPyB
         7eKolj45cpaP6jF5HflP+W85vgpwIsiSUBrIGCDJsy2Lucx+P3rE6AvuE734cCezUEjR
         Mh7tlNMJYXFAtSpcLHuRiU537f4qerw2ADBp/ZjwIW4mdRgy1CosF8PINFMA0qmuG2+Z
         FXo0P8AQINSgwu+Mwlm1LT1X7dTzc8fuBMEdiOguzm0PlnOHHg7Or597YkNe0M9HYe6s
         Og1n+BJp8mVpEWwFH78Ew1affdx2Vhu4CWHONpXNYmS6jo+hCSfvaLq6k+giqPoK/gH2
         0beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519967; x=1709124767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho//aj72slriik/179M2rojrPuMbpOIAUO4Yxezfrz4=;
        b=vNrs0O0LQHYsO+/FLrvgBDoi5oTTHKi5LrxZiBpnYq2qm2MppZAdGtAxcyGHS1VJD+
         3kHIZyv14xTmY/G+nbW4IzBP9xXjzqox1Gw0RhjO1WJa8zaZr25VvSquJibiFfny4Sad
         NMQh86VpfjAOt3N7M1hz7r1V1Xr5vCwxwZb9v5N2RwWbfGFWoXMWrHa5cnLBkw7KmeH0
         ycSaFm6t97DRIDnIH396Cbs3nL1xexNR4L4Il4AWjDf2/vTjIpWXQhWQrS57d89+hmZ6
         epfdg9GwqYn+OS5JRsjypj2K960tFnN1TrBGkrMF/LbmcgOcIxbrP1oKr6Ugzkozjcxj
         Ggdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0YmDN50wenR+MiohV0gsTfcPsS6Rpm+gtCTaQ0F7NtxDzROsT5dLahzREGMtHDxsUmuElIpAfyIfjS3Ph5aUdUVuc90wAtj3A
X-Gm-Message-State: AOJu0Yx9NTcclh2r90zMTfnPk6OUlc+2Bv1TsQLoo54IvqBfyqIqgGus
	6Uyyy4Hj2BD/C/lOSmWK7VFUub2bbTpaC8L4xPgIQUwRi6lUEKNc
X-Google-Smtp-Source: AGHT+IGZUdZDfmIHK5OdWptQQLr2xD9k6MArdAL25R6MRUDLEddJYRuWwAHwczwpDmqCDN2CilTkbA==
X-Received: by 2002:a05:6512:3b0c:b0:512:b0d8:2925 with SMTP id f12-20020a0565123b0c00b00512b0d82925mr7592886lfv.55.1708519966432;
        Wed, 21 Feb 2024 04:52:46 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bp38-20020a05651215a600b005124fb0156esm1645196lfb.211.2024.02.21.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:52:45 -0800 (PST)
Date: Wed, 21 Feb 2024 15:52:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <aje3eeeey7v4jafcad6beeee4xxev6pbnsdqbpv3f4fmn2zi4k@7qv6vvngxs53>
References: <20240221064846.3798047-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221064846.3798047-1-ajayagarwal@google.com>

On Wed, Feb 21, 2024 at 12:18:46PM +0530, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses.
> The current implementation of 32-bit IOVA allocation can fail for
> such platforms, eventually leading to the probe failure.
> 
> Try to allocate a 32-bit msi_data. If this allocation fails,
> attempt a 64-bit address allocation. Please note that if the
> 64-bit MSI address is allocated, then the EPs supporting 32-bit
> MSI address only will not work.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v4:
>  - Remove the 'DW_PCIE_CAP_MSI_DATA_SET' flag
>  - Refactor the comments and msi_data allocation logic
> 
> Changelog since v3:
>  - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
>  - Refactor the comments and print statements
> 
> Changelog since v2:
>  - If the vendor driver has setup the msi_data, use the same
> 
> Changelog since v1:
>  - Use reserved memory, if it exists, to setup the MSI data
>  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> 
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..9c905e5c4904 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -379,15 +379,22 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * memory.
>  	 */
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");

> +	if (!ret)
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);

msi_vaddr will be left uninitialized if the mask setting fails. Robin
had it initialized in v2 discussion:
https://lore.kernel.org/linux-pci/7cd42851-37cc-49d6-b9ad-74a256a73904@arm.com/


>  
> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> -					GFP_KERNEL);
>  	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;

> +		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");

Can we short it up already? I suggested something like "Failed to
allocate 32-bit MSI target address" in v2. It means the problem with
32-bit MSIs which can be perceived as the possible reason of the
respective peripheral devices not working correctly.

> +		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +		if (!ret)

Redundant check. It was discussed some time ago. See the comment from
Robin:
https://lore.kernel.org/linux-pci/335d730d-529e-7ce0-8bac-008a4daa6e3c@arm.com/

-Serge(y)

> +			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +							GFP_KERNEL);
> +
> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to configure MSI address\n");
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

