Return-Path: <linux-pci+bounces-20109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75657A16060
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8783A1437
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4C42AB4;
	Sun, 19 Jan 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTk6eKg9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6A42A80
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737265485; cv=none; b=ELNejNSw/T8m2YGpLifsVGdSIqXIdhkgHMM3wLIe3+2HrPJChoMbB+RdcHNWcRr1jemurnJbudbwzS8/e5RGohc7IcRDIbuOdaR6SeFvDKynSNUs6Kbh93neXLX2La6W8zsXTufEiPkEAtmsXWdJs502mQbrat+vv+OvIemBpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737265485; c=relaxed/simple;
	bh=JuJ7naDmXlmy8qx6XInrCFlwYy8tADOGQikyIAf19kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko5+zEZL3Siga/WJf8aLdDQmZuEiUBnzjL4WyXV4x9xBHGmgLwVFBqhT1pmPgDFg7qsmW83ysMo9oFFAwI7aetZnq0FBH163iXHn09si4DEvBZNFEBJQL/ZF00BQlend7+MiVD7stnx2PsEjrYcBl+ZyFz1LN+sgSgNofHzX9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTk6eKg9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so6266486a91.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737265483; x=1737870283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HBFYLkNa+YoNF9Pfhcn2ea51UZ/gLUJMdxLc+4EU3F4=;
        b=LTk6eKg9ntaUkQDbOSmftsGGOjpFejV6DpoaWFTZKNuCqSg6B4jQ4S4akio0i94GaP
         Zba9VYD9uFQ/x0jEXBXmtfoWiXHzIdsNj8yZBLqjTe3kEJjVB6l9SiyvmBJfnIrI7R66
         XvR4kInK8fIayAkenGXSNetUJJZllZC9J5MWhNchCyneN6vbSBlhKV4xPTvLyF/PXb6o
         nVUMwApwUMw+ron4hFvq3aNn0f0QkVkbGBfYpEf+FuqiJd9aGLzl6QK0Mf4Bz8qil717
         HB4ghXWGlyGUiMWzfYz6esxKB0qUDURdCiwZne8GyiUTpIPQ3lOYjH14QxUYKppo3PUQ
         G4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737265483; x=1737870283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBFYLkNa+YoNF9Pfhcn2ea51UZ/gLUJMdxLc+4EU3F4=;
        b=QxoBEX4ZY8sB3AYA3egM1eoMny+SjL88RVBvu15OqSFBTpnb55cUDj0oiNhxoswXI4
         eOTtpR95nwBlh6j+JjiJOuvfZXHX5o1wYTvKOvBKP5b/89+QJdMdtqtB8/Loiuy1+H5g
         Kzkjwk7/a2GCaHT7xl1LH3HwwiUlG2/yyj1maH9wBNViG3Nz8hjnEe1LvAhNpIxO6Cgn
         jUNmZH+uzhIwTawCXbPPNEToiOwBAjvxygJ3WDToIGVjgBrkGMg24PBYrscN2ui3d3Il
         CwczaXcKcpdnKov21SZK1s8+bQyqjOxbr5CdlkitYAbjQRuHgUzbIeS8LIMlzCAJeRTD
         u2bw==
X-Forwarded-Encrypted: i=1; AJvYcCXgNo4XNk+1ReNhZJaiQuBR74N809cLSJY9GZ401emoAZfqgU5uQA2x6GySWCpbfR9tsyiGCtBc77M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykgg6I1UqeAqauizO5nyLZ3oXc2MsYQvQOyLER4pfqoIyT0CFX
	4opA+vUl6OFNZFXBKT43RdPvoGxP+Ive1MiHgpVkq90QbmtguFo4257PbJNv10tR+x/I1RWppT8
	=
X-Gm-Gg: ASbGncs411KUV8YCDaL+IGcydBRtVGR4RHsSVcg8SEwL5GG/KTeshrpsWeFi6P3Ux9/
	hC8SGbT6vllxFXzp78ltjIuofPK+aX6F/bEKwFVDT86f7TMO/Fm9MESIv7gq/ZF7FyD7akpfUEZ
	D9aLLJw9l/8Tjj0Bq1BfExmhv5myAKfZQbHtxuopuEe6dbfNLEnpGoGnjan5qpzk+gt4gMI4DGX
	TNWzAp1T84w5QvCiJ9kyNbongvQ7gZz1CVzPAb9nbOziVRFYXlc4ZtoTKln+b7ssGTW2OceXGCx
	9+wQPg==
X-Google-Smtp-Source: AGHT+IEF7AswBtc7k3jDGF5yI8YAhFNLZyMCW3Irr0/2fB+onQMhz9MjtOFTjpEA4IGlQdfg2j8nZA==
X-Received: by 2002:a05:6a00:2184:b0:725:ef4b:de33 with SMTP id d2e1a72fcca58-72daf88b1b9mr13809008b3a.0.1737265482724;
        Sat, 18 Jan 2025 21:44:42 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81753fsm4835038b3a.60.2025.01.18.21.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:44:41 -0800 (PST)
Date: Sun, 19 Jan 2025 11:14:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Simplify config resource lookup
Message-ID: <20250119054438.r64thnipdvmlxn3p@thinkpad>
References: <20250117235119.712043-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117235119.712043-1-helgaas@kernel.org>

On Fri, Jan 17, 2025 at 05:51:19PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> If platform_get_resource_byname("config") fails, return error immediately
> and unindent the normal path.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One nit below.

> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e42a74108f0f..3fca55751dca 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -436,18 +436,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		return ret;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> -	if (res) {
> -		pp->cfg0_size = resource_size(res);
> -		pp->cfg0_base = res->start;
> -
> -		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -		if (IS_ERR(pp->va_cfg0_base))
> -			return PTR_ERR(pp->va_cfg0_base);
> -	} else {
> +	if (!res) {
>  		dev_err(dev, "Missing *config* reg space\n");

nit: How about:

	"Missing \"config\" reg space"?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

