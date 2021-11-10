Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB144C6DA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 19:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKJSn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 13:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhKJSn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 13:43:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE736115A;
        Wed, 10 Nov 2021 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636569668;
        bh=9089010GwP3SOumZqJ6YAoM6OGlHlqPBle/z9hQgaP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WdjIjCcslboX2CBB0ruVR4Zm2dQRaN8+YsWw0v6z3nPuBcxHUxyEoLWhCcM6e5CK+
         tJfDGvqny+grsC0oPLZoO1vaBiUZ2HN3XOvu49C02X43t+48kZzbQ9aCPrUX49bHKZ
         dDZChzvkttgpwDUb2cE3zg6qsp1m0eFXw4kyxVwdYa+/DzGjYzgPslllQzFqfM7NXj
         9YcH56JlqJk+81bs4tMRC1ZVeS1E6wQSo9jSwLqEwS9p2ecrNqQhULAfZBOLFmwcsZ
         GHMyqzosRXlHDUlQAf5od0MA9+AcZwQNGj9Ml/sXRt+p8J7Wk7zw4GdVf2uwzKkPvn
         SfZ5bRzchWZpQ==
Date:   Wed, 10 Nov 2021 12:41:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        maz@kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Message-ID: <20211110184106.GA1251058@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 07:07:24PM +0100, Christian Zigotzky wrote:
> On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
> > Hello,
> >
> > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16
> updates [2].
> >
> > Error messages:
> >
> > ata4.00: gc timeout cmd 0xec
> > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > ata1.00: gc timeout cmd 0xec
> > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > ata3.00: gc timeout cmd 0xec
> > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> >
> > I was able to revert the new pci-v5.16 updates [2]. After a new
> compiling, the kernel recognize all ATA disks correctly.
> >
> > Could you please check the pci-v5.16 updates [2]?
> >
> > Please find attached the kernel config.
> >
> > Thanks,
> > Christian
> >
> > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
> 
> Hi All,
> 
> Many thanks for your nice responses.
> 
> I bisected today [1]. 0412841812265734c306ba5ef8088bcb64d5d3bd (of/irq:
> Allow matching of an interrupt-map local to an interrupt controller) [2] is
> the first bad commit.
> 
> I was able to revert the first bad commit [1]. After a new compiling, the
> kernel detects all ATA disks without any problems.
> 
> I created a patch for an easy reverting the bad commit [1]. With this patch
> we can do further our kernel tests.
> 
> Could you please check the first bad commit [2]?
> 
> Thanks,
> Christian
> 
> [1] https://forum.hyperion-entertainment.com/viewtopic.php?p=54398#p54398
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0412841812265734c306ba5ef8088bcb64d5d3bd
> 
> [+ Marc Zyngier, Alyssa Rosenzweig, Lorenzo Pieralisi, and Rob Herring
> because of the first bad commit]

Thank you very much for the bisection and for also testing the revert!

It's easy enough to revert 041284181226 ("of/irq: Allow matching of an
interrupt-map local to an interrupt controller"), and it seems like
that's what we need to do.  I have it tentatively queued up.

That commit was part of the new support for the Apple M1 PCIe
interface, and I don't know what effect a revert will have on that
support.  Marc, Alyssa?

Bjorn
