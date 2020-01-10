Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1E1377C6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 21:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgAJUNB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 15:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgAJUNB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 15:13:01 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7E02072A;
        Fri, 10 Jan 2020 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578687180;
        bh=PfLHZGukc0z5xCBJJnlX/MhPi7LPVw3Zrifiaj+p2h8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WI0YJH38qrC0TTUUe4ebu68kdGoLYCfia+pun9R6ZUO1elt6XMdiFv8T/DimndHQq
         MK2AD2t09zFIxkgbMXKtemT6Jt/pB8VJVpmNknppjQmIWYaue7Lc7iqwRRCrC6Ws8F
         LxBog/ECbAumLfo6TasWJjjrdynb8cRhsxredF2c=
Date:   Fri, 10 Jan 2020 14:12:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     P J P <ppandit@redhat.com>, linux-pci@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: About pci_ioremap_bar null dereference
Message-ID: <20200110201258.GA83593@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve4WhwqKft_7nMi5Ys9N4Fs98G1FgKxpKZ59e_UyCsKuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 10, 2020 at 02:10:22PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 10, 2020 at 1:54 PM P J P <ppandit@redhat.com> wrote:
> >
> >    Hello Andy, Navid
> >
> >   -> https://git.kernel.org/linus/ea5ab2e422de0ef0fc476fe40f0829abe72684cd
> >
> > I was trying to understand this NULL dereference. IIUC, pci_ioremap_bar()
> > returning NULL indicates insufficient memory OR if the pci device is
> > configured to use I/O port address, instead of memory mapped region.
> >
> > I was wondering if(or how) it is reproducible for unprivileged user? Do you
> > happen to have a reproducer for it?
> 
> It's very unlikely to see IRL such problem. Theoretically  it may
> happen if the system in question has a LOT of devices connected to PCI
> and suddenly there is no window for a resource left (usually 4k) under
> PCI Root Bridge. Other than that I can't imagine what can go wrong.
> Ah, of course the virtual space starvation is another possibility.

pci_ioremap_bar() can return NULL if the BAR is an I/O port BAR or if
it's a memory BAR but we haven't assigned space for it.  It's a good
idea to check the return value of pci_ioremap_bar().

ea5ab2e422de ("8250_lpss: check null return when calling
pci_ioremap_bar") looks like a valid patch to add that check.  My
guess is that the patch was prompted by a static checker like
Coverity, not by an observed problem.  In any event, this code is in a
quirk only used for Intel Quark SoC X1000 HS-UART devices.

drivers/dma/dw/core.c (for the Synopsys DesignWare DMA Controller)
*does* use that pointer via dma_readl(), but the references in the
commit log (drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168)
are obsolete and not very useful.

Bjorn
