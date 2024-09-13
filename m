Return-Path: <linux-pci+bounces-13162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9C977E3A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3ACB1F2703F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB01D86C3;
	Fri, 13 Sep 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSl0ro/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A91D47BF
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225909; cv=none; b=nHCalNskFAmHMAhbVfRgZyeYX/uhqvQ6PCB+6SZSRwJepKNIMFrO9Jwhq5PDMP76GbLv51yFakozyYYJaHFWXgqTA5ZcJokmZcTKctcwgmsP6mWDtki0X+Uq2MC73yTXcynWvHtyPKHxyG/14Izh4SThganeeapCo7GzDOu9rF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225909; c=relaxed/simple;
	bh=ftDg/13T5xxqPu8FO1+ZOPi5p+r72xa4zeeMuHSDunc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/ddHkeEKYbLkCbspwdVgjqNW4ain2XgeGIPTDxNPVh+B1FS2Kdk6LlU9Wal0jUh0afO5WgLJF0cG1bSJz/0Avud/tX1B4K+LMthObRb9ziY5fPlvo3aqQTvd2xkeyBCXRH+elU/YUfqMblPIzbi9MzyvFbmh7M/40pb85kJtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSl0ro/f; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7191fb54147so1431344b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726225907; x=1726830707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4WuhP0VB2LGXkpsyd3caHAv7pGnfI0FTdQ8HjWlE/qE=;
        b=vSl0ro/f+563IFA9vV+lg4Kvj0NmIdLUZ0ZXmQXA4pRt36t9EXjfqF+5JIqHCqKaKZ
         JFHKGClNl1Qs1LYlKupYNexgGabKRJp5oz/kLL7fq2pFl/ckc3M/gBN6XivHUb16zlYh
         DY8TKzOL5x5UJ0IcnLF4O1XEzWrR0Kb2tFhbarv121m2uXYOn+yAnkpiAmIRjhrDmVr0
         T68JvPJTNsJJ7y5zVppWVntqtitVLc1BXWP66ZKcwR2wU3OZMBLNxoYA9EztI8mfY6wj
         a7ViIWaR/hvaStA2yzvbCLMDDyYmbvHJcrf/0jk6W12fIiMVv6I9QC+lpUniSQ/ds/T9
         ATLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225908; x=1726830708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WuhP0VB2LGXkpsyd3caHAv7pGnfI0FTdQ8HjWlE/qE=;
        b=rJTmh9ecWs0py3c9zSJeDyD02K0y3pYFgC7snDZ4etGcLJk+24/ZlBKTqahmmxx/cU
         EPJVXDMOPym5yc5f8get9BMjZa3laQ3aqWKJI73YFLzmFNlI4mPWCuANZMYV3LW3hUs5
         w6nGG28Z07oTC7axbNPg1pwSwmgQfwlToHguEoR2ZgMjQcnfhHFvdzE0WVtEZyvWmbsh
         ArsqxhRm1hPmkl2iYhNbfNMSh11b28hrsFm53Hi+E6Ya1vxWRIdeS6swEkxwbsrtPCVS
         UiBXQpR/MnZ4R+rlyEdqwLjPW3Qmb4LkUDorZcdiwZ/trJ3F+mglogDQnOMep3LqHmnx
         GtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW++QQ7trDg6lku0eJBwtE60e4hhCLEKw/Nsvj8Yspr3xfC9Eprz1eI/pXORq+dqFvfu/5nrhECT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9e8h4AcOnA26i861g+UMBccbRnsXnRsk9do52UD/T/CZbag5
	8ra+Ow41LGIXXNEr6ZgGE7Xti88e3JEaksPArJ/gu4nhrXPXxN2eQi5eBCCdUw==
X-Google-Smtp-Source: AGHT+IGKz9WzptWVNO9Zk3uVeShWL+DlgdyC8qF52qrFKeN6fzeWl1jtqiHFbePPdYangnFcrBJ36w==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-7192607fcb9mr9003619b3a.9.1726225907400;
        Fri, 13 Sep 2024 04:11:47 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe2641sm5897353b3a.59.2024.09.13.04.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:11:46 -0700 (PDT)
Date: Fri, 13 Sep 2024 16:41:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, jonathan.derrick@linux.dev,
	acelan.kao@canonical.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <20240913111142.4cgrmirofhhgrbqm@thinkpad>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
 <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
 <20240904062219.x7kft2l3gq4qsojc@thinkpad>
 <CAAd53p5ox-CiNd6nHb4ogL-K2wr+dNYBtRxiw8E6jf7HgLsH-A@mail.gmail.com>
 <20240912104547.00005865@linux.intel.com>
 <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p698eNQdZqPFHCmpPQ7pkDoyT4_C9ERXJ4X=V_8QFO8pQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 01:55:49PM +0800, Kai-Heng Feng wrote:
> Hi Nirmal,
> 
> On Fri, Sep 13, 2024 at 1:45 AM Nirmal Patel
> <nirmal.patel@linux.intel.com> wrote:
> >
> > On Fri, 6 Sep 2024 09:56:59 +0800
> > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> > > On Wed, Sep 4, 2024 at 2:22 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote:
> > > > > On Tue, Sep 3, 2024 at 10:51 PM Keith Busch <kbusch@kernel.org>
> > > > > wrote:
> > > > > >
> > > > > > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > > > > > > On Tue, Sep 3, 2024 at 12:29 PM Manivannan Sadhasivam
> > > > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng
> > > > > > > > wrote:
> > > > > > > > > Meteor Lake VMD has a bug that the IRQ raises before the
> > > > > > > > > DMA region is ready, so the requested IO is considered
> > > > > > > > > never completed: [   97.343423] nvme nvme0: I/O 259 QID 2
> > > > > > > > > timeout, completion polled [   97.343446] nvme nvme0: I/O
> > > > > > > > > 384 QID 3 timeout, completion polled [   97.343459] nvme
> > > > > > > > > nvme0: I/O 320 QID 4 timeout, completion polled [
> > > > > > > > > 97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion
> > > > > > > > > polled
> > > > > > > > >
> > > > > > > > > The is documented as erratum MTL016 [0]. The suggested
> > > > > > > > > workaround is to "The VMD MSI interrupt-handler should
> > > > > > > > > initially perform a dummy register read to the MSI
> > > > > > > > > initiator device prior to any writes to ensure proper
> > > > > > > > > PCIe ordering." which essentially is adding a delay
> > > > > > > > > before the interrupt handling.
> > > > > > > >
> > > > > > > > Why can't you add a dummy register read instead? Adding a
> > > > > > > > delay for PCIe ordering is not going to work always.
> > > > > > >
> > > > > > > This can be done too. But it can take longer than 4us delay,
> > > > > > > so I'd like to keep it a bit faster here.
> > > > > >
> > > > > > An added delay is just a side effect of the read. The read
> > > > > > flushes pending device-to-host writes, which is most likely
> > > > > > what the errata really requires. I think Mani is right, you
> > > > > > need to pay that register read penalty to truly fix this.
> > > > >
> > > > > OK, will change the quirk to perform dummy register read.
> > > > >
> > > > > But I am not sure which is the "MSI initiator device", is it VMD
> > > > > controller or NVMe devices?
> > > > >
> > > >
> > > > 'MSI initiator' should be the NVMe device. My understanding is that
> > > > the workaround suggests reading the NVMe register from the MSI
> > > > handler before doing any write to the device to ensures that the
> > > > previous writes from the device are flushed.
> > >
> > > Hmm, it would be really great to contain the quirk in VMD controller.
> > > Is there anyway to do that right before generic_handle_irq()?
> > >
> > The bug is in hardware, I agree with Kai-Heng to contain it to VMD
> > controller.
> 

I'd love to, but if I read the workaround correctly, it suggests reading the
register of the MSI initiator device, which is NVMe. IDK, how you can read the
NVMe register from the VMD driver.

> The problem I am facing right now is that I can't connect the virq to
> NVMe's struct device to implement the quirk.
> 
> Do you have any idea how to achieve that?
> 
> Kai-Heng
> 
> >
> > > >
> > > > And this sounds like the workaround should be done in the NVMe
> > > > driver as it has the knowledge of the NVMe registers. But isn't the
> > > > NVMe driver already reading CQE status first up in the ISR?
> > >
> > > The VMD interrupt is fired before the CQE status update, hence the
> > > bug.

I'm not able to understand the bug properly. The erratum indicates that the MSI
from device reaches the VMD before other writes to the registers. So this is an
ordering issue as MSI takes precedence over other writes from the device.

So the workaround is to read the device register in the MSI handler to make sure
the previous writes from the device are flushed. IIUC, once the MSI reaches the
VMD, it will trigger the IRQ handler in the NVMe driver and in the handler, CQE
status register is read first up. This flow matches with the workaround
suggested.

Is any write being performed to the NVMe device before reading any register in
the MSI handler? Or the current CQE read is not able to satisfy the workaround?
Please clarify.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

