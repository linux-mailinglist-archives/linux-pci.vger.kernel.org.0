Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336674654A8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhLASFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhLASFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 13:05:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A78C061574
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 10:02:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DF48B820D3
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 18:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71217C53FCC;
        Wed,  1 Dec 2021 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381719;
        bh=wE3GF+0YTkz5/FfzOKNJ2hS7QWpDIC1rWNBy1lr+OuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jo2QwzSRuPVvV/Ht0JCn5V+ZyMc/dBcdicyakc/Sg47Hn7H7gYrIx59X4lg3pvgcC
         LZFPdxLDIo9tjhrAIUEe+d9xcB8EHtttso0kQfrfvEqR0WwX/WpV15stzDdK7eagW6
         aIsffQtg5ZLYTCxSXQXo3scF6zYhE0bMRA7hA9d6ctqz5/2Eooedkwp/ZRJ+xrWfyD
         ojOOd2qv4qOkgG+YaX/X9Bc3AkgAVrTpD3O9KiFxhChP0X/nl/T5fW+OdTtwUizqzN
         cKV55tKglZbv/Agtr0QOGyr2FymoCFoENi6/missYHtshKcef/3vpkxURApVoUFvU/
         SqUB6hAGPcJKw==
Date:   Wed, 1 Dec 2021 12:01:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for
 PCI_ROM_ADDRESS1 on emulated bridge"
Message-ID: <20211201180158.GA2830321@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211201182324.28df466c@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 06:23:24PM +0100, Marek Behún wrote:
> On Wed, 1 Dec 2021 06:35:18 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Dec 01, 2021 at 10:50:45AM +0100, Marek Behún wrote:
> > > On Tue, 30 Nov 2021 19:53:08 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >   
> > > > On Tue, Nov 30, 2021 at 11:29:37AM +0000, Lorenzo Pieralisi wrote:  
> > > > > On Thu, Nov 25, 2021 at 05:01:48PM +0100, Marek Behún wrote:    
> > > > > > This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.
> > > > > > 
> > > > > > PCI Bridge which represents aardvark's PCIe Root Port has Expansion ROM
> > > > > > Base Address register at offset 0x30, but its meaning is different than
> > > > > > PCI's Expansion ROM BAR register, although the layout is the same.
> > > > > > (This is why we thought it does the same thing.)
> > > > > > 
> > > > > > First: there is no ROM (or part of BootROM) in the A3720 SOC dedicated
> > > > > > for PCIe Root Port (or controller in RC mode) containing executable code
> > > > > > that would initialize the Root Port, suitable for execution in
> > > > > > bootloader (this is how Expansion ROM BAR is used on x86).
> > > > > > 
> > > > > > Second: in A3720 spec the register (address D0070030) is not documented
> > > > > > at all for Root Complex mode, but similar to other BAR registers, it has
> > > > > > an "entangled partner" in register D0075920, which does address
> > > > > > translation for the BAR in D0070030:
> > > > > > - the BAR register sets the address from the view of PCIe bus
> > > > > > - the translation register sets the address from the view of the CPU
> > > > > > 
> > > > > > The other BAR registers also have this entangled partner, and they
> > > > > > can be used to:
> > > > > > - in RC mode: address-checking on the receive side of the RC (they
> > > > > >   can define address ranges for memory accesses from remote Endpoints
> > > > > >   to the RC)
> > > > > > - in Endpoint mode: allow the remote CPU to access memory on A3720
> > > > > > 
> > > > > > The Expansion ROM BAR has only the Endpoint part documented, but from
> > > > > > the similarities we think that it can also be used in RC mode in that
> > > > > > way.
> > > > > > 
> > > > > > So either Expansion ROM BAR has different meaning (if the hypothesis
> > > > > > above is true), or we don't know it's meaning (since it is not
> > > > > > documented for RC mode).
> > > > > > 
> > > > > > Remove the register from the emulated bridge accessing functions.
> > > > > > 
> > > > > > Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge")
> > > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-aardvark.c | 9 ---------
> > > > > >  1 file changed, 9 deletions(-)    
> > > > > 
> > > > > Bjorn,
> > > > > 
> > > > > this reverts a commit we merged the last merge window so it is
> > > > > a candidate for one of the upcoming -rcX.    
> > > > 
> > > > Sure, happy to apply the revert.
> > > > 
> > > > What problem does the revert fix?  I assume 239edf686c14 ("PCI:
> > > > aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge") broke
> > > > something, but the commit log for the revert doesn't say *what*.  How
> > > > would one notice that something broke?  
> > > 
> > > Hello Bjorn,
> > > 
> > > It doesn't break any real functionality that I know of, although it
> > > might, since the register is read pci/probe.c pci_setup_device()
> > > (pci_read_bases()).
> > > 
> > > But allowing the access to the register when it has different meaning
> > > is wrong in a similar sense that a memory leak is wrong (a memory leak
> > > also does not necessarily cause real problems, if it is small, but
> > > still we should fix it).  
> > 
> > What is the new information that led you to conclude that 239edf686c14
> > is wrong?  Apparently you originally thought the bridge had a ROM BAR,
> > but later decided it didn't, based on *something*?  New observation?
> > New understanding of the spec?
> 
> Hi Bjorn,
> 
> The new observation is that although the register is defined in
> register list (together with it's layour), it is not documented in RC
> mode, although other BAR registers are (and their meaning is something
> different from standard BAR registers in RC mode). Combined with the
> fact that there is no ROM containing executable code in the SOC (which
> we knew even before, but thought that maybe it could be somehow also
> implemented), we concluded that this register has different meaning from
> standard Expansion ROM BAR.

Thanks, applied to for-linus for v5.16!

Bjorn
