Return-Path: <linux-pci+bounces-44094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC0CF7FF4
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 12:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AFF830376BF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C9326938;
	Tue,  6 Jan 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1K0/H+X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416131AABC;
	Tue,  6 Jan 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698188; cv=none; b=gErKgHZ4vyVqqHvLOOp8bJs90wupE12lvJ0Nw5FUKkWBTNaoXnD+pOcVPn0iT/c8J613pCeMsgFr7tDzKI1yYyyge+tVwowtBywzCIQaMNY/4okoNGGYGiR01B2NScNMUy7ex9NB00IOqjxPTLHSe5/Jp+zaKdMdyLNlMbyort4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698188; c=relaxed/simple;
	bh=KAZTfW562W1oYvg6yLMZiwveTP/LAQQ3kkh1Vqc/32Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZsELDpu6nrX91Tk9EEov0VYE7hskRopsDsT1vcOxmB7K7lWnJC0pKfyj2oVdM8M33f6VZ5L9oB7hwAsNT12f/GOGiQTnyHg6VlT+u+XwgyvbzIlRjbBLTKCBgMX+ymIajr0ZJmeiqcs1rhLxpZbM4vVJakkHjOqWWoSx7RJGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1K0/H+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528DEC116C6;
	Tue,  6 Jan 2026 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767698187;
	bh=KAZTfW562W1oYvg6yLMZiwveTP/LAQQ3kkh1Vqc/32Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1K0/H+XpY/nY87i0BbOhrc0NiRe8qTneWo9Kclay0A+/ZiYEVXM8rM2Ru8hsNf8y
	 PxNWW770aUY0dfnswiMYnNUyiXyMopWxWKymiXrW+XiA+s5Y09ERidRRZG782OYHhD
	 4chf+I3fc+I8JmctmpRXqsR1iNYjVBnbR4j2HQFYpy59lZTrFG7rUnvWhWWj//5go4
	 LXdUEq9t2WGgtOv7/a88UHej4y9EJJGE/vb9oors6pxeMGccynmmEkVG5rYPDW4Rsq
	 79BH7p4Wrb3LzWNxaEbPknCyslDbxH1Y7TENlLw78noR/6XK39CD77/BuMLy05qqQB
	 oJUN+EE7CvPnw==
Date: Tue, 6 Jan 2026 12:16:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dwc: Add multi-port controller support
Message-ID: <aVzvANWTavhabhEB@ryzen>
References: <20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com>
 <20260105-dt-parser-v1-2-b11c63cb5e2c@oss.qualcomm.com>
 <aVvkmkd5mWPmxeiS@ryzen>
 <m5ukeugo2lazipljqpubyvm7j3xk2j5o7i2xgdbkkhii57xmyk@lh32qdzjhe4n>
 <aVzqMqTUWIuKhgmC@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzqMqTUWIuKhgmC@fedora>

On Tue, Jan 06, 2026 at 11:55:46AM +0100, Niklas Cassel wrote:
> For iterating, to avoid manually traversing the array, we could do like
> libata and create a simple macro, e.g. ata_qc_for_each():
> https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libata-eh.c#L851-L854
> https://github.com/torvalds/linux/blob/v6.19-rc4/include/linux/libata.h#L1657-L1659
> 
> And at least personally, I think my brain will parse dw_pcie_port_for_each() { }
> faster than it parses list_for_each_entry(port, &pcie->ports, list) { },
> since it is more unique, but perhaps I am the weird one here :)

Or... for_each_dw_pcie_port()

We also don't need to supply an integer to the macro, we could do like e.g.
for_each_nhlt_endpoint():
https://github.com/torvalds/linux/blob/v6.19-rc4/include/acpi/nhlt.h#L63-L64

which has does "for (unsigned int __i = 0; " in the macro.


Kind regards,
Niklas

