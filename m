Return-Path: <linux-pci+bounces-44127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF2CFB125
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 22:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618EC30519CC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492042F747F;
	Tue,  6 Jan 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ/EMUWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4F296BBF;
	Tue,  6 Jan 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734230; cv=none; b=ct7l0FEIOZOj1Z8y1kphmDowpNanySuv6cbFplLli4eAAELFpXQ4RPv9ENsdkj/mqrbmCTV5z7BXxE+/k8Ttcdjdk9kN/0XOJ2wbgGzguqMlehz0trKnpcRTXPSA06m0Uoe1zzYnafeor5REEme3svsjkbIk6f8nWgjGDL9WjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734230; c=relaxed/simple;
	bh=QLjWo0t79X6kihc/yxh2M5ASDv7kRQJ7SHHK2+hjnB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi9ezBw5q1oSh7K5QqeptwMjyYy7QsFLuJvfPGvbDuEgI6R8sFfZtLsAJgxoDHXgKbcHQEHVn5zmwH8esSJy70EZL2sgkSAw8P4nf98MXCY+wRUyFEm/BuXURN+WAdVYzb7mkZJwXKYIDQi+/T8Qa3BhY5RCukyud2yGwktM41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ/EMUWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654D4C116C6;
	Tue,  6 Jan 2026 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767734229;
	bh=QLjWo0t79X6kihc/yxh2M5ASDv7kRQJ7SHHK2+hjnB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJ/EMUWx5xOJ6jpzJjm0a8IJNcQXZ0IMgt5F25rQqG1hlEHkjqG5BZPoexNzSRB8n
	 ICw7PV+KEBh86ODxQ5AoDVhaagYgn4YkBkB7CinZ0kCJNIsvVJNgoQ24oai3nms+oY
	 DGjicaEv3qk8rwdLUAR52lasyYpCOLODRpkmPpw8N9jw46UqQsJ4dN1c+wRHkh4w0w
	 vAWV3JJqa5D5ZWBys99/vUGTlSTYxtlq91mFh/GizjZCkTWeLyK7i0hMO9WYJMcptw
	 bYIqbO0v07rxEjX/JKZpJcj9Gb/MCwfYETeSB1I2AacmE+ZRsN55wlYVEi1ec6R8lK
	 z4a5G4ksV4N9Q==
Date: Tue, 6 Jan 2026 22:16:56 +0100
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
Message-ID: <aV17yIhuOFLGYi8r@fedora>
References: <20260105-dt-parser-v1-0-b11c63cb5e2c@oss.qualcomm.com>
 <20260105-dt-parser-v1-2-b11c63cb5e2c@oss.qualcomm.com>
 <aVvkmkd5mWPmxeiS@ryzen>
 <m5ukeugo2lazipljqpubyvm7j3xk2j5o7i2xgdbkkhii57xmyk@lh32qdzjhe4n>
 <aVzqMqTUWIuKhgmC@fedora>
 <5gne3bureusi45sy4zqr2zrfvt4ba4uxgnsfdnjeh2eno5zspe@ldvhq2nilsan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5gne3bureusi45sy4zqr2zrfvt4ba4uxgnsfdnjeh2eno5zspe@ldvhq2nilsan>

On Tue, Jan 06, 2026 at 06:41:09PM +0530, Manivannan Sadhasivam wrote:
> > One advantage I can see, instead of doing:
> > 
> > +	struct dw_pcie_port *port = list_first_entry(&pci->pp.ports,
> > +						struct dw_pcie_port, list);
> > +	return dw_pcie_wait_for_link(pci, port);
> > 
> > for drivers with only one port (most drivers), we could just instead do:
> > 
> > +	return dw_pcie_wait_for_link(pci, pci->pp.port);
> > 
> > To simply get the first element in the array. No need to sprinkle
> > list_first_entry() everywhere in all the drivers if they just have one port.
> > 
> > 
> > For iterating, to avoid manually traversing the array, we could do like
> > libata and create a simple macro, e.g. ata_qc_for_each():
> > https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libata-eh.c#L851-L854
> > https://github.com/torvalds/linux/blob/v6.19-rc4/include/linux/libata.h#L1657-L1659
> > 
> 
> I specifically do not want to introduce custom helpers. That's one of my primary
> motivation for using lists :)

You are the maintainer.

IMO it would still be nice if we could avoid sprinkling:

+struct dw_pcie_port *port = list_first_entry(&pci->pp.ports,
+                                             struct dw_pcie_port, list);

all over the glue drivers somehow, especially those that will only have a
single port. Perhaps by introducing a macro?

In case you don't like the idea of introducing a macro to get the first
port...
Since most glue drivers only seem to use the port when calling
dw_pcie_wait_for_link(), perhaps we could introduce an alternate version
of dw_pcie_wait_for_link(), that can be called by glue drivers that only
have a single port.


Kind regards,
Niklas

