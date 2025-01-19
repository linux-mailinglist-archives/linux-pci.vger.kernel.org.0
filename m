Return-Path: <linux-pci+bounces-20107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDAA1605A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEE616511A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A433B1A4;
	Sun, 19 Jan 2025 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUcj0Nme"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CE2B9A5
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264784; cv=none; b=rW4mSemSv52ub6QN9x+rLlNjtmHCvZ6ggMvpTsxs33r6BYu5RJAoHxlmbiNdj/agA1ZNe1HbwPkK5qNv/5gccPvENTyPpTH12cCJK/5qGywEoTUBbddeLYzYxYR6h72/cXKeaxq2QqrG7wSABO9ker8LFUu8DhuP2Ytydxrwl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264784; c=relaxed/simple;
	bh=Aim4o1FGRF1BKqV6qGDRO39idywHcMtx7DceeXGnEqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj3XVRyr5h/5UWpajp14PUl32XvVo0AwEnAlcjKXw5Xek3SsNIgaUhVfNnTtJ2e9yAkyDOKgii3zfD2Lz51iCfC+mFELrlKxhMioAwu9GF1Y2/uUcfzCGj1JHRiPLLv4E7GzxwLcpRLOY+Qt3u+9Vcp5wNpkz75Tflh3sqlsgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SUcj0Nme; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso7107692a91.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737264782; x=1737869582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqCGbV7zpHDzYZ+fZLxnROEI51BBDI+1DMm1YweR+1U=;
        b=SUcj0Nme21xAlkvShnl34KcDm4YtDRcTiw90QvSnhaffuArJQpnyDMWVwHVboWXPVO
         tEi7RUhcDIF3U6nO3ies1HuVZIsgNyMYicqL8NH7dbLvVDKyg7hQtnijJK0Ugxy/s8i1
         qED45Mw5+Xkb/U4s1j9DHO/aaB8E8SKFBU4O8jv3j/cnx3y8yNAfnzUprPHp8F89qsin
         S6TzWu4+Fn/sr9SIJaImZxQg66OcI5BGjZKYFDFSWrfVDVIz6sHQNu75FCrUVDT63tBd
         7fbEJnXLCpxCFx5pryHR6XUMoWV98vTEj9/NoC0SFRrXsdGjiHM4FgVNzd5tVLzrRvMB
         NIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264782; x=1737869582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqCGbV7zpHDzYZ+fZLxnROEI51BBDI+1DMm1YweR+1U=;
        b=RUIg9GazVCCf1YQ8v5pSduzdrtdIsCvQVQen5PmTvJ1jYemr2BZO4PcK94AKYzpExe
         lEp8NqWoKyuVfvFNQVgVZ4kaibu0wF/y/mazhzkVspdQEUzU0afx4xJyC1DnbZheCnAr
         K/Q4BA5YyJUH3NtJ6GftEC5yeNKpc8QAVNVQ3VY32rjMp0INMIyIrd3IZUTC2fOfq7Yj
         Z751w88QZdvIb9yePU1lp0/gRDVUT3EP+JibxSSGLPsZwS8yZaBDs9arYkaH0nyCz+Cc
         kprDhmHJrqiBzpJ34DTYe6xRdo0RwNwYt7PCq+PI4h+vIx7v5d6/nwE0GyuFR/CpP02H
         kI8w==
X-Forwarded-Encrypted: i=1; AJvYcCX0/xdfneY+BCCYzTMYh/CBVT1soNboRC20S1uyE4rGPdCHT7dEO60DmQoZjUBGqe/4NTkqpGAqwrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInZLYLZrIPcYRcEBhctAcHPkDS8KVwhyxZWVHkjcc3WvvQEjO
	MxcKwL284TLlkQwvYOaFbt3nrsK2zazKZUbstoCNm8ipHQgLef2kKKbZIPvMVQ==
X-Gm-Gg: ASbGncs3FkpBKxTyKoyFu4zZYl2/BFBj0ZrGMr/4VXWJH1KnrZzCsKdHN3rj4MiO34O
	kA2YGJnxvFuHBeCvR6Onk2TFK8b4utKyD55GCiQMjIGZ6M1fMCDvxcgk5hHE9fr2K+sJrEwcDtX
	poLMMZVUwrwu0Dt3+/U9NSwBfPMZYVXTFXs24QtUTcKiFG0vKtukf3W0Zfr9jkvIQEkSSfrkGeb
	n60uOHIlle4T18jEBn7lgtVN95iWhXam0wS6PVjdAkmQPr+CH+6TTF2rCo9hHux2BnCTbrMzdgB
	grsF+Q==
X-Google-Smtp-Source: AGHT+IEhZIu+ZLj3vt8ETwwsRxKSvETw+1fTM1zsEoCfrbKsOqDvEXzbFh5G4mIqRa7UTE67mDSbfQ==
X-Received: by 2002:a05:6a00:2d11:b0:725:ebc2:c321 with SMTP id d2e1a72fcca58-72d8c4ae92dmr31757880b3a.4.1737264781743;
        Sat, 18 Jan 2025 21:33:01 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aa84ed133fdsm1980334a12.17.2025.01.18.21.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:33:01 -0800 (PST)
Date: Sun, 19 Jan 2025 11:02:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: keystone: Specify correct alignment
 requirement
Message-ID: <20250119053256.4hj2c6olm5oavddq@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-13-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-13-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:36AM +0100, Niklas Cassel wrote:
> The support for a specific iATU alignment was added in
> commit 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for
> buffers allocated to BARs").
> 
> This commit specifically mentions both that the alignment by each DWC
> based EP driver should match CX_ATU_MIN_REGION_SIZE, and that AM65x
> specifically has a 64 KB alignment.
> 
> This also matches the CX_ATU_MIN_REGION_SIZE value specified by
> "12.2.2.4.7 PCIe Subsystem Address Translation" in the AM65x TRM:
> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> This higher value, 1 MB, was obviously an ugly hack used to be able to
> handle Resizable BARs which have a minimum size of 1 MB.
> 
> Now when we actually have support for Resizable BARs, let's configure the
> iATU alignment requirement to the actual requirement.
> (BARs described as Resizable will still get aligned to 1 MB.)
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This warrants a Fixes tag. But also add stable+noautosel@kernel.org to not
backport this change without dependency.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index fdc610ec7e5e..76a37368ae4f 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -970,7 +970,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
>  	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
>  	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
>  	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
> -	.align = SZ_1M,
> +	.align = SZ_64K,
>  };
>  
>  static const struct pci_epc_features*
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

