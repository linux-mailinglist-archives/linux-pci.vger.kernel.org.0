Return-Path: <linux-pci+bounces-33798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC113B2187E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0989B4640E2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EFE226CF9;
	Mon, 11 Aug 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYdWfxaF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBB1862;
	Mon, 11 Aug 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951907; cv=none; b=FxIosMVfvmGlG+Y/lFut3CAtW1xLhN/HkpkpcP2G1eVjTDm9G5fvFY3wCOVv3PG6rpP4AUjy4f4YrNr9XdAdZ6RrcH/m5MfPA/KR29p7D4v9FTsv5l+VkvzKSQmu78FSoe0dVh+i8Vy/kt3rF8UNwC1V6/r4141lPKB+ckPE/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951907; c=relaxed/simple;
	bh=3T6rK8dP7+nl9lbiUQwqHRAdyHzrzjx6FJiiI7+hkjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amYMFE8cZg7xPsZDkMLu0zPbFnsKKibLT7N3hmhFxeAEVuQydPInEOAKahcca+xk9ZplbrNjgLOvQ6S5F/ua4AyV4FuhysOIGvgRqxu09o9gDTQXEHyEf7QeLXYZ1yjWZvxHZaVz3FMLxcjAviEJpApuASKHnqP7jRgqPuIhLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYdWfxaF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333a17be4e0so30985501fa.1;
        Mon, 11 Aug 2025 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754951904; x=1755556704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZiLjA/1KUaDSHD0207KvcHCt6eMEroHNgq+uatTRoA=;
        b=EYdWfxaFzClSOz1G3jF20uUfRb92vwSRvp38sVx5F82lxxk1Akx8W8NjjTE65HQN3T
         inx5lCIyYtuXvwlftPsXdwXEbCWesp1PAkpxRq5RaiK+zwNq9zSLBf2GuOp/rMcRPv/n
         LQ4Fqam7nrI2DKnTZfgORXuDsXVcNFAY6F6GpTlvo5Bkvn6txA8Wk/h4P2i+k+0xGL4L
         Drep8wn/WAJzFaSYbjJDGGm10DJW3v8SQcYKpdePkxlkTHAhHcjUCh1Sm3hgcUNqVcus
         dePSByUxVcSsx6BibMN/xiSfwnErxwG62TQPYJNXD/qlYMYaDDAVd7jGXnHFksv4nIlZ
         cqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951904; x=1755556704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZiLjA/1KUaDSHD0207KvcHCt6eMEroHNgq+uatTRoA=;
        b=mZmufoMO2q1A0Y5dXoOBdeEaAulcRbEaI8BsW5yI1oALLHoWu6o0rJC7CzvogmpVay
         akWE7+ncwmT0wXj5ZovK8NCsLc7fvXRn4CN0y1vCftiZipEzQCNYnqxTobvY5MD2xAwf
         +hvdgDjd0EGtZmaU/Mku3iiolkB/LWRzjqSUIvtMr4MUTL2qa02LUAcXV1q3V81p0/W3
         PbIKtgM3xZ0mUlt1PQHK+i1XBFZ4v2OjAvHUrn4HiqbX38pnhPeVZWx8/PP6D/rreubC
         a79n1tIvqT5ay3wf9/Qt7Qhe0yisqz71m3weOhb3iGa95UTvHP7wmcz6zDv8d/hXCwJ6
         8QMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpku9e34X/L0VSExehDIL3hWiMno6+cZLEapZGgDSzrcWuePmL5vIVidLEFGoBrHHn0zKjkVM1ZClJ@vger.kernel.org, AJvYcCX8eGoC+aYmyos0qBxhiu0IW7W0IuguTzaMDMyyRFdJVopIN7xNNXos27gR3h7gPqjV+8cc8Hsp4KNlxqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFy61z2WvHNcQ1lJesKRkXfhYQhj+LyOeo8obymFP5OS7e0lt1
	OioUkRq/7fGiqd/4r3kx8i3tGG7OjoBeu8XAeBZtNK1eoxuiINHEDkm3
X-Gm-Gg: ASbGncszS8cU/nASPMxHNux0Z4wvC5/VI+diGHEISeANuIgU45yXD2Bm8XySnD1qKTK
	kwAnyQMIalv8qr3ekizdMkIKAhsAMkcdJYhWyNdN0pVyGuPmzo9HbcLZIthRpvMC6LcG2fG7cCg
	5Q0jGzQwmaZrb5AuwX7p0ssNneS2XnlqEAnXNZlfYwemf6vaaCxjRUY7BownW6dbKBGiW5xk7xE
	0ohfzjhRXZEdSVtNrOsuKGvDuH02UWDNPnQ3qJ1ncl9J9WgZFdNz3dKeYAbank4CEg4fnfvx/zP
	y+JrIsCoZnZX0YNQcsvMdv67iC2PxyJc+3dcVOdM1WuRNzdiRFY4z2wHrb6gpB9cwsQELtYOVLk
	GD3jnXEkoYmTDwJwlNVDPrA==
X-Google-Smtp-Source: AGHT+IGoxiueWFiizy/DVtBkp9FATBbjiY/ita0NtieQ295l2YCVTx+aNvlaqdPYYgOqP8MPUGJqdA==
X-Received: by 2002:a2e:8449:0:b0:32f:41a4:5584 with SMTP id 38308e7fff4ca-333d7ba6e24mr2743451fa.27.1754951904238;
        Mon, 11 Aug 2025 15:38:24 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-333a6ff9789sm13761581fa.50.2025.08.11.15.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:38:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:37:35 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 3/4] irqchip/sg2042-msi: Fix broken affinity setting
Message-ID: <gnk4w7lmgvgwh3kdu3fn4c3frcyivkeukxrq63s223v4t7khcw@ft26odg7qtu6>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-4-inochiama@gmail.com>
 <aJoBdHlV6ZKcFry5@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoBdHlV6ZKcFry5@black.igk.intel.com>

On Mon, Aug 11, 2025 at 04:43:00PM +0200, Andy Shevchenko wrote:
> On Thu, Aug 07, 2025 at 07:23:24PM +0800, Inochi Amaoto wrote:
> > When using NVME on SG2044, the NVME always complains "I/O tag XXX
> > (XXX) QID XX timeout, completion polled", which is caused by the
> > broken handler of the sg2042-msi driver.
> > 
> > As PLIC driver can only setting affinity when enabling, the sg2042-msi
> > does not properly handled affinity setting previously and enable irq in
> > an unexpected executing path.
> > 
> > Since the PCI template domain supports irq_startup/irq_shutdown, set
> > irq_chip_[startup/shutdown]_parent for irq_startup/irq_shutdown. So
> > the irq can be started properly.
> 
> > Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
> > Reported-by: Han Gao <rabenda.cn@gmail.com>
> 
> Closes ?
> 

I got a direct private email from Han, so I think there is no pulic
Closes.

> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> ...
> 
> >  #define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> > -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> > +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> > +				   MSI_FLAG_PCI_MSI_MASK_PARENT |\
> 
> Can we indent \ to be on the same column (using TABs)?
> 

Yeah, of course

> > +				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
> 
> ...
> 
> >  #define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> > -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> > +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> > +				   MSI_FLAG_PCI_MSI_MASK_PARENT |\
> > +				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
> 
> Ditto.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

