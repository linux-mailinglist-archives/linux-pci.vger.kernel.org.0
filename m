Return-Path: <linux-pci+bounces-35689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39BB49B43
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 22:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0E3C1D93
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB62DC33D;
	Mon,  8 Sep 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwA2dgov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1B21FF39;
	Mon,  8 Sep 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364831; cv=none; b=k1CHiiWppVZ7beruOrXBa30qV7jL6wjpY3y4JDWJ6h6gs/asXkcfOuSijgLYC0rVgKVFLDbUZPEG9G25+eKaZu0sQeoajy4dkgVu6zXLFD6LCuJZKJfAvAB4VlqPSXcjCBmnrdac7Q7LamHAcx9nplMEJIFKMKZauL92LCvNTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364831; c=relaxed/simple;
	bh=POcz+JpYGpHubzD14Eku3ZQzqXppkJMBMmqMowj0z/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kUTpaUtrh/bH/1Sa3kfgbYDu43k0Om6BspAmteJ8Y0FQUpD5Io0KqZi2Yj2G123QmibPEeAI3QMaaC6oJBfzQ5DktXW411DDXLsUwlbbpvEeqth4hhxF5PhPk8EGxv/5XV/xQO/q037jtiErpOfQIK5aypTRPz9KKeoi2GZIWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwA2dgov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB6DC4CEF1;
	Mon,  8 Sep 2025 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757364830;
	bh=POcz+JpYGpHubzD14Eku3ZQzqXppkJMBMmqMowj0z/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HwA2dgovXhqbZKDE4CyF6jfjUOnL7dEWbzZKFuoiTgQM0/8RbmKtDJPAN9M5U7NdR
	 332e8aBZX3AbPbB6EpAt9HNVbvClc42ykkVZoJjNbULcacR8h0B5EXEYiKZkgZ0oop
	 MOztEVj9EyVglVVIKVAZMxdg6OGkWy3zLxbY/8rXxuKdTmHbBJJ416YTwQcjKpBtKY
	 fK6GtR6tE/0qkbhp5QxKjzmH6c551WY5tmeIrJaR+WyTrg1e0UOJG7niYxUXTfUBiu
	 qiXTd7ug2j69De7tF7VnvVqeCJga5fsCbsa8lXBVxnN8uEDltBUZshWZ3PB/PvJJG6
	 9aMOKYX/9U7dQ==
Date: Mon, 8 Sep 2025 15:53:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Message-ID: <20250908205349.GA1463686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905052836.work.425-kees@kernel.org>

On Thu, Sep 04, 2025 at 10:28:41PM -0700, Kees Cook wrote:
> After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations"), which allows GCC's value range tracker
> to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> "ffs(rq) - 8" used here:
> 
> 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> 
> could wrap below 0, leading to a very large value, which would be out of
> range for the FIELD_PREP() usage:
> 
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> ...
> drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>       ^~~~~~~~~~
> 
> If the result of the ffs() is bounds checked before being used in
> FIELD_PREP(), the value tracker seems happy again. :)
> 
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")

What's your plan for merging cbc654d18d37?  I suppose it's intended
for v6.18?  If it will appear in v6.17, let me know so I can merge
this for it as well.

Maybe this should go in v6.17 regardless, to avoid a warning
regression between this patch and cbc654d18d37?

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: lkft-triage@lists.linaro.org
> Cc: Linux Regressions <regressions@lists.linux.dev>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ben Copeland <benjamin.copeland@linaro.org>
> Cc: <lkft-triage@lists.linaro.org>
> Cc: <linux-pci@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..005b92e6585e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>  	u16 v;
>  	int ret;
> +	unsigned int firstbit;
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>  
>  	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  			rq = mps;
>  	}
>  
> -	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +	firstbit = ffs(rq);
> +	if (firstbit < 8)
> +		return -EINVAL;
> +	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
>  
>  	if (bridge->no_inc_mrrs) {
>  		int max_mrrs = pcie_get_readrq(dev);
> -- 
> 2.34.1
> 

