Return-Path: <linux-pci+bounces-19509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28552A054C0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAFA162A47
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C21ABEC5;
	Wed,  8 Jan 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwnRw9+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D2A59;
	Wed,  8 Jan 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322067; cv=none; b=nonNp3mUd8XvKf6ZRMDSsYeu9q2p8cWYE3C4DTWf23pfXdx/HURyimdHphy4oPVqJRPUUxEJV83wotPvdGICAh41t5s2V8UXhdoms+kbX2HIyPfDnCWyoeWncS7lJkVTVbym1ap7Qt1Aehb2hPdYGujMuWSmC+xFJF1jpc2MLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322067; c=relaxed/simple;
	bh=ZvgG0fVblJEUqLv1SArecw8faEroRTLOCzmzau1tdLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFiGUrAeDGWCbSCvIm4Nkq79sIm5Cq43xsYJ34n1KUMKW5LsiDDGdeis9wdRob/vD9Dgg5VapsEKGnTv/2QfNNIXW7RqK5xENj6Ae2iCR4oREaTBs9vuCj6Y+s6NQZEemEoWshAz3Fd1xkr5j2Zym9K1n7CRcAyD7euqO4v3RpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwnRw9+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B21C4CEE0;
	Wed,  8 Jan 2025 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736322067;
	bh=ZvgG0fVblJEUqLv1SArecw8faEroRTLOCzmzau1tdLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwnRw9+KpQpWIkH53xFoDXsL1xRNw92l3+voRC9NejJZJ1c4hibfZCYG/pM0B0u8P
	 HoKJlYglDGzEjdlBWwV9LKDbLgdOE+oO18zeAiIHC53J8Szb0+hc0q0OjczhHmefqV
	 zHb/zQ/uV/W4aR5vV79Rw+d3MOfl+2hR/2unxfcMqR8u6tTN8qujD+RY5rEdPSWvFc
	 mdm/hlH98QUsuyV9XAmqBBU25u70oTbf6cakAmCFM5Uo7tbXb5E7BiXQkfd75Mp0BA
	 PRnvWHhbG64GxS2q3aJCKkum3PYkiFfFzv8fzKJZzYarm+lVLRu61v1CjkrlbJPO3V
	 xRWZCOFHdvEvw==
Date: Wed, 8 Jan 2025 08:41:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v9 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z34sDgNf2vhCEQie@ryzen>
References: <20250108072504.1696532-1-18255117159@163.com>
 <20250108072504.1696532-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108072504.1696532-3-18255117159@163.com>

On Wed, Jan 08, 2025 at 03:25:04PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> 
> Change the data type of bar_size from integer to u64, to fix the above
> issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v8:
> https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/
> 
> - Split the patch.
> 
> Changes since v4-v7:
> https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
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
>  drivers/misc/pci_endpoint_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 0e68dfa7257a..812508308187 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
> +	int j, buf_size, iters;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	u64 bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> @@ -307,7 +308,8 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return false;
>  
> -	iters = bar_size / buf_size;
> +	do_div(bar_size, buf_size);
> +	iters = bar_size;
>  	for (j = 0; j < iters; j++)
>  		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>  						 write_buf, read_buf, buf_size))
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

