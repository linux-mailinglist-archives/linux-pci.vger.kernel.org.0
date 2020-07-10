Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ABF21B557
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJMpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJMpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 08:45:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF25C08C5CE
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 05:45:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v8so5874417iox.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZcRO1f+b9jNVOk+x2TB9QgvGJvzpJtVdNfPnEf5s1o=;
        b=GUYwLpsj8qQAESV2nZd93IXVIRWuIKi4fAaq36fiyQN+QxUJg0T4bppoDK9gQHLScZ
         YAAXDocKH5MOsyJXBEgwuG72PzgdztqVAgEH4w+z75r9Uj2DQZ8xay6QAmq1lI0ADqOq
         CtyWQlCoXV8NWFM0QNSlwS9UqM8BYnPXvWN2T3I0bW21ku15Gvf7ARrmVbumtEKDOPhB
         1BMsvfn3g37abilL4UdaVOXZMEceW+cW9EGAL5AL3rGnNz5dJcUQ5hKdmbJ43gVqvwD8
         /+3fUkS8N9dAZC1TAkv/rgcl7t4zGd5ehkS1Sof82TnBIFP9SNnF5wHaUe1tjJrTjFRT
         77YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZcRO1f+b9jNVOk+x2TB9QgvGJvzpJtVdNfPnEf5s1o=;
        b=UkEzFwH2dnEtB1+E19yKsxxPX2lJd7vv+Y710PxyPjfW28Urs3T2vtMdejfow5IkoX
         lh2dwK5nhl0Nw4xnD9E9VeP7RVvHq7mg7J0grrTImJns8Wgns9x2kiiLx0TGN9nFDh4T
         4G5NX5iqz873eHMxJraWCd9aAwWJYPyvHvf/7yAAFyUDVZkN2G8vFIsi58n+41Zgf/qT
         By47dDJblM06HvW77Nk1BOEPwoFZS85jAWrT7tcJk9eZhfkm51NCZSe9wMSuG6jIW4gB
         wJvhE1UyZvCBoR57EbE1gYVlPwD70FXD6AyPdljQ/pNwsk1ZCuUrYPAVWngAHlks/xOP
         R8UA==
X-Gm-Message-State: AOAM533pkiQu3wfajeUimFGljgyqL0UZtxVKKK0w3fai3NM/W7Giof07
        H62v1ZaLgOMGu4hQWfTnT7i6ZvT1WdKZaxrO7dpnZbHxrWo=
X-Google-Smtp-Source: ABdhPJxddDuO4dGAjJ2ezUEpnPpnjF6sV6CTpQ/0brpm0QJ+Wj5WblRjFKwmGirGRFIaag3TnGFsZuG4284+KODqSb8=
X-Received: by 2002:a02:b714:: with SMTP id g20mr69585673jam.117.1594385129117;
 Fri, 10 Jul 2020 05:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200710052340.737567-1-oohall@gmail.com> <20200710064535.GA8354@infradead.org>
In-Reply-To: <20200710064535.GA8354@infradead.org>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 10 Jul 2020 22:45:17 +1000
Message-ID: <CAOSf1CFj3x+V=0UwDpCOJ8v+sgSihUCaTbwwT1ziddPeYmD=Uw@mail.gmail.com>
Subject: Re: PowerNV PCI & SR-IOV cleanups
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 4:45 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jul 10, 2020 at 03:23:25PM +1000, Oliver O'Halloran wrote:
> > This is largely prep work for supporting VFs in the 32bit MMIO window.
> > This is an unfortunate necessity due to how the Linux BAR allocator
> > handles BARs marked as non-prefetchable. The distinction
> > between prefetch and non-prefetchable BARs was made largely irrelevant
> > with the introduction of PCIe, but the BAR allocator is overly
> > conservative. It will always place non-pref bars in the prefetchable
> > window, which is 32bit only. This results in us being unable to use VFs
> > from NVMe drives and a few different RAID cards.
>
> How about fixing that in the core PCI code?

I've been kicking around the idea but I've never managed to convince
myself that ignoring the non-prefetchable bit is a safe thing to do in
generic code. Since Gen3 at least the PCIe Base spec has provided some
guidance about when you can put non-prefetchable BARs in the
prefetchable window and as of the Gen5 spec it lists these conditions:

> 1) The entire path from the host to the adapter is over PCI Express.
> 2) No conventional PCI or PCI-X devices do peer-to-peer reads to the range mapped by the BAR.
> 3) The PCI Express Host Bridge does no byte merging. (This is believed to be true on most platforms.)
> 4) Any locations with read side-effects are never the target of Memory Reads with the TH bit Set.
> 5) The range mapped by the BAR is never the target of a speculative Memory Read, either Host initiated or peer-to-peer.

1) Is easy enough to verify.
2) Is probably true, but who knows.
3) I know this is true for the platforms I'm looking at since the HW
designers assure me there is no merging happening at the host-bridge
level. Merging of MMIO ops does seem like an insane thing to do so
it's probably true in general too, but there's no real way to tell.
4) Is also *probably* true since the TH bit is only set when it's
explicitly enabled via the TLP Processing Hints extended capability in
config space. I guess it's possible firmware might enable that without
Linux realising, but in that case Linux is probably not doing BAR
allocation.
5) I have no idea about, but it seems difficult to make any kind of
general statement about.

I might just be being paranoid.

Oliver
