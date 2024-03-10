Return-Path: <linux-pci+bounces-4703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F38776EB
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7034B20A1F
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A61EEE7;
	Sun, 10 Mar 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrgMIvzo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74524B34
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710075893; cv=none; b=cD7qFvVbzFUYEv+LQDSLPYf1r0rwm7dRwAF4w0rHNc/docQTdAPg5+z5holJPSnTHKMIrXRFqgSoNExCs9Mnl3QtnOQPbIOcCJ93wDXVSiveLaQR2J4KZ7l86rWofM9oyrGlulvv0A9xd9f0TOXkSyqh+nBzinKwn6XeL4c/0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710075893; c=relaxed/simple;
	bh=UmjxYgbTGnnpxyubHbRKjhPY0Bk+hknB2MKG66/qby4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXiQjkdkllwygXr4tK+JTjfFdYPmIxP51eMNgIesCWljFB+bmUYstUapcde2kjywD9464R9v82JBfD3cKKpNlASG4Rg8LFybEeEsfeADp2eg/x6UKj/xxeTWR/ZFcdK/jRGj4o2DzJL4inZYxLZT83yXYV7MNo0d0TDGrOMbrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrgMIvzo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e66e8fcc2dso1972481b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710075891; x=1710680691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=McYRKBQPUeNuNea/elNtNuHcCyO0eQX+NeCaOhSpzaw=;
        b=lrgMIvzoUJbu+KiP0BJn30nGyzvszjvqf5g5NASiP6WI3xwyFVW1aatOe6uibDemsp
         TGJa3lSPDchMxGkd0vT2UzTmNPHNoW9uMQoqfGH+Rku+KBJVX0gDSzfM2/jCLbt4lb3e
         8h5E/b/qyF7dD5btPa4EYNFKXyIZ0SnQdtLT4L3i3rVa1t349lSD1OBo5bK/s00KJOB4
         ptkEkj6rKIhQwjZRVgppwqN1KYE69nzFU2xAsLbPlT2mya7EdwiUlCsavbJEH5vtoXPU
         1sgAWsMv4oLnxZOii/XLdDYlBAg0All2irPT1Ho+Er1c9XFGMrZL9dbIpldc/jSJjH0G
         BoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710075891; x=1710680691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McYRKBQPUeNuNea/elNtNuHcCyO0eQX+NeCaOhSpzaw=;
        b=ajYtGXHYzkxPaqxtD55oDU9FY2mUHVNU3q+nNG4muDq5KfUlvUXN+3WMevL8IFp9A9
         UXUOR9SyPW6blTE3WdFhLpEZUsrzMrmpyCaj6rQMhuZ50/hyOoYaOHhR6EntXI3YqIVF
         0pCghgkH1ogFTfEoUBS3qWWD0+0Dj9MqIrKotSKuMA++rGn2IFt/k17CWwE7Uc9/ZOE+
         win3ahrToy40jyFMXN4i3EqQm2w0/JtFjulZ+QaspoCPs4109OVHIMS4tKSqzIsS74ge
         ogFPhsOLBDXdAfUGXfGOZmriI6IWpbLnC4TWysmyHWlG5bbNsijw5vXP9c/PyG/5FGmg
         Y5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/NMzpQZrcXZ+2iCRcVjtq5gEcoi6Isjm+YM9R/1LwCwEsToA6d4E5NArFMQECwF8FyL4CDn2rrgGA/MyLA93E/zq+05mvWCB
X-Gm-Message-State: AOJu0YwgPehs8lvqAM8ErPARoNWQipCTLx06nBo2mylDzH0jXX4pUn0N
	YDg2gk4cSsyV0AwCypJkldl+glXlZtymG+NoMjVL35ZC7ZcYIGA3fYjpJbCPtg==
X-Google-Smtp-Source: AGHT+IEyVPmoaPMyuaJusNN6Mok77vDmKC2gW8HwBHwAq8tr71PShOfnhlg2uL5eP0kbd1pRRvQIbQ==
X-Received: by 2002:a05:6a20:daa8:b0:1a0:e089:e292 with SMTP id iy40-20020a056a20daa800b001a0e089e292mr1910354pzb.3.1710075890888;
        Sun, 10 Mar 2024 06:04:50 -0700 (PDT)
Received: from thinkpad ([120.138.12.86])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a000b0c00b006e566b4872asm2542341pfu.113.2024.03.10.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 06:04:50 -0700 (PDT)
Date: Sun, 10 Mar 2024 18:34:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix advertised resizable BAR size
Message-ID: <20240310130443.GC3390@thinkpad>
References: <20240307111520.3303774-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307111520.3303774-1-cassel@kernel.org>

On Thu, Mar 07, 2024 at 12:15:20PM +0100, Niklas Cassel wrote:
> The commit message in commit fc9a77040b04 ("PCI: designware-ep: Configure
> Resizable BAR cap to advertise the smallest size") claims that it modifies
> the Resizable BAR capability to only advertise support for 1 MB size BARs.
> 
> However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
> contains the possible BAR sizes that a BAR be resized to).
> 
> According to the spec, it is illegal to not have a bit set in
> PCI_REBAR_CAP, and 1 MB is the smallest size allowed.
> 
> Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
> 1 MB BAR size.
> 
> Before:
>         Capabilities: [2e8 v1] Physical Resizable BAR
>                 BAR 0: current size: 1MB
>                 BAR 1: current size: 1MB
>                 BAR 2: current size: 1MB
>                 BAR 3: current size: 1MB
>                 BAR 4: current size: 1MB
>                 BAR 5: current size: 1MB
> After:
>         Capabilities: [2e8 v1] Physical Resizable BAR
>                 BAR 0: current size: 1MB, supported: 1MB
>                 BAR 1: current size: 1MB, supported: 1MB
>                 BAR 2: current size: 1MB, supported: 1MB
>                 BAR 3: current size: 1MB, supported: 1MB
>                 BAR 4: current size: 1MB, supported: 1MB
>                 BAR 5: current size: 1MB, supported: 1MB
> 
> Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

If you happen to respin, please CC stable list. Otherwise, Lorenzo or Krzysztof
could do it while applying.

Cc:  <stable@vger.kernel.org> # 5.2

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes since v1:
> -Fix spelling of advertise (Bjorn).
> -Add lspci output to highlight the problem (Bjorn).
> -Add specific section and version when referring to the PCIe spec (Bjorn).
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 9a437cfce073..746a11dcb67f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -629,8 +629,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
>  			PCI_REBAR_CTRL_NBAR_SHIFT;
>  
> +		/*
> +		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
> +		 * size in the range from 1 MB to 512 GB. Advertise support
> +		 * for 1 MB BAR size only.
> +		 */
>  		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
>  	}
>  
>  	/*
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

