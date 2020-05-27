Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B1E4A65
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391275AbgE0Qh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 12:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388698AbgE0Qh6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 12:37:58 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6E420C56;
        Wed, 27 May 2020 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590597477;
        bh=1ElavpxIOb162jTK3qnHRLYZHlidGmYNpnubB2FcWVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CSc6KbFP5IFSMVcU25BkGBaUGo+R9FqeOUCt0o2DX9mgcvg9JruRp4Qn39hDf4q0i
         qVL3+P2ip5hAxLC9gyhnXqNnQsMatS0i6bSAKMCmov1ZykA8eVNixPS2WD7udS6r79
         jzeA3QvVJfUAzMRLrHRZJGYtHCoTKuSbOuKSzCpY=
Received: by mail-ot1-f50.google.com with SMTP id o13so49841otl.5;
        Wed, 27 May 2020 09:37:57 -0700 (PDT)
X-Gm-Message-State: AOAM533hGsrLGktGZHWCHsNJKYbPWWGHxCzLDRHIUnh0XfBROLtkf0xt
        RqKoCUEC5KojnsSjn6jJBXiwK/wut8ktQA6+WQ==
X-Google-Smtp-Source: ABdhPJypzvc3q05z4AIUaGBF+aU21FPPXvUjMSTRC9ZOMkYJnnpBx8mSfd2Yxm6R6AYCBI8u4iJP95DuhMIdrGo2nfU=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr4952847ote.107.1590597476323;
 Wed, 27 May 2020 09:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200522033631.32574-1-kishon@ti.com> <20200522033631.32574-4-kishon@ti.com>
 <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
 <df29309d-8401-4040-eb1e-90bb3af93a82@ti.com> <CAL_JsqLy9T8O81stSW8RHpsUXFFjon80VG9-Jgync1eVR4iTew@mail.gmail.com>
 <b3663862-44df-867f-0824-28802909f224@ti.com>
In-Reply-To: <b3663862-44df-867f-0824-28802909f224@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 May 2020 10:37:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMZxOFw-kn5_9bNTPzJuwHybJAi6iQyBq=6BrKSvfTqA@mail.gmail.com>
Message-ID: <CAL_JsqJMZxOFw-kn5_9bNTPzJuwHybJAi6iQyBq=6BrKSvfTqA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 4:49 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 5/26/2020 8:42 PM, Rob Herring wrote:
> > On Sun, May 24, 2020 at 9:30 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 5/22/2020 9:24 PM, Rob Herring wrote:
> >>> On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>>
> >>>> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
> >>>> 32-bit accesses for reading or writing to Cadence registers. Convert all
> >>>> read and write accesses to 32-bit in Cadence PCIe driver in preparation
> >>>> for adding PCIe support in TI's J721E SoC.
> >>>
> >>> Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
> >>> with this and never can be given the PCI_COMMAND and PCI_STATUS
> >>> registers are in the same word (IIRC, that's the main reason 32-bit
> >>> config space accesses are broken). So this isn't going to work at
> >>
> >> right, PCI_STATUS has write '1' to clear bits and there's a chance that it
> >> could be reset while raising legacy interrupt. While this cannot be avoided for
> >> TI's J721E, other platforms doesn't have to have this limitation.
> >>> least for EP accesses. And maybe you need a custom .raise_irq() hook
> >>> to minimize any problems (such as making the RMW atomic at least from
> >>> the endpoint's perspective).
> >>
> >> This is to make sure EP doesn't update in-consistent state when RC is updating
> >> the PCI_STATUS register? Since this involves two different systems, how do we
> >> make this atomic?
> >
> > You can't make it atomic WRT both systems, but is there locking around
> > each RMW? Specifically, are preemption and interrupts disabled to
> > ensure time between a read and write are minimized? You wouldn't want
> > interrupts disabled during the delay too though (i.e. around
> > .raise_irq()).
>
> Okay, I'll add spin spin_lock_irqsave() in cdns_pcie_write_sz(). As you also
> pointed below that delay for legacy interrupt is wrong and it has to be fixed
> (with a later series).

But you don't need a lock everywhere. You need locks in the callers
(and only sometimes).

> How do you want to handle cdns_pcie_ep_fn_writew() now? Because now we are
> changing the default implementation to perform only 32-bit access (used for
> legacy interrupt, msi-x interrupt and while writing standard headers) and it's
> not okay only for legacy interrupts for platforms other than TI.

Now I'm wondering how set_msi is not racy in the current code with the
host setting/clearing PCI_MSI_FLAGS_ENABLE? Maybe that bit is RO from
the EP side?

Ultimately I think you're going to have to provide your own endpoint
functions or you need accessors for specific registers like
PCI_MSI_FLAGS. Then for example, you just rely on the 2 bytes before
PCI_MSI_FLAGS being reserved and do a 32-bit access without a RMW.
Trying to abstract this at the register read/write level is going to
be fragile.

Rob
