Return-Path: <linux-pci+bounces-44081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C352CCF6C68
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 06:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15E53047959
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644003081A4;
	Tue,  6 Jan 2026 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn7eNbq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CF3043BD;
	Tue,  6 Jan 2026 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676775; cv=none; b=BGgiLgm/xWlwWzhbx0Yz3NkCVP0ZTDjN74iH34FWfcu0Vf32QtChiRTDfCVqYYVayTiQquptF8B6SnyUeIYW4fUm8Qw8BSz0R5ApAiS4AHMyLJ6uhTVQzQfIJ95NtlqsC3TY8CmHrA6ZtnYRe4mKv030PhukxqpnisRIGaekjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676775; c=relaxed/simple;
	bh=h2nYGKojRr759U41EwbB4BsmLSlNtVAL8aBfQlF4xTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEvab8v0OkivgC5x5s8h9gRIKtgw3phGDP/0vy3NAuETeRcTP/32h8/Jvl2mHi+YtqaQjv+2H3avzBL8p08m0S9wWR5kI+VS3FBKiAlpyT4Q5l5kcOLpMZ4Ft19XW4z+vqkkyf2ylzrUm+2c4lrsjw4Hpcct2f2Zs6b5Jpex6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn7eNbq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7117FC116C6;
	Tue,  6 Jan 2026 05:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676774;
	bh=h2nYGKojRr759U41EwbB4BsmLSlNtVAL8aBfQlF4xTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn7eNbq+r0jsnqP0Mix+RIWDvZUr1tdAgbjsrEGr2Ms9oW27hgMlnJw0ZkpSpIB7H
	 VFVpNZUQpOrDUTBWHMpyZi9/eKY0Qb+AnhG52J5zL8WWqo88g/p5j0J5Zy85RsIztz
	 P2mn8L1AGv1qK0pNNdB/HsIJIkBXeXj+VG0BiSfhQJOHcPXQkEZQG6mMUihoezwrSB
	 w8K6ZeXkX1jI/ZfTN4Zm7awLzTo9nbMlCOwvaMpLHDKzcXwj3pixaITdVMhWoVjGKB
	 KrSBHZeR6A15yHPveYgjG/D2gFY70Y8Q5JReXwCWQqbWYvWeEnIvCRk91nnGFYGIc8
	 dYoNqcI1m3mfg==
Date: Tue, 6 Jan 2026 10:49:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Pratyush Anand <pratyush.anand@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dwc: Add multi-port controller support
Message-ID: <m5ukeugo2lazipljqpubyvm7j3xk2j5o7i2xgdbkkhii57xmyk@lh32qdzjhe4n>
References: <20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com>
 <20260105-dt-parser-v1-2-b11c63cb5e2c@oss.qualcomm.com>
 <aVvkmkd5mWPmxeiS@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVvkmkd5mWPmxeiS@ryzen>

On Mon, Jan 05, 2026 at 05:19:38PM +0100, Niklas Cassel wrote:
> On Mon, Jan 05, 2026 at 05:57:55PM +0530, Sumit Kumar wrote:
> > The current DesignWare PCIe RC implementation supports only the controller
> > (Host Bridge) node for specifying the Root Port properties in an assumption
> > that the underlying platform only supports a single root Port per
> > controller instance. This limits support for multi-port controllers where
> > different ports may have different lane configurations and speed limits.
> > 
> > Introduce a separate dw_pcie_port structure to enable multi-port support.
> > Each Root Port can have independent lane count, speed limit through pcie@N
> > child nodes in device tree. Add dw_pcie_parse_root_ports()
> > API to parse these child nodes.
> > 
> > Equalization presets and link width detection currently use common DBI
> > space for all the root ports. Per-port DBI space assignment for these
> > features will be added in future.
> > 
> > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> 
> Hello Sumit,
> 
> Is there a reason why you represent this as a list of ports rather than a
> simple array?
> 
> The number of ports is known by parsing the device tree, so it should be
> static, no?
> 
> At least to me, this seem similar to e.g. how a gpio_device has multiple
> gpio_descriptors "struct gpio_desc *descs":
> https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib.h#L68C1-L68C26
> 
> A list is usually used for something that is dynamic.
> I don't think that the number of ports to a PCIe controller will be dynamic.
> 
> I can see that struct qcom_pcie in pcie-qcom.c has struct list_head ports,
> but that does not necessarily mean that we need to have a list of ports in
> pcie-designware-host.c. (pcie-qcom could also be modified to have an array
> of ports if there is a desire for similar design pattern.)
> 

Only reason why I went with lists in pcie-qcom is flexibility. There are useful
helpers available for traversing the lists and they seem much more elegant to
use rather than manually traversing the array in C.

But to be frank, I don't really care which one is used as there is going to be
only a handful of ports at max anyway and there is not much overhead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

