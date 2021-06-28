Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737AE3B69E9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhF1UyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 16:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235419AbhF1UyK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 16:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED8A61CCE;
        Mon, 28 Jun 2021 20:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624913504;
        bh=6Rw9kC7+BoZjYRTXQe/wrVuyAruZixMncl8jeldbNCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QyPZ/HjKwEK7VC0C4V1xDS6siEHa1AqR5/yAmpRG1mSfYKowH4W3gTeZLMrCWD8b2
         Bg2zWFPfHSwD8ODtoB3G3qpiW4D3T07bhwcPKDP07VwN46GPEPTu0CH6oPiNTsSIzT
         uf2yMCW4CQQNZyXo8gwG5RHmwbUsaYalKk8WyOWGS/WWO8vU0guwh9/qDtG73K72Zw
         CYVOXqifkIXDx2pfXeg4BF0rZeCOVKp6jBBTRk/gwNcbhE6TzRDsZ0j9gSS4nohfSW
         MblCmzUOuj7Ibi6kxVB2Ail0TekxTwUAXsPu6EDLi8F1qCMJzOUVemzk5M6bGgwLDT
         HWvoPh31M/WUg==
Date:   Mon, 28 Jun 2021 15:51:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210628205143.GA3955911@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H68tBbTxoy-qOP4F3KDWEjunZMC-v3dAPWfU==NCMBbyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 27, 2021 at 06:25:04PM +0800, Huacai Chen wrote:
> On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > but their maximum supported MRRS values are not detectable. Moreover,
> > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > > will actually set a big value in its driver. So the only possible way is
> > > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > >
> > > However, according to PCIe Spec, it is legal for an OS to program any
> > > value for MRRS, and it is also legal for an endpoint to generate a Read
> > > Request with any size up to its MRRS. As the hardware engineers says,
> > > the root cause here is LS7A doesn't break up large read requests (Yes,
> > > that is a problem in the LS7A design).
> >
> > "LS7A doesn't break up large read requests" claims to be a root cause,
> > but you haven't yet said what the actual *problem* is.
> >
> > Is the problem that an endpoint reports a malformed TLP because it
> > received a completion bigger than it can handle?  Is it that the LS7A
> > root port reports some kind of error if it receives a Memory Read
> > request with a size that's "too big"?  Maybe the LS7A doesn't know
> > what to do when it receives a Memory Read request with MRRS > MPS?
> > What exactly happens when the problem occurs?
>
> The hardware engineer said that the problem is: LS7A PCIe port reports
> CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big".

What is "too big"?

I'm trying to figure out how to make this work with hot-added devices.
Per spec (PCIe r5.0, sec 7.5.3.4), devices should power up with
MRRS=010b (512 bytes).

If Linux does not touch MRRS at all in hierarchices under LS7A, will a
hot-added device with MRRS=010b work?  Or does Linux need to actively
write MRRS to 000b (128 bytes) or 001b (256 bytes)?

Bjorn
