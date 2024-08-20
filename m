Return-Path: <linux-pci+bounces-11865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D49580B1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A971C20FE7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D918A6C5;
	Tue, 20 Aug 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOa8BKm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916C18A6BD;
	Tue, 20 Aug 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141893; cv=none; b=p+4PA7jpVym0CRuWhxq2sbCBc74PQt/+0tGbbDTszzvld21k2elGXiz1F+mD1fzU0X/IjvNTs/jbdpWWIE7PwUu3PbJJ0EaT11Vu+2+9TaTyS4TbYzMy/HTO5mWUFUyfeXLbrarMpIOk+67lG5nwxJ+wV2E64tsOFSycCIEmigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141893; c=relaxed/simple;
	bh=4PKySPJtLybVjP6ASjYFKEOOrZb80ZA3ULc4n8o/ar0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FksfQVYEome6j3De4DaeJhmbRwVhJdox2dhkKryiLManIyQeVHOcAwy3PgRPcr1mTjOz8sg/HYsXctnAYJzRixxHZQlzB21dC476rahvVfNiLOrMdwAOBymSlL/RS5DKzsHuu4YWFNktF588bZqYx4AK7Wie5XFbZI8MQb8utqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOa8BKm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFF9C4AF0F;
	Tue, 20 Aug 2024 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724141892;
	bh=4PKySPJtLybVjP6ASjYFKEOOrZb80ZA3ULc4n8o/ar0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bOa8BKm+pkVi9LFrMZ7PdJxajM+qlGPTpslTSPTkRsKX1394tpk8Z18Qq1l4NaAeY
	 JwNyFHd2qLZy3eOLA8BgH4zHZjEzM9eBHatuPVIih0VQtgI0Kscmgj3U9zBG5ex6s0
	 xVz1cTHcc2iidW4cvmeo2pKWvZaOM617ulPL7+86caJq3fBnHJjyzR4b95dqO5fZAy
	 hZuZKNYqDNwd8YQpVzn53ncwjjQyTCINyz2k+aaUPwIJzVXSLwbIk9lDpWVA1TZ5+S
	 H3UK5aQsZeUG6oFY7DHS+DvDiRKSVXQ1hEDArk0MRgpASkY76QnA+adVQW/gwt2u7r
	 ov7BhWkFc72cQ==
Message-ID: <54451b81-b503-4072-807a-af2f0b914ec2@kernel.org>
Date: Tue, 20 Aug 2024 17:18:10 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PCI: endpoint: pci-epf-test: Call
 pci_epf_test_raise_irq() on failed DMA check
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch
Cc: alberto.dassatti@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
 <20240820071100.211622-2-rick.wertenbroek@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240820071100.211622-2-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 16:10, Rick Wertenbroek wrote:
> The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
> is meant to be used in a PCI endpoint device connected to a host computer
> with the host side driver: /drivers/misc/pci_endpoint_test.c.
> 
> The host side driver can request read/write/copy transactions from the
> endpoint function and expects an IRQ from the endpoint function once
> the read/write/copy transaction is finished. These can be issued with or
> without DMA enabled. If the host side driver requests a read/write/copy
> transaction with DMA enabled and the endpoint function does not support
> DMA, the endpoint would only print an error message and wait for further
> commands without sending an IRQ because pci_epf_test_raise_irq() is
> skipped in pci_epf_test_cmd_handler(). This results in the host side
> driver hanging indefinitely waiting for the IRQ.
> 
> Call pci_epf_test_raise_irq() when a transfer with DMA is requested but
> DMA is unsupported. The host side driver will no longer hang but report
> an error on transfer (printing "NOT OKAY") thanks to the checksum because
> no data was moved.
> 
> Clarify the error message in the endpoint function as "Cannot ..." is
> vague and does not state the reason why it cannot be done.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53a..b02193cef06e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -649,7 +649,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  
>  	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
>  	    !epf_test->dma_supported) {
> -		dev_err(dev, "Cannot transfer data using DMA\n");
> +		dev_err(dev, "DMA transfer not supported\n");

Should we set the FAIL status flag here ?
E.g.:
		 reg->status |= STATUS_READ_FAIL;

Note: I have no idea why the status flags are different for the different
operations. We should really have a single SUCCESS/FAIL flag common to all
operations. So I think we could just do:

		reg->status |= STATUS_READ_FAIL | STATUS_WRITE_FAIL |
			STATUS_COPY_FAIL;

here, or go back to your v1 and handle the failure in each operation function to
set the correct flag.

> +		pci_epf_test_raise_irq(epf_test, reg);
>  		goto reset_handler;
>  	}
>  

-- 
Damien Le Moal
Western Digital Research


