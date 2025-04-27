Return-Path: <linux-pci+bounces-26876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE924A9E3D7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0133BAB5D
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C311DD0F6;
	Sun, 27 Apr 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNtknHeO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA058190462
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745769471; cv=none; b=QRb2ozcG8H5ZsufqIdOwPtRdW0R5iecdVhPS9KPjHDu3k6e7yRuHx4TZFrzCl4KVmdf8kOxV06MjVHhA4MV7IZS89KfxjNcLZKKc7KfyWzk9QNde606VTNWgGOnST3nuJlUC74LsOlRF1sbf6FpFkAWrWN2dUOG4XuyWPwnC1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745769471; c=relaxed/simple;
	bh=vsvOb7IMd7UFDjWg/sdkTHiSVZXXld7fUcITTiCZhaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC7cnFrmNA5/AKsIZqbF3QgSyd/d6mnSWsYugkTnWFikYw2Yw3yDqeq/gZM5RlPB6dSGHsy8DMyDDwDPiqca0/lIhNdJ9iK/cUUEswXhn5AnYPrT8equgNQqOTLA0SyNPup4AAvoys/a9nHxKYzOUvS6kmPt72B4BDpowjtaK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNtknHeO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264aefc45dso59962435ad.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745769469; x=1746374269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wAQOexojybAGTeMdsNoO2UVvORn8VBszuxGfnJS/v7k=;
        b=KNtknHeOWJs1uNWVfpf04+mUdU6DD62crEVxIx9Ny02iDROnSoZDZWhlsk6nzT1iTx
         byhlXUEAT9Es88FpDMM6Pu2yEw57DFfzpScncRqgIRFz+TOBBgyIAWyLYiWz+oxxT3YR
         +WJuwznddB7Y0am1YcsEj6WHpvoIv2ItkAoz1jxjLgIr76xP3pEiHIv67ljfKcMaQgrk
         lnytceXm2aBZ4pZrDQDJp7Zlmxc0aOBsxUt/AzMeR8Fx1pdR4k501bvurMRcJgymvLdt
         OvJd6+7LwuH7V5sp9mkg6E1bmQRyG5VLJZb4PWGOYS0kYxEUxFalyEm6zoaYKsZpnp8T
         DP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745769469; x=1746374269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAQOexojybAGTeMdsNoO2UVvORn8VBszuxGfnJS/v7k=;
        b=HjGKQ5sEQ/EVKdoziK4YZXsgfWUBQXibSGOsEc7ZjZwp76z6a4LPFzuIqoAS+/ShcN
         nCmcsefvt2T5i6dAZwiX1UwSHuloeDDEV9kSThOqbo6c8w4Rc7lrmTxDvizxCi3i9NMN
         sIAsR3LOWG230dewgNHP9141s/gcHU7j6R6Wcd1IASNcRUxvQDO/6y/1Ur864LyvCf94
         8UD69QaM4k8VYiqOqkJxf+Q8YgSOkl7lIQt/TD3KSXgp7TH5QOuv+D+sE5aipPJUEY6X
         MF2KKb6uP4es0uFbl3tUiYJlQHmyXQEkRCnYiv37t9jNODu+jWx/N+1p390Oq1HfQyyU
         tTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXOHE3pGjwfsoyiNUkZ9BLYLvW6bR8cV+K6sFPQ053Ugn6zWj/pwdBJx7LrWTJ3d4ndA8NOUJuV/F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74p9+8L7jH4m0D+CwtowyIZZhemCxO6yAlIRFGZj9X1XHAG4K
	tmyCDoofMdc4jG0EJU+1u+ZtaOYKfmhMPpV+bKIVdAzxykq6LwBaztmebXAcRw==
X-Gm-Gg: ASbGncu8khTghfFtNu3cikC1k+CPjlrPCzKWrXHt92boR5y+2JegVY9r29/4LXJMDoJ
	kVSxlboMb2bFQ3R6eBS8521krf9D95EPVcpzrYDCleTKYwUspJyd2yY/7/QSJ1CoKoF5y2qNTF+
	nArWKLENaaJkYDth24pSqfDOgRzOxtZ3nh+DaGn0ftBPnzZfH/+EAlBQm7fwcr2aJ4J6kLU4nko
	dVB4bxNo2UePxAA0ahL37BZSbog2Xpq47viL42UbeH8UyGPuCNbJMee76f8B2RFWTkiXHhwC6US
	4m3MMcOD730OpO0yLFWgXp1YxlGd1WgH5Eb70D7Jtjcx9tMmOw==
X-Google-Smtp-Source: AGHT+IEP13Jf8XrJ95hgr9B14nxiB8ZEhLY+BdmhSptU0N+CRKp6D1Tz5feKkZ7HgdcKBmp5ELALrA==
X-Received: by 2002:a17:902:ec8b:b0:224:13a4:d61e with SMTP id d9443c01a7336-22dbf7472bbmr124495975ad.51.1745769468973;
        Sun, 27 Apr 2025 08:57:48 -0700 (PDT)
Received: from thinkpad ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216728sm65551085ad.231.2025.04.27.08.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:57:48 -0700 (PDT)
Date: Sun, 27 Apr 2025 21:27:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
Message-ID: <ym5fy2svuukmoy7uvg4i4amsosjdzygxauytxoctjbjzxwqdng@o5tsy5irkgfl>
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>
 <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
 <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com>
 <lk37wtb25pr2rj3zhct5udaykr7joqw2mpgtupjq33of2xhesi@rmdgucbzxmgz>
 <CALHNRZ8gSzOVpN_au_ntSan7or=uRBrPSRFdbDqAHxitcEfs7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ8gSzOVpN_au_ntSan7or=uRBrPSRFdbDqAHxitcEfs7g@mail.gmail.com>

On Mon, Apr 21, 2025 at 11:33:01AM -0500, Aaron Kling wrote:
> On Mon, Apr 21, 2025 at 3:54 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Apr 21, 2025 at 03:09:42AM -0500, Aaron Kling wrote:
> > > On Mon, Apr 21, 2025 at 2:52 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Relay wrote:
> > > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > > >
> > > > > The driver works fine as a module, so allow building as such.
> > > > >
> > > >
> > > > In the past, the former irqchip maintainer raised concerns for allowing the
> > > > irqchip drivers to be removed from the kernel. The concern was mostly (afaik)
> > > > due to not disposing all IRQs before removing the irq_domain.
> > > >
> > > > So Marek submitted a series [1] that added a new API for that. But that series
> > > > didn't progress further. So if you want to make this driver a module, you need
> > > > to do 2 things:
> > > >
> > > > 1. Make sure the cited series gets merged and this driver uses the new API.
> > > > 2. Get an Ack from Thomas (who is the only irqchip maintainer now).
> > >
> > > Should this be a hard blocker for building this one driver as a
> > > module? I did a quick grep of drivers/pci/controller for irq_domain,
> > > then compared several of the hits to the Kconfig. And every single one
> > > is tristate. Tegra is by far not a unique offender here.
> > >
> >
> > Not 'unique', yes. But the situation is a bit worse atm. Some of the patches
> > (making the driver as a module) were merged in the past without addressing the
> > mapping issue.
> >
> > Please take a look at the reply from Marc:
> > https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html
> >
> > Even though Marc said that disposing IRQs is not enough to make sure there are
> > no dangling pointers of the IRQs in the client drivers, I'm inclined to atleast
> > allow modular drivers if they could dispose all the mappings with the new API.
> > This doesn't mean that I'm not cared about the potential issue, but the removing
> > of modules is always an 'experimental' feature in the kernel. So users should be
> > aware of what they are doing. Also, we have not seen any reported issues after
> > disposing the IRQs from the controller drivers. That also adds to my view on
> > this issue.
> >
> > That being said, the safest option would be to get rid of the remove callback
> > and make the module modular. This will allow the driver to be built as a module
> > but never getting removed (make sure .suppress_bind_attrs is also set).
> .suppress_bind_attrs is already set in this driver. But what happens
> cleanup on shutdown if the remove is dropped? Would it be better to
> move remove to shutdown for this case?
> 

remove() won't be called on shutdown path, you need to populate the shutdown()
callback for that. But do note that both remove() and shutdown() serves
different purpose, so do not just rename the function.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

