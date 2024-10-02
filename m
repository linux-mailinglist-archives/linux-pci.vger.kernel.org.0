Return-Path: <linux-pci+bounces-13734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5298E560
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 23:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A13B21675
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631101D1E95;
	Wed,  2 Oct 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs8FyTyu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94F19580A;
	Wed,  2 Oct 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905064; cv=none; b=Tl9VEl0VKv/g/f5HACTowVVDkKa08DyeI5OqML5VNXH9/prtD4qrBm9DLXeKMGya0jsQkYDMyN0RRWOneAZT0iEgZaRg/Xleec5V5vs4yExPB3qlI5tYpqkjg+Yp7HAw1cbAJisoiAOBIirqqk6Vy1mucb7kuBVQYf1mieQblmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905064; c=relaxed/simple;
	bh=gdbxJfBIn/rgoeybQnKRALegFXwGWpWmdxAqI5sGHxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s6fs+2CwAecN1kDwSxPPFlUz/3QaetNC3yfQ5thaboby7sY1oof4VO0axGCIi4VkNz/LCsj390bl2hlz3strXIlA13g1iODFMJeKWI+Ve3fo1/jx+jJPYq3J9/UVgVVvy3L0wz8imumH+S5ZY19qSCYKaKbtFpusKte2dYyic1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs8FyTyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C056C4CEC2;
	Wed,  2 Oct 2024 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727905063;
	bh=gdbxJfBIn/rgoeybQnKRALegFXwGWpWmdxAqI5sGHxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bs8FyTyuoknhHtZLEE81Agk7sRlpT3DLNeJ9CPRgB+wRjygLiL1R9CWTX0l1R1qe2
	 IuO2Q1FJsiNNltMwh3KdJc/i4GJMG25jTVdCg2bZ7EG/9vGhrblTCfzqXI65rhJC1Y
	 DyykqRn9Xbk/jv3Pw4LVp3w3oPaZdRLqFlxTJDA8aH0pFwbi4iyOIs79Ca6yu6TsUB
	 OWZezztdkKIHiyYNgwN7szdf7zEkcCYOwR7M3kqcWoiPrr6I+7PYQF0YyJAH+fPDMV
	 PinfW4uB4IDhwiTQf1mQqBnYp1/B5T2AyFRj3iVizrNj/LCaVEESXq14ZXXbMx8aOV
	 THwqYYsiVVVXg==
Date: Wed, 2 Oct 2024 16:37:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Todd Kjos <tkjos@google.com>
Cc: kernel-team@android.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix memory leak in reset_method_store()
Message-ID: <20241002213741.GA280235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001231147.3583649-1-tkjos@google.com>

On Tue, Oct 01, 2024 at 11:11:47PM +0000, Todd Kjos wrote:
> In reset_method_store(), a string is allocated via kstrndup()
> and assigned to the local "options". options is then used
> in with strsep() to find spaces:
> 
>   while ((name = strsep(&options, " ")) != NULL) {
> 
> If there are no remaining spaces, then options is set to NULL
> by strsep(), so the subsequent kfree(options) doesn't free the
> memory allocated via kstrndup().
> 
> Fix by using a separate tmp_options to iterate with
> strsep() so options is preserved.
> 
> Fixes: d88f521da3ef ("PCI: Allow userspace to query and set device reset mechanism")
> Signed-off-by: Todd Kjos <tkjos@google.com>

Applied to pci/misc for v6.13, thank you!

> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..0e6562ff3dcf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5244,7 +5244,7 @@ static ssize_t reset_method_store(struct device *dev,
>  				  const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	char *options, *name;
> +	char *options, *tmp_options, *name;
>  	int m, n;
>  	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>  
> @@ -5264,7 +5264,8 @@ static ssize_t reset_method_store(struct device *dev,
>  		return -ENOMEM;
>  
>  	n = 0;
> -	while ((name = strsep(&options, " ")) != NULL) {
> +	tmp_options = options;
> +	while ((name = strsep(&tmp_options, " ")) != NULL) {
>  		if (sysfs_streq(name, ""))
>  			continue;
>  
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

