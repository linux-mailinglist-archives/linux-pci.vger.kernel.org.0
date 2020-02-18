Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7C162F68
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRTJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 14:09:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44737 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTJX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2020 14:09:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so15293576lfa.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2020 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgC+KcoeEeyex6eD3mMv5OuL0TkVAKrfj+D1k7Ogeuw=;
        b=B7SdNIl5IuU5K9WpPsBZx8JhLBx4fcihbbhrLKIvbz4QwExJuv3DWqhoiGC8ZIT2N+
         0+7CBvSyOSHs+Yyomv29TbnfyH343iJX6GdGiK99hbWfXVocIxGU5HUhSc8j6xlgpi3X
         A+bGtseJKGz7F8M1cOwlu3ZTZZQUei37cDAigXu1DclhFt6dPQbkmfO7iKpoypxLBrnr
         IFESohfOEtq5Mrks2mPKYXZT66lsu8tofpUq3DUj06Sm5LpNi7B2OUUcKq2PxEEivKGt
         Otcy+/SdZdN6nV01wu62lRZWFz4mjBSXBphXpOInkHduve4r8pp07P7dXYcDjftabJ/D
         aogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgC+KcoeEeyex6eD3mMv5OuL0TkVAKrfj+D1k7Ogeuw=;
        b=knCNSt8oNlnDxTTQXU9R7jKSi654Tu1Wv6cElDuIFoZ400PPaq9xDu6vuoiy+Mhz05
         ylFIyPGbW3slvKO7RPdaQwBMwpiDQ4T3THki5JRKfDvv5mb2OjOJv+mc2DkNh4t9nOi2
         SYDYANcolNDzBRZXOwohZbWiyEX6FTBqWJWGNZkgkvJo6th2BSAnfd3CdhozxS4HlAos
         mskvdkQqPU+B4KdXFoycBLCz/uMqn6E4QvyR26ZEqG8MAWOfCPGnbHczNpK6sxgAZpjR
         wNWgyXSjwAj0tF8OGbdQXJlG9UNort0mZaDEXlnfQApKHCy6/R5hGxnCN8C2CsPcZ9MH
         RuzA==
X-Gm-Message-State: APjAAAUAWIl61ae7tTGpi6TrXv+0uWjb5zVAiSmqa2qZ09rGdAAWEhcv
        ii6H5ZPbXLfTAltqE667unIUHMAyFQiphujn2raqmw==
X-Google-Smtp-Source: APXvYqyQa7SCnKGAund4lr/pos/r4SSc5cZAOL8kfuir0DSmhrrLVzgnRx9UUogyHTUSI5sPAqW9V3GBHuZN4nZBbgg=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr11044121lfg.47.1582052961407;
 Tue, 18 Feb 2020 11:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20170821192907.8695-3-ard.biesheuvel@linaro.org>
 <1581728065-5862-1-git-send-email-alan.mikhak@sifive.com> <CAKv+Gu9W0v9owp85hkAatwCvu-y9z4BZxvbKf92N-s_nnD910Q@mail.gmail.com>
 <867e0o6ssr.wl-maz@kernel.org>
In-Reply-To: <867e0o6ssr.wl-maz@kernel.org>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 18 Feb 2020 11:09:10 -0800
Message-ID: <CABEDWGxDz6njYYQN879XnGmY2vxOKvbygeg=9nBK54U6WP8_ug@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 15, 2020 at 2:36 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 15 Feb 2020 09:35:56 +0000,
> Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (updated some email addresses in cc, including my own)
> >
> > On Sat, 15 Feb 2020 at 01:54, Alan Mikhak <alan.mikhak@sifive.com> wrote:
> > >
> > > Hi..
> > >
> > > What is the right approach for adding MSI support for the generic
> > > Linux PCI host driver?
> > >
> > > I came across this patch which seems to address a similar
> > > situation. It seems to have been dropped in v3 of the patchset
> > > with the explanation "drop MSI patch [for now], since it
> > > turns out we may not need it".
> > >
> > > [PATCH 2/3] pci: designware: add separate driver for the MSI part of the RC
> > > https://lore.kernel.org/linux-pci/20170821192907.8695-3-ard.biesheuvel@linaro.org/
> > >
> > > [PATCH v2 2/3] pci: designware: add separate driver for the MSI part of the RC
> > > https://lore.kernel.org/linux-pci/20170824184321.19432-3-ard.biesheuvel@linaro.org/
> > >
> > > [PATCH v3 0/2] pci: add support for firmware initialized designware RCs
> > > https://lore.kernel.org/linux-pci/20170828180437.2646-1-ard.biesheuvel@linaro.org/
> > >
> >
> > For the platform in question, it turned out that we could use the MSI
> > block of the core's GIC interrupt controller directly, which is a much
> > better solution.
> >
> > In general, turning MSIs into wired interrupts is not a great idea,
> > since the whole point of MSIs is that they are sufficiently similar to
> > other DMA transactions to ensure that the interrupt won't arrive
> > before the related memory transactions have completed.
> >
> > If your interrupt controller does not have this capability, then yes,
> > you are stuck with this little widget that decodes an inbound write to
> > a magic address and turns it into a wired interrupt.
>
> I can only second this. It is much better to have a generic block
> implementing MSI *in a non multiplexed way*, for multiple reasons:
>
> - the interrupt vs DMA race that Ard mentions above,
>
> - MSIs are very often used to describe the state of per-CPU queues. If
>   you multiplex MSIs behind a single multiplexing interrupt, it is
>   always the same CPU that gets interrupted, and you don't benefit
>   from having multiple queues at all.
>
> Even if you have to implement the support as a bunch of wired
> interrupts, there is still a lot of value in keeping a 1:1 mapping
> between MSIs and wires.
>
> Thanks,
>
>         M.
>
> --
> Jazz is not dead, it just smells funny.

Ard and Marc, Thanks for you comments. I will take a look at the code
related to MSI block of GIC interrupt controller for some reference.

I am looking into supporting MSI in a non-multiplexed way when using
ECAM and the generic Linux PCI host driver when Linux is booted
from U-Boot.

Specifically, what is the right approach for sharing the physical
address of the MSI data block used in Linux with U-Boot?

I imagine the Linux driver for MSI interrupt controller allocates
some DMA-able memory for use as the MSI data block. The
U-Boot PCIe driver would program an inbound ATU region to
map mem writes from endpoint devices to that MSI data block
before booting Linux.

Comments are appreciated.

Alan
