Return-Path: <linux-pci+bounces-22073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67EA40619
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4F700F43
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E191DC9B0;
	Sat, 22 Feb 2025 07:38:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA978F4E
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740209914; cv=none; b=fkTNyc/jvaNwG1fZnilMZUT2zBmp+DNawtOdvoTQfHVNaCTWKA4id7/jL/Zrfa+G/CzpTiuoieq8WJV4NUW02Zd5P9lLHhA/Z1EkqMkFfqG1BOLJ6apRtGfW3ckeKhFxtLWu2FTrZpzxhdbtLOeDb/8td2g6hSjwV8UYTRjArks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740209914; c=relaxed/simple;
	bh=qu91disMdwxq3Nu1GPR/Q+BYrNxfC0ooqZ66KPz3qVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNRJjL9T8spjjp0GDEHWCmMtP+zfDHsEgvamgZtlJnGEVRy1CRtRGRBp/+LntXjAJ52ERoBRGHhR/ea0MxfROOk6kF5D0KcGYdPEXZz86oA+fg3P5lFAPP1cwS2OaSfkpLuZM2zT/M9LTwx3RYoR4krSBp5ODG+ND+KsO4mwDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc6272259cso4726191a91.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 23:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740209912; x=1740814712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ0UFW2pdjOoWqROlGDZphwMQ2EIio94ZLPWcsQImvI=;
        b=DjFE8TVAvMMe99/51Tj2FMHjR7/eMK+ghY+yLbVbQoS4ylNcCJKyyZ3JHOIUDBD6iP
         CoB6yt3g2tAlqmREdeB/J/jOXEfT43TKqgf+uKLpuLAeitrdQd0Kj0rKGbNfPZQRl3tI
         8WGT2iq8D8l36H3S8xPjbSG9W/FUnkZxluYPXnfzVvgk8fZ69dH5cJAeSXtEf6S88TbO
         ZfNtJZLJQFoKNvKgWADVdXbbdZtyKySGrBl7AcW5s65gxFQTJhmf5c48zErCBIfdYUqt
         u5GdZWa9GI+mLhXuq2JD4mf74lG7i0suMthWMdmtbC+WE9+UcUw7sT99muqY6hL+Hjc+
         zcFw==
X-Forwarded-Encrypted: i=1; AJvYcCXdPJVqOgl267DlUgBQpVV2acnEdETibqRpu9aRj2S1/bClu9JZYfNpGj237LeAfZS0rn81+EBzcLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHON8e+4v/JVl4ReIsKtmrekzCKs55vR8lZtD7CyHwo6hpwQxt
	gZfROFwMzGxPZZSsIFXwzF6s0qho+9Tmn6i7Yx9s2pojmJUhcNtz
X-Gm-Gg: ASbGncsfdGV6r61R1P730fHZ6BKg16bcTD5hwPDJgQqRHAwh2QUaFPvUD+mTGjdgc5q
	Lm9XsIAJUJAbiDegBXPVmwEYg7dTmEwCFvwS7dvwpJ6D72Orz6Vo0b8akmk4i6XHcftt9ox1K2l
	g4mB/ov8DEDKd6RIQ8CTvOBGQTrEazfjxfF16yl/zCGzBOmsiWgM6XFlzZOuwG/6Er98hPwAULm
	K+rUobM9CasqyART3/H4eDGL8opIUkPyMXN9KQura8KdZBFuAVGoIST+hQrFoDBGC9rdaKc+vzp
	sI/se6Z2ll6XRGA+dtP69NSmq/S+ZyjLMP8ouCiIbzt/697uaLtA+tXcdUkI
X-Google-Smtp-Source: AGHT+IFThR433LcObShHk7gSPjGjLSI8AWlZ6U2G2AIgjEbAQv5VuI5xA/i3kLqSjTt2eyUi9Bp6Sg==
X-Received: by 2002:a05:6a00:22d6:b0:730:94e5:1ea2 with SMTP id d2e1a72fcca58-73426c8d91bmr9220237b3a.4.1740209912568;
        Fri, 21 Feb 2025 23:38:32 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568acesm17390081b3a.56.2025.02.21.23.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 23:38:31 -0800 (PST)
Date: Sat, 22 Feb 2025 16:38:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <20250222073829.GA1158377@rocinante>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250221202646.395252-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221202646.395252-4-cassel@kernel.org>

Hello,

> + * ATS does not work on rk3588 when running in EP mode.

Would it be OK if we started to style "rk3588" as "RK3588", unless the
lower-case is preferred?  I had a look at Rockchip's own datasheet, and the
product code names seem to be styled with upper-case.  That said, I am not
a Rockchip expert.  Just curious for the sake of consistency.

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
> +}

To keep things consistent, it would be nice to capitalise sentences in code
comments, and end them with a full-stop where appropriate (e.g., longer
sentences, etc.).  That said, this is something I can after applying, to
save you the hassle of sending another versions.

Thank you!

	Krzysztof

