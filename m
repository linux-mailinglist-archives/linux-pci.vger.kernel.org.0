Return-Path: <linux-pci+bounces-27086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E4AA6B26
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 08:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC9198545D
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 06:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EF266B7D;
	Fri,  2 May 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ+518aa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4A266B5C;
	Fri,  2 May 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169146; cv=none; b=dKrM1n3Pnr9hS2B1O+aKjVQD1WKucP2BJy2NjohSdeQuvpXQSWgWd7ak7NumtVB9vVjfWWxaNyEPs+hAdKtJMTE+Fyq9Cry7GHy+qTLaBlgUo7fb/HgiIGjT+QrR7GNDcGrAGvFmks9c0s7k3/vIWvH6WmcNkDPgghGBM2+Z3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169146; c=relaxed/simple;
	bh=6sClcWYGukBbkpULYb0l3opl4yAyv99xyShFUXuykaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJKgwe1ZzcR45TzPZJx7TQGPU+CI/EVg9qvfKul1fiDFeabXfG74ElzA+ZC6erb9tYhYs4dY6zn7q72GROieZpMLeAH6Sggy5Ckq6Qpaw5vWLMX7iVDW9GOK//Jhng9RsiB9Pjqtf5JJ72G8fOrSl1iAhetXWEd6BTyn+HIq+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ+518aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E737C4CEE4;
	Fri,  2 May 2025 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746169146;
	bh=6sClcWYGukBbkpULYb0l3opl4yAyv99xyShFUXuykaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZ+518aayrvUeQVuipI53moncuZzz4Ed/Dxji11skD7ZoU/b8gOmjfcFisHFnOejD
	 2H5xYuuxFMt83VfJdsM7XgiERYCLpi+Vp7GPfHA9/+FVKOMljmLiY8ZpT6e/iKg7wJ
	 nizYqciu1F9qXd4WqTODYU2hO5nO8p7Tr2SM3InYqL1ZXhj48gc2MHuwECjTbfWsSE
	 nxl0K8UkWJ+BABy1L3v4uOSlh1iyZZ7HEgsGwd+N3IkkBZvgbSi8bl0oBeX9CNQqF/
	 vE/ksOsT8chgpOzjxV3Qp8JItztaXuCleeQfhQHliip5rBU/ZMNjodJXuwNkE5CpKp
	 dWtzAxdeOe4nw==
Date: Fri, 2 May 2025 08:59:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2] PCI: dwc: Add support for slot reset on link down
 event
Message-ID: <aBRtNOLQ6R-5iOB4@ryzen>
References: <20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com>

Hello Wilfred,

On Thu, May 01, 2025 at 11:57:39AM +1000, Wilfred Mallawa wrote:
> @@ -688,6 +699,79 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> +				       struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = bridge->bus;
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	struct device *dev = rockchip->pci.dev;
> +	u32 val;
> +	int ret;
> +
> +	dw_pcie_stop_link(pci);
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);

Sorry that I didn't see/mention this earlier, but the order which we deinit
things should be the reversed order of how we initialized things.

(i.e. it should match the ordering of the error path.)

In both the error path of this function, and the error path of
rockchip_pcie_probe(), we do deinit_clk before deinit_phy, so I suggest we
do the same here.


Kind regards,
Niklas

