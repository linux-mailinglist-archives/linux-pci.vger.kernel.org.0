Return-Path: <linux-pci+bounces-19332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E4A0248B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820E9164A16
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CD1DDA10;
	Mon,  6 Jan 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPDSdoBA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE141DD9AD;
	Mon,  6 Jan 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164146; cv=none; b=L6NW2z5OIzs7I+bDZqI8QJLIbRli7wFkvT6bhlkvw1vQWUXXpxKP9s3U/spcsBCyZzM/Kkum+PHDiHOEw92HK8aJvrvkdzIi4O02EtEoo3CWT7JjpmueuwIc6D5m/bZ26hxxGfJOcWVAByoPNXM+R021lSlV9Jj2xtWpIJaVaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164146; c=relaxed/simple;
	bh=th2FcPgSzUrZsqMrYGEIu+RCX35MJ63fAapbzUqbMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYDvTbkpUWzHduueNE4hfa8T6WUadH3tp1X38HzoUgBFDtt9NbGROJBoCDkVJ/epgbzOcVTZr2Z58Bg485crCDkmetT/63gYjf6UdwsIMRto4mGpQJHYuaWu5JJUpGO0u3EmkPgLRMstQoW/j3sA8JS2mCuwnNs6tX0TyV8tWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPDSdoBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C0C4CED2;
	Mon,  6 Jan 2025 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736164146;
	bh=th2FcPgSzUrZsqMrYGEIu+RCX35MJ63fAapbzUqbMGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPDSdoBAbIFK1daJMQlQq+BerF6DQIjjzj3rTwLyv/5y9plFCdk741wPQ0a5m0PLn
	 txgnjlhK5Ue+nbVKrMkw3WMf6qMvuCnExLFe1yKQ3ZpKd2bIlJB3mgrYM67+5+0aHW
	 J7K6OPAODQ6yfCsQObzie3r0rbXEfBzomZhCX2OYGo33kQt3eqlxqR53U57Lnk9RMk
	 2KXD26hh6O8BJnb0hspCz4JFu6+ItwVEPkLB3AWos7nvBk8q5W2mjPuiel7DGkFt9A
	 U/gr63WaMvjzvJ1Dtk7iiCofIxzDr0l5z3l4JfbSR4xCE2l4rmTK0IhXZzB3Y9t8Ty
	 miSXLThPKg+dQ==
Date: Mon, 6 Jan 2025 12:49:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z3vDLcq9kWL4ueq7@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104151652.1652181-1-18255117159@163.com>

On Sat, Jan 04, 2025 at 11:16:52PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> 
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When significantly changing the patch from one version to another,
(as in this case), you are supposed to drop the Reviewed-by tags.


Doing a:
$ git grep -A 10 "IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT"
does not show very many hits, which suggests that this is not the proper
way to solve this.

I don't know the proper solution to this. How is resource_size_t handled
in other PCI driver when being built on with 32-bit PHYS_ADDR_T ?

Can't you just cast the resource_size_t to u64 before doing the division?


> ---
> Changes since v8:
> 
> - Add reviewer.
> 
> Changes since v4-v7:
> https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
> https://lore.kernel.org/linux-pci/20250101151509.570341-1-18255117159@163.com/
> 
> - Fix 32-bit OS warnings and errors.
> - Fix undefined reference to `__udivmoddi4`
> 
> Changes since v3:
> https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
> 
> - The patch subject were modified.
> 
> Changes since v2:
> https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
> 
> - Fix "changes" part goes below the --- line
> - The patch commit message were modified.
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
> 
> - The patch subject and commit message were modified.
> ---
>  drivers/misc/pci_endpoint_test.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..50d4616119af 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int j, buf_size, iters, remain;
> +	resource_size_t bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> @@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return false;
>  
> -	iters = bar_size / buf_size;
> +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
> +		remain = do_div(bar_size, buf_size);
> +		iters = bar_size;
> +	} else {
> +		iters = bar_size / buf_size;
> +		remain = bar_size % buf_size;
> +	}
>  	for (j = 0; j < iters; j++)
>  		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>  						 write_buf, read_buf, buf_size))
>  			return false;
>  
> -	remain = bar_size % buf_size;
>  	if (remain)
>  		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
>  						 write_buf, read_buf, remain))
> 
> base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
> -- 
> 2.25.1
> 

