Return-Path: <linux-pci+bounces-20919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50AA2C9FA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A521683F4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227117C224;
	Fri,  7 Feb 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQNpygJ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2637F199E9A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948726; cv=none; b=TpnNTgRNOlzm48W0c7chlZA3m+785Je/laJVKNhpDTZ+ttsWmC/6vDj9Ibca/LOWxgvCljXm7qRvOD+7plwDzY3qS7tOZuP+cdHX6xghRXX05AuNwk100qP9TAmA8qZRr/T8NEzZnExcxwOAYkzzDUxmC25XEwrNMydjuEvHgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948726; c=relaxed/simple;
	bh=r4CoIWfvFEuQXvlDX3KWyj8Fvz9HRA497e/7Bod5Nt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulVPXh7VVbaQa4dJgTLavpDy54I6+5g5ZC3l3oCFxW8QP+CbSw8rmQvnU5gEmwXTbJxj+3TShoSrc3OeLQL0pbCpz18jItXsJhHrW0k7FaCy1xD7ABs9v82p/iVh4kGeoI15bBC6+/Z3jJQqi4EjKr61R2/YeZeRZYiAvHjP1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQNpygJ1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f0444b478so35654075ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738948724; x=1739553524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hg7e0/B3cGljLk2Nikoh+K7LkRDj1sOycP/pEjzHBjw=;
        b=HQNpygJ12ZhF66xHlnnrh+Ge41YP4pHElRTaVUdq/eNjhKOBw5d6FNdCgAKzC6wJvX
         UwZzueh/PYL9iLKYxPJCYG9wSAWAIQHDUIncujhtKt/ircaHEv5FWix/n4ArxKhYNfVh
         QGImB8jtfvMQL2VlzII/kQtWjl2qr39GbeS/h3+JdpWfEnSOUdI9cbNa3WW9Q7Fy9RJP
         YVm9ed7GXwYVXHlXEyWwqvwEUBJXocOjcicUmEoVs1uH8L9Jv0NL69ZanCQbWAeEcpzK
         VGRkZFcsSbSEXhOkWbkPGseM2MUva1PWcjpwFTjDl76S8u9ZG/XNw531oYlwRKtyS5XO
         NapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948724; x=1739553524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg7e0/B3cGljLk2Nikoh+K7LkRDj1sOycP/pEjzHBjw=;
        b=LC/475Z4mUOWHEuz2Ki67Fau+nJ2QBVnK+bYFnLSST4EJsudbw31+4LTplJTV2B/QI
         G4d/yl6xOvVgQ81p59KiaOw2+nP/5NIzKX6VOZZvoa0z5vpFDcBfQUaOwVCj3jTcdW4l
         +whZXwYwsYvcdkQoVS5G4iOyX8sTo/4EUepSK4gPkyz1Sn34ZYqS0B0bVBTxheZtQEZR
         c02lhIuI7Wgw963TOaKwJNP7ifdVMj3QO+/erFcJEUOPl3nKEUJ2JTCdhtL1kAIrIjhA
         u9T7KXb0ijfZbLp89oYJiys6Wh51kYl+kI8B9VRc7JeVfp6ihWBo8HBVbcRtDiKU3dLD
         Z4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVyHu/jWU6DSzpQTyHDq04IscwwkuEvwiku55JfDev8gciTpFD6spRf4iH+sFj7xzLQn9UaYOO5zyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkMgL6R8exlGiBpZ5g7v5IN++ycQNmIFe/LESw0vRUCMWrIml
	UO8Qs31GriK/wy464F0vtxucYbcjlZbwEiCby7SpPA0ABDTOSadGgMth7/I8Pw==
X-Gm-Gg: ASbGncsqf4mvRdhh9AZWya84Zi27KljCnTiqK/tsQmaycKuG/FOjKuKjPg6zY2yBOhZ
	IsCpp2EEXB5nv6BzDotqz80BDG0svtSoA7ec5C84PnwK2alBW1UkAefgjVnuITGUuUFyA2RKFNV
	0ZF8fZBu3s8yStlPEEwRyg+VxMfP8KWzc0VYrmaT74xUetpg0dxjox+5R9qRSBR4nDe8CvJ4RqN
	wRkYVxOeotYYpoYWbAnuV09o0Y25vqyywpYsPq6SqgmS//KkTTiwddLIWWJMMX2RgQrL6miAbJc
	4qKkMO+rjk5KF5eNyDdAIBAE/A==
X-Google-Smtp-Source: AGHT+IGhfEpTx0DFyi32kzYj85d93HuYNILOYsBC7FSF1uJnI/lQd7C3d8DBTf97dT7XMKklZeHSyg==
X-Received: by 2002:a17:902:ebc3:b0:216:2f9d:32c with SMTP id d9443c01a7336-21f4e7a1ffbmr70784075ad.53.1738948724455;
        Fri, 07 Feb 2025 09:18:44 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653afc2sm33304575ad.62.2025.02.07.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:18:43 -0800 (PST)
Date: Fri, 7 Feb 2025 22:48:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	stable+noautosel@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 6/7] PCI: keystone: Specify correct alignment
 requirement
Message-ID: <20250207171839.lpolc4hdequhssm5@thinkpad>
References: <20250131182949.465530-9-cassel@kernel.org>
 <20250131182949.465530-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131182949.465530-15-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:55PM +0100, Niklas Cassel wrote:
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
> Cc: stable+noautosel@kernel.org # Depends on PCI endpoint Resizable BARs series
> Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

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
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

