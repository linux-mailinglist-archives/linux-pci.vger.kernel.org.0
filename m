Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2963B6C66
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 04:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhF2CO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 22:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhF2CO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 22:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CFF61CD4;
        Tue, 29 Jun 2021 02:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624932753;
        bh=40DfyvAwaRSwoO4YmkDwh7OGHM66xbwjoAxB96ffGb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J79tZ/W7+LQ/JxNsP8wybCA63bP3yzIJ0csoFeAsr9a9zUkYAkmGA2OoHzwPWbnqq
         oim3Jve9yPbr2pkPGdQfLtbAy0LWlcvh/YshKTzQrNRcSMyaGWCwH9kzGngDXbrTOY
         XfMLwOA84Y7SEVy26k4flv/SLZ8KhI5z9eK+Xgy3HYgh5grR1t46EauasOs3kbo5z9
         xJu3/12DPVCylugFDY6q1dh++okvtqnng8BlXroYHhBxrtFG2gadzvc3DmA66BNdAF
         jjk5UdYqjOVECzwyr5/KVYAl6pqlcUIHa+g52es0BPSFP0ss54fItQJ0tH7YuLrmtw
         NUlSI4IcQ1R+g==
Date:   Mon, 28 Jun 2021 21:12:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210629021231.GA3982831@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6rmQjfeOhoLDUu_rCBGLUrL_Vi4wRAgNzSjEdOjSjUmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 29, 2021 at 10:00:20AM +0800, Huacai Chen wrote:
> On Tue, Jun 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Jun 27, 2021 at 06:25:04PM +0800, Huacai Chen wrote:
> > > On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > > > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > > > but their maximum supported MRRS values are not detectable. Moreover,
> > > > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > > > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > > > > will actually set a big value in its driver. So the only possible way is
> > > > > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > > > > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > > > >
> > > > > However, according to PCIe Spec, it is legal for an OS to program any
> > > > > value for MRRS, and it is also legal for an endpoint to generate a Read
> > > > > Request with any size up to its MRRS. As the hardware engineers says,
> > > > > the root cause here is LS7A doesn't break up large read requests (Yes,
> > > > > that is a problem in the LS7A design).
> > > >
> > > > "LS7A doesn't break up large read requests" claims to be a root cause,
> > > > but you haven't yet said what the actual *problem* is.
> > > >
> > > > Is the problem that an endpoint reports a malformed TLP because it
> > > > received a completion bigger than it can handle?  Is it that the LS7A
> > > > root port reports some kind of error if it receives a Memory Read
> > > > request with a size that's "too big"?  Maybe the LS7A doesn't know
> > > > what to do when it receives a Memory Read request with MRRS > MPS?
> > > > What exactly happens when the problem occurs?
> > >
> > > The hardware engineer said that the problem is: LS7A PCIe port reports
> > > CA (Completer Abort) if it receives a Memory Read
> > > request with a size that's "too big".
> >
> > What is "too big"?
> >
> "Too big" means bigger than the port can handle, PCIe SPEC allows any
> MRRS value, but, but, LS7A surely violates the protocol here.

Right, I just wanted to know what the number is.  That is, what values
we can write to MRRS safely.

But ISTR you saying that it's not actually fixed, and that's why you
wanted to rely on what firmware put there.

This is important to know for the question about hot-added devices
below, because a hot-added device should power up with MRRS=512 bytes,
and if that's too big for LS7A, then we have a problem and the quirk
needs to be more extensive.

> > I'm trying to figure out how to make this work with hot-added devices.
> > Per spec (PCIe r5.0, sec 7.5.3.4), devices should power up with
> > MRRS=010b (512 bytes).
> >
> > If Linux does not touch MRRS at all in hierarchices under LS7A, will a
> > hot-added device with MRRS=010b work?  Or does Linux need to actively
> > write MRRS to 000b (128 bytes) or 001b (256 bytes)?
> >
> > Bjorn
