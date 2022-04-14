Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB152501EFE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 01:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiDNXZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 19:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDNXZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 19:25:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7EB898B;
        Thu, 14 Apr 2022 16:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF618B82762;
        Thu, 14 Apr 2022 23:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F750C385A1;
        Thu, 14 Apr 2022 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649978609;
        bh=7tRW0rE5UC55+IymPZVk7biWmaN3JlYQe5vs90QpsMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b10SPq1xObHjVgrTTzouDybJFobX/tmlHZCE+xPukgETRF7ws5p0ev0y6kBVeoz6G
         H/VuXi/V02mpfR2XHSshBnOYDSDB4QsHVfq1qZyACpfS4TT4zOyeFKRpAFsQtvjWUI
         vUfc0+krpph1Sy0IUJX/4jzCRcLoeAY9ZNijzrilBWBASX5T3n49+t3wiSabhIHAbm
         hPPrHg3h0PwL5wrZ4XaFwCtxGQG5RMwYnfYubJTa1PE1fv1Kz/1MGo3HdbtXlzTpGA
         O1SOvBQ9Jy2Z3988HTpfTCx8eTNChalDNWwbGHVvlsmbyUU8jQg4zy13b0dHDzqG4E
         T8/dMdVE86QYg==
Date:   Thu, 14 Apr 2022 18:23:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>, a@bhelgaas
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220414232328.GA770621@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204142111010.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 09:22:42PM +0100, Maciej W. Rozycki wrote:
> On Thu, 14 Apr 2022, Bjorn Helgaas wrote:
> 
> > > > > Address 0 is treated specially however in many places, for
> > > > > example in `pci_iomap_range' and `pci_iomap_wc_range' we
> > > > > require that the start address is non-zero, and even if we
> > > > > let such an address through, then individual device drivers
> > > > > could reject a request to handle a device at such an
> > > > > address, such as in `uart_configure_port'.  Consequently
> > > > > given devices configured as shown above only one is actually
> > > > > usable:
> > > > 
> > > > pci_iomap_range() tests the resource start, i.e., the CPU
> > > > address.  I guess the implication is that on RISC-V, the
> > > > CPU-side port address is the same as the PCI bus port address?
> > > 
> > >  Umm, for all systems I came across except x86, which have
> > >  native port I/O access machine instructions, a port I/O
> > >  resource records PCI bus addresses of the device rather than
> > >  its CPU addresses, which encode the location of an MMIO window
> > >  the PCI port I/O space is accessed through.
> > 
> > My point is only that it is not necessary for the PCI bus address
> > and the struct resource address, i.e., the argument to inb(), to
> > be the same.
> 
>  Sure, but I have yet to see a system where it is the case.
> 
>  Also in principle peer PCI buses could have their own port I/O
>  address spaces each mapped via distinct MMIO windows in the CPU
>  address space, but I haven't heard of such a system.  That of
>  course doesn't mean there's no such system in existence.

They do exist, but are probably rare.  Even on x86 where multiple host
bridges are now fairly common, and the hardware probably supports a
separate 64K port space for each, the ones I've seen split up a single
64K I/O port space so each bridge only gets a fraction of it.  I'm not
sure Linux would even support multiple spaces.  I do know ia64
supports multiple port spaces (see __ia64_mk_io_addr()), so we could
have something like this:

  pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
  pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])

I guess the question is whether we want to reserve port 0 and MMIO
address 0 as being "invalid".  That makes the first space smaller than
the others, but it's not *much* smaller and it's an unlikely
configuration to begin with.

But at the same time, it adds another slightly weird special case in
the already full-of-special-cases alloc code, and I'm somewhat averse
to things like that.

We do have the IORESOURCE_UNSET flag bit that could possibly be used
in pci_iomap_range() instead of testing for "!start".  Or maybe
there's a way to allocate address 0 instead of special-casing the
allocator?  Just thinking out loud here.

Bjorn
