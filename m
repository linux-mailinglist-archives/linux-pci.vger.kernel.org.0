Return-Path: <linux-pci+bounces-35418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A5B42FE8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 04:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3A48729A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 02:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AF1F9F51;
	Thu,  4 Sep 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqmfuwO0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B21F8ADD;
	Thu,  4 Sep 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953797; cv=none; b=Hnn3bJq1dd8G8Mw+ZJEYyHJfb/DFGdcjCKxSNYa+LKlf6gsTdNGXtl2CnFtpMb42wwV/+LY4SHhWbeL3pKK/yVJcP5AWV110T7lLcgOV62Lc0oDCmLj5sjsPA0jwL7TsY0DQTIzlsIFnyjs+dH+sP1FGYjB4GQx4BV9AhZ7vq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953797; c=relaxed/simple;
	bh=UIH7ADUUQjVWgw2DD5w8NGuzPpDVd4VV6TWvbS74P2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kArYOxC431EZCYXLTxfFs3Li3YXAeZIsRIZJGwwHjSe06YuWsItehTqO9cDvqrncApax1I2flEAZ8tY8LOWrMD4MDgbjXNRR4F2qMFBqQnwrtXSogHMRugi5GpLRBxXl8S/ml9zElOZucS6ZMHwg9hOqr3bzQGZ1qfjFm8+eF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqmfuwO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B7AC4CEE7;
	Thu,  4 Sep 2025 02:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953797;
	bh=UIH7ADUUQjVWgw2DD5w8NGuzPpDVd4VV6TWvbS74P2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TqmfuwO07Nelf4xjhnWrMpQ2PEzf5mEuLZs+QOvwBhfbKX/q7MBBdl7IkPtTfbkZ6
	 Uiiy787F3ckcVY1iezpNznJojVOk8r/kGHEu7Z2hl/sb9By2/v2Ykl5l3RcCbDjF3G
	 Z7x9zd5VVi8WJ/hXHC9Cnj73HvaGwGh+kI1OKsqx8XYdiCN6AuPHQ2E36Bkc2G7BPr
	 Be85zhNh2Ta3NDYttIN6BPU+A4rLjHSGq4L2gCdKl7c+NEkRTvfoe+AcOJlMov7hVb
	 +KQPNhV+M1HRwCFxiElqglUd0oaylEFwW5W/3UdXngV5gCJUirfFxxu3uu8cduL8BO
	 KpaN359HULjRA==
Message-ID: <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
Date: Thu, 4 Sep 2025 11:40:15 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Wang Jiang <jiangwang@kylinos.cn>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 11:37 AM, Marek Vasut wrote:
> Currently, the test allocates BAR sizes according to fixed table
> bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
> does not work with controllers which have fixed size BARs, like
> Renesas R-Car V4H PCIe controller, which has BAR4 size limited
> to 256 Bytes, which is much less than 131072 currently requested
> by this test.
> 
> Adjust the test such, that in case a fixed size BAR is detected
> on a controller, minimum of requested size and fixed size BAR
> size is used during the test instead.
> 
> This helps with test failures reported as follows:
> "
> pci_epf_test pci_epf_test.0: requested BAR size is larger than fixed size
> pci_epf_test pci_epf_test.0: Failed to allocate space for BAR4
> "
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Wang Jiang <jiangwang@kylinos.cn>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8a..d9c950d4c9a9e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -1022,7 +1022,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	enum pci_barno bar;
>  	const struct pci_epc_features *epc_features = epf_test->epc_features;
> -	size_t test_reg_size;
> +	size_t test_reg_size, test_bar_size;
> +	u64 bar_fixed_size;
>  
>  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
>  
> @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (bar == test_reg_bar)
>  			continue;
>  
> -		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> +		test_bar_size = bar_size[bar];
> +
> +		bar_fixed_size = epc_features->bar[bar].fixed_size;
> +		if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size)
> +			test_bar_size = min(bar_size[bar], bar_fixed_size);

I think this can be simplified to:

		if (epc_features->bar[bar].type == BAR_FIXED)
			test_bar_size = epc_features->bar[bar].fixed_size;
		else
			test_bar_size = bar_size[bar];

because if the bar type is BAR_FIXED, then the size of the bar can only be its
fixed size.

> +
> +		base = pci_epf_alloc_space(epf, test_bar_size, bar,
>  					   epc_features, PRIMARY_INTERFACE);
>  		if (!base)
>  			dev_err(dev, "Failed to allocate space for BAR%d\n",


-- 
Damien Le Moal
Western Digital Research

