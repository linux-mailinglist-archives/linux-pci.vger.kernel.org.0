Return-Path: <linux-pci+bounces-35983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BDB543E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8145686602
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC0281530;
	Fri, 12 Sep 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/4hv4q4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC61917F1
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662299; cv=none; b=T5JPEIFp4T5HM7dGhuH7yjlgLtTSsT4ez7EVPLGElRzJdUCqsCBpgHB6Y/yflbCsxexmsgOl6LhCVOHl2ViMpo+97vrGoDH/Sk0hlop1dOKdoEE2yVB5xJnSOIm+2zNFofQOLERJ5ONkOT//y6P2KlKfIFS83DqaDvBOrrFyYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662299; c=relaxed/simple;
	bh=TZpTxFDmSe7EMR/ZVrRQ+bWbSTyYS+WuOsZbKAYbS1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdv0EJghA8A4yPtqFeya3ixQlzWP206cqdXEngbab703g5C1y0KDl4aND3weLAgWh3ltBKTaWSK/Rl5PsbBEnF80y5qrHmAJUG/CD0HBKxs4G6wg99oE2l6fRCbrS9XTVqB5K7ox+qIhvN4I/8k/AZb1xMo5ZakscxDdj+z+TOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/4hv4q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB9C4CEF4;
	Fri, 12 Sep 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757662299;
	bh=TZpTxFDmSe7EMR/ZVrRQ+bWbSTyYS+WuOsZbKAYbS1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/4hv4q4YtNsfAmESnzDSlGmRJWfn15IeGq34vlmH7+3LyiEpbLP8v0s2dG7hJMG/
	 me1/CPrAki/HmPqHx8jO+lrvdGRMYd96E/svCA2LDYPbsa2z/LhPXuZFTarbJvczzJ
	 ZKxpY2Mg87VZRkTmnQ6vTTuvv5aLheDERigxS23HY+nyN850COS74AGwf5HO+LkioD
	 7tA2jzZDCTyWsGDhjXc8sdcnOpMFKmZrm3ZVUHQmWgYay683A9MmlCwf6/unRz5Cpf
	 xMCpKdXvHg2nIPSPOC6oO4ldjRTAfsHT3ljVFtjzhbyCzUAPj6Nlt4crstSnlu/JYZ
	 JKe6JkvNsFGtA==
Message-ID: <94e8dbce-9e9a-4fe7-b33c-1d451c07eba6@kernel.org>
Date: Fri, 12 Sep 2025 16:31:36 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 16:11, Shin'ichiro Kawasaki wrote:
> When endpoint controller driver is immature, the fields dma_chan_tx and
> dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> initialization. However, pci_epf_test_clean_dma_chan() assumes that they
> are always non-NULL valid values, and causes kernel panic when the
> fields are NULL. To avoid the kernel panic, NULL check the fields before
> release.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8..1c29d5dd4382 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
>  	if (!epf_test->dma_supported)
>  		return;
>  
> -	dma_release_channel(epf_test->dma_chan_tx);
> -	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> +	if (epf_test->dma_chan_tx) {
> +		dma_release_channel(epf_test->dma_chan_tx);
> +		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> +			epf_test->dma_chan_tx = NULL;
> +			epf_test->dma_chan_rx = NULL;
> +			return;
> +		}
>  		epf_test->dma_chan_tx = NULL;
> -		epf_test->dma_chan_rx = NULL;
> -		return;
>  	}

Can we simplify here ?

	if (epf_test->dma_chan_tx) {
		dma_release_channel(epf_test->dma_chan_tx);
		epf_test->dma_chan_tx = NULL;
		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
			epf_test->dma_chan_rx = NULL;
			return;
		}
	}

>  
> -	dma_release_channel(epf_test->dma_chan_rx);
> -	epf_test->dma_chan_rx = NULL;
> +	if (epf_test->dma_chan_rx) {
> +		dma_release_channel(epf_test->dma_chan_rx);
> +		epf_test->dma_chan_rx = NULL;
> +	}
>  }
>  
>  static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,


-- 
Damien Le Moal
Western Digital Research

