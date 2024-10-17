Return-Path: <linux-pci+bounces-14730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4C9A1A0F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 07:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9784B20FD2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045F259C;
	Thu, 17 Oct 2024 05:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRX1Hcj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44021E3AF
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729141453; cv=none; b=WZRAJHGLzATYo2ZIO+cU6CUiHweVXe4BcETKG1yCpIUBVCDjaCiYmZ8hGmBgsloPGsKQytiLLCJOjxqDJcR74l+MKOl4oRlmnSdKQQWFKhrFPQc9EoH6UFJzzy8l7c81eBIj1sXuhRcY1vSw4HTbJeD3z0IR7K62tGGdzaVrcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729141453; c=relaxed/simple;
	bh=1nz7vbNsaczmdF4i4UojoSPV5OlaE7N+1HyvU06CA4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4ZUqOS3K0TvI8EX8GCKV3SmicHfiAmlfgm5+XkRmvW44L4RaeLsKo9hcKZJNRSWOEevY9bUvQqb1GizeNPv7hXgPFNOhwJTj1j+Hgdj/H3DRw6a/24jDCt3mA0PkQ8ROIWteet8d+QAx8wtsw/9wfg+Mg6Nlxk7NpPSXgmTrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRX1Hcj3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso471066a91.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729141450; x=1729746250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFtVQTx6haK8+52oRba+8ohHiUcgcdnDFsNorYhcV3c=;
        b=XRX1Hcj3EzxGhz8FBxMqYKpeZwlNX/6Xd8RpMSQzZCWpINBrcf2kTDTt5ELdGwXGlY
         xDGYPoaw1i468JAvtrvvynr5r/9tahF3NChbs1I6GvLNZzocea9WfO5k1ORltSt7J5Y/
         +VIhrW+yYnmahJvvzX2ITYPt7y/RBLmqSRqOcf6p8aYHCU3ln+8RzEvQIHWCbYsRUiIh
         6W5AOds88AO8VrczU92oL6Zrw/2V3CDaO5iSj1I7lDVjBo5ipY6mal7Dmou/1MG1ty/j
         ucTvtS64yiQWOECnornRFiDCPiIcnzsUbLYhw2S3KbXBeMdBPGZGi435ixwjeqhUYfI5
         UbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729141450; x=1729746250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFtVQTx6haK8+52oRba+8ohHiUcgcdnDFsNorYhcV3c=;
        b=B0ZLyZr/CitVV3BRc+bDnEiLAApeZaYF4ReQXbLnT4a0kMaxWaRAPUAKo8jggUeiBn
         OTwVGDkbc5XaprxVOUP2TqUAGMsvh4o+LCr8TMUhixV5D9zwS5MumDmRwWUmDDQ0tzJg
         VLISVh/5eu5nIzTCiMbArxSTLIGwmhI3GdtMv+q6gW4UT2vYwD6JLdBbpFCT+frw9pwQ
         rC5ZTziiyMoTG7yaezX1+KOshx4mTM5Vqm3jCnkZPYH6ffBwep5XRgYKArAQm3wAqH30
         45TeN/6Q6+885CAQraaQm5jc1mFAsic6yFs0gxb9mpfLiYuA7KlY3vKFI3mbQMuYND1g
         puXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdvZpL8SiVVJgM43YmIt120FIhsiqz7V4UXTexFlF8SDv2zBLB+jjkrXlE0uyAkpHi+KpIRQ/R7y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDO+V5ixYVBNlsZ0S3U+3bMj+MwfLuS3iaU4uXd7k8QyVgZSX+
	rrOCDRdti7mKKt7OajOLoMJKsaQBMFQU9TpIm75un4Gx9c59yKakfhXa1IdGvg==
X-Google-Smtp-Source: AGHT+IGTwFuwtXLeGlVJfoGXkiv8qrqrthIjM6bH1YuWajVdRvCJvG1Kj0DECOfus6mAGZa/YtRYHw==
X-Received: by 2002:a17:90a:a881:b0:2e1:89aa:65b7 with SMTP id 98e67ed59e1d1-2e3ab7f85b1mr8126771a91.9.1729141450224;
        Wed, 16 Oct 2024 22:04:10 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e090953fsm818288a91.57.2024.10.16.22.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 22:04:09 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:34:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] PCI: Add pci_remove_irq_domain() helper
Message-ID: <20241017050404.vkbbqsehfgknme5i@thinkpad>
References: <20240715114854.4792-1-kabel@kernel.org>
 <20240715114854.4792-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715114854.4792-2-kabel@kernel.org>

On Mon, Jul 15, 2024 at 01:48:53PM +0200, Marek Behún wrote:
> Add a helper function pci_remove_irq_domain() for disposing all
> interrupt mappings of an IRQ domain and then removing said IRQ domain.
> 
> As explained in the attached link, the PCI INTX interrupt may be shared,
> and so the PCI device drivers do not dispose mapped interrupts when they
> are unbound from a device, since other devices may be still using those
> mapped interrupts. Thus the interrupts must be disposed by the PCI
> controller driver when the IRQ domain is being removed.
> 
> This function may be used by PCI controller drivers that wish to be
> removable / modular.
> 
> Link: https://lore.kernel.org/linux-pci/878qy5rrq7.ffs@tglx/
> Signed-off-by: Marek Behún <kabel@kernel.org>

Thomas shared the diff leading to this patch. Shouldn't you give some credit to
him?

For the patch though,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/irq.c | 21 +++++++++++++++++++++
>  drivers/pci/pci.h |  7 +++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 4555630be9ec..30c8d930016a 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/pci.h>
>  
>  #include "pci.h"
> @@ -259,6 +260,26 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
>  
> +#ifdef CONFIG_IRQ_DOMAIN
> +/**
> + * pci_remove_irq_domain - dispose all IRQ mappings and remove IRQ domain
> + * @domain: the IRQ domain to be removed
> + *
> + * Disposes all IRQ mappings of a given IRQ domain before removing the domain.
> + */
> +void pci_remove_irq_domain(struct irq_domain *domain)
> +{
> +	for (irq_hw_number_t i = 0; i < domain->hwirq_max; i++) {
> +		unsigned int virq = irq_find_mapping(domain, i);
> +
> +		if (virq)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	irq_domain_remove(domain);
> +}
> +#endif
> +
>  /**
>   * pcibios_penalize_isa_irq - penalize an ISA IRQ
>   * @irq: ISA IRQ to penalize
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..1ba6a6f418ac 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -170,6 +170,13 @@ void pci_no_msi(void);
>  static inline void pci_no_msi(void) { }
>  #endif
>  
> +struct irq_domain;
> +#ifdef CONFIG_IRQ_DOMAIN
> +void pci_remove_irq_domain(struct irq_domain *domain);
> +#else
> +static inline void pci_remove_irq_domain(struct irq_domain *domain) { }
> +#endif
> +
>  void pci_realloc_get_opt(char *);
>  
>  static inline int pci_no_d1d2(struct pci_dev *dev)
> -- 
> 2.44.2
> 

-- 
மணிவண்ணன் சதாசிவம்

