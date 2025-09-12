Return-Path: <linux-pci+bounces-36048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9CB5552C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9275A16F258
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C43218BF;
	Fri, 12 Sep 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmbXP34F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE32145E
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696289; cv=none; b=mIf23DUM8Y5p/m/iINcL2/BY8IZ7/zMHjt/W1EUxisn6wFNMySTEM1or6/77rt+CzqA7EV6ay3eMzI0aeUKL48e3WTStQeT1zsCI0Vu6uQEtO8rLZ6yWH/0hmSSTpnMTCQEfHSeBpXC1NrU4PU0ee4279NSJ7JZpwZW2BqYhnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696289; c=relaxed/simple;
	bh=OoRdHtTOUMfFS2/6YMJj+FtDjsuwWqJPziOP2yWlZZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCarpw+I9WRXPxkQJnXHyJag1RhO9h1hxeGnQea0f5BnfOABvYvDp0Y38fgkcdFZ2rg+RpAso4u7LhhYygN9Q0WdzUK8SvsdE0VB6t9Q8RT9wbasfu1IzsSAX/YTbcPJDdGXToPztfVyC88IE6lHx/vSh4bhkwNZTTZXYGrk+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmbXP34F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA84C4CEF1;
	Fri, 12 Sep 2025 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696288;
	bh=OoRdHtTOUMfFS2/6YMJj+FtDjsuwWqJPziOP2yWlZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmbXP34FMIkJoDoPI3fUdp5p86uMkyh5V8ZlAl6h1SlcuZ1ojBYH1cgTr+BpHt2ya
	 9xiKaYHvlxu4txPFYWMzkQJderqgO4nk8OgZ52NYj3fqGS8B9fMWFAOuTGFKZ9tRy4
	 SoO4s/aCcd+zgmmdFK9Vn0n0BKGVSYLSqV81ls1xabsbY9fXt6vPq17/5AJV5RkWFI
	 fi4Bfp4QfzvSrB/buYaz8JdpyI1wIqfqXx30t61KYQ08nPTmer9TxBKvBeeMraKwLW
	 4G1RFKEHwAPuS+RRLmFBbqj2OvBNX1so0Yr7CduIG32TqRGTtlQex9kKNyrEf/rdH2
	 Wb/zzHARtDWGg==
Date: Fri, 12 Sep 2025 22:28:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Message-ID: <hjqei3oc33o7uqnpv5lcxph5jk3fmjbdiuljdkvxtuv7mowwy4@tvljtegx3rop>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>

On Fri, Sep 12, 2025 at 04:11:40PM GMT, Shin'ichiro Kawasaki wrote:
> When endpoint controller driver is immature, the fields dma_chan_tx and
> dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> initialization. However, pci_epf_test_clean_dma_chan() assumes that they
> are always non-NULL valid values, and causes kernel panic when the
> fields are NULL. To avoid the kernel panic, NULL check the fields before
> release.
> 

Have you seen the kernel panic or just predicting it by the code? If you have
seen it, it is better to add the logs, Fixes tag and CC stable list. Even if
not, Fixes tag would be needed since it is a bug fix.

- Mani

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
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

