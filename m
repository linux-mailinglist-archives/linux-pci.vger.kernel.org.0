Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933805062E0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 05:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348122AbiDSDkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiDSDki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 23:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0548612AE6;
        Mon, 18 Apr 2022 20:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81FDCB81125;
        Tue, 19 Apr 2022 03:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A123C385A7;
        Tue, 19 Apr 2022 03:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650339474;
        bh=XO0qydolLG+50b6HQGB6tyjIvyVwb/H+8RS7erMEihw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lK43d7VSsda/pVM9cI+pybwuD7fVEt81a/i5C6BneqhI0s2HxhTlcHwcsnQZNCxsD
         PRTmao2X0cUgFD1LQLAmKsa85HeSDO6jQOlKrSim2lJyr7+ZHd+pQrA+Ytv5KulVsN
         F5hi/pYQDCTWalMobn+QWff11gCo4YcgaQ+1dUnMc/EFNIPm5b3gB1YnlAN6IpbRsR
         osPeBs6nfbCM5u43Pa1URqfNCbM9ELflFcJ+k0hujZ/XDsKLhxhN50dvSJXI456sR3
         nU4ND30WMkyz/VXeKPDy3WY83gLlbHAILF+v/pCH26mTlYV/qS5iKL70EdCXSh+S3t
         jZz6eysv9YCVw==
Date:   Mon, 18 Apr 2022 22:37:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220419033752.GA1101844@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204160049500.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 16, 2022 at 03:02:35PM +0100, Maciej W. Rozycki wrote:
> On Fri, 15 Apr 2022, Bjorn Helgaas wrote:
> ...

> > Another possibility is PCIBIOS_MIN_IO.  It's also kind of an ugly
> > special case, but at least it already exists.  Most arches define it
> > to be non-zero, which should avoid this issue.
> > 
> > Defining PCIBIOS_MIN_IO would be simple; what would we lose compared
> > to adding code in pci_bus_alloc_from_region()?
> 
>  As I explained in the change description:
> 
>   Especially I/O space ranges are particularly valuable, because
>   bridges only decode bits from 12 up and consequently where 16-bit
>   addressing is in effect, as few as 16 separate ranges can be
>   assigned to individual buses only.
> 
>   Therefore avoid handing out address 0, however rather than bumping
>   the lowest address available to PCI via PCIBIOS_MIN_IO and
>   PCIBIOS_MIN_MEM, or doing an equivalent arrangement in
>   `__pci_assign_resource', let the whole range assigned to a bus
>   start from that address and instead only avoid it for actual
>   devices.  [...]
> 
> Yes, just bumping up PCIBIOS_MIN_IO was my first thought and the
> path of least resistance.  However with the strictly hierarchical
> topology of PCIe systems the limit of 16 ranges feels so
> frighteningly low to me already as to make me rather unwilling to
> reduce it even further for a system that is free from PC legacy junk
> (no southbridge let alone ISA) and therefore does not require it.
> So I've reconsidered my initial approach and came up with this
> proposal instead.  I think it is a good compromise.

Sorry for being dense here, I think it's finally sinking in.

The problem is that making PCIBIOS_MIN_IO greater than zero would keep
us from assigning a [io 0x0000- ] window, so instead of 16 I/O bridge
windows, we could only have 15 (unless bridges support 32-bit I/O
windows).  Right?

Are you running into that limit?  Most devices don't need I/O port
space, and almost all other arches define PCIBIOS_MIN_IO, so they live
without that window today.

Sparc uses the MMIO I/O port address directly in the struct resource,
so it will never try to allocate [io 0x0000], and there's no problem
with using PCI I/O port 0:

  pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
  mpt2sas0: ioport(0x0000804000001000), size(256)

The sparc ioport interfaces are basically:

  ioport_map(port)  { return port; }
  ioread8(addr)     { return readb(addr); }
  inb(addr)         { return readb(addr); }

RISC-V uses the generic ones, i.e.,

  ioport_map(port)  { return PIO_OFFSET + port; }
  ioread8(addr)     { if (addr) >= PIO_RESERVED)
                        return readb(addr);
                      else
                        return inb(addr & PIO_MASK); }
  inb(addr)         { return __raw_readb(PCI_IOBASE + addr); }

Obviously RISC-V gives you prettier I/O port addresses, but at the
cost of having PCI I/O port 0 be 0 in the struct resource as well,
which makes it basically unusable.  Is it worth it?

Bjorn
