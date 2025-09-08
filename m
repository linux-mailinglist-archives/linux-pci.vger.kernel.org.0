Return-Path: <linux-pci+bounces-35701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36815B49C67
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE495174BF2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52892E22BA;
	Mon,  8 Sep 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS36maUZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789523371B;
	Mon,  8 Sep 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368304; cv=none; b=ly57Y7YwSkWcpshtcuH7gG20vb2z+9k/abH/cQBPS2IvZ96RcZvmN18F53TMqVu37hpaRmLU8QczqQ0UgRsiujLATJA9uMkoQ59DLfeItNGcxEN8bOIRhlj0GsPkZmrgfaYQud76EV9eXC1c78T/2FdYYfLsNAdosQywnGk8yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368304; c=relaxed/simple;
	bh=U9AbL5VFGndjUVgINshuPsOfUibJtOYH//MWS793yfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ApaVMNT5DySaWswW3wpDOeroQ6nCFUnb8UWxuvuSPXAkaf0UN28pCtBF9chfgbJ9ljUsdRUeWcpOYUakT5TllT4I2Uk6rdQ1ON8BpOMznWxP+BJo4a/6RFq3ltluk/VeYvnS8lYcoGiPXdVbPJtxSXfSDvGYj1GUWfI7k3QijbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS36maUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACFC4CEF1;
	Mon,  8 Sep 2025 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368304;
	bh=U9AbL5VFGndjUVgINshuPsOfUibJtOYH//MWS793yfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VS36maUZSdl08Q1FVLRzY0Aj10s8sHfIw14e21tydqTAHRI0sweL9IUAYHIthqy26
	 29US43sB7uD/EKUBcYqHAshz5adGkFQ5UYKtcCOWdSNbyreuhQw5eAeJ+Ewx7kI1Y2
	 6YgDxpVJFy6w9UX2Hec/VBoIVI1MHOyhyPHCyB+7lf+JdxZzg5bX9org18mOhH/22g
	 x3jBR/v5oR16kIvLoZYaNUyYFStLSb/fu49lI+PNDVwe+k1T8MoTvmS5EqMwO98LzJ
	 603vBAc6vz9EeHaz1oj0dj2Y8IauQt+NUUmIhaUjF06q5qyFtW/G8QISaAPRcKM6hT
	 Z4XgKg5xvyXSA==
Date: Mon, 8 Sep 2025 16:51:42 -0500
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
Message-ID: <20250908215142.GA1467111@bhelgaas>
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
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Would be great if you included this as part of your series, thanks!

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

