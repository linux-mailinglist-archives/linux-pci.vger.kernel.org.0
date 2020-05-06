Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074551C774D
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgEFQ7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 12:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEFQ7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 12:59:42 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E967206B9;
        Wed,  6 May 2020 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588784381;
        bh=YQF8j6KEhKwnPtrb6xBuYQlIxEGfDwEBnvs9W1vNn5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bl/BVxAIVr56QFXAv9pnp6WQVrobs8g8Fxbpjue97jbM3xUKp1LmbIWG0OzkQz6SG
         3wMYuc/FKPnPY+h5O78/axkASCAUKmnjLu+6rF7I2xwYKnhz9vssaDdUqDxEDadMq5
         UnpDauki8tXFFxoEwrygyfQ0bjdH5ZBL1bCjNpYo=
Date:   Wed, 6 May 2020 11:59:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Message-ID: <20200506165938.GA435967@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506153340.GA2978@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 04:33:40PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 06, 2020 at 12:22:13PM +0200, Geert Uytterhoeven wrote:
> > Hi Lorenzo,
> > 
> > On Wed, May 6, 2020 at 11:19 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Wed, May 06, 2020 at 11:02:31AM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, May 6, 2020 at 10:57 AM Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > > On Tue, May 05, 2020 at 08:35:04PM +0200, Marek Vasut wrote:
> > > > > > On 5/5/20 8:02 PM, Lorenzo Pieralisi wrote:
> > > > > > > On Fri, May 01, 2020 at 10:42:06PM +0200, Marek Vasut wrote:
> > > > > > >> On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
> > > > > > >>> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> > > > > > >>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > > > > >>>>
> > > > > > >>>> The PHY initialization function pointer does not change during the
> > > > > > >>>> lifetime of the driver instance, it is therefore sufficient to get
> > > > > > >>>> the pointer in .probe(), cache it in driver private data, and just
> > > > > > >>>> call the function through the cached pointer in .resume().
> > > > > > >>>>
> > > > > > >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > > > > >>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > >>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > > >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > >>>> Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > > > >>>> Cc: linux-renesas-soc@vger.kernel.org
> > > > > > >>>> ---
> > > > > > >>>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > > > > > >>>>       branch pci/rcar
> > > > > > >>>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> > > > > > >>>> ---
> > > > > > >>>>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
> > > > > > >>>>  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > > > >>>
> > > > > > >>> Squashed in https://patchwork.kernel.org/patch/11438665
> > > > > > >>
> > > > > > >> Thanks
> > > > > > >>
> > > > > > >>> Do you want me to rename the $SUBJECT (and the branch name while at it)
> > > > > > >>> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> > > > > > >>> the commit subject tag renaming from this cycle (and in the interim you
> > > > > > >>> send a rename for the drivers files ?)
> > > > > > >>
> > > > > > >> I don't really have a particular preference either way. I can keep
> > > > > > >> marking the drivers with pcie-rcar and pci-rcar tags if that helps
> > > > > > >> discern them.
> > > > > > >
> > > > > > > So:
> > > > > > >
> > > > > > > - "rcar" for the PCIe driver
> > > > > >
> > > > > > Wouldn't it be better to mark this rcar-pcie , so it's clear it's the
> > > > > > PCIe driver ?
> > > > >
> > > > > All other drivers in drivers/pci/controller are PCIe but don't require
> > > > > an extra tag to clarify it - that's the rationale behind "rcar".
> > > > >
> > > > > How does that sound ?
> > > >
> > > > Are there any other platforms that have two different drivers for the same
> > > > platform, one for PCI, and one for PCIe?
> > >
> > > I don't think so - nonetheless it's time we agreed on something and be
> > > done with it. Bjorn expressed his opinion on this and unless we have a
> > > compelling reason not to follow it IMO it'd be better to take it.
> > >
> > > I don't think using rcar-pcie is a disaster either.
> > >
> > > Let me know how you want to proceed, thanks.
> > 
> > /me has just returned from a bike ride, so it's time for a bike-shed
> > 
> > "PCI: rcar:" for pcie-rcar.c, "PCI: rcar-gen2:" (or "PCI: rcar2"?) for
> > pci-rcar-gen2.c?
> 
> Fine by me, all agreed ?

Sounds good to me.
