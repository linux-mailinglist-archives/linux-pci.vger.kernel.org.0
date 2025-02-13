Return-Path: <linux-pci+bounces-21342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D6A34068
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD716A745
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B31F462A;
	Thu, 13 Feb 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+wyZUZq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C623F439
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453548; cv=none; b=WWDMoq23dKOxSg4ZC+95/65ZtUpIpNqZMsi7nTJW0yiqygsU5YeBe0w8QISpcEzqw05+dS3X0eXZ+TPFReQ0Ofo0x8w7UP0pqCX//r+OrVm2fs5ROPXJf1hNFrvDqtZzL6X+41pdUkldgOSQXxTX0GbYXmtME78HpQn0HVknJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453548; c=relaxed/simple;
	bh=CAILtdMsrv4+YNK2l8LbbVv1zKpFK5bH4qZx9ogZl1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK1HZqg/m1kT2TVj924qo4tM91GlG3z+hZDqTz4xkNNyD9GjVPRKwxlkKahhLetdUr/G770GCMeALMl7/LDPKqGuMBeaQvSBA/dMpJYlPualHFWFNd1QHoyPyCXjr+noGK8oRfsDrXYFURD6M7UI5AFvrvUgDYWerPpI/HVAmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+wyZUZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50027C4CED1;
	Thu, 13 Feb 2025 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453548;
	bh=CAILtdMsrv4+YNK2l8LbbVv1zKpFK5bH4qZx9ogZl1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+wyZUZqGiVph8VzExwOtmeCaRe9mBEUdYPea5ZSRmEcXycuA5SW8sHWDxJq3TpI7
	 3Y02aLXTBsThqx9vL9K3ARcyN41Df4U1EiLh0mai1SHc2YRJiSoIwCEQcnainpsYpw
	 EI9RAc1kTXDgPTfyq/q5pF9JBn4XNDofJUwIYKu2N1Wf57ezgXNcWwbK7Cul+ipmNC
	 MYowv2rPHYcngxRhD86g9lW0DkAcLozHd/loUGfB9QEYOgRtywNNocZcmeNkc1sabZ
	 j8vU/GprjvowhxU9sFUsFB0LbuqLOJcHDsHb0mQYn81OWP2JxZnKG1I/qp6gGjaJw7
	 reGbNfDpnl5Bw==
Date: Thu, 13 Feb 2025 14:32:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Fix
 pci_endpoint_test_bars_read_bar() error handling
Message-ID: <Z630aKSRHHuQH7eI@ryzen>
References: <20250204110640.570823-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204110640.570823-2-cassel@kernel.org>

On Tue, Feb 04, 2025 at 12:06:41PM +0100, Niklas Cassel wrote:
> Commit f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
> changed the return value of pci_endpoint_test_bars_read_bar() from false
> to -EINVAL on error, however, it failed to update the error handling.
> 
> Fixes: f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Changed the type of the variable ret to int to match the new return type.
> 
>  drivers/misc/pci_endpoint_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..7584d1876859 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -382,7 +382,7 @@ static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  {
>  	enum pci_barno bar;
> -	bool ret;
> +	int ret;
>  
>  	/* Write all BARs in order (without reading). */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> @@ -398,7 +398,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		if (test->bar[bar]) {
>  			ret = pci_endpoint_test_bars_read_bar(test, bar);
> -			if (!ret)
> +			if (ret)
>  				return ret;
>  		}
>  	}
> -- 
> 2.48.1
> 

Ping.

Because of this bug, if this test fails, it will be reported as success,
so quite bad.


Kind regards,
Niklas

