Return-Path: <linux-pci+bounces-8285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A468FC4AA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0912832FD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66518C331;
	Wed,  5 Jun 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNPPrBCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577396A03F;
	Wed,  5 Jun 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573013; cv=none; b=IvwTDyWsjz8iyhSFhDIOyj5A7STzGreZaKnlLeeKpt66IJ50TzGMShNAJtbRM0z0U14ZPKn0avDcrQTPEtsJ1Jeg22uXI3nMIJ8fp2pVcR12sR7q70ZhNs6j4+5wD1mC39n0vrmE00esLJGIBEY+3Fac5SNWmew9LvLvQAKjchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573013; c=relaxed/simple;
	bh=DQJTe2Ght4na0MugFgxDTyVIKpzB8sCXy6NbZn7Uafs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NotXA8nf9/R+dblD2OjLhmLTimTAMPxcMuQ+vO46r3S6fQroZG9paamf/CZ7TpzfDjkmtymf0LB4YWyzhZIZX/HLngelp8X9ZOYdByb5SlPz2MSMX7MSIg7lajE9V6s5MyBvfKEc8YcRfPl5uwaiomLFKUy6OF+i9lWo4dYdyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNPPrBCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CFC3277B;
	Wed,  5 Jun 2024 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573012;
	bh=DQJTe2Ght4na0MugFgxDTyVIKpzB8sCXy6NbZn7Uafs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNPPrBCT0Coo9vD/2NLylNzEPGebbKwq9YFg3ZoTeW/Zzve+4eGTpfqHoHRAHotD2
	 L7OQq+W+Krw9HfMLaCgQ0tlZP0Tw3xYvGEYLBCXlHoLihW2PN+jQbYUhFueG0wHMfB
	 lAXMQumUWnAKPVVRbf79m7LzULBO7wQc1m5dczfLpoVKzgSKlZColaq1liSv4hQtKm
	 WWZg9NQVEHvlAp1+kRCzZBXXQcnQKvIgrQadTpv/snncrWzRPMdG+Wg1NCEms3NInb
	 XxooNhB8yzbSngjFYGa/6jVFztbnFiYTmoM5O9D0ncLRCpKhF74YwxRZwKNLODmJvw
	 mGsHAQMGFFCEA==
Date: Wed, 5 Jun 2024 13:06:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 05/13] dt-bindings: PCI: rockchip-dw-pcie: Fix
 description of legacy irq
Message-ID: <20240605073640.GG5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-5-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-5-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:28:59AM +0200, Niklas Cassel wrote:
> The descriptions of the combined interrupt signals (level1) mention
> all the lower interrupt signals (level2) for each combined interrupt,
> regardless if the lower (level2) signal is RC or EP specific.
> 
> E.g. the description of "Combined system interrupt" includes rbar_update,
> which is EP specific, and the description of "Combined message interrupt"
> includes obff_idle, obff_obff, obff_cpu_active, which are all EP specific.
> 
> The only exception is the "Combined legacy interrupt", which for some
> reason does not provide an exhaustive list of the lower (level2) signals.
> 
> Add the missing lower interrupt signals: tx_inta, tx_intb, tx_intc, and
> tx_intd for the "Combined legacy interrupt", as per the rk3568 and rk3588
> Technical Reference Manuals, such that the descriptions of the combined
> interrupt signals are consistent.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index 60d190a77580..ec5e6a3d048e 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -56,7 +56,8 @@ properties:
>            pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
>        - description:
>            Combined legacy interrupt, which is used to signal the following
> -          interrupts - inta, intb, intc, intd
> +          interrupts - inta, intb, intc, intd, tx_inta, tx_intb, tx_intc,
> +          tx_intd
>        - description:
>            Combined error interrupt, which is used to signal the following
>            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

