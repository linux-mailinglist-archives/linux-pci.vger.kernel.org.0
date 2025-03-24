Return-Path: <linux-pci+bounces-24535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF6A6DD25
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB17C188B637
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209725FA1E;
	Mon, 24 Mar 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m25GWIhD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BD25F996
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826971; cv=none; b=ahDA7/kjGP8ZRuzcvyZPoSlpCe3RQJd8rrXtwZzEC++bbbWpQZkIHsbSNlQWOhYojKP+jy8FgRhwLJttLdpYcXkmDXroVctBKDbkpYSIdzmunbuAQoP7NRdTuysEnqjJUa69cwK2W3d4O8ucYlN0Rg7uVuj4BH7DvuHEAGifM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826971; c=relaxed/simple;
	bh=GzU2khTy9edLOPP+nLp8NetDsg+HJrBHGDBGWsqgqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbVRI9L6Qu+UeeGYfK0hGaulasmS/ZWEwyMeqkvlYzVVnrV++RB1429/JB5gBT82hlEksoaA4x6oQ5TBJtiRazQk0k1/dRoTbKX8ofqGiiRzcKeNYFJ3awxZOfeU97ZhWovqyy48XWY1RjG5qABS483ofa2gon9yWnEU2jk9bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m25GWIhD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224171d6826so8101435ad.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742826967; x=1743431767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gfDNrOLDRsSoKnoiSnKZrCZ6ys+s/p6oKC6Xtt3UxnY=;
        b=m25GWIhDQjgL8i+adCWRZXt00ur0ACXROJu85JtK59EdJkSkczr1UEpzTUKrhK+KM/
         mQ9ygtAJs2z+YME3KGKgKl4Jg7McKOKjJoduJN3a+rEDQQneak8Aurt0Wdqc0dJXoOUS
         q0dAtBnvsSAyD+QrVmkeHMNDaXISVQKEOT+NgLXmIFPHNaVZQoCkys+wAVSba81hIz/S
         KX8/FCP9nquDZ9IFN5TiHmVW0931Uuw4/fIpSGaVPUUXbBXv/OEvtj5pgGVGgkhkauXF
         PPRG63iI/r2leYRZNJcLmNw3sKjcXsCjoQGneExCqbtTvQTZSgsD++UMPLyQ9FLJJ/AF
         MgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826967; x=1743431767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfDNrOLDRsSoKnoiSnKZrCZ6ys+s/p6oKC6Xtt3UxnY=;
        b=DGgZnVg+wNulVD4e3P8LyiBqFIiZyqb9qPAHQ7D+1PUycFwSvwaJGv44kWIIQcS+a7
         2NbB0VTu4Wt6uJWM48tYdK2oUDCiSOuoSwTjL63eHGN2yjFmMjzq/Gx7OHGlwk+/Al0A
         llZDIrH5BgmthIXodOYh9x25bePXz19FUADypms10n1kk0FpoT9tG5ZjFosc2klltc2P
         nXn9qOgJBNH2gpvXXOmD6Rqc9ULA198Q+uLToT5haSAJoESQoy5EtkekH7iKxMF868Mt
         ONwHzFj97XttKwmKWcj4HVPNHHOkyf+LlIM0Olod/VlPy3fIRq9KLooUW20YNNS5lyw1
         Zcaw==
X-Forwarded-Encrypted: i=1; AJvYcCXk12kt79YpJS8WmLUZy2Go85uTGUTIEtN/YO0cBkfEUIy9967xYIC5ZC+K1lafnjjANmBmy8yyfoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCX4j7ay7xOyF2NbBXUT/ivQuyP+1x6NsFjcLXjyCMZ1uJAAr
	jVvz4iUVD04oPCv98N1q9dq+dM+mgYyyqz2Y4mYNmCbs84gs76jB2X/ejZSyFg==
X-Gm-Gg: ASbGncspvymK0ulWmIbBZ/h2WV9vm+DT0s+IaEedoqUhmsaKOgnzggEFQpvYNpm1jwT
	x+/CN1FAU4iLxsrlC5l2ZGoOJfQnXuKX856VC9U/A1IGe23kGaSFdbZ+lR2ukOJQ3o1OYjeYmsl
	ukcxOysbYW7UKWcK10peYCP/3vM38hvZvH7NuWm6wr54S2eoDoW5CXHhz0a5LjvqNREe/qrujwJ
	OzfsfyQRSK321EmHNEe+HYz8l7a2wi6tQoutDE3GSlHErRYP0OXwC6nJAgBUysq8BlW6TOP6XWr
	NRS9rPLAIZP+pHCWh/1XXfBnz5OxAnpjDAOFDU1m2SuzS+WAH9Yj3Tw=
X-Google-Smtp-Source: AGHT+IHosn533Honkxz5Gkn47lhA4z7ibid7YzujQ4Q5gGN1wmrSmuIZVipbX/6bHz2UT8zZDxLukA==
X-Received: by 2002:a05:6a00:1885:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73905623ea3mr21273776b3a.0.1742826966908;
        Mon, 24 Mar 2025 07:36:06 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905faa565sm8053740b3a.1.2025.03.24.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:36:06 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:05:58 +0530
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
Message-ID: <brhtmymbntt7dk3bqgcwjb72ai4g2bn4b5emcaxntbizvu4i7f@ulvm37yyl4oq>
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

Mostly looks good to me. But I do have a few comments, that I'll share.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

