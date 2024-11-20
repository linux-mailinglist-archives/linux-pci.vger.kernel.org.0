Return-Path: <linux-pci+bounces-17125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BEE9D42F2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EB281F02
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B8170A30;
	Wed, 20 Nov 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU1+95RB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB6145B18;
	Wed, 20 Nov 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134138; cv=none; b=XMkgIG1TJ0euRiXaslp01l/Cn97J4MEfgJswZr0iNG5B+jJn2xtqDUWjxHoGkROLY2Tc0afkvsczYHRZ9YbszxK9WkRcjGHCKFwe7fpfItrk/yt/8ot83s7iPXS8CHmyjSXrGKxVltmTsr08f4Wa2F90C3VExQB+PGRLp15Qsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134138; c=relaxed/simple;
	bh=pbUjkkEUj6pUI2tekegEPPQ/oo0bRuT03AegnZ1y3TU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EV5dXfK+UQb3+5fsKPiz4We4r09EnwWBKhq3jMFZqNOOfgCkiUcrIRr+J13tw4DeXdc/TJWpxH0yBBtAuz9dVOjDMOdJC9Lz5wpZrBlIGPofZUEI/HTAtnJGk2u0ZlVKkML+8vzjpV2/Nnlw2xSMgxtbftVYwgYz/64YbZSVvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU1+95RB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9B9C4CECD;
	Wed, 20 Nov 2024 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732134138;
	bh=pbUjkkEUj6pUI2tekegEPPQ/oo0bRuT03AegnZ1y3TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AU1+95RB9KsBGdk6c0s4wqxoF5c8jbB3/yTh+81FgvQ4Ob7k04iUkXSNfAWU0Tw5/
	 CNEtesxRI+6QewAFz2uOzdyNHhfMvcivdg1VgJ24DuVkkNyAckHta5wosvhG3/F0Aq
	 epTOJL4vvGgsVSYxcHZ9grn11apzlhUSDv3q+MgD2BKYZPcA2CzLg09ZuNz6Z3LYVh
	 Ubfwly24vZeWq5RqMOacyCr2Cb8keZesR3ci4dpJ4Aqk/9kXHQ5PWylR/0eSmv/rCT
	 vcXS9EfCK2sFjNTOMSZUihj0+xEaKSml5a/EaeJe6a4G67UKQDJPunRnq8uTwNLTnu
	 1FaI5EPeeWXPg==
Date: Wed, 20 Nov 2024 14:22:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: Fix several incorrect format specifiers
Message-ID: <20241120202216.GA2347727@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112090924.287056-1-luoyifan@cmss.chinamobile.com>

On Tue, Nov 12, 2024 at 05:09:24PM +0800, Luo Yifan wrote:
> Make a minor change to eliminate static checker warnings. Fix several
> incorrect format specifiers that misused signed and unsigned versions.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Applied with Mani's reviewed-by to pci/misc for v6.13, thanks!

> ---
>  tools/pci/pcitest.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 470258009..7b530d838 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -95,7 +95,7 @@ static int run_test(struct pci_test *test)
>  
>  	if (test->msinum > 0 && test->msinum <= 32) {
>  		ret = ioctl(fd, PCITEST_MSI, test->msinum);
> -		fprintf(stdout, "MSI%d:\t\t", test->msinum);
> +		fprintf(stdout, "MSI%u:\t\t", test->msinum);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -104,7 +104,7 @@ static int run_test(struct pci_test *test)
>  
>  	if (test->msixnum > 0 && test->msixnum <= 2048) {
>  		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
> -		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
> +		fprintf(stdout, "MSI-X%u:\t\t", test->msixnum);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -116,7 +116,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_WRITE, &param);
> -		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "WRITE (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -128,7 +128,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_READ, &param);
> -		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "READ (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -140,7 +140,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_COPY, &param);
> -		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "COPY (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> -- 
> 2.27.0
> 
> 
> 

