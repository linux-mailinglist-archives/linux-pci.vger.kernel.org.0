Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB6387A8F
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbhEROAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 10:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243689AbhEROAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 10:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0BFD61184;
        Tue, 18 May 2021 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621346367;
        bh=jSlJr3dPYi1GNZJQs0cLMGeeiXo/lBYu1Gef6Gm8Kks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZCjs8K31ZaQWM4HCALbCo9NRnOxJDuj6Df6U/BmYqL63dlIF0MaKKlwA/LKAGq3c3
         UYBgG8HkFEJGHRax3ZM3s2S2kAhvr8iZgbAVMswddVqaIfCe3LEzF7S/2yEfqTA+1P
         NgyEFeLktfvY85zUGmLRCzMPjUmrhJu8e6WxoISdHnQekCoWYTX45uW54dxp/VBHlX
         OmTOHP3ciDFAezKCPNLSO2sPQ2+NdHDJrA/eP1obJDe0mJnti7DPK6N8rRTHskX7Z8
         d7HqCB6QUL2OuE0wkIY6E+5HVm04gTtC/aSUW5GPr/KBXnPpkt0QPskbQWuaAA/OZ0
         Dejsm/wghO5rQ==
Date:   Tue, 18 May 2021 08:59:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20210518135925.GA116106@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H61Uc5D7+1pMR5xSJeBVXHwPttTtaPg6_gwJoYBywHjPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob, beginning of thread
https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn]

On Sat, May 15, 2021 at 11:52:53AM +0800, Huacai Chen wrote:
> On Fri, May 14, 2021 at 10:52 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> > 在 2021/5/14 16:00, Huacai Chen 写道:
> > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > >
> > > In LS7A, multifunction device use same pci PIN and different
> > > irq for different function, so fix it for standard pci PIN
> > > usage.
> >
> > Hmm, I'm unsure about this change.
> > The PCIe port, or PCI-to-PCI bridge on LS7A only have a single
> > upstream interrupt specified in DeviceTree, how can this quirk
> > work?
>
> LS7A will be shared by MIPS-based Loongson and LoongArch-based
> Loongson, LoongArch use ACPI rather than FDT, so this quirk is needed.

Can you expand on this a little bit?

Which DT binding are you referring to?  Is it in the Linux source
tree?

I think Linux reads Interrupt Pin for both FDT and ACPI systems, and
apparently that register contains the same value for all functions of
this multi-function device.

The quirk will be applied for both FDT and ACPI systems, but it sounds
like you're saying this is needed *because* LoongArch uses ACPI.

Bjorn
