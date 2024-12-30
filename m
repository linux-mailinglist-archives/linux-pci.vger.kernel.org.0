Return-Path: <linux-pci+bounces-19102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18F9FEA49
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E827916286D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822814B088;
	Mon, 30 Dec 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfp+sQw+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4EEAD0
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586353; cv=none; b=toZRk4OsSbM3777l0y2kimPWoTVEGEwjM36PL5bnAksq3RwPExbGr759jLA0PcMAMHuoVL7wN1oP441enEeWdXd3E3b7pDi1EH6QLQul5PL7XtAYLP9VJJ5Q3BdrvQkd7sRnpg2xJveIYE+ATZFpFrm370Uhy3pPfz+zz1CefiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586353; c=relaxed/simple;
	bh=X0EYxHXdyVdmOPGxViBjSU30WP05CYZbb75sYLlIZak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o24n9JzbLuvRZERjKS2Nqe7Sbfki31tj/bZ+ERXvCqPNRzRwV2K5iaxoaw5yYrWkT8gOHmO3zFroFCWSeiPfkPhhY1M0cqTexMVIsA25h1HH73GeIiC9euOMTJgwOEEAAs8iKaet/HLJBcysocq8glvCd7pspKPScmp4IelPWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfp+sQw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413F2C4CED0;
	Mon, 30 Dec 2024 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735586351;
	bh=X0EYxHXdyVdmOPGxViBjSU30WP05CYZbb75sYLlIZak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kfp+sQw+92xxFfPP5xyPzMvbLdqPXLOBdfm2btiHhnRSOn0NYolCFg2fwL3XgQKAn
	 xOicRxgCm/GJGDPPlA1icF7IXRfYE3/nsC96+2jqRnp0hGqo/2o8XSdbIH8kkhZ+33
	 U1CoYnr/nl19EduvPnO71DJYp0UQXyjA9EBs6V4jlbqZy0OPscozdhA1+EY+Ga0x6b
	 WYGDj60Nbj+wHpFf4LJVXkjQJ6xuTHhNAoUcn6kMqhgAtq4wWxVhi89CWGlv9RjWY/
	 eP6dAw6YUK2CzEUT5rGbij5l0zqVspX8PEGFSmy7GEeo4znW1yORMYIQQzn0bxg/Sr
	 v79iM6hEOHZsQ==
Date: Mon, 30 Dec 2024 13:19:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <20241230191908.GA3962801@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127145041.3531400-2-cassel@kernel.org>

On Wed, Nov 27, 2024 at 03:50:42PM +0100, Niklas Cassel wrote:
> Most boards using the pcie-dw-rockchip PCIe controller lack standard
> hotplug support.
> 
> Thus, when an endpoint is attached to the SoC, users have to rescan the bus
> manually to enumerate the device. This can be avoided by using the
> 'dll_link_up' interrupt in the combined system interrupt 'sys'.
> 
> Once the 'dll_link_up' irq is received, the bus underneath the host bridge
> is scanned to enumerate PCIe endpoint devices.
> 
> This commit implements the same functionality that was implemented in the
> DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
> endpoints based on Link up event in 'global_irq' interrupt").
> 
> The Root Complex specific device tree binding for pcie-dw-rockchip already
> has the 'sys' interrupt marked as required, so there is no need to update
> the device tree binding. This also means that we can request the 'sys' IRQ
> unconditionally.

Thanks for doing this!

> @@ -436,7 +481,16 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
>  
> -	return dw_pcie_host_init(pp);
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	/* unmask DLL up/down indicator */
> +	rockchip_pcie_writel_apb(rockchip, 0x20000, PCIE_CLIENT_INTR_MASK_MISC);

I know we already had a bare 0x60000 in rockchip_pcie_configure_ep(),
but can we add #defines for both of these PCIE_CLIENT_INTR_MASK_MISC
bits?

