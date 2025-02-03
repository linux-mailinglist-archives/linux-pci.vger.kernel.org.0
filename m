Return-Path: <linux-pci+bounces-20672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F270A261BA
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B187A26E6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68A20A5CB;
	Mon,  3 Feb 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVQfA6Ba"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195C3A8CB
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605059; cv=none; b=LzMdsCbpe0G+3yksDs6YJ8Gb1P1bfLgHYk5fLuxCudCEB3po3pK2nfj+YgvWgX1ZGgeFlGZlT3R/93fqW6cuxJib1/ijQV+vKH8JsgYGJay5l9jJNrOjV82/Cys8i041hW3bkWZaYSa+cnBjTnWAyk4KfAOH30RoNYgAsaNIObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605059; c=relaxed/simple;
	bh=msjrMOhVFQTam8LsHvWU02Q7S8Fw/6DL11BmDJK1/qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4ICU5TWFpwMkEyYQzhuCpqMvRY2myY1TeUsYmNmOA8JZ8K2O0qJvLptK6C4ZzlDsFAvt1tnP1eOq2m47fRoCsgJj4w/+PwOvAmscRv0lIEPNITpamtUKvF8hfqPuu15o8NO/mWd5FNR8ofQvFsgvxKVqXwZCObM2trbpM0XFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVQfA6Ba; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216426b0865so81067845ad.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738605057; x=1739209857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mzj9WiLIhOB5vMReFD5p6XHQD8Hfc0IzZaAIE1EbWG4=;
        b=oVQfA6Bafwte0SBnh7jXmZtctoNtdBPDXZ1sXm7pzV8qdu3gEqPcM0fzNrSToaxtGQ
         qPlmXnw+alLb0RCmSQRj2ZdHUaUvY1SwdgNUJ5bV0+76VSbSorZre8Y4M8HJEdb1cUHe
         neYaxS8lhmyq+GpZvXgEU1mjf5AIoK055dKG3Bmnf/vEecCs6ZY6nX2QolwnQnRFTUwn
         i8+G4OZAW7XN3Fhkdf2Vfklk2xrMEALhbUjnhj6sv2fcZpNkhHr5w2fZ0LLGyvzH84IO
         VT/hDCWcb/15R7sycsomMwCueu1KKBOd6aG8yI0UeKhlGHx25k+U3Efyctap2CHO/zF3
         IpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605057; x=1739209857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzj9WiLIhOB5vMReFD5p6XHQD8Hfc0IzZaAIE1EbWG4=;
        b=XO51DKE1EEzKfR1SmYUhDiyZVRGFDhx/ZT3k+OJ9DwCdEyKLjKPUE4VIwvnP2lqgaO
         savlDnwwE5g+p4PVHc6KUUaH5edFSowUsibYeCT8139QgSQKZSPMNvlK/mk8L7fjvi7N
         G1klspKrQ+mxDRAFqp8G2SDpx8yEYPhN+jq7GqU0JposCNLoP2Hq+QCa4UPWwd3KErNd
         O/E2jmVy9TdBMJ9OBoe/YErsnK/9/6NareqeeZYGBZZad3k/KbYBsCOEstVZM5rzIqog
         BnY8rBOuBkf5jWZ2gcCiSiCoJqnRSthFHNNNnSHevodSJrjyDYDXvCGYejFLo8qXYRPG
         u+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUEfKnf3Qqphrrit1iFxFLzTHMf9n5eBDW4ZGDzo3iWgs9wlqYsHzO7wtuqQt76S5Ig+H3qhalxsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybmUIdfqyuNBSZY4hk+i9SL5kgVe4+kx3IW0nWvKWHSF2mg+pp
	6DOGQL+XEngIzBWpo5qNrN7KT+udpyXP406LlAQ6lEU6sbsjg+Ub3xBrY6scaw==
X-Gm-Gg: ASbGncvHUjMJBFnT7hRHzm4FSiukD7/nn8bXGN6/W5pSsiEFdKlsPqEa6wQSoE9jTyO
	yFGyUo2jVxMBdEccBDGRs0Si5Q9sr/B2q11fMU+QiINFplPqsT+aR/Jg8HceoTEpFzph9LITGp4
	AI0Wmpwvu9fZhTDV/qDaNsjkfAkBWgEMDM1nEvywCM/1nL19EUxnU2FGLunOBs5UPoDmLBPe46B
	3KK6jCgAYqp63yL0WlbHdkBzsOiBgydJ0i4MpGPuIuFX8SZ6C1OlHBigvau7WfsX0UZL5jmM7u2
	GyDAXd/3P7uoGwbTmQcaVYIRng==
X-Google-Smtp-Source: AGHT+IELooHF0qMvKyeOA5tLJ+3Ezf8GfLZEZvxarJoUbgD+ShYJqVXPzWfrjpSpkcyIBau0pRT4fw==
X-Received: by 2002:a17:903:2a85:b0:216:7ee9:2235 with SMTP id d9443c01a7336-21dd7dff6aemr371780435ad.43.1738605057004;
        Mon, 03 Feb 2025 09:50:57 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f03edsm79348895ad.45.2025.02.03.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:50:56 -0800 (PST)
Date: Mon, 3 Feb 2025 23:20:49 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Message-ID: <20250203175049.idxegqqsfwf4dmvq@thinkpad>
References: <20250201162416.azp4slqqeabo2xyl@thinkpad>
 <20250201170740.GA731664@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201170740.GA731664@bhelgaas>

On Sat, Feb 01, 2025 at 11:07:40AM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 01, 2025 at 09:54:16PM +0530, manivannan.sadhasivam@linaro.org wrote:
> > On Mon, Jan 27, 2025 at 06:41:50PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 23, 2025 at 08:11:19AM +0000, Jianjun Wang (王建军) wrote:
> > > > On Wed, 2025-01-15 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> > > > > > Remove the usage of virt_to_phys, as it will cause sparse warnings
> > > > > > when
> > > > > > building on some platforms.
> 
> > > > > >       snprintf(name, sizeof(name), "port%d", slot);
> > > > > > -     port->base = devm_platform_ioremap_resource_byname(pdev,
> > > > > > name);
> > > > > > +     regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > > > name);
> > > > > > +     if (!regs)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     port->base = devm_ioremap_resource(dev, regs);
> > > > > >       if (IS_ERR(port->base)) {
> > > > > >               dev_err(dev, "failed to map port%d base\n", slot);
> > > > > >               return PTR_ERR(port->base);
> > > > > >       }
> > > > > > 
> > > > > > +     port->msg_addr = regs->start + PCIE_MSI_VECTOR;
> > > 
> > > I think this still assumes that a CPU physical address
> > > (regs->start) is the same as the PCI bus address used for MSI, so
> > > this doesn't seem like the right solution to me.
> > > 
> > > Apparently they happen to be the same on this platform because (I
> > > assume) MSIs actually do work, but it's not a good pattern for
> > > drivers to copy.  I think what we really need is a dma_addr_t, and
> > > I think there are one or two PCI controller drivers that do that.
> > 
> > I don't see why we would need 'dma_addr_t' here. The MSI address is
> > a static physical address on this platform and that is not a DMA
> > address. Other drivers can *only* copy this pattern if they also
> > have the physical address allocated for MSI.
> 
> Isn't an MSI on PCI just a DMA write to a certain address?

That's from the endpoint prespective when it triggers MSI.

> My
> assumption is that if you put an analyzer on that link, an MSI from a
> device would be structurally indistinguishable from a DMA write from
> the device.  The MSI uses a different address, but doesn't it use the
> same size and kind of address, at least from the PCIe protocol
> perspective?
> 

Yeah, but in this case the address allocated to MSI belongs to a hardcoded
region in the host memory (not allocated by the DMA APIs which will have the
region attributed as DMA capable). So it doesn't belong to the DMA domain, and
we cannot use 'dma_addr_t'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

