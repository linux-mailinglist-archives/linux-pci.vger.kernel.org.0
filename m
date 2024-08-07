Return-Path: <linux-pci+bounces-11451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5F94ADB4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D884D1F21315
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102BC83CD9;
	Wed,  7 Aug 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhbY3tr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA950126F1E;
	Wed,  7 Aug 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046911; cv=none; b=jLLU9FFX/ayaeX0OPxPw9hKZ0YTzJGC8o/yffolprUgDr0+S1FYF/WJOeDYbLltLhqQavVP36c45mytyvjPqxMgep/TP4LhkdgFWWcie+Uhz6hALRot+0Il0Yvf95euNIko3btgEtqHN7bVsVHMlJzLGIq/IZAvOIWk2/xGMd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046911; c=relaxed/simple;
	bh=I/U03uJ5GHL/Z34bxPDSEvBc5UJaMZBDCl3d2gUM7c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Az3lmeVkSjB6BANfbwLceROAj7fBqaTp1P3wt8iLDoz5zjgRdmspzyB08vSuLVEAqZAwEZaRb1ccSRcNRJy0AlOQphldHXsvhd+FEVKEF1FV+BMfxdNHJAmJBV6fNUEsowv2yIhhLxaK5Ed6zkHEdYRShFhIvMYfoI4/0a/W2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhbY3tr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A3C4AF0B;
	Wed,  7 Aug 2024 16:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046910;
	bh=I/U03uJ5GHL/Z34bxPDSEvBc5UJaMZBDCl3d2gUM7c4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FhbY3tr3lhTUMIQjhcET/RJiZ7ghbW0Txn1WMOWmLgGgeV7FMZsqq9wD9RS+QVA8Q
	 y+y/JDfU8jrUTXJxbyqqBIV7dapPY0cEvfQFCd2/g7+IOgMOOpqpHBWbNtKmJwDbRJ
	 28nDLwAi/SVNwow+86xTOx1F7yA72Z6zU908uSrY9VCO8A/uFz9Sbxd/keTdaeZ8u0
	 WwrpVIhNpIcFoQwK7Kl4sPwnxpQ14h8eCHXwN2mF0zIbFq61BQcHnvn4XOoi/AMxsx
	 QSIWrnlQ9TG8mahrnFz7bmm8r8IlLouRbC+f7SU5JceA4yI7Yi8LWekiZTgmQCOEQS
	 eIjTGHQTjfY8g==
Message-ID: <7a44e4cb-9f91-47e3-badc-8c6d406d1ea0@kernel.org>
Date: Wed, 7 Aug 2024 09:08:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch
Cc: alberto.dassatti@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806162756.607002-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240806162756.607002-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/06 9:27, Rick Wertenbroek wrote:
> The test for a DMA transfer was done in pci_epf_test_cmd_handler, which
> if not supported would lead to the endpoint function just printing an
> error message and waiting for further commands. This would leave the
> host side PCI driver waiting for an interrupt because the call to
> pci_epf_test_raise_irq is skipped. The host side driver
> drivers/misc/pci_endpoint_test.c would hang indefinitely when sending
> a transfer request with DMA if the endpoint does not support it.
> This is because wait_for_completion() is used in the host side driver.
> 
> Move the DMA check into the read/write/copy functions so that they
> report a transfer (IO) error so that pci_epf_test_raise_irq() is
> called when a transfer with DMA is requested, even if unsupported.
> 
> The host side driver will still report an error on transfer thanks
> to the checksum, because no data was moved, but will not hang anymore
> waiting for an interrupt that will never arrive.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 29 +++++++++++++++----
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53a..bd4b37f46f41 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -314,6 +314,17 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>  		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
>  }
>  
> +static int pci_epf_test_check_dma(struct pci_epf_test *epf_test,
> +				   struct pci_epf_test_reg *reg)
> +{
> +	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> +	    !epf_test->dma_supported) {
> +		dev_err(&epf_test->epf->dev, "Cannot transfer data using DMA\n");

While at it, can we change this message to be clear, e.g. "DMA not supported".
"Cannot ..." is vague and does not state the reason why it cannot be done :)

> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> @@ -327,6 +338,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
>  		dev_err(dev, "Failed to allocate source address\n");
> @@ -423,6 +438,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!src_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
> @@ -507,6 +526,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!dst_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
> @@ -647,12 +670,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	WRITE_ONCE(reg->command, 0);
>  	WRITE_ONCE(reg->status, 0);
>  
> -	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> -	    !epf_test->dma_supported) {
> -		dev_err(dev, "Cannot transfer data using DMA\n");
> -		goto reset_handler;
> -	}
> -
>  	if (reg->irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;

-- 
Damien Le Moal
Western Digital Research


