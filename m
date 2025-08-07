Return-Path: <linux-pci+bounces-33596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2DB1DFC2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 01:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590921887947
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31922D78A;
	Thu,  7 Aug 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eahc1kpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC91946AA;
	Thu,  7 Aug 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608774; cv=none; b=C2+RsqDUy9hO48qXyqGmnrxIIsbxLk7fzoOuxFROOxeVq8hnBdkoJUMl/XK+8Dg5uQkz3zizefnDKJN2KuIPzNOEJ2B9tLT6iO2Hje0rIz0AL4l46iOr9vZpsHakkTsz+ZXgy0ZKFvdfkt+kFCk1kS2D2+tFMv2uBBhsqyZWTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608774; c=relaxed/simple;
	bh=bAXacL2pSF1uABD2HwZ8/SaisN/OWd5ZmAoUQo7XKbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC8PRvrJUPOeDMm9Xa0Q/U7nIJrrvixIayuknNBaJiD1GXF5frjV48nGKzd25AuT4D1RRBe41Ao1gdv0K+BAe2yH+BpAXZdX1VNIELFS2ksportjpceB9RIDziVrLXj2wTyU8WkvNw0p9Yex3mL0Bw9MZASZW3LXQgzYARNCPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eahc1kpY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bfd457607so1763326b3a.0;
        Thu, 07 Aug 2025 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754608772; x=1755213572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZvRJJkQ87oqbe1kWSjOlM4Ymc/WxzGAXEvqZJl19TQ=;
        b=eahc1kpYz/ygdxmS2W2F/XHQPrMXlK1V00bg6DX4aoNPKCZaJDAKH3Qe+9TgzbY+aS
         dalFtEbf75zxmp0ywBhPaUbQNIwIiazR5dgUsmDGXqPQn9h3YK5EU3F3ot9pDQZwf21S
         U5A6yy8SD33Pd7l+s61RgtndxkYVOLTVW0pJxfv2WJFNg74tA9YeWoeNPsLmq9UtTwv5
         f1PiE924vLQaOzKqN2fHYuQwqAUYcx29kZAtSQOq6rlQtQU7eQixWT1zIFpt+MBAji0L
         dTWI/xTXg/wRuQURoVfRiml+PZfeuMAO6HnlPPWCUEtYPTjLOXr+Q7pG9DyypXOb4rIn
         j2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608772; x=1755213572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZvRJJkQ87oqbe1kWSjOlM4Ymc/WxzGAXEvqZJl19TQ=;
        b=FjiJSP3TXdQBMUXGTU1EFW4VPGnLmozJzeW1vsk9Jr4yvk6W8Mo1txDF7viQtUrLVy
         +4ZV38SABgzR8GDEoiHKuPuniYy+O0SkcIRDpBaQs6i/8H5/lbQe3anrYnWTNJXs1LAJ
         v/iUX9iN+5rw0jUw4rwEkX0fiCp+kk6wUhSDXjjIvms9Z3fRigkuVdOoVydC7irWzQXO
         WveMW8UXFgcID8+zEiSrhQs6r5oeCvbINYHSLKZDdgU+6rIyoTa9qJfvaJ5onZPt+2Ds
         1BYilR/dhrBMOijwAurljVfBQLzi3Wqr4PumTG6IO2BJoZHxDvjz2hcp6lODsVyZ5Ksm
         4q7g==
X-Forwarded-Encrypted: i=1; AJvYcCXQoTBxLZq4RNueW2Nz6ywt8vVAGIz/ptXCMXWv+nZhsODx05D5673AXkLDhtIfFqmbxA84z9IO5o7U@vger.kernel.org, AJvYcCXSdvubVlmzC5M/C6FCro8AAjaU3IaX4QBDfTQmzBnbm1e4uaTwfy6EU1k7wQHG3d0PSvolXBL8yuv9IIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU9Ck4cLO0fVE7a+Hggu3pUE0k620K/AcAfNcuh6acJaop5Xk
	NC27Fyl0XT8dZSj079XaIjKkXj4aGj0smXyZQxuhd52KJOPnmJoGz8Wx
X-Gm-Gg: ASbGncvHlv+XgG2cUJljpsXcTGnjyg7TF600Knjt3PXI/izzzqANQ+CRhUCxPRJ6oRp
	1BMkDoss5skDk0fAkUwWhVMIGtbGlubzOfkApZ1qGUKRNDr0iRVmyzMINzeieJiZ+dfqWDxWx8I
	Esd8h/7raWA4R7q5YO78HEVpUPCkVA3GjUNSmdWZYdqfeGGrqRgLixZDHeLGiYxnNK0g8/uv6NO
	4lXpDWK4K75msjTx2eoUmfEbfwRGxdh32wvMdEu3EQ06o5//UxIQXiJsFICcjSVmO/XNmmzXy5T
	4FknR8YFIxMLM8RPqcShLubniM6aNfX5xxuGL9Fes3Phze37gGdVMlkvlQg4ZOKC6RMQuHaxDOX
	/PWu9RvEd2I1+RP13dfMpJevZJXaS7eGC
X-Google-Smtp-Source: AGHT+IHgkQbbEtuK5S2Oc4T8Ig6hqIrvHrg72ui1q1zSkfhWG5n0XiJY9RKjCNDtzEZqQKBPxJ4KCA==
X-Received: by 2002:a05:6a20:3944:b0:23f:fec8:9ace with SMTP id adf61e73a8af0-2405503abacmr1215405637.11.1754608771873;
        Thu, 07 Aug 2025 16:19:31 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bcce8f9dfsm18974118b3a.53.2025.08.07.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:19:31 -0700 (PDT)
Date: Fri, 8 Aug 2025 07:18:48 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/4] PCI/MSI: Add startup/shutdown support for per device
 MSI[X] domains
Message-ID: <hjummqbdurgohpv2kvrnr23abirami642vrpvs4j272yhw5hna@k3rqwvzax5no>
References: <20250807112326.748740-3-inochiama@gmail.com>
 <20250807162521.GA50955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807162521.GA50955@bhelgaas>

On Thu, Aug 07, 2025 at 11:25:21AM -0500, Bjorn Helgaas wrote:
> In subject, s/MSI[X]// and s/support for/for/
> 
> The "MSI[X]" notation really isn't used anywhere else, and we already
> include "PCI/MSI" in the prefix, so I don't think we need it again.
> 
> On Thu, Aug 07, 2025 at 07:23:23PM +0800, Inochi Amaoto wrote:
> > As The RISC-V PLIC can not apply affinity setting without calling
> > irq_enable(), it will make the interrupt unavaible when using as
> > an underlying irq chip for MSI controller.
> 
> s/As The/As the/
> s/unavaible/unavailable/
> s/irq chip/IRQ chip/
> 

These are good for me. I will take it.

> > Introduce the irq_startup/irq_shutdown for PCI domain template with
> > new MSI domain flag. This allow the PLIC can be properly configurated
> > when calling irq_startup().
> 
> Maybe something like:
> 
>   Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
>   MSI-X templates.  For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, 
>   these startup and shutdown the parent as well, which allows ...
> 
> s/This allow/This allows/
> s/can be properly configurated/to be configured/
> 

Thanks, I will update my commit log.

> Evidently PLIC depends on this "parent" connection, but that isn't
> explained at all in the commit log.
> 

When call irq_startup, the PLIC is called irq_enable() instead of 
irq_unmask(), the the irq on PLIC can be enabled.

I will add this to the commit log.

> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
> >  include/linux/msi.h         |  2 ++
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index 0938ef7ebabf..f0d18cadbe20 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
> >  	arg->hwirq = desc->msi_index;
> >  }
> >  
> > +static __always_inline void cond_shutdown_parent(struct irq_data *data)
> 
> Is there a functional reason why we need __always_inline?
> 

I am not sure for this. As I found other cond_[mask/unmask]_parent()
also have this attribute, I added this as well.

> If not, it seems like this annotation is just clutter, and the compiler
> will probably inline it all by itself.
> 

I will see if someone know the reason. If there is no other objection,
I will remove this in the next version

Regards,
Inochi

