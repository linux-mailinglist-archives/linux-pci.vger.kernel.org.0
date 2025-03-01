Return-Path: <linux-pci+bounces-22707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07890A4AD91
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 20:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4683B5BA0
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDC1C5D77;
	Sat,  1 Mar 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLa0zLtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424391BD01F;
	Sat,  1 Mar 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858577; cv=none; b=QjsIXfWROzyJ0XvliOBWZBPJhxShi4ILK9NclFxWx0hZ2yHJ2tgdWPhAjdERpbDm2chbSkAslhEwi4H/NMEC+kngmQxgta5Pp8u7mJ7WmWHc1+P4SCTFFAtW9rJnKErxFTuIqXpdJ00PM1BY/JdL7jkLvNlLX0mLofKRlom5pjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858577; c=relaxed/simple;
	bh=9odiYJC9DPemt6LxEsKMW4Rhg8ObrgW4I1OHQ0BcBpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiPzcOyGV98wT8XqZP6yfmLkiJPqJI7OQX5ll/ow9FMQkj3qU6ZK+qN0zsh/VFyq+lSkFV14nPad7FxOeQzmOG2bW2dewEwc7Y4OOkBNGmjAYWlS9NSl7C7cstWgn+aXtO9dPzRwQgP+5Qpjxx1E1UvRGEvtWc95pfAKY3Pxij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLa0zLtg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feb867849fso3779175a91.3;
        Sat, 01 Mar 2025 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740858575; x=1741463375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m40WT/R1Hk9XjcXHYp23RySZqhVIaD/d4See+TNH5ng=;
        b=GLa0zLtgzNBJTrHfPNzzsEGhaT714bBFF6rlhFW72e+CHxMtWBgsc4GlXXJpvNRbNJ
         Hgijy5fWt6tUQMeahPBA0X/ZnCvj2gjP3wovi6Y4tcRyhly54dvCQ25dtyBc1JYKJJqP
         h530LcHKqjQBy3MQhPU0yFX9r3HFNPUZRv7SJkhW6MAmpSBPrSQb4x8LKJUkZb6Vi9sm
         TDLqG2kI+waxQWLZ1Z5Entkl436lTvcALDOk8i060BQrWQG79UaFxVgmf2Y64Lyw0g63
         HHBbQcUzSXOwmsxt77uMj5EKKLw8HbpUmOWk3sHvPw80WkKDzb9SRci+paHcv9rjeUE6
         Cv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740858575; x=1741463375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m40WT/R1Hk9XjcXHYp23RySZqhVIaD/d4See+TNH5ng=;
        b=UFzZVdXqXSuV2GKMiPQbEIXBGrHLbBLcMywKcHdPf8DeBjLb3SJIGi5l7MPOFpHnNo
         D8HKpQGFHYEAQi7mjP2UrujbDFzzloD0NNgYiszUZMEPLhPcv8eitklVbB0h6xozcsik
         ZbsupjNnSs4iEMpM0gka90KuIE46BC2HAbDo400tkc0zthDXF1AqskuFfCPQc5i8FyVm
         l2cRUGg83V+DEvqkCU9pWU2Z97Ffl4fpyma8mighSATYvgHdfkC2LH/j2b/0Bu5ABFxH
         ruBuXhgJtz0E4ALPKIN/Wch/7vb/5wmIikElEKEXQtZtbxYUCR3j+SHVEuZ97ld/kxqo
         Ubdg==
X-Forwarded-Encrypted: i=1; AJvYcCWWuPf2TragQzpU5C/NhHnaPJ/4xs9/p8FNTCzYuKEB5x9FeHKVYUTuJ0LYPS7ngUI2jV2ArcSOWGj0@vger.kernel.org, AJvYcCXx9mJxIA8Qu0DLhWdnUBgFi9WQ+haCzISvQixaJBBiAY7ihg+I/8ywDoJqrS9bOI2wxuI7WR+7/+cnWEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1lcGl7FE0roF72GFtLnU5Zu8mbJ7yiZoQXhIJW0MkIhW+ruD
	FPMZL5rzmPFEuAaCBhC9l/W2sNEl7SiVbo8/cxqQ5sAqcweZk/sc1TAPuyZoePGE22MDLt+O5Gf
	L2/NTEsHfA/hdXb5H8yJJsYtBg/0=
X-Gm-Gg: ASbGncusFdoqPJPmuDaKavB+h+wqXPQ2QJEM0qTYfj4lnfaJhnU+7eqbyBxDHods8rx
	nHxFTVpuj6Y08wKHPLz8j+VBqGATpsjyGrfD5F5a3/xaO7uyUVGG3TJua/+UgvAKVTmUJJ4766+
	arhvaf8sGl5MBpQ6ADLYbQJkJ0XSA=
X-Google-Smtp-Source: AGHT+IG6VIaqEiLWSNudy9fvUgj2q/O4B65YH3aD9+BudKFfhKZtSgF1Q6oGItRLDasMJpxPlIqDkJhsAoCNQM+4oAY=
X-Received: by 2002:a17:90b:1b47:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2febab2eea1mr11010484a91.5.1740858575254; Sat, 01 Mar 2025
 11:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874k0bf7f7.wl-maz@kernel.org> <20250226215001.GA556020@bhelgaas>
In-Reply-To: <20250226215001.GA556020@bhelgaas>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Sat, 1 Mar 2025 19:49:23 +0000
X-Gm-Features: AQ5f1JqPCWHmgRYiAV51ne0zUw7IIgk6c2vpYfvdZjevZ7Cydlxsc9mtbXskS3k
Message-ID: <CAEzXK1qtSRVS0TYAwMHTYh=7edO604iRKuXMQNMO_MC+-hunQg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

First of all I have to admire your work maintaining so many systems
and architectures and in particular the mvebu platform and I would
like to offer my help for testing the patches with your guidance.

I have essentially five working Armada A388 systems, one from solidrun
and the other four are my own creation, a mini-DTX board that I
designed and built for my home use, although at some point I planned
to sell those boards, but it did workout due to my PhD that consumed
too much time. I am now planning to do some NAS units with it and
possibly sell them. In any way, long story short I've read in some
threads about mvebu that PCIe is broken, and I say that it is not, the
secret to have PCIe working is to use a good u-boot bootloader. Many
recent u-boot versions cause the PCIe not to work on boot and I
haven't figured out why yet. In fact my A388 systems are working with
the amdgpu driver and an AMD Polaris, a RX 550 with 4GB VRAM. I have
been succesfully using PCIe with this old u-boot version:
https://github.com/SolidRun/u-boot-armada38x repo and branch
u-boot-2013.01-15t1-clearfog. The system has 2GB of RAM and I am able
to use the Ubuntu desktop and even navigate the web with Firefox, or
watch 4K H265 videos with Kodi. The amdgpu driver works stable for
several weeks in a row of power-up time, although since a year ago
there is a regression in drm_buddy that freezes 32-bits systems on
boot, but I have reverted that patch locally and have it working with
kernel Vanilla 6.9.6. Yes, I know I should have reported it to the
amdgpu team, but I have been very busy during this period. I hope to
do it soon, would like to debug it better even with OpenOCD and a
remote GDB for the kernel code.

Please let me know if I can be of help.

Thanks & best regards,
Luis Mendes

On Wed, Feb 26, 2025 at 9:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jun 23, 2022 at 09:31:40PM +0100, Marc Zyngier wrote:
> > On Thu, 23 Jun 2022 17:49:42 +0100,
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Jun 23, 2022 at 06:32:40PM +0200, Pali Roh=C3=A1r wrote:
> > > > On Thursday 23 June 2022 11:27:47 Bjorn Helgaas wrote:
> > > > > On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Roh=C3=A1r wrote:
> > > > > > Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark:
> > > > > > Rewrite IRQ code to chained IRQ handler"") for pci-aardvark
> > > > > > driver, use devm_request_irq() instead of chained IRQ
> > > > > > handler in pci-mvebu.c driver.
> > > > > >
> > > > > > This change fixes affinity support and allows to pin
> > > > > > interrupts from different PCIe controllers to different CPU
> > > > > > cores.
> > > > >
> > > > > Several other drivers use irq_set_chained_handler_and_data().
> > > > > Do any of them need similar changes?
> > > >
> > > > I do not know. This needs testing on HW which use those other
> > > > drivers.
> > > >
> > > > > The commit log suggests that using chained IRQ handlers breaks
> > > > > affinity support.  But perhaps that's not the case and the
> > > > > real culprit is some other difference between mvebu and the
> > > > > other drivers.
> > > >
> > > > It is possible. But similar patch (revert; linked below) was
> > > > required for aardvark. I tested same approach on mvebu and it
> > > > fixed affinity support.
> > >
> > > This feels like something we should understand better.  If
> > > irq_set_chained_handler_and_data() is a problem for affinity, we
> > > should fix it across the board in all the drivers at once.
> > >
> > > If the real problem is something different, we should figure that
> > > out and document it in the commit log.
> > >
> > > I cc'd Marc in case he has time to educate us.
> >
> > Thanks for roping me in.
> >
> > The problem of changing affinities for chained (or multiplexing)
> > interrupts is, to make it short, that it breaks the existing
> > userspace ABI that a change in affinity affects only the interrupt
> > userspace acts upon, and no other. Which is why we don't expose any
> > affinity setting for such an interrupt, as by definition changing
> > its affinity affects all the interrupts that are muxed onto it.
> >
> > By turning a chained interrupt into a normal handler, people work
> > around the above rule and break the contract the kernel has with
> > userspace.
> >
> > Do I think this is acceptable? No. Can something be done about this?
> > Maybe.
> >
> > Marek asked this exact question last month[1], and I gave a detailed
> > explanation of what could be done to improve matters, allowing this
> > to happen as long as userspace is made aware of the effects, which
> > means creating a new userspace ABI.
> >
> > I would rather see people work on a proper solution than add bad
> > hacks that only work in environments where the userspace ABI can be
> > safely ignored, such as on an closed, embedded device.
> >
> > [1] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/
>
> OK, this patch [2] has languished forever, and I don't know how to
> move forward.
>
> The patch basically changes mvebu_pcie_irq_handler() from a chained
> IRQ handler to a handler registered with devm_request_irq() so it can
> be pinned to a CPU.
>
> How are we supposed to decide whether this is safe?  What should we
> look at in the patch?
>
> IIUC on mvebu, there's a single IRQ (port->intx_irq, described by a DT
> "intx" in interrupt-names) that invokes mvebu_pcie_irq_handler(),
> which loops through and handles INTA, INTB, INTC, and INTD.
>
> I think if port->intx_irq is pinned to CPU X, that means INTA, INTB,
> INTC, and INTD are all pinned to that same CPU.
>
> I assume changing to devm_request_irq() means port->intx_irq will
> appear in /proc/interrupts and can be pinned to a CPU.  Is it a
> problem if INTA, INTB, INTC, and INTD for that controller all
> effectively share intx_irq and are pinned to the same CPU?
>
> AFAICT we currently have three PCI host controllers with INTx handlers
> that are registered with devm_request_irq(), which is what [2]
> proposes to do:
>
>   advk_pcie_irq_handler()
>   xilinx_pl_dma_pcie_intx_flow()
>   xilinx_pcie_intr_handler()
>
> Do we assume that these are mistakes that shouldn't be emulated?
>
> [2] https://lore.kernel.org/r/20220524122817.7199-1-pali@kernel.org
>

