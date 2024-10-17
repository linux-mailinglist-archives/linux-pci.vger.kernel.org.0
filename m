Return-Path: <linux-pci+bounces-14731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40329A1A24
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 07:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD631C21842
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDCB14EC59;
	Thu, 17 Oct 2024 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpXY0Cuz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDC21E3C1
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142623; cv=none; b=Bl7914/dvqCFrJXH3tpJHn/tMJn4GYqx4mQQzj+YYlgQ6ZAiVJSycJAzui2VDgartxF4bYVIN0BB8Ase9Jk0MikycTmMyY1N8edNvy+HV3DZVDIM2EPcDKwWItlsnpDnxBash1fnBfXLUB5x2Cn8NTF6UmrIbR2Ao9dyzfJ9VvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142623; c=relaxed/simple;
	bh=mExZyhdsMMf4gRVZCP39my2kunhL/jtzjTLIVTva+Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWU5Tlf3yjsIe3Cfo16btUhiewYNPN+w1QuQKztqO93jnuYqzo9seyIfuivxz4PcinUZDBgvNh58lLcxStrUPVe/s3/E6AWrPDRigzoLtRbWkDbqMFsDjYurjt7coswYNQgegaw80BP/t73DoSm3fI3obT6sNkbf5mIa/Yrw+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RpXY0Cuz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e31af47681so424991a91.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729142620; x=1729747420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OCa/2861obl9V5ckCTUYjogSBw7B5osjW4tVSSSNZes=;
        b=RpXY0Cuztn0mbdhd4VlNGDDbtpy0yiKwfp6bKWe9iwmdjnJL4JcHvEKfu2WZuSO1KN
         pspJVEGejkf/MkAi5sULZFcRyQxRZ00o8CZty1QgPHL+tBGPZyLgfndT9JRDxCQRwy7x
         6m7RiQG3qpD8CtgaUrGLaoNNyqzJ0q/T7dXNfOjMib+dcPL7Iy6H+NM+B84ioLfbn8g0
         LEjkco68VmPSe87G5H0pmBN4aBJCizh4TbZiHIrGDX+9UbgK50fYBkg8tx7hnu3leVua
         USHVDDQs4Syko0vFmtcw7OLmTnOAPrue+lXSlG7KHYj+zsMEQ/PPzNler5t6F4bPPQRH
         5kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729142620; x=1729747420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCa/2861obl9V5ckCTUYjogSBw7B5osjW4tVSSSNZes=;
        b=boPu03H1hOnzPC9D0ahPChDC+kpaC2Sw3Xubrpm3la+nKBeDaTvRe0tjFRImAwt5o5
         5U/eKEoTYSvAbaeS+hTjstSlUu6p7g4V1wXX7hLDX9mvp5OTLbH5FuvZhaCvyKCkGBxQ
         20ky+rJTMBJ74/w3xYYOMzjZsg00Ebv3p4x79BOoErPG7Umd3gHJOKC1CiVMKxOHTaOJ
         d6GfvfWh1SEQs1tcfBMShvXJDarnpg46ZFMEC81glAOEk32Daq1eLZZXT46fypbOc2Fk
         ADM8k3+U2W85ZJpgwMXHZpUwDxoE9DZ64GJlFYcz9VMGhc7Zo7gFh9qDm1UKR3Ai2XLE
         Wjuw==
X-Forwarded-Encrypted: i=1; AJvYcCWxoapKuLGO9d9wkFp6BRVb6yU9RTI2Aphq72PX1w+D6DF7MvuX9zTYhahoyepztR+8d9PyRILZ7dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqF7Xug2Z+TL6dxbEUx95fKFEdoJb525TZmdorImmGetWyZBU
	+H5B55qPvOW+eMxr6VhbsAMpHJeKmJ+5aK+gfHsHohswIVF1drbjepBK5z1U9g==
X-Google-Smtp-Source: AGHT+IGjeBk2kioaY/kHyxT3q1nImWDtOTVlpOhMJRI/BFXigA3MIpzvfkBk1ObbO7BBS1NML8GqFg==
X-Received: by 2002:a17:90b:1241:b0:2e2:857e:fcfb with SMTP id 98e67ed59e1d1-2e2f0b09d89mr22612829a91.19.1729142620475;
        Wed, 16 Oct 2024 22:23:40 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08ebf2asm865122a91.31.2024.10.16.22.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 22:23:40 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ley Foon Tan <ley.foon.tan@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20241017052335.iue4jhvk5q4efigv@thinkpad>
References: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
 <20220727195716.GA220011@bhelgaas>
 <YuJ+PZIhg8mDrdlX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuJ+PZIhg8mDrdlX@hovoldconsulting.com>

On Thu, Jul 28, 2022 at 02:17:01PM +0200, Johan Hovold wrote:
> On Wed, Jul 27, 2022 at 02:57:16PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 26, 2022 at 11:56:59AM +0200, Johan Hovold wrote:
> > > On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> > > > On Mon, 25 Jul 2022 16:18:48 +0100,
> > > > Johan Hovold <johan@kernel.org> wrote:
> > > 
> > > > > Since when is unloading modules something that is expected to
> > > > > work perfectly? I keep hearing "well, don't do that then" when
> > > > > someone complains about unloading this module while doing this
> > > > > or that broke something. (And it's only root that can unload
> > > > > modules in the first place.)
> > > > 
> > > > Well, maybe I have higher standards. For the stuff I maintain, I
> > > > now point-blank refuse to support module unloading if this can
> > > > result in a crash. Or worse.
> > > 
> > > That makes sense for regular interrupt controllers where its hard to
> > > tell that all consumers are gone, but I don't think that should
> > > limit the usefulness of having modular PCI controller drivers where
> > > we know that the consumers are gone after deregistering the bus
> > > (i.e. the consumers are descendants of the controller in the device
> > > tree).
> > 
> > Those consumers are endpoint drivers, so I think this depends on those
> > drivers correctly unmapping the interrupts they use, right?
> 
> Right. For MSI this means that pci_alloc_irq_vectors() in probe should
> be matched by pci_free_irq_vectors() on remove.
> 
> For legacy interrupts, which can be shared, the mapping is created by
> PCI core when binding to the first device and can only be disposed by
> the host-bridge driver once all descendants have been removed.
> 
> The endpoint drivers still need to disable their interrupts of course.
> 
> Buggy endpoint-driver remove implementations can lead to all sorts of
> crashes (e.g. after failing to deregister a class device), and if that's
> a worry then don't unload modules (and possibly disable it completely
> using CONFIG_MODULE_UNLOAD).
> 
> > > > > It's useful for developers, but use it at your own risk.
> > > > > 
> > > > > That said, I agree that if something is next to impossible to
> > > > > get right, as may be the case with interrupt controllers
> > > > > generally, then fine, let's disable module unloading for that
> > > > > class of drivers.
> > > > > 
> > > > > And this would mean disabling driver unbind for the 20+ driver
> > > > > PCI drivers that currently implement it to some degree.
> > > > 
> > > > That would be Bjorn's and Lorenzo's call.
> > > 
> > > Sure, but I think it would be the wrong decision here. Especially,
> > > since the end result will likely just be that more drivers will
> > > become always compiled-in.
> > 
> > Can you elaborate on this?  I think Marc is suggesting that these PCI
> > controller drivers be modular but not removable.  Why would that cause
> > more of them to be compiled-in?
> 
> As mentioned earlier in this thread, we only appear to have some 60
> drivers in the entire tree that bother to try to implement that. I fear
> that blocking the use of modules (including being able to unload them)
> will just make people submit drivers that can only be built in.
> 
> Not everyone cares about Android's GKI, but being able to unload a
> module during development is very useful (and keeping that out-of-tree
> prevents sharing the implementation and make it susceptible to even
> further bit rot).
> 
> So continuing to supporting modules properly is a win for everyone (e.g.
> GKI and developers).
>  
> > > > > > > Turns out the pcie-qcom driver does not support legacy
> > > > > > > interrupts so there's no risk of there being any lingering
> > > > > > > mappings if I understand things correctly.
> > > > > > 
> > > > > > It still does MSIs, thanks to dw_pcie_host_init(). If you can
> > > > > > remove the driver while devices are up and running with MSIs
> > > > > > allocated, things may get ugly if things align the wrong way
> > > > > > (if a driver still has a reference to an irq_desc or irq_data,
> > > > > > for example).
> > > > > 
> > > > > That is precisely the way I've been testing it and everything
> > > > > appears to be tore down as it should.
> > > > >
> > > > > And a PCI driver that has been unbound should have released its
> > > > > resources, or that's a driver bug. Right?
> > > > 
> > > > But that's the thing: you can easily remove part of the
> > > > infrastructure without the endpoint driver even noticing. It may
> > > > not happen in your particular case if removing the RC driver will
> > > > also nuke the endpoints in the process, but I can't see this is an
> > > > absolute guarantee. The crash pointed to by an earlier email is
> > > > symptomatic of it.
> > > 
> > > But that was arguably due to a driver bug, which we know how to fix.
> > > For MSIs the endpoint driver will free its interrupts and all is
> > > good.
> > > 
> > > The key observation is that the driver model will make sure that any
> > > endpoint drivers have been unbound before the bus is deregistered.
> > > 
> > > That means there are no longer any consumers of the interrupts,
> > > which can be disposed. For MSI this is handled by
> > > pci_free_irq_vectors() when unbinding the endpoint drivers. For
> > > legacy interrupts, which can be shared, the PCIe RC driver needs to
> > > manage this itself after the consumers are gone.
> > 
> > The driver model ensures that endpoint drivers have been unbound. But
> > doesn't the interrupt disposal depend on the correct functioning of
> > those endpoint drivers?  So if a buggy endpoint driver failed to
> > dispose of them, we're still vulnerable?
> 
> Just as you are if an endpoint-driver fails to clean up after itself in
> some other way (e.g. leaves the interrupt enabled).
> 

The IRQ disposal issue should hopefully fixed by this series:
https://lore.kernel.org/linux-pci/20240715114854.4792-3-kabel@kernel.org/

Then if the dwc driver calls pci_remove_irq_domain() instead of
irq_domain_remove(), we can be sure that all the IRQs are disposed during the
driver remove.

So can we proceed with the series making Qcom driver modular?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

