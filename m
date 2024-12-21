Return-Path: <linux-pci+bounces-18928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EB9F9F52
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 09:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8A188B789
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FACF1DEFE3;
	Sat, 21 Dec 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGN3nuid"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AD282EE;
	Sat, 21 Dec 2024 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734769484; cv=none; b=pBznXRIKYC7cXlMo/+qET+N/xcD8//1x+dx46xHo7j69kiI9MQJGbZLVobtq8vFYR0eyLmwTaGoSD33tzvdIwMijQ90VyEyMwwJAwQH4bms+0Mg0t2iaqm5CejNitFlkgbNylbD2lqD1A06hSsIhPovysB7nmZivFlmoaszzKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734769484; c=relaxed/simple;
	bh=eMHYMKBI0Q1KMz20uGtsNZT+W1rlLdlPwlzc6lzzQ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5WoYEUFemHQd5uTS1QB5C/4+jmDENvDxE8eLUNiSb2As8uQ62lrLasUp8nav2q7rtU4/CcUeEN1lKxPAnezW2ukXaFBYphSpbYFtRPDZCj/f+O6f07NI92VwD4JmKBMUasNiZQQwp+0bn85mRqMYZGGgnJcn5bbJKrgbGEMAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGN3nuid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265D9C4CECE;
	Sat, 21 Dec 2024 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734769483;
	bh=eMHYMKBI0Q1KMz20uGtsNZT+W1rlLdlPwlzc6lzzQ1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGN3nuidPhSaPMXZxbgy3sugacKuadNe6aBKw1MjG6fnR6rlK1Xxr2l7fWRvN5W0C
	 ZimaqJeH8XOMTjaq8BEIexclYxsu4RkqYDuOnVXMCvK5skik8ouPOOgql3v8v1a8wV
	 V/48ZXZVIPvzlE5meQ5eXMLybHZS1zTM/MOgOHEgYsR5IOnYG/hiouvYth03BmJuo8
	 O2pvf8kJA4wlWuIzBgiOYc4WXT1z/0vZ3iSbit4e2AOlDmZukPLz0l4KYX71XE6pkW
	 xIPrbXoH9d0yt2fJkzYZQU7xurzhcV4Dfd3juvjr/1XUiRx5Dpc2sPhQWCIag7bYvz
	 Cdve8hzTCECQQ==
Date: Sat, 21 Dec 2024 09:24:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Mohamed Khalfella <khalfella@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Set RX DMA channel to NULL aftre freeing
 it
Message-ID: <Z2Z7Ru9bEhCEFqmc@ryzen>
References: <20241221030011.1360947-1-khalfella@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221030011.1360947-1-khalfella@gmail.com>

Hello Mohamed,

in subject s/aftre/after/

On Fri, Dec 20, 2024 at 07:00:00PM -0800, Mohamed Khalfella wrote:
> Fixed a small bug in pci-epf-test driver. When requesting TX DMA channel
> fails, free already allocated RX channel and set it to NULL.
>

Commit messages should be written in imperative.

I.e. "Fix .." instead of Fixed .."

> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
>

There should be no empty line between the Fixes: tag and your
Signed-off-by: tag, see:
https://docs.kernel.org/process/submitting-patches.html


With the three comments fixed, feel free to add:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
when sending out V2.

> Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ef6677f34116..d90c8be7371e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  
>  fail_back_rx:
>  	dma_release_channel(epf_test->dma_chan_rx);
> -	epf_test->dma_chan_tx = NULL;
> +	epf_test->dma_chan_rx = NULL;
>  
>  fail_back_tx:
>  	dma_cap_zero(mask);
> -- 
> 2.45.2
> 

