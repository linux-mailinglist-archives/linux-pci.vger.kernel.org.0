Return-Path: <linux-pci+bounces-26329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D3A94E4C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 10:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1A43A2397
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF820E03C;
	Mon, 21 Apr 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0npXpJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643D1CDFD4
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225677; cv=none; b=Y4KVkpX9vUcyVt4/bleitb3C6TVhQxPXYyZ9/LI+WQnTlBVXD2Lmoe9YmdYxTKL/GCrl3V0mUcT+hkSdNacJVWfnzXtyRIsrLEMouAR/dnG+nRjQICNTxcuoPX9bV/wyq5rJhTvHT+sj15FKvayFtPwAyWgTZr+lTkgQDy0JytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225677; c=relaxed/simple;
	bh=6owbIwn0Z92Iad5VoDVl0Hb7ifHZ5gRy5Bq1+R0Ao1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIMRA/cNHyR+XGOMk3s26Jr4zIiL2naNoiqfK40Kj4vpSh7Xfh9YatIX4qLWtKDOMLUVcBjqO9QfkpfNZqJUT7m4hCnROc0/1oNdV6SsQOq04+nGIe2utCoTbNy+/FD86JFYrN0CXtrC9SCVOBAXEjQHiazCCKS+4npzA//hmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0npXpJI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2295d78b433so42393045ad.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745225675; x=1745830475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JsUANS/3QmGwXCVqQcGJa453VmqQ/CMnkdO6ufQpYW0=;
        b=g0npXpJIIrKrb+dQeVfkiJdfQDQj9SC/423WupUbj1wbxEeBo9tpuw5feyRaxe8m3O
         ptbotn4xNAuV157Y01iaOvoVqkw02lD6zNQmJn0qSU1Ptf61vyecuYzz+W+HCR6nbtvV
         gaRI7i0hDh/EqrfVJL6D/fVB/NKJ/z3CSQ8SbOX3dsMXTWbHok9WMgQ34OgRwK91xh0f
         nz9KhN6gFkR0WYZ+E9jctO+jY2SdukNCfBGrPWyOGmPtRFpKzC06KMldAh8qHxno/asy
         0EiQpfei5f07+AWzUIfXAB4dEhEMf8JgUPBcDujOtTCyPJC0WE6qX8XmHpDE0bAUjnIG
         zN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745225675; x=1745830475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsUANS/3QmGwXCVqQcGJa453VmqQ/CMnkdO6ufQpYW0=;
        b=SHt+22uSVLVbactLl2zL+K5CRFTWqPJR23bV3H0kUY+IrW4sAv4yMs2DA7VrIomNgk
         uZFVeUY4tOTRjcGCfFKXPAsMyB01684B0kL1lzaZYYwwwMTFbyNKLptQJ+djhEmSH080
         CRS6u53nHqOlan2It7oViUX/OLNxoNdfAdYCO9sg7uNmZxR+h/A/k1Xv6IhjoCJA6Ks2
         W5cVsYgS4dAjcovuE8lK96dk2fhj8ha9BwBD3sCVZWkAvwk8AC2eJVLq/pbRpGT+wjO7
         umz/oUe4DQS4NPn2HqpSjWGwNLknpNJWjBDBg4mrXqkK5Xt91AJkpdOjtxemjYb+/uvK
         uBjg==
X-Forwarded-Encrypted: i=1; AJvYcCXJgicOp0VZaFFV2MN+XnKGaf9oUyVyom9c3IR30kQ2uuqTNEKeWUq+XPgBWCx+bCQIjUvNLhQ/InM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkx1u/5+TGICciva/3NRjUD3A37fpVnHTkVVJCcr2OuM4Kymy5
	bZC1vRcdVBGLqauxaBLOVe5bBn8heLg39xH63G85n/H5fHKP3dYeYKUScEMj2Q==
X-Gm-Gg: ASbGnctQnpgQ55hiAqupzIuVbx6SS4zsWHDz3oqg5V7FIkEb+u1QFrqDAsrbydcRTuI
	UIzkhsTalFX0TpljjFwpWVMyko5VtEWcVXVFT+S1aln6xWF4dLGmKHdqTpZbwKa6zSyeBpOIvWJ
	gphHWksf6nHTzI/liF/uSgqDvtcLxi+1wL+L3SqwRt0BbW/FkpJZko7g99Hmfz4WrgUYEGI2H4+
	Co76aiTXD7e42knZbAY4DeXliF9iq5jsk3IKvU7QUjee8kQuZ/HK2eMAXOCMG2dZTw61KCvdtB8
	NBsbIP1E/37cNXg9DL+JLYjcOP0gKsojn8j9srNw8YVH7DftwsQ=
X-Google-Smtp-Source: AGHT+IF+6vp1Asd0YufISXtpwDH4F0HjLKz5ncPpxH+cAOzmBbxfoIeObcPr7mGOJDtXf1kolL0S7A==
X-Received: by 2002:a17:90a:fc4f:b0:308:2b5b:d67f with SMTP id 98e67ed59e1d1-3087bb51a77mr16746598a91.9.1745225674795;
        Mon, 21 Apr 2025 01:54:34 -0700 (PDT)
Received: from thinkpad ([120.60.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbaa2sm60594995ad.250.2025.04.21.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:54:34 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:24:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
Message-ID: <lk37wtb25pr2rj3zhct5udaykr7joqw2mpgtupjq33of2xhesi@rmdgucbzxmgz>
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>
 <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
 <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com>

On Mon, Apr 21, 2025 at 03:09:42AM -0500, Aaron Kling wrote:
> On Mon, Apr 21, 2025 at 2:52 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > The driver works fine as a module, so allow building as such.
> > >
> >
> > In the past, the former irqchip maintainer raised concerns for allowing the
> > irqchip drivers to be removed from the kernel. The concern was mostly (afaik)
> > due to not disposing all IRQs before removing the irq_domain.
> >
> > So Marek submitted a series [1] that added a new API for that. But that series
> > didn't progress further. So if you want to make this driver a module, you need
> > to do 2 things:
> >
> > 1. Make sure the cited series gets merged and this driver uses the new API.
> > 2. Get an Ack from Thomas (who is the only irqchip maintainer now).
> 
> Should this be a hard blocker for building this one driver as a
> module? I did a quick grep of drivers/pci/controller for irq_domain,
> then compared several of the hits to the Kconfig. And every single one
> is tristate. Tegra is by far not a unique offender here.
> 

Not 'unique', yes. But the situation is a bit worse atm. Some of the patches
(making the driver as a module) were merged in the past without addressing the
mapping issue.

Please take a look at the reply from Marc:
https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html

Even though Marc said that disposing IRQs is not enough to make sure there are
no dangling pointers of the IRQs in the client drivers, I'm inclined to atleast
allow modular drivers if they could dispose all the mappings with the new API.
This doesn't mean that I'm not cared about the potential issue, but the removing
of modules is always an 'experimental' feature in the kernel. So users should be
aware of what they are doing. Also, we have not seen any reported issues after
disposing the IRQs from the controller drivers. That also adds to my view on
this issue.

That being said, the safest option would be to get rid of the remove callback
and make the module modular. This will allow the driver to be built as a module
but never getting removed (make sure .suppress_bind_attrs is also set).

- Mani

> Sincerely,
> Aaron
> 
> >
> > - Mani
> >
> > [1] https://lore.kernel.org/linux-pci/20240715114854.4792-1-kabel@kernel.org
> >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/pci/controller/Kconfig     | 2 +-
> > >  drivers/pci/controller/pci-tegra.c | 3 +++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index 9800b768105402d6dd1ba4b134c2ec23da6e4201..a9164dd2eccaead5ae9348c24a5ad75fcb40f507 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -224,7 +224,7 @@ config PCI_HYPERV_INTERFACE
> > >         driver.
> > >
> > >  config PCI_TEGRA
> > > -     bool "NVIDIA Tegra PCIe controller"
> > > +     tristate "NVIDIA Tegra PCIe controller"
> > >       depends on ARCH_TEGRA || COMPILE_TEST
> > >       depends on PCI_MSI
> > >       help
> > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > > index b3cdbc5927de3742161310610dc5dcb836f5dd69..c260842695f2e983ae48fd52b43f62dbb9fb5dd3 100644
> > > --- a/drivers/pci/controller/pci-tegra.c
> > > +++ b/drivers/pci/controller/pci-tegra.c
> > > @@ -2803,3 +2803,6 @@ static struct platform_driver tegra_pcie_driver = {
> > >       .remove = tegra_pcie_remove,
> > >  };
> > >  module_platform_driver(tegra_pcie_driver);
> > > +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> > > +MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
> > > +MODULE_LICENSE("GPL");
> > >
> > > --
> > > 2.48.1
> > >
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

