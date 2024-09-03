Return-Path: <linux-pci+bounces-12667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626296A129
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95971C2412E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D71547F9;
	Tue,  3 Sep 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKRrOoEr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E56F30D;
	Tue,  3 Sep 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375073; cv=none; b=UHKecEn4MV7xLXQ8VdEyECH6Zm8ACjfnreJvPOixb6JY3luMwuY3lU+r/5+dNWGTWz/iPgsZDuJm0j0KxH4+xCZ1DsQFqnXOWT2D5G6xAGxLFcPqUtbjMdvTxuSqsyC0PU4rXEmvevptrmMQbDepVt5GyXy/g8xaP6IjAVTmKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375073; c=relaxed/simple;
	bh=ypa679/SQEuDxwGocMv1PijQXWWAn25QLhcHQVjpBvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWWuobfcfl5YmcfFQwZBmpYjmtgu4xGrcA+Oe5VZg5IVSuGU8D40u1Ogxh8G96wDc4tvDlTh9xht9y/yJLDZgpf04g8seTL/WRPGLNafIkpK0xeS9VrCD8KFTuGf7zsAcALELZx6KPxjnDO2lgFD+uc7JSJoP9yVveHVQNvucLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKRrOoEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB15C4CEC4;
	Tue,  3 Sep 2024 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725375073;
	bh=ypa679/SQEuDxwGocMv1PijQXWWAn25QLhcHQVjpBvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKRrOoEr8Arhm+x7N/MQWDjafbcWFx427plpqZCa4XqNEEz40U3VnF/jyV8LBzro2
	 rhd4fdgdmKL06YnWnvFddjc/Y43BGD4hkRGRq31uC0QrLomc+wRenY2GPO7TNCrF6u
	 ecc7Hjf0MA5ZvwOnZlKW5gFWiP9dOA2OpkwbwxcIU6w0fmh0mtF1DQdfDSfimIOmSk
	 K9jDMjw/e/vH6QmOqAlDDPYEeh57cs3IYYfcNQkKycOygMri4+7JgmiL2TrbCo4yJ0
	 qkyfvehSn6RfDXf+klpP4OEwxk36nhpfDZqhQUaGNOU+bfzKGtsAmgAQqQLeWGLqQN
	 72A9KfzPuZJzQ==
Date: Tue, 3 Sep 2024 08:51:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	acelan.kao@canonical.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <ZtciXnbQJ88hjfDk@kbusch-mbp>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> On Tue, Sep 3, 2024 at 12:29 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
> > > ready, so the requested IO is considered never completed:
> > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> > >
> > > The is documented as erratum MTL016 [0]. The suggested workaround is to
> > > "The VMD MSI interrupt-handler should initially perform a dummy register
> > > read to the MSI initiator device prior to any writes to ensure proper
> > > PCIe ordering." which essentially is adding a delay before the interrupt
> > > handling.
> > >
> >
> > Why can't you add a dummy register read instead? Adding a delay for PCIe
> > ordering is not going to work always.
> 
> This can be done too. But it can take longer than 4us delay, so I'd
> like to keep it a bit faster here.

An added delay is just a side effect of the read. The read flushes
pending device-to-host writes, which is most likely what the errata
really requires. I think Mani is right, you need to pay that register
read penalty to truly fix this.

> > > +     /* Erratum MTL016 */
> > > +     VMD_FEAT_INTERRUPT_QUIRK        = (1 << 6),
> > >  };
> > >
> > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > >   */
> > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > >
> > > +static bool interrupt_delay;
> > > +
> > >  /**
> > >   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
> > >   * @node:    list item for parent traversal.
> > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > >       struct vmd_irq_list     *irq;
> > >       bool                    enabled;
> > >       unsigned int            virq;
> > > +     bool                    delay_irq;
> >
> > This is unused. Perhaps you wanted to use this instead of interrupt_delay?
> 
> This is leftover, will scratch this.

Maybe you should actually use it instead of making a global? The quirk
says it is device specific, so no need to punish every device if it
doesn't need it (unlikely as it is to see such a thing).

