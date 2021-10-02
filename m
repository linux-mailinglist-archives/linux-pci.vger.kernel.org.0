Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1D41FDD5
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJBTDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 15:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhJBTDD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 15:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A524B619F7;
        Sat,  2 Oct 2021 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633201277;
        bh=NTGyouacxEmuFQJT7w3cDH1MxUdbQeXeZs8seJ5/Jbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e1L7YCP/u/b9hf63WJz2ghDP3UvtRDevQK1EQgBZFCupqKdqJ26E76tQtBxggryhO
         Texi/WhKGY7wfhTg/fR4nb8borEhT54tkgikBui2uRWOwoR1qBqGlsGxyEFLGZWnJK
         VEpBj89qTQR/fc96DF3Yg5TF4pKPmuuGlC/WrfZ7UVZKiAUsR4EAG9fMCQ5pR1FnF2
         paa3WgsEBu9W0b8hNRt5ggGKKnUj8+407DXHuORzycKobWWLrKyV/WnKUvcLx9+auw
         AFV4lAnHmWCIE9wpjD73rKStSpUIcBsN4QBtpGg1i02nxqMSFnY5qreNI9xpAAzBKm
         cM8dSCA3OoHsg==
Date:   Sat, 2 Oct 2021 14:01:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
Message-ID: <20211002190114.GA976888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVRqW=v+AKsXKJkm7d_DUubF_zn3tRq560S9m5996PrHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 08:22:13PM +0200, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Sat, Oct 2, 2021 at 6:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Seems overkill to mention "rcar" and "pci" twice in the subject.  We
> > have so far not distinguished pcie-rcar-host.c and pcie-rcar-ep.c in
> > subject lines.
> >
> > If we want to start doing that consistently, maybe we could use "PCI:
> > rcar-host:" and "PCI: rcar-ep:" as we have done for cadence-ep and
> > designware-ep.
> 
> I know.  But this is for PCIe, and there's also pci-rcar-gen2 for traditional
> PCI.

We do have a precedent of "rcar-gen2" for that driver:

  $ git log --oneline drivers/pci/controller/pci-rcar-gen2.c
  df561f6688fe treewide: Use fallthrough pseudo-keyword
  669cbc708122 PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
  4a957563fe02 PCI: rcar-gen2: Convert to use modern host bridge probe functions
  6e0832fa432e PCI: Collect all native drivers under drivers/pci/controller/

  $ git log --oneline -- drivers/pci/host/pci-rcar-gen2.c
  6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
  9e2aee80c78d ("PCI: Move private DT related functions into private header")
  38b35992b7d2 ("PCI: rcar-gen2: Remove duplicated bit-wise or of RCAR_PCI_INT_SIGRETABORT")
  8cfab3cf63cf ("PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate")
  1e61a57cac56 ("PCI: Use of_pci_dma_range_parser_init() to reduce duplication")
  bf44167f37a1 ("PCI: rcar-gen2: Make of_device_ids const")
  7b99d94277ba ("PCI: rcar-gen2: Use gen2 fallback compatibility last")
  de9e6bc84b7e ("PCI: rcar-gen2: Add local struct device pointers")
  0b9c158925b2 ("PCI: rcar-gen2: Make explicitly non-modular")
  ac575ead871f ("PCI: rcar Gen2: Request host bridge window resources")
  b2a5d3e2cf65 ("PCI: rcar: Drop gen2 dummy I/O port region")
  3517652fda51 ("PCI: rcar: Add gen2 fallback compatibility string for pci-rcar-gen2")
  8d598cabf50d ("PCI: rcar: Allow DT to override default window settings")
  de24c18c0fac ("PCI: rcar: Add R8A7794 support")
  7a27db23a3f6 ("PCI: rcar: Verify that mem_res is 64K-aligned")
  b44923b78d11 ("PCI: rcar: Convert to use generic config accessors")
  e27a5130ab64 ("pci: host: drop owner assignment from platform_drivers")
  d47b62f4b1c0 ("PCI: rcar: Add gen2 device tree support")
  b9bfe1bca8ec ("PCI: rcar: Use new OF interrupt mapping when possible")
  33966fd9b5bc ("PCI: rcar: Break out window size handling")
  546cadda3575 ("PCI: rcar: Register each instance independently")
  e64a2a973e17 ("PCI: rcar: Fix bridge logic configuration accesses")
  80a595d941a2 ("PCI: rcar: Add error interrupt handling")
  ed65b78881c7 ("PCI: rcar: Check platform_get_irq() return code")
  fb178d8b2fab ("PCI: rcar: Add runtime PM support")
  c176d1c71bd1 ("PCI: rcar: Fix rcar_pci_probe() return value check")
  ba3eb9fce315 ("PCI: Add R-Car Gen2 internal PCI support")

> > On Fri, Oct 01, 2021 at 02:16:43PM +0200, Geert Uytterhoeven wrote:
> > > Remove includes that are not needed, to speed up (re)compilation.
> > > ...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
