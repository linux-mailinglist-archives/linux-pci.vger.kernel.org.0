Return-Path: <linux-pci+bounces-1986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666D829708
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB6D282402
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64723EA9B;
	Wed, 10 Jan 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AO0EkQAO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQVesUM8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B73FE38;
	Wed, 10 Jan 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5Jxz0T1xD051k59TZhvLPFRayxJvxa5EysVlTILtpo=;
	b=AO0EkQAOmU9KLlpT3zvCgjQ+6cBekw8ytiyXxpEaeP3cun6dlwjYXVlS1jUP73+qw+0gLW
	YXt2XapwJB4goMtgQmyHLcC1X8xAJKHWzpX5ldtIJRCv2k+TQ2XvRpEecg9DrbwyaBADq3
	bh7axWrApkKRAMjP5QqINYBd5o5AKK1BxeIEH8XZvQhPSGVihlct7h6x0eyVQcnf7DUFoN
	D22LfE+XG+H3FHFqAGoezjmg7Js2fXfGhlVO0BkPJtRy5cOabTTtnalJJdoeyaiaIWXN8R
	wiy5jdjSmEFtlBCwpvt6xN+uG2yrBiNamjP2VHGlPkdGTAHFVZzhF0yfK8aBUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5Jxz0T1xD051k59TZhvLPFRayxJvxa5EysVlTILtpo=;
	b=OQVesUM8pL0/7AP3pTe5E/tS5IoD2/91UrVlFi9clP1jyicBi0NXrVv4EOVFC95dd1L4jy
	ceDQuECqjtL1kfDw==
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, vidyas@nvidia.com,
 sagar.tv@gmail.com, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V2] PCI/MSI: Fix MSI hwirq truncation
In-Reply-To: <20240108120522.1368240-1-vidyas@nvidia.com>
References: <20240105134339.3091497-1-vidyas@nvidia.com>
 <20240108120522.1368240-1-vidyas@nvidia.com>
Date: Wed, 10 Jan 2024 11:12:23 +0100
Message-ID: <87il41jy48.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 08 2024 at 17:35, Vidya Sagar wrote:

> While calculating the hwirq number for an MSI interrupt, the higher
> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
> number gets truncated because of the shifted value casting to u32. This
> for example is resulting in same hwirq number for devices 0019:00:00.0
> and 0039:00:00.0.
>
> So, cast the PCI domain number to u64 before left shifting it to
> calculate hwirq number.
>
> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Added Fixes tag
>
>  drivers/pci/msi/irqdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c8be056c248d..cfd84a899c82 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>  
>  	return (irq_hw_number_t)desc->msi_index |
>  		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;

This is not casting to u64. It's casting to unsigned long:

  typedef unsigned long irq_hw_number_t;

So this works only correctly on 64bit. On 32bit kernels unsigned long is
still 32bit. It's probably arguable that the 32bit case is not a
problem, but the changelog and the change do not match. This needs a
proper explanation why we don't care about this on 32bit.

Thanks,

        tglx

