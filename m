Return-Path: <linux-pci+bounces-12716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5796B179
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C591F21C47
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 06:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2885C5E;
	Wed,  4 Sep 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXTFruj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFB84E0A
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430947; cv=none; b=S16xAGu62Wxh97BL2YMj5lGPpuGjt00HUKXHnVMBdCt1MgzZte9L4yZzokdy6lfjUBxr+w5OsYMmHAkfOa1UYY8IUaLzygi5R7xyqpli+JWO8rAuxRcAnYOTadB8/nFjenKisR6woyy6aahdwwWd+20V0y7GKK8zDNIYud4JGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430947; c=relaxed/simple;
	bh=FO7/eg2n+yly83LuRtxVU2WlOjHeRHJhaGPjhuvmLeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFRikhj5j78jbxsk1DNeWDpMKLNB7AZTf0lBHkl4hzmGC17/pWmAjvfk/pb7eIgKo1D9TdzQdjTyMEzDUWmRWOUIOSLTen2Jxz76vWJhXpyWISQkHu86RnBSX91ZA1I8UNqorEMb6NDxoZ/b57phLmwCcQ1ErLD/7J06bhKimGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXTFruj1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2057c6c57b5so2253995ad.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725430945; x=1726035745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvx4PCK6P/x70ytMbdp6+XNFJeNRoV9prf+YBUPPRO0=;
        b=xXTFruj1r4hmU0+D91BUQP5CkIvyTfKBsFPI7WsQDX1Gt3cGPc7mdgDCjK/MDL5Fxf
         MRsr3NtY67h5xePE9cFDZdCUaluXokxJegDfIs9m5OK/Mn4xwwaEBFHP976A8hP35jbB
         mxeIcQHDl/TWK5iV6attimcbObn3mV5+K264/FOrzCf4j+QMYX4gY4eaXA5nii1/r5iX
         Eno0dsyPmIOgQtxjRQlyq37wBIU0dKfnme8W4H0pJdCLLH6pae6ptCR/M+pXShBQDDPo
         FeMhbOhZeL/aQUuBd6W0VLILGBlisnR2xumAwk84qQpUv14k3W8hfPqfNX0hX7kQYYtT
         zYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430945; x=1726035745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvx4PCK6P/x70ytMbdp6+XNFJeNRoV9prf+YBUPPRO0=;
        b=PPU+MV/uP6V1lW+l44uyuGdbTPP8qpmhnuZxyBC8nlqnbvaeOuMaOGiHz4t5bRaYJq
         3hPwY5kRU3Z8b/FISj47bFbYVW0CZkPEz5zv3YK81MDP3h+HVrjFvp4YgX+YCF4OD7Ms
         3PtFvWypyKNOlYsVAmeATvxrAk2iZ9btWxve82yBiiYl9lpt4uzUCCwreo7zn8b6FSRi
         O1mDxpAWoqTP2FJO+Sq83Wh6HibXyCDE7fePGQvrIaRVEKtV0NyFvI4jauSOi5oZCWAM
         PUOW9plyB9Jp8adXry7igS03SLuNkAGpcEh/ZZueYB6w2gSZ4dnSlz9jBMTTXEwNaZQl
         CDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFUzvj3RRVjpFub1+5BE90Lwj8ZNJ0r4dKWMq0LojsPsKuR9Svqst9qaquxXkHCGM5awDozfR5Zig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3x7AT1yLH3HpqgNomcagfTvdACs24dMWFZ63JddhbkCPPdtV
	K5eHRDvDTgGqkGp99QrBPEej0XSVQTUIOu70bfiRAyhbz1N7+lRhfvpFHd5tPA==
X-Google-Smtp-Source: AGHT+IFxH6Rr1LsBK8g6/owk9LowGpE1jvBIhUi6gZeytNmBAPTC6+GyIjdjZd2Lg+PefbI6Bg1K9Q==
X-Received: by 2002:a17:902:dac1:b0:202:4bd9:aea5 with SMTP id d9443c01a7336-206b833f304mr21086275ad.14.1725430944940;
        Tue, 03 Sep 2024 23:22:24 -0700 (PDT)
Received: from thinkpad ([120.56.207.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38435sm7168105ad.166.2024.09.03.23.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:22:24 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:52:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Keith Busch <kbusch@kernel.org>, nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev, acelan.kao@canonical.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <20240904062219.x7kft2l3gq4qsojc@thinkpad>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
 <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>

On Wed, Sep 04, 2024 at 09:57:08AM +0800, Kai-Heng Feng wrote:
> On Tue, Sep 3, 2024 at 10:51 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > > On Tue, Sep 3, 2024 at 12:29 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > > > Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
> > > > > ready, so the requested IO is considered never completed:
> > > > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > > > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > > > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > > > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> > > > >
> > > > > The is documented as erratum MTL016 [0]. The suggested workaround is to
> > > > > "The VMD MSI interrupt-handler should initially perform a dummy register
> > > > > read to the MSI initiator device prior to any writes to ensure proper
> > > > > PCIe ordering." which essentially is adding a delay before the interrupt
> > > > > handling.
> > > > >
> > > >
> > > > Why can't you add a dummy register read instead? Adding a delay for PCIe
> > > > ordering is not going to work always.
> > >
> > > This can be done too. But it can take longer than 4us delay, so I'd
> > > like to keep it a bit faster here.
> >
> > An added delay is just a side effect of the read. The read flushes
> > pending device-to-host writes, which is most likely what the errata
> > really requires. I think Mani is right, you need to pay that register
> > read penalty to truly fix this.
> 
> OK, will change the quirk to perform dummy register read.
> 
> But I am not sure which is the "MSI initiator device", is it VMD
> controller or NVMe devices?
> 

'MSI initiator' should be the NVMe device. My understanding is that the
workaround suggests reading the NVMe register from the MSI handler before doing
any write to the device to ensures that the previous writes from the device are
flushed.

And this sounds like the workaround should be done in the NVMe driver as it has
the knowledge of the NVMe registers. But isn't the NVMe driver already reading
CQE status first up in the ISR?

- Mani

> Kai-Heng
> 
> >
> > > > > +     /* Erratum MTL016 */
> > > > > +     VMD_FEAT_INTERRUPT_QUIRK        = (1 << 6),
> > > > >  };
> > > > >
> > > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > > > >   */
> > > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > > >
> > > > > +static bool interrupt_delay;
> > > > > +
> > > > >  /**
> > > > >   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
> > > > >   * @node:    list item for parent traversal.
> > > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > > >       struct vmd_irq_list     *irq;
> > > > >       bool                    enabled;
> > > > >       unsigned int            virq;
> > > > > +     bool                    delay_irq;
> > > >
> > > > This is unused. Perhaps you wanted to use this instead of interrupt_delay?
> > >
> > > This is leftover, will scratch this.
> >
> > Maybe you should actually use it instead of making a global? The quirk
> > says it is device specific, so no need to punish every device if it
> > doesn't need it (unlikely as it is to see such a thing).

-- 
மணிவண்ணன் சதாசிவம்

