Return-Path: <linux-pci+bounces-22102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54AA409D0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B32417977D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25B1CDA3F;
	Sat, 22 Feb 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V55ZtYcl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1421E3DED
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740240526; cv=none; b=cTdXOnuvhTBufI7mpSjoykVYXjCja7wDx65YMbm3R2tma8J5CyxtErVV6J2qBGD6kyN1foSCs/a0Zw8lEc4XTRVcvIIYy+Ix2Mh7TiCEv59fgn8tYF4BsmbD7NMgGYbc3Ud5nxhmx1szQr98fa3/m1gHRA1/G5mr7KYU2Y4gfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740240526; c=relaxed/simple;
	bh=0/RY4MiK5oUZ2yxOJ/3OlnlBf2XZZ8Y3knFd3zoWC5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZVg0TvP9XyHpqeyCHXchyPzqp4zpp9NDV1f0EGRvq19whFIcJSQ+Sb7GqXvuWwTYXhHSxQglrMoCvdVGAqClHTZB8K8SwVHpji99ctz0QMMPvXqUlVBL6730qC/gm+5Kpvqm7e3md/8KTbT92ZXXc5XdwycNVdK3R98oXssglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V55ZtYcl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so54119305ad.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740240523; x=1740845323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m6nKOO+ujfvI6kP5NRUFljlra8jwiaSae/QIEC4vlMk=;
        b=V55ZtYcl0cCqBA0TELb7JHTVy9Svws9/+bVW+xAW+evOjTwKAOAPkdA3ZWH3lleUwB
         nszhkfPC+/+PGytJN7ZIxfZsluj++slDqV4jMfVybjNP9GoKLad67dnqHSK225G/Rzv1
         sgLp+0DBahtfkMPTdT+msiRvE9QkUzfKbD5U6VMrXl6unxxY2kOrKD67VbAOuBh9jl4Q
         uBSFpMTnr2vWTe+hDjoEOBZ10DQPd6WSFoHGA36zV60x/5uZoQZPLe10ryjvXs9v70RT
         l9ruRuxhLS5An6smpn3+F1/0Mfl6mg1iH3XImg3cL8vvRRrbHIgmOocUduBKXX4oKaQ1
         6WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740240523; x=1740845323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6nKOO+ujfvI6kP5NRUFljlra8jwiaSae/QIEC4vlMk=;
        b=QYFH8M1FaZafzkxelTrABBA6Yyw8RdZxtVITkQy+2AYkdPjBcFeMYiIuRlzhu+45G0
         fvR5vsOCtYU4n9dJOBaJhuVFxUV8i5dyNCqaqOTGc0s+JSR4Iu4GtwnZeF2XgFMZWwSy
         RGHTJQ7T3LM2AMjK8e0nm735eADlzAcUjttNiapGWDKrU5DUyO0iuweseUvXEV4hNPtB
         8Q5m09inzjyVnQJwpQoOWN5AEffQ74Azicnobx9Horu8gGwme62o3eKLpqO24hs+RfkC
         ZMUSX0su7WOKw4847s2PkAJ2m+9/+v90n9XsXVXyJF9DvLqwLTHX0QNrPN76Htf9fex5
         C0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCX+LsyHD3phB3KW5YWMDHZUMEPChdbNI+cOjsoBtHS9bZj+oqo7fFo14ugDFh+Yki+tAUesHE2cELQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4ve67rMTJr6gHp/ljmNUbnh14F29c7wdu6aMQMbIsDmXdEY5
	2MOQrncSpAj4xkxtc9euJVjpfVL13L4etJ0ZkjoWvRQ4UYT9CnzxfdhvTKfcdyAT+tALgbHA39U
	=
X-Gm-Gg: ASbGncuoppp0ihLhnvWRPK7WcCvSv396WyurErXX6u6dCVEUhpZYrR6uy7GM6zTafrx
	gS+MsEA6tALH0N7mZ5aT847zePkD8aak8e0fQKSmV2qDpnQU+Jp2HJY6OVZF3m4fi0tWMraJ9Pb
	Rvot0uxdqpEO8J6bk3IMf4ZxYuSKTa/B3+aNhvuLfRzkck8FDhaLfrADDLtjxGMXAtLHQhJ8Jlm
	1/petR0jcmkWaCWj1o++kO7g8V1cQufDx8T02CNYWn0e7R2AqNdrs9bSM6Qh8XL1b6KQinHlCl1
	rLbGP3+v7nkG4bDsy9uCAbQO9d/K8TWjTmXKlg==
X-Google-Smtp-Source: AGHT+IHN0WlvX+IkHk8JMgEJNSbtnqx/TMfpzaynwWxX8s++M0aKqed9Cxvgkv+KhaqAUxrXEQr99g==
X-Received: by 2002:a17:902:e80b:b0:215:44fe:163e with SMTP id d9443c01a7336-2219ff34b52mr134423285ad.1.1740240522821;
        Sat, 22 Feb 2025 08:08:42 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d7dasm3319824a91.5.2025.02.22.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:08:42 -0800 (PST)
Date: Sat, 22 Feb 2025 21:38:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <20250222160837.mropn3laiyv3acaa@thinkpad>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250221202646.395252-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221202646.395252-4-cassel@kernel.org>

On Fri, Feb 21, 2025 at 09:26:48PM +0100, Niklas Cassel wrote:
> When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> enabled, the host side prints:
> DMAR: VT-d detected Invalidation Time-out Error: SID 0
> 
> When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> enabled, the host side prints:
> iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> 
> Usually, to handle these issues, we add a quirk for the PCI vendor and
> device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> we cannot usually modify the capabilities on the EP side.
> 
> In this case, we can modify the capabilties on the EP side. Thus, hide the
> broken ATS capability on rk3588 when running in EP mode. That way,
> we don't need any quirk on the host side, and we see no errors on the host
> side, and we can run pci_endpoint_test successfully, with the IOMMU
> enabled on the host side.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 836ea10eafbb..2be005c1a161 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -242,6 +242,51 @@ static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>  	.init = rockchip_pcie_host_init,
>  };
>  
> +/*
> + * ATS does not work on rk3588 when running in EP mode.
> + * After a host has enabled ATS on the EP side, it will send an IOTLB
> + * invalidation request to the EP side. The rk3588 will never send a completion
> + * back and eventually the host will print an IOTLB_INV_TIMEOUT error, and the
> + * EP will not be operational. If we hide the ATS cap, things work as expected.
> + */
> +static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct device *dev = pci->dev;
> +	unsigned int spcie_cap_offset, next_cap_offset;
> +	u32 spcie_cap_header, next_cap_header;
> +
> +	/* only hide the ATS cap for rk3588 running in EP mode */
> +	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3588-pcie-ep"))
> +		return;

Compatible checks always tend to extend. So please use a boolean flag to
identify the quirk in 'struct rockchip_pcie_of_data' and set it in
'rockchip_pcie_ep_of_data_rk3588'. This way, other SoCs could also reuse the
flag if required.

> +
> +	spcie_cap_offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI);
> +	if (!spcie_cap_offset)
> +		return;
> +
> +	spcie_cap_header = dw_pcie_readl_dbi(pci, spcie_cap_offset);
> +	next_cap_offset = PCI_EXT_CAP_NEXT(spcie_cap_header);
> +
> +	next_cap_header = dw_pcie_readl_dbi(pci, next_cap_offset);
> +	if (PCI_EXT_CAP_ID(next_cap_header) != PCI_EXT_CAP_ID_ATS)
> +		return;
> +
> +	/* clear next ptr */
> +	spcie_cap_header &= ~GENMASK(31, 20);
> +
> +	/* set next ptr to next ptr of ATS_CAP */
> +	spcie_cap_header |= next_cap_header & GENMASK(31, 20);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, spcie_cap_offset, spcie_cap_header);
> +	dw_pcie_dbi_ro_wr_dis(pci);

This code is mostly generic. So please move it to pcie-designware-ep.c. The
function should just accept two CAP IDs (prev and target) and hide the target
capability. Like,

	dw_pcie_hide_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI,
				    PCI_EXT_CAP_ID_ATS);

Its too bad that we cannot traverse back from the target capability. We could
open code dw_pcie_ep_find_ext_capability() to keep track of the prev_cap_offset
though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

