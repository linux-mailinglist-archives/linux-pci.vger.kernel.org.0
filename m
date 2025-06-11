Return-Path: <linux-pci+bounces-29439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB9AD55BC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7707F167817
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E38274FDE;
	Wed, 11 Jun 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWbC0asS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5759253F08
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645514; cv=none; b=c33pYLepJaTRXEtbWhLO2uN3M6t+gYY32JCjZUJULu6tjm1s/jqgQJoity/EJz+lz0xaOzKZc0vVo4+XD5Kf7Ng5kQrdDE+lrhjMMLKEPsihYAZU1lChotL+RbjZEawEspDxTpUn75MA0665LLmkX7pFWUGxH4opvPIQ64MZfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645514; c=relaxed/simple;
	bh=/MOf/oEHsGPsUchouM2t6kOTUEC8T4zBTp5M261WavM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ro6TnwCB54n82UU67zdARMjRgFMLTN4G+Bi64fvdYYRsFfs65+MHoqmZNzYIopL5nTU8FR0/tSBOh8E+0jRjdn4kbjLophXxrVnGIXzCkhzJ9izjATYy5Vm2OSEstj7KwlxFzMfytTH6bsFYa7e74oC7/kFGEIOY7jxFr62B2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWbC0asS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD5BC4CEEE;
	Wed, 11 Jun 2025 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645513;
	bh=/MOf/oEHsGPsUchouM2t6kOTUEC8T4zBTp5M261WavM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZWbC0asSw6Fskh/euwqE7EVnhzLptG51gNlFsKlKEGX06o5xGZNS/PYjM9CcnJOtq
	 pVZRMyEEutxveEAIvKr56zGNQD+iKcmqK3l28w/rqepv0vQtzLmxR2IXpjiLTqZB0n
	 pbPFfSF9oBeMqv17b6KgWWQzKRzzm8o8+72SGmGRKj4D4wfRSiYIp08sJP2+c1JGqU
	 dFsJjHuWmLNZt/NTPEA5WWrgRKE7hcEye0t4qclbV6Gj+fZ+QOj7adnBUBFV8H78Ui
	 rSv0pxTf1btKSjKbtGJjoXEm8ikMbB6T+Xn1FrfhNBppF5I6w1U3q67t/gOikpLNe7
	 apIyJ673du9pQ==
Message-ID: <bf1edd8b-cfe4-4ad1-b001-c4297047f9c5@kernel.org>
Date: Wed, 11 Jun 2025 21:38:31 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
References: <20250611105140.1639031-6-cassel@kernel.org>
 <20250611105140.1639031-10-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250611105140.1639031-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 19:51, Niklas Cassel wrote:
> There is no reason for the delay, in each loop iteration, while polling for
> link up (LINK_WAIT_SLEEP_MS), to be so long as 90 ms.
> 
> PCIe r6.0, sec 6.6.1, still require us to wait for up to 1.0 s for the link
> to come up, thus the number of retries (LINK_WAIT_MAX_RETRIES) is increased
> to keep the total timeout to 1.0 s.
> 
> PCIe r6.0, sec 6.6.1, also mandates that there is a 100 ms delay, after the
> link has been established, before performing configuration requests (this
> delay already exists in dw_pcie_wait_for_link() and is unchanged).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 11 ++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index dbb21a9c93d7..8ef1e42b7168 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -701,7 +701,11 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	u32 offset, val;
>  	int retries;
>  
> -	/* Check if the link is up or not */
> +	/*
> +	 * Check if the link is up or not. As per PCIe r6.0, sec 6.6.1, software
> +	 * must allow at least 1.0 s following exit from a Conventional Reset of
> +	 * a device, before determining that the device is broken.
> +	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (dw_pcie_link_up(pci))
>  			break;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..52daf9525bae 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -62,9 +62,14 @@
>  #define dw_pcie_cap_set(_pci, _cap) \
>  	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
>  
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_SLEEP_MS		90
> +/*
> + * Parameters for the waiting for link up routine. As per PCIe r6.0, sec 6.6.1,

s/for the/for

and maybe reword this to something like:

* Parameters for waiting for a link to be established.

> + * software must allow at least 1.0 s following exit from a Conventional Reset
> + * of a device, before determining that the device is broken.
> + * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
> + */
> +#define LINK_WAIT_MAX_RETRIES		100
> +#define LINK_WAIT_SLEEP_MS		10
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

