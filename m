Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC21C6C49
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEFI5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 04:57:46 -0400
Received: from foss.arm.com ([217.140.110.172]:59704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgEFI5q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 04:57:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C54A30E;
        Wed,  6 May 2020 01:57:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B5E3F71F;
        Wed,  6 May 2020 01:57:44 -0700 (PDT)
Date:   Wed, 6 May 2020 09:57:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Message-ID: <20200506085736.GA30251@e121166-lin.cambridge.arm.com>
References: <20200426123148.56051-1-marek.vasut@gmail.com>
 <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
 <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com>
 <20200505180214.GA18468@e121166-lin.cambridge.arm.com>
 <a7971547-869a-b3ca-5934-4ce5028aacf1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7971547-869a-b3ca-5934-4ce5028aacf1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 08:35:04PM +0200, Marek Vasut wrote:
> On 5/5/20 8:02 PM, Lorenzo Pieralisi wrote:
> > On Fri, May 01, 2020 at 10:42:06PM +0200, Marek Vasut wrote:
> >> On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
> >>> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> >>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>>>
> >>>> The PHY initialization function pointer does not change during the
> >>>> lifetime of the driver instance, it is therefore sufficient to get
> >>>> the pointer in .probe(), cache it in driver private data, and just
> >>>> call the function through the cached pointer in .resume().
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>> Cc: Wolfram Sang <wsa@the-dreams.de>
> >>>> Cc: linux-renesas-soc@vger.kernel.org
> >>>> ---
> >>>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> >>>>       branch pci/rcar
> >>>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> >>>> ---
> >>>>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
> >>>>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>>
> >>> Squashed in https://patchwork.kernel.org/patch/11438665
> >>
> >> Thanks
> >>
> >>> Do you want me to rename the $SUBJECT (and the branch name while at it)
> >>> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> >>> the commit subject tag renaming from this cycle (and in the interim you
> >>> send a rename for the drivers files ?)
> >>
> >> I don't really have a particular preference either way. I can keep
> >> marking the drivers with pcie-rcar and pci-rcar tags if that helps
> >> discern them.
> > 
> > So:
> > 
> > - "rcar" for the PCIe driver
> 
> Wouldn't it be better to mark this rcar-pcie , so it's clear it's the
> PCIe driver ?

All other drivers in drivers/pci/controller are PCIe but don't require
an extra tag to clarify it - that's the rationale behind "rcar".

How does that sound ?

> > - "rcar-pci" or "rcar-legacy" for the pci-rcar-gen2.c (preference ?
> >   there is no urgency, no commit queued to rename, it is for future
> >   code)
> 
> rcar-pci , since the Gen2 controller surely isn't legacy.

Ok

> > Are we OK with that ? If yes I will rewrite the commits subjects
> > and push out an updated pci/rcar branch.
> > 
> > ...DT bindings commit subjects - should I change their tag subject
> > too ?

I shall leave DT bindings as they are then.

Lorenzo
