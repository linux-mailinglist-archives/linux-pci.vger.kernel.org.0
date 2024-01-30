Return-Path: <linux-pci+bounces-2839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BF842D5D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81241F25AB1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E356EB4F;
	Tue, 30 Jan 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJqnIFMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA369E1E;
	Tue, 30 Jan 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644503; cv=none; b=e4+2pgYdBafDHUSlWt70szZMPu0Vcf5ly5L9JunpBz6EGkIOtyMCgG1iytzEex1II5YTXSwdPO02AE2L3euPQZivwyy0dctbBgYjfFRN64WR/+J6ofDPSDV2ZAA8LGtp0Hl1GPbrqYJegJnBflxAuQC1SMHiRdCBFSq/RqKrhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644503; c=relaxed/simple;
	bh=DfqrNRwTG+fSm+GnX5EML1iL/TOOm8jOTMiPq5Lv9to=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FRqzkp5R6vhicZC06rnaY6p1OlxD1O1A/otSpgxLGPw74eL0vv5lz+3beFoMzEKKDp5dgYqsgwPcFzWNVP9vEhT6XOm54euZ7r5dV8jKsWHD5aw1jgjB298Y+iIUP7/lnPXhlcQUg3CJ8GRvZScwQts5Jb9b1+HwpQegod5aco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJqnIFMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2515C43390;
	Tue, 30 Jan 2024 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706644502;
	bh=DfqrNRwTG+fSm+GnX5EML1iL/TOOm8jOTMiPq5Lv9to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IJqnIFMfyOHlsLgFUqsfqi5VB0X1J4QRa3vJuQ33CEAcuYfe94TRDTqm0nIX7RrMG
	 F8nk78fQFPLEeLEKCi70Xf47/kF8UxqGQfZVYc5rZalvmYW2HC25WEqXRlffw2p9+O
	 8aPmKKo5/8c8nKczrkwqeYa9Q/PFKnz28YME/Z3dQj9lg5+wo+Cg1C6cHpvrW3VN8d
	 zvWmwfeFvT4NTosK9sfOPkhQzfw8BiwX3786WUb1r9WxnAolSp/eYjebpDkIURoEdg
	 P5pv8VeeuhGPdRCTkWAMye7jSiIZfnxVQPvlvkzKSHKHXCRIHnbAixR+M1UGWUJ4PV
	 MjiKngcm7CcpA==
Date: Tue, 30 Jan 2024 13:55:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240130195501.GA562748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129165933.33428-1-lpieralisi@kernel.org>

On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> The PCI endpoint subsystem is evolving at a rate I
> cannot keep up with, therefore I am standing down as
> a maintainer handing over to Manivannan (currently
> reviewer for this code) and Krzysztof who are doing
> an excellent job on the matter - they don't need my
> help any longer.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczyński <kw@linux.com>

Happy to merge this, and would be good to include your ack, Mani.
Would hate to sign you up for more work unless you're expecting it :)

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..a40cfcd1c65e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>  F:	drivers/pci/controller/pcie-xilinx-cpm.c
>  
>  PCI ENDPOINT SUBSYSTEM
> -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  M:	Krzysztof Wilczyński <kw@linux.com>
> -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Kishon Vijay Abraham I <kishon@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 2.34.1
> 

