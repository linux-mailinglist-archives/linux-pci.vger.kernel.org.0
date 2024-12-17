Return-Path: <linux-pci+bounces-18647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E39F5075
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3AB169CE5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B11FBC96;
	Tue, 17 Dec 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeqXW1yy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A81FBC92
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450963; cv=none; b=MibhvsRcrRCqSj1somxFDymctUcwkn5h72IftSJS1PR4DSeuG0qWmjrubXhwIcdFtqCLAw2eG5yue7HnWdTgm1Z84iUPjv01ZJjWG82cMRF1iPVE2Maa92d2NuNC17LvAmNJUPOMPAHwemxgnG5cZyV6Lj6NwJ4bhESDI+AEeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450963; c=relaxed/simple;
	bh=kwvGFM0/Bl8OJ8VL1EvDzIcuA1ZzHRlUeKpqH2L9zm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJaRSs/wPomC+etYq+FWtLXGJAUKOP9RoJmerVHpNpesMJ4j2hSG5uHhwhU+Rvk7otJE5JsWK8nIO7FiSHbvhe5ge2o/ue0bQZfxQ402hPrcy5qbk4WL9rS5k75Qv5D+4qobB8UCUiFAU4hlGklehfVCE83dj7kYw7AEJpCdodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeqXW1yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FAC4CED3;
	Tue, 17 Dec 2024 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450962;
	bh=kwvGFM0/Bl8OJ8VL1EvDzIcuA1ZzHRlUeKpqH2L9zm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeqXW1yy+f/kxXvxSfsOOz7dJWZJnMYriNQLGo2C4NcB432i8bIvV+j4cXyZPa2tZ
	 o4HMNXB0x+OqKD94+a4TNnuHZG5jEWs0d5PvfUtDLl9t+3ULKnF9RRPtjVYBtVJqO/
	 TTYLolE5BOLexgYzbMkrlwj+GwcR6mm+Lo9YcPbAxbXDJuVmBzFxk4ZZId4/T/mZpq
	 Fj1hk3LBW7vB6/CWSsoqBTlfbAuc3fuf8o8/GGuqPpJGAuWL09xd8obGW8KtHBz031
	 YQg50fJFnCN1K2zhcxOsbcbzc26XynQ6UBXVE/j7Omh/BkMqW2LEbQiwoimGmhJdNA
	 3aTiYP8jda1xg==
Date: Tue, 17 Dec 2024 16:55:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, inux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return
 value out of bounds.
Message-ID: <Z2GfDU4gKYlaOXmF@ryzen>
References: <20241217121220.19676-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217121220.19676-1-18255117159@163.com>

On Tue, Dec 17, 2024 at 07:12:20AM -0500, Hans Zhang wrote:
> The return type of the API is inconsistent. Inconsistencies may
> result in out-of-bounds. If the bar size of the EP device exceeds
> 4G, this bar_Size will be equal to 0.
> 
> For example, there is an EP device, the bar0 size is 16MB, bar1
> size is 32MB, bar2 size is 8GB. When testing bar2, barno equals
> BAR2. Then run pcitest -b 2, console will output "TEST FAILED".
> 
> Variable declaration of bar_size is int, the range less than or
> equal 2G. The return value of pci_resource_len is resource_size_t.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..414c4e55fb0a 100644
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
> -- 
> 2.17.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

