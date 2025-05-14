Return-Path: <linux-pci+bounces-27678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C05AB634F
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D2C7AB1D4
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CB202C3E;
	Wed, 14 May 2025 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApOhuhEu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE481FE470;
	Wed, 14 May 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204782; cv=none; b=az9MEiqJOa6D06LWL2mqYUCpcm2BfasCVepWRc0OqbohCJ/lllC65GCn0Mqy8gbWxx1wa+AqITQmR8nxXy20nBloXBYekLADczKyLh3hC86FPIySJOEORDW5PcvRvOh8RSHhb2QN0TaE/47AIfQ1mij1x4g4Amwcn3GedqsPyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204782; c=relaxed/simple;
	bh=dLPnyVUsbA+rtCJMIW6m9OfctifOEzbCmjQWykaELdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU8/p2ye2vzBC43Ju84jF1L9JRw2Fcb6UzqZIMAetr7umiL5tdklTwnc+gpTgFJ+qfppZib2MuRpcOcu+Y69aJJx++nc1oSlOkogeXpVHKtA/REKQF/5Wj5XpzcAvP+xxhfg1LseDTs94weyoayoaARSHjQ54TZnzEK/XkLe1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApOhuhEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D9AC4CEE9;
	Wed, 14 May 2025 06:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747204780;
	bh=dLPnyVUsbA+rtCJMIW6m9OfctifOEzbCmjQWykaELdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ApOhuhEuDmYEwqlYD7YTcY7XBW03QADe1CXb2AIDTCM5K6qqNkLQHPl+K6EStB7Nu
	 LSVAz1lF7tmMH3CXj8T+tnxp344EKktRPOP6T6OqNML3TRHf/ak2iytL0NpM4t8y4c
	 vDASdz+Ds6U/ikxD1tls9K8UoyxgAtdMMls7bgFvWSDqq2C35gYSLLmFh7/L6vuyTT
	 sks9k9MhdTV0nx5MtSH5wk35Rcm63PaNFk8AhIaLwiqbNoCW4DCfdOU8Hbm2CeRhZU
	 /mGclfsrNqaVuF7zr7ULuQtpwZM3fCma/5dj9rGvoz6bOR4Z2NVAG8FiqBdHpEhYVC
	 KnRF2lU7SbqYQ==
Message-ID: <a5c3efbc-89a4-45c5-a14c-d0c0fd2e232c@kernel.org>
Date: Wed, 14 May 2025 15:39:31 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] PCI: endpoint: cleanup set_msi() callback
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable+noautosel@kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20250513073055.169486-8-cassel@kernel.org>
 <20250513073055.169486-12-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250513073055.169486-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 16:30, Niklas Cassel wrote:
> The kdoc for pci_epc_set_msi() says:
> "Invoke to set the required number of MSI interrupts."
> the kdoc for the callback pci_epc_ops->set_msi() says:
> "ops to set the requested number of MSI interrupts in the MSI capability
> register"
> 
> pci_epc_ops->set_msi() does however expect the parameter 'interrupts' to
> be in the encoding as defined by the MMC Multiple Message Capable field.
> 
> Nowhere in the kdoc does it say that the number of interrupts should be
> in MMC encoding.
> 
> Thus, it is very confusing that the wrapper function (pci_epc_set_msi())
> and the callback function (pci_epc_ops->set_msi()) both take a parameter
> named interrupts, but they both expect completely different encodings.
> 
> Cleanup the API so that the wrapper function and the callback function
> will have the same semantics.

Same comment as patch 3. Mention the semantic the patch implements.

> 
> Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

A few nits below, but other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 4 +++-
>  drivers/pci/controller/dwc/pcie-designware-ep.c  | 3 ++-
>  drivers/pci/controller/pcie-rcar-ep.c            | 3 ++-
>  drivers/pci/controller/pcie-rockchip-ep.c        | 5 +++--
>  drivers/pci/endpoint/pci-epc-core.c              | 5 +----
>  5 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 78b4d009cd04..f307256826e6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -220,10 +220,12 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  	clear_bit(r, &ep->ob_region_map);
>  }
>  
> -static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
> +static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
> +				u8 interrupts)

To be extra clear, I would rename this num_interrupts or nr_interrupts. No
confusion possible with such name.

> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index 9da39a4617b6..b25ad23bedb7 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -261,10 +261,11 @@ static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>  {
>  	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
>  	struct rcar_pcie *pcie = &ep->pcie;
> +	u8 mmc = order_base_2(interrupts);

Same rename suggested here and for the other drivers.


-- 
Damien Le Moal
Western Digital Research

