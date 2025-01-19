Return-Path: <linux-pci+bounces-20102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFBA16047
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A121D1883FBF
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656391CD2B;
	Sun, 19 Jan 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfuuSCkN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21610F9
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737263345; cv=none; b=SwZaSAXE+Nggad1xdS5brTIVBEuQM/jlFE8XBJi9YVlevhbZEeFRGf7qB3vqqn3mnjGQ4huu8MahF1RRYVB3pXmcDesO5qxGY/KFmti8ED3ij3ZLGVkyplCCFZ049E1HxxgLzS6Afx9DYxoK/H3dWVf4vtFnhRTGc4r6pihvgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737263345; c=relaxed/simple;
	bh=qNKDtcytVHhmIFNag2V4Oay3L6Xwu5mlaXOBmoK2LKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az9+WHjNtRhgYvbrXzKItmQKUrraqfUBclMW2tb3jSIiKkOLF2N3PSVhqg7Df+jLGbJZeGOaFPAaqH9us1Ly8tfOl6wiviSB5IFTjslFZRcbjiALpQf7bLZZCuOJQeBojUcBPZJTQLUPxu03B7zk5OgvewjTFGODZXh+3W8dpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfuuSCkN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216728b1836so59135755ad.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737263343; x=1737868143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvJecefk7RmS0IifJ26t3rGZLpvHVBi8QGp4fEpog/w=;
        b=hfuuSCkNF3sE7K46TSS8QzNnsiK/QibDBmg2aEcgjL6rc/+fwokYmToIV1p3P5IWbc
         91N2zZwrmZF7dSbro/s0WWry2kPYsH4JKyDrwassuIHmnaZTzczZ9j8kmQNCJj9Nbz5A
         x8LEaBTtdMLXsgUmT4vlAV9bKi1Xi14UiP9qTb1HLJCMuRokTB1CGnmeczQsGgHsvOOb
         eBC9y2JSfhLVGwM8XW4JHnICdc94X7Tt79CXyTyU/YEp6CS/kHMTE1qwZcmm5PA9OYLI
         4wGh6gcCTH2anNl88h2A2olYfn2ozcexzMXoHEJuirdc7t0LDo07/4hGkaQDUyc+ZUpx
         fMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737263343; x=1737868143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvJecefk7RmS0IifJ26t3rGZLpvHVBi8QGp4fEpog/w=;
        b=Y77qaL/lRLW9x3VDnRebbIe8j0LjHQWpTbYUBz0wyu1xBwvidvj9tJaLkdgRnYPot8
         diCjSUu64d/C0fy5hoetjZj4nnqXpIe5zynKWrVmA8ELeBDRhIWk3JLjEDgtCiynhmY7
         rhbGJ+CeJRptqrXo0NBT9XPGnawr1ryPUPGAMpsz7fEwJWMyM0nbSgbUUBZKCgoLjZMl
         WDlB3Lg7LyM55+Qr7HVg6HbXkpX8jd0blQW1RklhrE7fbnaR0+BFwQZ6Csl3fZGMdaR1
         joHWan7YMxx6RFWKpeCg2vEbhEq3cvyeqqD/jOxuIkcbsEaXz7p9ZvwvmE6ACKtH3yab
         wc8g==
X-Forwarded-Encrypted: i=1; AJvYcCUbkqBfmBFmnJolmnAPMxg03QKDxtx35eXnI1jcLlHBioR+r9H7LUiqKomrlmTem2qDP+Dr+UcoKos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPo5VGzpHgpelmjIgffAZyBdjYxCn3gpe5amZ2tAjxATTCvCA
	5sl4hy/Jfm34sO2y6rgBDPMan+Whr0ZEGzkZScb2lb/jFyNjoZV9LebAZ0LHEA==
X-Gm-Gg: ASbGncvBzvA1kPobM4r/mq6ORT3np7vFv55F8hIeB6CyQuNK//ATAxEo/o1wb+ZUX90
	ncWSmWHifgk+qOpyslr2FIYeWQk1giDI6HCi68UhWKV3SbGsg8rDlU17VDYljkcaWbWgnL+iEtF
	DAFIBXx2IzPgZ4roKmdB7QfQk70jUIddUbTlTCH557z7dkH+f+W7iH/JQ9aLJ4Bi+ICEvQZ2wLc
	OSCIzlfziOpEUxXFFBtLJ4D/f5Cx63XfhYDo+YGlKUYG9MIv7ngumjcGwRq3mduHXTnsleeDhqK
	RG7EDA==
X-Google-Smtp-Source: AGHT+IH56I3/tW+579vI6yiwAOJnC+RYQDWkaXTf+d9BkFZwz6flw0LrFdP//bjYLbRS+vchvwKt9g==
X-Received: by 2002:a17:903:41c3:b0:216:728b:15d8 with SMTP id d9443c01a7336-21c3556b158mr128203955ad.30.1737263342699;
        Sat, 18 Jan 2025 21:09:02 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0934sm38612255ad.36.2025.01.18.21.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:09:01 -0800 (PST)
Date: Sun, 19 Jan 2025 10:38:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/6] PCI: endpoint: Add support for resizable BARs
Message-ID: <20250119050850.2kogtpl5hatpp2tv@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-8-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:31AM +0100, Niklas Cassel wrote:
> The PCI endpoint framework currently does not support resizable BARs.
> 
> Add a new BAR type BAR_RESIZABLE, so that EPC drivers can support resizable
> BARs properly.
> 
> For a resizable BAR, we will only allow a single supported size.
> This is by design, as we do not need/want the complexity of the host side
> resizing our resizable BAR.
> 
> In the DWC driver specifically, the DWC driver currently handles resizable
> BARs using an ugly hack where a resizable BAR is force set to a fixed size
> BAR with 1 MB size if detected. This is bogus, as a resizable BAR can be
> configured to sizes other than 1 MB.
> 
> With these changes, an EPF driver will be able to call pci_epc_set_bar()
> to configure a resizable BAR to an arbitrary size, just like for
> BAR_PROGRAMMABLE. Thus, DWC based EPF drivers will no longer be forced to
> a bogus 1 MB forced size for resizable BARs.
> 

The subject got me confused for a moment because, you are not really adding
support for Resizable BARs as per the PCIe spec, but just allowing the EPF
drivers to configure the size of the resizable BARs from fixed 1M. This is a
good improvement btw, but the subject should be reworded as such.

- Mani

> 
> Tested/verified on a Radxa Rock 5b (rk3588) by:
> -Modifying pci-epf-test.c to request BAR sizes that are larger than 1 MB:
>  -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  +static size_t bar_size[] = { SZ_1M, SZ_1M, SZ_2M, SZ_2M, SZ_4M, SZ_4M };
>  (Make sure to set CONFIG_CMA_ALIGNMENT=10 such that dma_alloc_coherent()
>   calls are aligned even for allocations larger than 1 MB.)
> -Rebooting the host to make sure that the DWC EP driver configures the BARs
>  correctly after receiving a link down event.
> -Modifying EPC features to configure a BAR as 64-bit, to make sure that we
>  handle 64-bit BARs correctly.
> -Modifying the DWC EP driver to set a size larger than 2 GB, to make sure
>  we handle BAR sizes larger than 2 GB (for 64-bit BARs) correctly.
> -Running the consecutive BAR test in pci_endpoint_test.c to make sure that
>  the address translation works correctly.
> 
> 
> Texas Instruments kernel developers, if would be very nice if you could
> help out with testing on Keystone.
> 
> 
> Changes since V2:
> -When looping in dw_pcie_ep_init_non_sticky_registers(), use the index
>  that we read from PCI_REBAR_CTRL (e.g. a platform could have BARs 0-2
>  as programmable, and BARs 3-5 resizable, so we need to read the index).
> 
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (6):
>   PCI: endpoint: Add BAR type BAR_RESIZABLE
>   PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
>   PCI: dwc: endpoint: Add support for BAR type BAR_RESIZABLE
>   PCI: keystone: Describe resizable BARs as resizable BARs
>   PCI: keystone: Specify correct alignment requirement
>   PCI: dw-rockchip: Describe resizable BARs as resizable BARs
> 
>  drivers/pci/controller/dwc/pci-keystone.c     |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 231 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
>  drivers/pci/endpoint/pci-epf-core.c           |   4 +
>  include/linux/pci-epc.h                       |   3 +
>  5 files changed, 219 insertions(+), 47 deletions(-)
> 
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

