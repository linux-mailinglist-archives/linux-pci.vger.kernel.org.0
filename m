Return-Path: <linux-pci+bounces-24552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A3A6E16C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F286C168B91
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9359264FBA;
	Mon, 24 Mar 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jauDl7DA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEA264625
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837662; cv=none; b=u7+chdYIs+Xqhoal1sA7f2b0GDyQB3iIR+tTHuJyVC9RTmQSZhRYdMqPI50qIyCLZx+n65+yxLLopZ6gK2MiUw0+BT/6Qo7BlpPy9ALgtvDD0FDldFSB3O0b1SzyFeAPz46C72WhD4qh+XXQM+pYo6HwZlpNawLdCKBBMGCiZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837662; c=relaxed/simple;
	bh=9VD5yRc3tLAiwhVEBXo82ZOS86iUaUZI1Asrk4moJko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix8QfpRrJuVqmGbekUaeFcRz6Rff6MlukjUC3wPhswcKBvKPhCAGapjuxYVRTAiV67e8E7Q2K4apyMqyv797PYJKi9sN1Nz2ACZUAknbyPxnimIdDB9uJoe0rpQO+oQdmPhsU3lQ0G0CnuGDmng1iB37RgqVsoVKU57hFxd0VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jauDl7DA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301493f461eso5630472a91.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742837660; x=1743442460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=83CYsZDlIxjagBMUpXjJLP1JyYGcnqEAQYBsR+/D8Lg=;
        b=jauDl7DA903iMHf6apJ2L7OURIkE3timkN3eaGgGcFlnz+vhePrbWCtTTCnLaGHrxh
         NCtZBUowGzKx2mdDZDPWcvUP29SprxinIZHb727ZzMQOJREO52Xgg43TviMIdwlmjcqU
         +CA04U8f+85g0a1jQ0hayxPckUVK+BLKIkhpVtbJtpH0pcJy3e8zO3LDlEK8Pr8JPbEM
         VFLioNdCP+1afQtg5L9Lu9vD5gDoUaOs/OsvLvQ8zpdjcoXNJbLxXxa5K6+WTCgWmLxT
         sjFHEkG6+a+wjYjNHwhVOMKy9RKVHtx6vP4qu6aI90DqOc2reWvgWX9FaH+4iTyPcewc
         XPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837660; x=1743442460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83CYsZDlIxjagBMUpXjJLP1JyYGcnqEAQYBsR+/D8Lg=;
        b=Mit/7wVbDU9hERjPFRqWANv6PCzVGb5JBrNIIp8UOOSnDqjQpRMQiZJ3OqZpzf3Vsl
         B7YNZHEpc953ZxlNhzh9Gvn8FUIwgc+vXEBrm7hxg3ozMbri0zop75FkOS4dw3Yh3cuk
         4qVZEbR+AB90D7Zegdisy1XKalkiXmi92BnRgwEf521AaH7VR92+VlUoQNo8drOaZHbE
         Dn/JOAwGC/Z1uYCgkdsPGniEnoD+uO7hr1YHZLpHD5HHhHQKo2V2Kne8huq/BHC42+aQ
         Bul+6e7m4hCLNBEK1EIW6xW19hLs1weDAZO+h1M7HI8LhpYu/9Mpn++PeZKZFl1LNf/K
         ieeA==
X-Forwarded-Encrypted: i=1; AJvYcCX1MYiISysp84YBDiWIIWngPAFk/K+WTHa/Y+Iv1t2mSgwkc21D1eD1qf4EGWnRd8vms80+M91wnmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtfbRuOmfmCi5ismVb5e7YB6zuZVUwlDw5H4BBeBXjjx0IM/V
	Ndatp4YtgQ+V3BjOciVBnkCjxOrXlDD2BDw7hWkmDZQ3Hkios7h/KtkY0FI8WQ==
X-Gm-Gg: ASbGnctSW17iGI2EzWUJ62f0ToFpse/TMBDomfM7Dtc8Iz5MWbO3q3WlAgxN2wCKVb7
	jQ6vJR0VhPGgzKqUu1payVLMy5SaEB/HwfLWn1ZzxzSpau50U3jz0nRma0G/wFThxghWK4M5ZTK
	EpdbpyLpsRY7X0o5ZpzQd7BISLYTIMdhHlZ0UlgAVQctWVZUb7+xN1yB4w58Rm1gOCR2A1//NGk
	mq7hODXklUrXC1MQ7hKOM40YzHy8ZpTKKIs3DdlFOUXhQ9gYYeWekMabLhKhAL4X65eUXGdiJJ6
	T1dEVE3eFD1MjQd20NnGCT/1eYf41Qn9P99JjeQzogtbszLA96OL954=
X-Google-Smtp-Source: AGHT+IHbIVCssVeg7Lv61Tjada9UpukwFQFdXBab670umPHzvG4MJv+C/Yb75yCUgxbb10I3kj+LVA==
X-Received: by 2002:a17:90b:510d:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-3030fefd847mr23814182a91.24.1742837660393;
        Mon, 24 Mar 2025 10:34:20 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b525sm12457882a91.35.2025.03.24.10.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:34:19 -0700 (PDT)
Date: Mon, 24 Mar 2025 23:04:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 00/13] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Message-ID: <sffiojhyyu5gc7nx4oe6re53r3ti4nbnkworsxzawkus6ovlsh@3auwqhcpdp3c>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a v12 based on Frank's v11 series.
> 

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> #SA8775P-RIDE

- Mani

> v11 https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com
>     
> Changes from v11:
>   - Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init(), before
>     any devicetree-related code
>   - Call devm_pci_epc_create() early in dw_pcie_ep_init(), before any
>     devicetree-related code
>   - Consolidate devicetree-related code in dw_pcie_host_get_resources() and
>     dw_pcie_ep_get_resources()
>   - Integrate dw_pcie_cfg0_setup() into dw_pcie_host_get_resources()
>   - Convert dw_pcie_init_parent_bus_offset() to dw_pcie_parent_bus_offset()
>     which returns the offset rather than setting it internally
>   - Split the debug comparison of devicetree info with .cpu_addr_fixup() to
>     separate patch so we can easily revert it later
>   - Drop "cpu_addr_fixup() usage detected" warning since we always warn
>     about something in that case anyway
> 
> Any comments welcome.
> 
> 
> Bjorn Helgaas (3):
>   PCI: dwc: Consolidate devicetree handling in
>     dw_pcie_host_get_resources()
>   PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
>   PCI: dwc: ep: Consolidate devicetree handling in
>     dw_pcie_ep_get_resources()
> 
> Frank Li (10):
>   PCI: dwc: Use resource start as iomap() input in
>     dw_pcie_pme_turn_off()
>   PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
>   PCI: dwc: Call devm_pci_alloc_host_bridge() early in
>     dw_pcie_host_init()
>   PCI: dwc: Add dw_pcie_parent_bus_offset()
>   PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
>   PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr
>     offset
>   PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU
>     addr offset
>   PCI: dwc: ep: Ensure proper iteration over outbound map windows
>   PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
>   PCI: imx6: Remove cpu_addr_fixup()
> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 18 +---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++------
>  .../pci/controller/dwc/pcie-designware-host.c | 57 ++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.c  | 82 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  | 24 +++++-
>  5 files changed, 171 insertions(+), 84 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

