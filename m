Return-Path: <linux-pci+bounces-19250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9539A00DAF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E959218849B4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AF1FC0E0;
	Fri,  3 Jan 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx0pQfwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E11B87FE;
	Fri,  3 Jan 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929331; cv=none; b=rAh27/etoJU+5vwHzgrmR/sSE7qtWkSFJO3Auke7X8bApFQGg57SXJk3sTKTmmixZNKYs5FRpI6VKlDrniF9F0uab+K0bzG4UaflBIZG5FY5Jx2EcP1IYucRVWnH5F/rGxkLJGxa+X98rzX2jbxsMJwSm0DWJvk/Ssi0LVwy5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929331; c=relaxed/simple;
	bh=ibvW79eXJj9bVQweOC7IEhp7Vlli+LtSmdXNdcq9QEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MvfCqk/qfWrqMAtTra/qzGGr/yH+Qdo1pGRSvdblzzSWh67PjXjtTsfOiXle2atLOYyvbcMlMhBGZZSYZul6Uc3CwaxPUSrcSXDkBKKanb2wtvn5RtqoJHo3bz/L1X3pTOudO8tAVk8trYWjJKuUsGd3glAT/oo87wHixS+3B08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx0pQfwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91611C4CECE;
	Fri,  3 Jan 2025 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735929330;
	bh=ibvW79eXJj9bVQweOC7IEhp7Vlli+LtSmdXNdcq9QEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xx0pQfwXe3nUi4AxSJKfgoGsj5s6dtkSTxO4cKrT/aqGtOb4X5McUGs04OaP1J7jU
	 2Xzu+QBsX6tTThEl7PjqQJRaWR+7pK5SPuYLSD6KzojpMq6cEm2sAtoq3A3cMSDV5Z
	 mIDzYbT5B66q2E8FftvyNQ+4Q7KxYjxE1nK56uoiR1WyvKcpG7Up2IPTHERS31ACx2
	 23wT8S3lC8frjB3fEExs5/7S8OurliP6NnsoUsCyNp0KdWuMF0mu6knHOl7EUGNK6/
	 R6i6wMJYJfRLgfuWXZlcDkp8Pmv0O3P5bCqdCEyWlkovWtWDfNfizggj+C0x/4I/x7
	 o8iNiXs6XXmQQ==
Date: Fri, 3 Jan 2025 12:35:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
Message-ID: <20250103183527.GA3959656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-pcie-en7581-fixes-v5-5-dbffe41566b3@kernel.org>


If you repost this series, here are a few comments/typos.  Otherwise
we can do the trivial updates on the branch.

In subject: this patch doesn't *add* a delay; it *moves* it.

On Sat, Nov 30, 2024 at 12:20:14AM +0100, Lorenzo Bianconi wrote:
> Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> causing occasional PCIe link down issues. In order to overcome the
> problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
> REG_RESET_CONTROL (0x834) registers available in the clock module
> running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().

Add parens after clk_bulk_prepare_enable.

> In order to make the code more readable, move the wait for the time
> needed to complete the PCIe reset from en7581_pci_enable() to
> mtk_pcie_en7581_power_up().
> Reduce reset timeout from 250ms to the standard PCIE_T_PVPERL_MS value
> (100ms) since it has no impact on the driver behavior.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/clk/clk-en7523.c                    | 1 -
>  drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 22fbea61c3dcc05e63f8fa37e203c62b2a6fe79e..bf9d9594bef8a54316e28e56a1642ecb0562377a 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
> @@ -393,7 +393,6 @@ static int en7581_pci_enable(struct clk_hw *hw)
>  	       REG_PCI_CONTROL_PERSTOUT;
>  	val = readl(np_base + REG_PCI_CONTROL);
>  	writel(val | mask, np_base + REG_PCI_CONTROL);
> -	msleep(250);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 01e8fde96080fa55f6c23c7d1baab6e22c49fcff..da01e741ff290464d28e172879520dbe0670cc41 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -977,6 +977,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  		goto err_clk_prepare_enable;
>  	}
>  
> +	/*
> +	 * Airoha EN7581 performs PCIe reset via clk callabacks since it has a
> +	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> +	 * complete the PCIe reset.

s/callabacks/callbacks/

> +	 */
> +	msleep(PCIE_T_PVPERL_MS);
> +
>  	return 0;
>  
>  err_clk_prepare_enable:
> 
> -- 
> 2.47.0
> 

