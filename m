Return-Path: <linux-pci+bounces-19507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E973A054BA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB53A6357
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EE1ABECA;
	Wed,  8 Jan 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbmA7QYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F78A59;
	Wed,  8 Jan 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322025; cv=none; b=k5rgIebpJCkEOTGf5s/05DdBQ9l6GAAxHzqYQk7nK9xMQJtBAFjsg2Vrnhdi6EzyScPFHm6qQUQyKgZGxh1CPXEQ0v6nG/WWjwsxAOamVEQMCTby6gvcYM4aaH6j7SAPgsBSCjup7Lk6dgg2mG8jHmvtxZT1oTzTGNa1W0nWgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322025; c=relaxed/simple;
	bh=001b5sUqO8aQ9ScJfjT2JT2BgSCXEP5hetrSG7nTX/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXMYwl6iUeHf9iDYaGaFyf+u9F1Hxx9k0YIKdxKgBVaX19oNZFCyvoZlGEBlql/zrOF2aXDyOB6EOSNIb3/kLV71+iAVCMf9eiK8+uU+JAyXGRoolgNWEzT0ShNxSXiTX9ChP0pkV6gAZguCVijBfJr67lSIAE2511Yd/Cy/Ek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbmA7QYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9FDC4CEE0;
	Wed,  8 Jan 2025 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736322024;
	bh=001b5sUqO8aQ9ScJfjT2JT2BgSCXEP5hetrSG7nTX/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbmA7QYUJD04bv9S4Sw7NA3V8WwpLHsrSEihmVX24A/X0TrZvcMRCfL47/jxswy+l
	 z+C5iTQ4qOFHkDuDEEShav3woIlnsyewsPLo4vpfTSgqcWaJ4OQ/MWcgF05wTF0Bqz
	 ML1/DHIw85TO2AbFzqAGdKGwOaY2YnV3feoyP+biBKQVU8rrw7whWxL+SXFl4ZOqYt
	 AGCnCr0MWbSGgMrxr5kLq/1cNSZe4HaEXw1KUic+SzseGF1cYtDESSe6oIwO008UBV
	 TEF6wP/suLFThWBV5YvKg1g/Z8s9U1DYwybL5xmXWUgZjH9E1F8kEJjsZ07enTh6ru
	 VFHo45vc4Hrhg==
Date: Wed, 8 Jan 2025 08:40:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v9 1/2] misc: pci_endpoint_test: Remove the "remainder" code
Message-ID: <Z34r44ltlzRhatyg@ryzen>
References: <20250108072504.1696532-1-18255117159@163.com>
 <20250108072504.1696532-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108072504.1696532-2-18255117159@163.com>

On Wed, Jan 08, 2025 at 03:25:03PM +0800, Hans Zhang wrote:
> A BAR size is always a power of two. buf_size = min(SZ_1M, bar_size);
> If the BAR size is <= 1MB, there will be 1 iteration, no remainder. If
> the BAR size is > 1MB, there will be more than one iteration, but the
> size will always be evenly divisible by 1MB, so no remainder.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..0e68dfa7257a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -313,12 +313,6 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  						 write_buf, read_buf, buf_size))
>  			return false;
>  
> -	remain = bar_size % buf_size;
> -	if (remain)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> -						 write_buf, read_buf, remain))
> -			return false;
> -
>  	return true;
>  }
>  
> -- 
> 2.25.1
> 

You also need to remove the remain variable declaration in this patch,
otherwise there will be a build warning when building this patch.

With that fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

