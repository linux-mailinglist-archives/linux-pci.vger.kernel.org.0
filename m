Return-Path: <linux-pci+bounces-34945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C70B38ED6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D097A2AEB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1A1B6D08;
	Wed, 27 Aug 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoHlYsN3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EC6FC5;
	Wed, 27 Aug 2025 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335228; cv=none; b=CNOlYzmR5fy1yG0Usn2MngxzsMwyFVaLgaGSyqvLhvgV9xEWR07vrWkyAHt7aj0U4EdmK0Dezte1SSj8XbgTpPj7zXmyizZSPaMRmH+p7mhZ+/PTF24z8niuSAC/1ZDjnZaflsZ6rLtFFctpQmRGArK71ixRz5va54wquOruw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335228; c=relaxed/simple;
	bh=qx9L6BbewKMpl4DXPDq6nEwKsLd49TI5v6Q+s2yIAeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lggmpNTy6UBb4MfvD5z+l9NitjvTBznZU82gv7YcUN+9Q+VizRrMlWSURPJqMKyNd55egyOaOaLjYJq0OM8vaVFeUcw0jcHZkVnfn5sJsJiP/tQzX+e3ebA7iBXtDD2ikyiyxVzxSllHkM8N+0/SCVhmHDxoHc0hLiAd9uHEIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoHlYsN3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49d46a8d05so357304a12.0;
        Wed, 27 Aug 2025 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335226; x=1756940026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5GAPOkJLyGHl3BeAzPSzMibv8UFdn1Toswu4lqeRmw=;
        b=PoHlYsN3ySST1K9iXoLiNg7VaRZ0zhv+eOGhqdhMq8rt+YFD4GRbgOJr+XspWYm43i
         9oYElgW+HhFePyFhRtJCPCQMejrDfUo0rTnP0AjObLODhh0BVei+xkadQplxMLruuT8V
         of31QEX6o/ya4s+E3IrxS6R7o7NxFU6XREZsfNkUEqc9PKgrsR+YLf9Otj1HINggjTiC
         Izmj5uNDQPz229UlgcjQwTWhCBCyszjBh5lFvAdxFdHxwIS8Qzw17TR6kLYRuKx1rXHU
         I+g0LWxT5sccYw7yS4Zs85DjWDjLrjExCuHwMXdbGcyiuMq/h4sSM7wbbqPtXfR9RxPW
         3Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335226; x=1756940026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5GAPOkJLyGHl3BeAzPSzMibv8UFdn1Toswu4lqeRmw=;
        b=B/rSJ6dpLs0A5OLg3NQgwM6sCTgZU1mchTThazNtR4swHyaI56VjZcKvA/S8OJeQqz
         5ZkCFBIKr242vHU+0qh/fCmh+IEv8gM42CLLLC2K+FBecYPMcHR108+3QCQDbRFT5Dl0
         KsWOeG7OF8mp7HajHa8XYHqsOp5ZaktMxwTKLAje4zIaAcgAgRF/s0DGNaycs6p+pEbj
         cnfomdUOl41cI5mLJm11LjN3kTLQISwIRUvUiWhSHir59RtwGf6Q3IrcWY7eBgvBRSHI
         oFmu5RnKDcLhqeC0EvfUhTFaXx7i5qLv9uklfWkWMniM0cMu0pJBzRVuU3ptdCM2L2nu
         +0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW/P4fkguHa5ghQBLbayn5dJfQhxY4LM4SP06KQh/XaywuFhk4CyI7gMTDGdykR/bK2lkTAwiCzqB+I@vger.kernel.org, AJvYcCX7anjq8vRvbJyIjP0OqiE7NcErgwitmakAdRDVX7QYUd2WtFpyDENMMOc+BRtHBdJ3Lg2eumH/VgMNjJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVd2Fk9wrysqaAFRfITsaFhDvI9UFOOdxR2s+S19ocqkgl23Y
	SSAPp8CJo1P+OXSUNe//uhTE+eyr9lTmr+x3rILaOhpSdry96VUL5u35
X-Gm-Gg: ASbGncsADUJeBJxvTptxgUiXhIqWpX1+2u0yV9f1FORMTZkVz6Wmtro9dOmA8193cPn
	vQY3ObR6dy+0kB8LDyT8ZagAOxcXiQ1Tv6D+kJWChuLR4zIUcGlVzezBkqswkgA7oFizllV61NL
	40CN+XI6LNAD7KMVxAptWlWOKbYyV0zk6wWgYrDsm+8/PujiGP+TmWsJeaA8jNZ99yNYBdfsgzN
	79ctgbDnKHAUP1H3wymN3cQ1i2SS3iyiOaWnZBoWmyPNEBjayBjOXG5I7ZIgIESAld7qnxd4BjQ
	KerguYv9fje9515uRqUE/i8/lHccEmn7tJXI4kYbgz1eOMyWwzq25GopBeM2j2R5zsBAz2bssej
	vH/nIm4g5pd/x/7YWo3+YeQ==
X-Google-Smtp-Source: AGHT+IHDSSVKStlkRxc9uZPGoNs8adMCt2I9S7LNO+sTw/f4mEs4YfBgNzFG6sTKv8biCiKs+WODkw==
X-Received: by 2002:a17:903:943:b0:234:b743:c7a4 with SMTP id d9443c01a7336-2462eeb75edmr258424945ad.38.1756335226090;
        Wed, 27 Aug 2025 15:53:46 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-248953dc1f4sm30583395ad.30.2025.08.27.15.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:53:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:52:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Nathan Chancellor <nathan@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Longbin Li <looong.bin@gmail.com>, Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <zlhxt6zqvweklyknmmrlheg3ojy4lildosfjoginliggdtdf5x@zent5qnnawvb>
References: <20250827062911.203106-1-inochiama@gmail.com>
 <20250827183202.GA893001@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183202.GA893001@bhelgaas>

On Wed, Aug 27, 2025 at 01:32:02PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> > For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> > the newly added callback irq_startup() and irq_shutdown() for
> > pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> > shutdown the interrupt. This will prevent the interrupt from being
> > enabled/disabled normally.
> 
> s/templete/template/
> 

> AFAICS cond_startup_parent() is used by pci_irq_startup_msi() and
> pci_irq_startup_msix() in pci_msi_template; cond_shutdown_parent() is
> used by pci_irq_shutdown_msi() and pci_irq_shutdown_msix() in
> pci_msix_template.
> 

cond_startup_parent() is used by pci_irq_startup_msi() in
pci_msi_template and pci_irq_startup_msix() in pci_msix_template;
cond_shutdown_parent() is used by pci_irq_shutdown_msi() in
pci_msi_template and pci_irq_shutdown_msix() in pci_msix_template.

> > Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> > cond_[startup|shutdown]_parent(). So the interrupt can be normally
> > unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> > 
> > Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> 
> I guess there are several other reporters and reports that could be
> added here.  Up to you whether to add them.
> 

Yeah, there are some missing tag from the original post, as this patch is
already submitted. I will add it in v2.

> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/pci/msi/irqdomain.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index e0a800f918e8..b11b7f63f0d6 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> > 
> >  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >  		irq_chip_shutdown_parent(data);
> > +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +		irq_chip_mask_parent(data);
> >  }
> > 
> >  static unsigned int cond_startup_parent(struct irq_data *data)
> > @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> > 
> >  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >  		return irq_chip_startup_parent(data);
> > +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +		irq_chip_unmask_parent(data);
> > +
> >  	return 0;
> >  }
> > 
> > --
> > 2.51.0
> > 

