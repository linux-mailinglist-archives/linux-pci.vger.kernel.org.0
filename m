Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2244223A7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhJEKiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 06:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233855AbhJEKiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 06:38:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A34D6124F;
        Tue,  5 Oct 2021 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633430181;
        bh=7IHAoNDtwUnipee3OL2fgVGFmswEGIi2rXrg8IrZjYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wy1SczWqqBOs6aGrPN1HEcDd0Z4f4m/TkPixhpjvStyx3RtLMBBIU9kHFaiOa3zsX
         fQVQOUCfPRSXe03Zm6un0AZm4MjMWddCdCVqo21CWqnG64uL2y107/eRQV5sPk2NdI
         B69ckeATvm4tpoALz5gyUkWR2SkpZd23sOAh9JN8=
Date:   Tue, 5 Oct 2021 12:36:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] MIPS: ralink: fix PCI IO resources
Message-ID: <YVwqpCbYzxUWm5LJ@kroah.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <CAMhs-H9p4xmPO2F_byk4DQncTGZayW1HwAzrPn_W0eEW5UUn9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H9p4xmPO2F_byk4DQncTGZayW1HwAzrPn_W0eEW5UUn9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 03, 2021 at 06:21:21PM +0200, Sergio Paracuellos wrote:
> Hi Greg,
> 
> On Sat, Sep 25, 2021 at 10:32 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > MIPs ralink need a special tratement regarding the way it handles PCI IO
> > resources. On MIPS I/O ports are memory mapped, so we access them using normal
> > load/store instructions. MIPS 'plat_mem_setup()' function does a call to
> > 'set_io_port_base(KSEG1)'. There, variable 'mips_io_port_base'
> > is set then using this address which is a virtual address to which all
> > ports are being mapped. Ralink I/O space has a mapping of bus address
> > equal to the window into the mmio space, with an offset of IO start range
> > cpu address. This means that to have this working we need:
> > - linux port numbers in the range 0-0xffff.
> > - pci port numbers in the range 0-0xffff.
> > - io_offset being zero.
> >
> > These means at the end to have bus address 0 mapped to IO range cpu address.
> > We need a way of properly set 'mips_io_port_base' with a virtually mapped
> > value of the IO cpu address.
> >
> > This series do the following approach:
> > 1) Revert two bad commit from a previous attempt of make this work [0].
> > 2) Set PCI_IOBASE to mips 'mips_io_port_base'.
> > 3) Allow architecture dependent 'pci_remap_iospace'.
> > 4) Implement 'pci_remap_iospace' for MIPS.
> > 5) Be sure IOBASE address for IO window is set with correct value.
> >
> > More context about this series appoach in this mail thread [1].
> >
> > Patches related with reverts are from this merge cycle so they are only
> > added to the staging git tree. So to have all stuff together I'd like to
> > get everybody Ack's to get all of this series through staging tree if
> > possible :).
> >
> > Thanks in advance for your time.
> >
> > Changes in v3:
> >  - Collect Arnd's Acked-by for the patches.
> >  - Be sure IO resource start address is zero and WARN_ONCE if it is not
> >    on MIPS pci_remap_iospace() patch. Also make use of 'resource_size'
> >    instead of do the logic explicitly again.
> 
> I think nothing is missing to get this added through the staging tree.

Great, thanks for sticking with this, will go queue it up now.

greg k-h
