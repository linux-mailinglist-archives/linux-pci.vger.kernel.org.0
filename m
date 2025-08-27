Return-Path: <linux-pci+bounces-34813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A508B37637
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 02:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5568E3A6184
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 00:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B21C5499;
	Wed, 27 Aug 2025 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z04zFHY9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0C1A8F6D;
	Wed, 27 Aug 2025 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255647; cv=none; b=cerIwzOO7tPX0eN1fLMTIp5SIZxRfwp9z4jJJZ6t6XAJFJaxtklLFrtWl3oEH/sis+uc7QgAa3bT8KeOG2wF63x1jg6WOc6S5cnsuhDBhPAJdrD6tbuQMjjB6OxSDljPg4GgVaZs3molCNkKWB+lCVRpjuDkhfRLIeGnuIGScVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255647; c=relaxed/simple;
	bh=fJibzDU7/2s4PGf/xnGmOVoava/WtPPgeSBLdxdvRAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7HhWnuQUy0dRsorVJZC3/Asusn6jxeIjWIgFsq0XFVrXxW6/Pm31rmEbjOA/X5PeOaruOeNTOK+KdfWqygA+uBM33aD9z718en2XhnOv9Gvd2HXgUtTZ+epSuj+DkmtaWtqL/bUS+p/d23rhYecG6GlfXZw7MtFbo820O3KGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z04zFHY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DF1C4CEF1;
	Wed, 27 Aug 2025 00:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255647;
	bh=fJibzDU7/2s4PGf/xnGmOVoava/WtPPgeSBLdxdvRAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z04zFHY9UxRveACRgyHDlt+oZzzLREXskSz486JKDN7StLFjGNYWkTLlfLffuMX7J
	 PVmJrFf5SYQdzPvhJBMX7KCamml864BWNvojqKD9A1cv7Smzp1/dz9o+M6sHphOKEA
	 OLmHH8hdRORf4OAsm3PZyL4Oe3OmziXypIZ2mYYUgArb1XQ+gdr6VJ+T2jIF3nI+jN
	 daIMt9c3fSrO9K7ZSCfirX6SAI1hu5+gODhasY3pFpEqQrMzuS261KDoaoBBbIDF/L
	 vIF40OvKjBGdSloMfYq8CT0ZHGkAifI6qf/L5Svsgi0urrHQgCYq/rT+bTES+zolkg
	 x4LOvp8jC3wSQ==
Date: Tue, 26 Aug 2025 17:47:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, regressions@lists.linux.dev,
	linux-next@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de,
	dan.carpenter@linaro.org, naresh.kamboju@linaro.org,
	benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <20250827004719.GA2519033@ax162>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
 <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
 <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s>

On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> OK, I guess I know why: I have missed one condition for startup.
> 
> Could you test the following patch? If worked, I will send it as
> a fix.

Yes, that appears to resolve the issue on one system. I cannot test the
other at the moment since it is under load.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
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

