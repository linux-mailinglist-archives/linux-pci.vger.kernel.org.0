Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01DB34FD8E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCaJ5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234375AbhCaJ5D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 05:57:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FFED6195C;
        Wed, 31 Mar 2021 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617184622;
        bh=8rL65lt1qV8iT7ZE18EYU50vT0TsGC32h7IxPz6FjaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhf+WD7AxKKtAeGLC3msHJEc36Ka122A2z7DM46mkLJ8sYCh8sb/8VhTRP/9zxzuV
         2kzdMfgvL2NsjL+sSYaOoRPBEvfZ7Tq/w0kJixoaOLVl6i/xOFxtA1cCMLQs1pHq1D
         xh8Ot/WowRQe7FoAMBZfZ1tfYdDT+PxfxT4nV4jtXTD6SI9ZHmg4v51/Jyrdga/L+2
         boe+OsxKwajjFIWBYkHNHUioTgp3f8ffWUEf7f/Mz0fmml+oqq5WU0oENhn7vW+Nke
         q/jpGscRCnE7PWJyRC23Y3iYekdr9j4YECCacLxCN1YtUK62kcmI1lpHssO4p1NXEI
         Lkob02lSIaCUg==
Received: by pali.im (Postfix)
        id 6E216AF7; Wed, 31 Mar 2021 11:56:59 +0200 (CEST)
Date:   Wed, 31 Mar 2021 11:56:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: Interrupts in pci-aardvark
Message-ID: <20210331095659.dmnbn3aiblbnk7qe@pali>
References: <20210328140912.k33qqfpkizdtlrcp@pali>
 <87im58rd3o.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im58rd3o.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 March 2021 14:21:47 Marc Zyngier wrote:
> On Sun, 28 Mar 2021 15:09:12 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> 
> [...]
> 
> > Aardvark HW allows to mask summary TOP, summary CORE, individual CORE
> > (PME, ERR, INTA, INTB, ...), summary MSI and individual MSI bits
> > interrupts, but not final 16 bit MSI interrupt number. MSI bits are low
> > 5 bits of 16 bit interrupt number. So it is not possible to mask or
> > unmask MSI interrupt number X. It is possible to only mask/unmask all
> > MSI interrupts which low 5 bits is specific value.
> 
> If you cannot mask individual MSIs, you have two choices:
> 
> - you only support MSI-X *or* MSI (not multi-MSI) and mask interrupts
>   at the device level

There is no information in available documentation how to implement
MSI-X in Root Complex mode, so currently MSI-X is not possible.

> - you restrict the number of MSIs to those you can actually control,
>   and that's 2^5 = 32 (which is what the driver currently supports, I
>   believe).

Well, 32 MSI interrupts is not enough for new modern wifi cards. E.g.
QCA6390 (ath11k) wifi card requires 32 interrupts and when this card is
connected to 2 port PCIe packet switch then packet switch requires 3
additional interrupts (1 for downstream and 1 for each upstream = 1+2).
So in this setup at least 64 MSI interrupts are required because PCI
functions of packet switch are initialized first (take interrupts 0,1,2)
and then is initialized wifi card which requires 32 aligned interrupts
(so 32,33,...,63). This setup is common on existing A3720 hardware:
Turris Mox with Mox G module.

Currently aardvark driver unmask all MSI interrupts and does not
implement masking/unmasking callbacks for individual interrupts.
Currently it has implemented support for 32 individual interrupts.

So it is an issue if masking / unmasking stay unimplemented?

> > Also aardvark HW allows to globally enable / disable processing of MSI
> > interrupts. Masking summary MSI interrupt just cause that GIC does not
> > trigger it but from registers I can read it (e.g. when GIC calls
> > aardvark interrupt handler for other non-MSI interrupt).
> > 
> > And I would like to ask, what is in this hierarchy from kernel point of
> > view "bottom part of MSI" and what is the "upper part of MSI"? As in
> > above diagram there are 3 MSI layers.
> 
> The upper part is the bus-specific part, PCI in your case. You don't
> need to implement it.

Ok!

> The bottom part controls the HW, and deals with all the masking,
> acknoledgement, allocation and demuxing.

So it is basically everything related to MSI interrupts in that diagram.

> > And which irq enable/disable/mask/unmask/ack callbacks I need to
> > implement for legacy irq, bottom MSI and upper MSI domains?
> 
> You need to provide what makes sense for your HW. I would guess that
> you need at least mask/unmask and most probably ack at both levels,
> and of course a compose_msg callback at the bottom level.
> 
> > And where should I add code which globally enable/disable receiving of
> > aardvark MSI interrupts? Currently it is part of aardvark driver probe
> > function.
> 
> Seems like the logical place to put it. The kernel deals with
> individual interrupts, and not with global switches.

Global enable is needed to call also when HW resume from suspend state.
Suspend is not currently implemented, but I would like to know what is
the preferred way, where to put "MSI initialization code" which needs
to be called for "global initialization & enable" and also after wakeup
from suspend. Has struct irq_chip callback for this action? Or such code
really should be called in driver probe function and then also in driver
resume function?
