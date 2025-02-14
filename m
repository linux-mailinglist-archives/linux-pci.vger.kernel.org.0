Return-Path: <linux-pci+bounces-21424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A34A356BF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 07:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC84169FA4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D21DD0E7;
	Fri, 14 Feb 2025 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkRaTZ3w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351401DC9AC
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513384; cv=none; b=TJ38dB9LKABK+8h8ELRzqWmHokH82nS7hJoqbEivhsHB5D97z6K7P5x+XQZdcsbWAEEiIE/JkY+ylA2x5GkAUhRNXp66WloXFt9W4vNtCVJIiRgBGH/5Uw3LlFVvCZp+wKZiq5gwv35/KcYLL+SVkvgs9MCZAkwRnexiYlFcQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513384; c=relaxed/simple;
	bh=gslqCHxXuliK3k42oXZWCxQ/0azTZyYkThTDVb/Huws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/IgOYnu2cJqhtshxjTrvjuwl86C0q7ly41Zs7a+Rkv4O2+xv/1BebWgXFPa71EEOOjVzTnjheONmY6vA/pQvdKxfGAFwZkYsx2wtrlRpcN+v7tXwgBkmyH8x/1sX5dsdS8Ic7lucta760rgewh1ep77ETtIZJ9Wjbqyh9bC+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fkRaTZ3w; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so3207210a91.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739513382; x=1740118182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qvr3z8yXwbqcPQYudFZGi2O6Yo/lZbNexZYPGGJGKds=;
        b=fkRaTZ3w9zDI9tzKrpxo1hsDDxwiw7FHKHfX3XCeT6gi97VuF7yunzRjt76xiip445
         uBDXWt44VnJH9lHKm+boridLB7EmfKsQTEijoeQC4mRtjjkS3T1C220nGj4rrQKW2tXA
         OhQTKkAoxFfuaFE9He4LsIgmGLAjBlm6BzAD3uw0VtUVqjb3TXvyIQYOnz3iDXAqeWZW
         et8wsE95g+tf5tW13JLa2NVjOiHa6gXWXO0aobCKpV+o7SDMV20dBcZtO/OMOIGMVE5O
         c1I4SE1Ejvt+Q8+BHpwdiSHsov4/AXbdGUa4GmGC7wDQQwxbyhxhPXlvZBiDVFOw9BnL
         GUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513382; x=1740118182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvr3z8yXwbqcPQYudFZGi2O6Yo/lZbNexZYPGGJGKds=;
        b=xI2yp0FVI0dywh0DVnHgPXmIlqMyLlT12Xuxx/aPPmm7i1NToeEIMgUzimPAxQeWYd
         Lcxpom0KsB3THl5S1GhlpJ7gCp6NmHNYdmjVWUzngq5I1iOtHjbTPaxCJnVcWFuPPR7W
         AAsRZx1nzRA2JVjGITZXU7T8DmUxlgNe0t+rW46Cx6nzqno0EOJfgtPcTJt5csvi/dYO
         kf0BkyfMZxPRPgvo3SM4GPVvveu3PZVXAOA92kA6dzzjlc3sBlJNh951PtR/Khpww518
         pBQzmKs811c/+rMCGlRgjemY9VYdyyC5XDNEJX5CUruhRdar4IUYHAsz5BwA2dMzSOgE
         LyMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+8dPDcriTKpLd5q1gvE5OPiWurH6Glo+wubj/Hqouke81pJups4u12/d78WlTz+FWP/1LvfB18Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrJVffzcjEO9tR7Jq69v3QcvTfbhf+0Y3zZmFNxNZJyoVA5xc
	LeHrUmkkcTbLu5o/KsRbITvhVk+NwpfcNcO8V70nsUJSW67JlfNyx3UHrH4SYg==
X-Gm-Gg: ASbGncty7V+Ry8q0dMmcwch6DzhdTV/50Xz2bROS3fwrH/e5baapS0PO1ROglXCbJWi
	kEgByzzPlAhdp9Mb7FoOT/udfMXwaRvoxin2tzeKPHdWehitYputtWZLvEZXvV/sl4cG4LSEdVf
	n/34vN9Oai+2ojBVzAQgW95Re8sUxPaIF81dgeSkwQI2ikB4+tuwu31xOROUaToB+8eQS7Nl5PE
	qru8zMoq80zOwdKg72atG3XjIaQURa2ppE7bxK6vbZKnnBY4lGi2OmnI0ZA1WupYAKineZqw7T2
	68REWnsbN8B42qYbWhAg/CpBdbq07NY=
X-Google-Smtp-Source: AGHT+IGJ3PDtM/43vWXCC0cF5aeFBeRUcz79hhv9m7sp4Xsbx/Vh9naI+GxiQ5/c5A05umj2CLzzHA==
X-Received: by 2002:a17:90b:2743:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-2fbf5c0f614mr17644772a91.17.1739513382401;
        Thu, 13 Feb 2025 22:09:42 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad7c62sm2228797a91.29.2025.02.13.22.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:09:41 -0800 (PST)
Date: Fri, 14 Feb 2025 11:39:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250214060935.cgnc436upawnfzn6@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
 <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>

On Tue, Feb 11, 2025 at 01:09:04AM +0530, Anand Moon wrote:
> Hi Manivannan
> 
> On Mon, 10 Feb 2025 at 23:14, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> > > kmemleak reported following debug log
> > >
> > > $ sudo cat /sys/kernel/debug/kmemleak
> > > unreferenced object 0xffffffd6c47c2600 (size 128):
> > >   comm "kworker/u16:2", pid 38, jiffies 4294942263
> > >   hex dump (first 32 bytes):
> > >     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace (crc 4f07ff07):
> > >     __create_object+0x2a/0xfc
> > >     kmemleak_alloc+0x38/0x98
> > >     __kmalloc_cache_noprof+0x296/0x444
> > >     request_threaded_irq+0x168/0x284
> > >     devm_request_threaded_irq+0xa8/0x13c
> > >     plda_init_interrupts+0x46e/0x858
> > >     plda_pcie_host_init+0x356/0x468
> > >     starfive_pcie_probe+0x2f6/0x398
> > >     platform_probe+0x106/0x150
> > >     really_probe+0x30e/0x746
> > >     __driver_probe_device+0x11c/0x2c2
> > >     driver_probe_device+0x5e/0x316
> > >     __device_attach_driver+0x296/0x3a4
> > >     bus_for_each_drv+0x1d0/0x260
> > >     __device_attach+0x1fa/0x2d6
> > >     device_initial_probe+0x14/0x28
> > > unreferenced object 0xffffffd6c47c2900 (size 128):
> > >   comm "kworker/u16:2", pid 38, jiffies 4294942281
> > >
> > > This patch addresses a kmemleak reported during StarFive PCIe driver
> > > initialization. The leak was observed with kmemleak reporting
> > > unreferenced objects related to IRQ handling. The backtrace pointed
> > > to the `request_threaded_irq` and related functions within the
> > > `plda_init_interrupts` path, indicating that some allocated memory
> > > related to IRQs was not being properly freed.
> > >
> > > The issue was that while the driver requested IRQs, it wasn't
> > > correctly handling the lifecycle of the associated resources.
> >
> > What resources?
> >
> The Microchip PCIe host driver [1] handles  PCI, SEC, DEBUG, and LOCAL
> hardware events
> through a dedicated framework [2]. This framework allows the core driver [3]
> to monitor and wait for these specific events.
> 

Microchip driver also has its own 'event_ops' and 'event_irq_chip', so defining
'request_event_irq()' callback makes sense to me.

> [1]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-microchip-host.c#L90-L292
> [2]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-microchip-host.c#L374-L499
> [3]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-plda-host.c#L448-L466
> 
> StarFive PCIe driver currently lacks the necessary `request_event_irq`
> implementation
> to integrate with this event-handling mechanism, which prevents the core driver
> from properly responding to these events on StarFive platforms.
> 
> static const struct plda_event mc_event = {
> .  request_event_irq = mc_request_event_irq,
>   .intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
>   .msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
> };
> 
> This patch implements dummy `request_event_irq` for the StarFive PCIe driver,
> Since the core [3] driver is monitoring for these events
> 

This still doesn't make sense to me. Under what condition you observed the
kmemleak? Since it points to devm_request_irq(), I can understand that the
memory allocated for the IRQ is not freed. But when does it happen?

> > > This patch introduces an event IRQ handler and the necessary
> > > infrastructure to manage these IRQs, preventing the memory leak.
> > >
> >
> > These handles appear pointless to me. What purpose are they serving?
> >
> Yes, you are correct, the core event monitoring framework [3] triggered a
> kernel memory leak. This patch adds a dummy IRQ callback as a
> placeholder for proper event handling, which can be implemented in a
> future patch.
> 

The dummy request_event_irq() callback is not supposed to be needed in the first
place. So clearly, this patch is not fixing the actual memory leak but trying to
cover it up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

