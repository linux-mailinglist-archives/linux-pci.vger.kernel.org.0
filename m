Return-Path: <linux-pci+bounces-27680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB05AB635F
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464D81B40A6C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B920103A;
	Wed, 14 May 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNh8vQSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072161F6667
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205004; cv=none; b=E5LTNkO0gHmPXAXLE13hJE1RQzSfxFPo5xBQK5t+f5H32a6UbHmf5SbPNvpdWexEY/KfgQ9EIfVU/vfOsDWM41KIIt0Ey45K9s89eUyZSbypsqQZvDX2Y2JfFD+/LUjnqgekyn1kV9B2YMurdWKouj7svm8Ok6ostCeW5y4huMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205004; c=relaxed/simple;
	bh=HU309RTzi1NeUVsfWMPzP89UTFkzAZbuQV9Penc4cuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkQyKYIYVFdbfRiM7hssnWoe3irNaCtBENFz8O8WFBaRmyaxhnvOwtHH8OK+fdUL5KghxQqEXNCjYFgOc8J/KBhlBrL4EPJ8GWEHrRhVvoBWt74CSLqCCSz9fqZn+rfichQV5N6ToGQ4P8IriYcuvJNsa4Jd0BkS1lJOS/lNet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNh8vQSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33965C4CEE9;
	Wed, 14 May 2025 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747205003;
	bh=HU309RTzi1NeUVsfWMPzP89UTFkzAZbuQV9Penc4cuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNh8vQSvBd8eNlJ8OBqEL+3RCeSrotCySD/bgRNLSEjp374xjHXugpvvTJx9uma5V
	 0w9LDf5pCseT6BAQp/dVfPHYNuQAdNglb/3GOIJ4tnsLITi4c3sCAo5XxBHQxheMKD
	 3CmD5aBB4qdAyg3iOqkWoAvlDURR6eI5xa6A0B9aGdHhQrsGv97u4OLTAXhb60rUpD
	 KUC0hd6ZoX84lJdgoNN20nl2JiTVTJIz4GPBz1zE7CUzNhkH78XileRGXvP2k//f7K
	 kzXSpRQOqOtPHCwBY9J4LejF92nJo0UL6jTRGouUY2VtYqG5YZ031KlEwCmwHeKi4c
	 +PR7FIfogILzA==
Message-ID: <4d9ea518-b649-4bfc-8c3f-42365cc86a0e@kernel.org>
Date: Wed, 14 May 2025 15:43:16 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] PCI: endpoint: cleanup set_msix() callback
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable+noautosel@kernel.org,
 linux-pci@vger.kernel.org
References: <20250513073055.169486-8-cassel@kernel.org>
 <20250513073055.169486-14-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250513073055.169486-14-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 16:31, Niklas Cassel wrote:
> The kdoc for pci_epc_set_msix() says:
> "Invoke to set the required number of MSI-X interrupts."
> the kdoc for the callback pci_epc_ops->set_msix() says:
> "ops to set the requested number of MSI-X interrupts in the MSI-X
> capability register"
> 
> pci_epc_ops->set_msix() does however expect the parameter 'interrupts' to
> be in the encoding as defined by the Table Size field.
> 
> Nowhere in the kdoc does it say that the number of interrupts should be
> in Table Size encoding.
> 
> Thus, it is very confusing that the wrapper function (pci_epc_set_msix())
> and the callback function (pci_epc_ops->set_msix()) both take a parameter
> named interrupts, but they both expect completely different encodings.
> 
> Cleanup the API so that the wrapper function and the callback function
> will have the same semantics.

Again... :)

> 
> Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

A nit below, but looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 ++---
>  drivers/pci/controller/dwc/pcie-designware-ep.c  | 5 ++---
>  drivers/pci/endpoint/pci-epc-core.c              | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index bbb310135977..542533a8c56a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -294,14 +294,13 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>  	u32 val, reg;
> -	u16 actual_interrupts = interrupts + 1;

Again suggest renaming interrupts to num_interrupts or nr_interrupts to avoid
any confusion.


-- 
Damien Le Moal
Western Digital Research

