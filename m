Return-Path: <linux-pci+bounces-34934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CAB3899B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AAE205CBF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212F2750E6;
	Wed, 27 Aug 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUlXZuo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E613E41A;
	Wed, 27 Aug 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319524; cv=none; b=RMJbFBTAZVLl1YminWaNjsMs5jMY33BRCwsFhVG/zdZI0OXwKpx+u6+AaM1k/dZ/J5lgLApHcUctLTaN7H14i2EizbTsFFAlAoFyRMrTmw0c4BJl+rQuDucWad1JaE9OZQlUcTrbg41EaJuHMzZw4QhCVK94varD2OsxWlMr7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319524; c=relaxed/simple;
	bh=odr+1odvhIhRpJwcI6Gwr3WvQHaQP4jXsUMOb+r+pXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ojs7a7wVzn182aGnuqTGkfMzFpJEaTb5hLZWgvJGmQ6Ds0CQtfvp1Fn/uHvY04/kyPC9lfXet6GHTm8uFVYeZA0kGeSTn4MwxrtwMVaq2MmiCioA3WYrC289X5EdI+zJLLsvYXYOo35KX3l6PH5frHDpvkvQrzKaDuNIhAt7KEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUlXZuo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCA4C4CEEB;
	Wed, 27 Aug 2025 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756319523;
	bh=odr+1odvhIhRpJwcI6Gwr3WvQHaQP4jXsUMOb+r+pXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iUlXZuo0n74D4JhyomiyD6B+9612ke7ZgzZfVmGKXvQESvMtgS93US+iFQO8FEhqo
	 GOEyQ0mn/aI2ybTDzKIOwynh4zPm6Uj/ok1vIdOIETIX0OtKek1Y7yAxXHTIWZp0Cf
	 v8+2tCVq30Z4Rq1UGxnTfMWIEKNntS/0bdsCdhgoLkToPdEf1MmP2PcEZzyquJ8+I4
	 0oTKFpaKq1xRuN3kfTIUCKGdRaDagV0XmfBdY4D6IQ9oOdeTjjAlYM9ihaR9RChoR9
	 NgoPGmWCf3dTWAjGWhOwEYL38+481rBZR4MJyzgtHbXTGoJ5gMvFk5PmtcMhkpbDrg
	 svyKewiXCY1Ew==
Date: Wed, 27 Aug 2025 13:32:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <20250827183202.GA893001@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827062911.203106-1-inochiama@gmail.com>

On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.

s/templete/template/

AFAICS cond_startup_parent() is used by pci_irq_startup_msi() and
pci_irq_startup_msix() in pci_msi_template; cond_shutdown_parent() is
used by pci_irq_shutdown_msi() and pci_irq_shutdown_msix() in
pci_msix_template.

> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> 
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/

I guess there are several other reporters and reports that could be
added here.  Up to you whether to add them.

> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e0a800f918e8..b11b7f63f0d6 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> 
>  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>  		irq_chip_shutdown_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_mask_parent(data);
>  }
> 
>  static unsigned int cond_startup_parent(struct irq_data *data)
> @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> 
>  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>  		return irq_chip_startup_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_unmask_parent(data);
> +
>  	return 0;
>  }
> 
> --
> 2.51.0
> 

