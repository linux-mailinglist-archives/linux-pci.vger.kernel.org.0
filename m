Return-Path: <linux-pci+bounces-2886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32484428C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 16:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D021F1F216A9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365185C65;
	Wed, 31 Jan 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTN65ngd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291178288B;
	Wed, 31 Jan 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713279; cv=none; b=rIh0vBXXL8Kvh4vbwAwxTHSHXNzgttUVOku05drQkOA4NgU2BCyNHx0RRYJNcMwZKUGv269fvwwBe21ynJiGwFuEa5K0rfSpBrYQ/k0VwPlrWWQFYs1pIRT6jOmsbLp9vDs0XOgIvdxk3A3AhRlFEotxjXlqgKLk70K7wGBO8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713279; c=relaxed/simple;
	bh=t0OHP1DHYbso8jV46X86xkzFzyHEBT7ORdPCzpNMSqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=afQ3VCuV4lPBZbdaYLMG1IFsdAKOAk5OCf66Iy595yc5hdWcTAtl0DQJQUbWvd6H9geKj1oAfAsLGABztGPUVdvEHWcmfyvdzkg8mjUgiqi45zdAMB0F/Uz+/n89ihCZ/LpeVK9yyRzSREfAem8jeGQQA3nrJuICq6UcuiM8980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTN65ngd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D62FC43390;
	Wed, 31 Jan 2024 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706713278;
	bh=t0OHP1DHYbso8jV46X86xkzFzyHEBT7ORdPCzpNMSqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WTN65ngdx16owFE8cl1gWUbIYOb2PNS87GVfdxeoVcIMp2RwMmp9DJyxSQkY2Si/o
	 A3z5WO57/pWmTTP79cJg4gcGAHbt2DmiTA5MExRAKgYtSIYTYHcS4/ww1Yl2PL03Iz
	 gIQnGgvpS+PaN/qg2FovUjHzQbz3BxXN0ODOUgyNoHz8YkKG/ax49NVjaygXNA5I2Z
	 HOvzcRYzjggoy8K1HLZjNPy5vyMhUTDKOkKXqRNBeJFywZ5lagv4OaPggCm61SKGf/
	 zKqU3zNjAUbbtc5DgcLEztyZfFOhlHPPIZoCn9FeMckfmz2s6Jfyyi+lqTDM+zRam7
	 mFZ2pMLn5VA8A==
Date: Wed, 31 Jan 2024 09:01:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240131150116.GA585251@bhelgaas>
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

Applied with Mani's ack to for-linus for v6.8, thanks!

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

