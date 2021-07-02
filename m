Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1693BA32C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGBQ1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 12:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGBQ1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 12:27:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7432D613C1;
        Fri,  2 Jul 2021 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625243089;
        bh=G7G4/x8tJkyUwo1PTiPMwDxmwwdqEqvNmhSuQg80OSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hJuygQwO8ZlDg9AE5yRdx5lmwDe+ETNY9bScM/9CydA+lf4grts4nw09WJLajCw/H
         ohYdAWxbucJtZFEeHQEgxPmxiW5I4kosQkve27Oki/0g2hk/ViTc1BIn3zpNvakMZn
         rVktXKwEWkbB8tLFszESNend+o0WDftpRiOkpqrOCQHM+GxSFh6Z8RtkK3MD4CUnMT
         5SoGoYa3/FHBJDN76Nxf6fGRdcM5NBMQC72UeCo/UAQUQi6o2a8FmwCf1t+BJ2BSc8
         UdnMMugYlrJAKT1Vs4J59aefYOchXVAP91fe5Ivz+/K0g3e9Bq9bToKhiyuvC/U5KD
         se4n+yY9Et2uQ==
Date:   Fri, 2 Jul 2021 11:24:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        =?iso-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Zachary Zhang <zhangzg@marvell.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Call MPS fixup quirks early
Message-ID: <20210702162448.GA192062@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237a49d8a113f44b55e537f6f2f99b7db9d97485.camel@decadent.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 02, 2021 at 05:39:43PM +0200, Ben Hutchings wrote:
> On Thu, 2021-07-01 at 10:25 -0500, Bjorn Helgaas wrote:
> [...]
> > After 27d868b5e6cfa, pci_configure_device() did actually call
> > pcie_set_mps(), which updates the Device Control register (possibly
> > restricted by dev->pcie_mpss, which is set by this quirk).
> > 
> > The fixup_mpss_256() quirk was added in 2011 by a94d072b2023 ("PCI:
> > Add quirk for known incorrect MPSS").  Interesting that 27d868b5e6cfa
> > was merged in 2015 but apparently nobody noticed until now.  I guess
> > those Solarflare devices aren't widely used?
> [...]
> 
> The key thing is that this quirk was working around an issue with
> legacy interrupts, while the sfc and sfc-falcon drivers have always
> preferred to use MSIs if available.  (But I also don't think many
> SFC4000-based NICs were sold, and they were EOL'd about 10 years ago.)

Just out of curiosity, do you happen to remember the legacy interrupt
connection?  MPS has to do with the maximum TLP size, and it's not
obvious to me why using INTx vs MSI would matter there.

I guessing the scenario is that SFC4000 uses either either INTx or
MSI to signal some kind of I/O completion, the ISR puts more I/Os in
the queue, the SFC4000 does a DMA read, and chokes on a Completion TLP
that's too big?  But somehow if it uses MSI, it can handle bigger
TLPS?

Not a big deal; I think it's obvious that we need Marek's patch to fix
the ordering issue.

Bjorn
