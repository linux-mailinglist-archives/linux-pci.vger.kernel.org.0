Return-Path: <linux-pci+bounces-6410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C58A95A1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB91B2180F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C7136991;
	Thu, 18 Apr 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFUoSndn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB415AADB
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431315; cv=none; b=n2iU8NrNl27YdL2pQZd5uDiO53SpqgUZkehAR7E6uww63k7+nrKWCQ8QnYZPae2MaxiOL6/qiDHgY1TR4z3zllVWTgQWfVDvzgfVTiWjpvMj+MXtSp86nnBqZbSt8+FrwNW0BJThYV8KbDErKaCgGeODX1kExWXqWbcLbCiIlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431315; c=relaxed/simple;
	bh=w9qtibCyHNCUzxVnJHgPVlM+BKHeYHUkm7Q0VyZNp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnptCSfT77PQ2b/Wjgm7vJW2AChA9fiDjtO4rScS4Fa2W+8HXaU8KYmfHvU0CTf7XfkPZV5SwVKHzzAtBHRXjwoTyygOOVymZ2E/n5mMakONhI918PSnEx4+TBWGJLak2FaWfBBel06L64UQeAOB3fSmo5GfiXZTJ+lXVVKsYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFUoSndn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D90C32782;
	Thu, 18 Apr 2024 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713431314;
	bh=w9qtibCyHNCUzxVnJHgPVlM+BKHeYHUkm7Q0VyZNp2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFUoSndn3XE7X22WrD1a8wbKF/b/GDvri3V+A+QfpXaQ4KdM3UWA2UNFY/tzM52jD
	 WMyZXcGJD1sx+ar/aRZuyDvf9MN7HhQlbGK+Gn/ppgb2bSctIfh2/MmrEM+6fgAwCI
	 PT1B/ZlQ6Hlmsw0GphtVvGbIPHfM/96TDpbqvXi1Yc4zjUrxgcT/vJ3qN8Yu5tywAm
	 1Ldmz1JjKA0cIGvLA18cchnN4/quDQjsa+1M+rW7vJu/4kDzVENeWMYgP9ZXyDl6y+
	 AdY5mO0aCJGFiZyt1sHZZCaEh3WzEC/NWZ7Pmcz8RTHY9LsFcqrUSc1FefCWPRpgVE
	 IVDJawAXj98Gw==
Date: Thu, 18 Apr 2024 11:08:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZiDjDUlmDLAehonO@ryzen>
References: <20240322164139.678228-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322164139.678228-1-cassel@kernel.org>

On Fri, Mar 22, 2024 at 05:41:38PM +0100, Niklas Cassel wrote:
> The current code uses writel()/readl(), which has an implicit memory
> barrier for every single readl()/writel().
> 
> Additionally, reading 4 bytes at a time over the PCI bus is not really
> optimal, considering that this code is running in an ioctl handler.
> 
> Use memcpy_toio()/memcpy_fromio() for BAR tests.
> 
> Before patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 1.56s
> 
> After patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 0.54s
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v3:
> -Use scope-based resource management __free attribute from cleanup.h to
>  avoid overly verbose gotos and labels for error handling.
> -Added a comment related to why we allocate a buffer of max 1MB.
>  (kmalloc() default upper limit is usually 4 MB on ARM and x86.)
> 
>  drivers/misc/pci_endpoint_test.c | 54 +++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..bf64d3aff7d8 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/crc32.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> @@ -272,31 +273,60 @@ static const u32 bar_test_pattern[] = {
>  	0xA5A5A5A5,
>  };
>  
> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> +					enum pci_barno barno, int offset,
> +					void *write_buf, void *read_buf,
> +					int size)
> +{
> +	memset(write_buf, bar_test_pattern[barno], size);
> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> +
> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> +
> +	return memcmp(write_buf, read_buf, size);
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j;
> -	u32 val;
> -	int size;
> +	int j, bar_size, buf_size, iters, remain;
> +	void *write_buf __free(kfree) = NULL;
> +	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
>  	if (!test->bar[barno])
>  		return false;
>  
> -	size = pci_resource_len(pdev, barno);
> +	bar_size = pci_resource_len(pdev, barno);
>  
>  	if (barno == test->test_reg_bar)
> -		size = 0x4;
> +		bar_size = 0x4;
>  
> -	for (j = 0; j < size; j += 4)
> -		pci_endpoint_test_bar_writel(test, barno, j,
> -					     bar_test_pattern[barno]);
> +	/*
> +	 * Allocate a buffer of max size 1MB, and reuse that buffer while
> +	 * iterating over the whole BAR size (which might be much larger).
> +	 */
> +	buf_size = min(SZ_1M, bar_size);
>  
> -	for (j = 0; j < size; j += 4) {
> -		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != bar_test_pattern[barno])
> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!write_buf)
> +		return false;
> +
> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!read_buf)
> +		return false;
> +
> +	iters = bar_size / buf_size;
> +	for (j = 0; j < iters; j++)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> +						 write_buf, read_buf, buf_size))
> +			return false;
> +
> +	remain = bar_size % buf_size;
> +	if (remain)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> +						 write_buf, read_buf, remain))
>  			return false;
> -	}
>  
>  	return true;
>  }
> -- 
> 2.44.0
> 

Gentle ping :)


Kind regards,
Niklas

