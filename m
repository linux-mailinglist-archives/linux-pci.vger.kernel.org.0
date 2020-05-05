Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA11C5F89
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgEESCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 14:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgEESCW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 14:02:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE0ED6E;
        Tue,  5 May 2020 11:02:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1BF3F305;
        Tue,  5 May 2020 11:02:20 -0700 (PDT)
Date:   Tue, 5 May 2020 19:02:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Message-ID: <20200505180214.GA18468@e121166-lin.cambridge.arm.com>
References: <20200426123148.56051-1-marek.vasut@gmail.com>
 <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
 <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 10:42:06PM +0200, Marek Vasut wrote:
> On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
> > On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> The PHY initialization function pointer does not change during the
> >> lifetime of the driver instance, it is therefore sufficient to get
> >> the pointer in .probe(), cache it in driver private data, and just
> >> call the function through the cached pointer in .resume().
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> ---
> >> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> >>       branch pci/rcar
> >> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> >> ---
> >>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
> >>  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > Squashed in https://patchwork.kernel.org/patch/11438665
> 
> Thanks
> 
> > Do you want me to rename the $SUBJECT (and the branch name while at it)
> > in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> > the commit subject tag renaming from this cycle (and in the interim you
> > send a rename for the drivers files ?)
> 
> I don't really have a particular preference either way. I can keep
> marking the drivers with pcie-rcar and pci-rcar tags if that helps
> discern them.

So:

- "rcar" for the PCIe driver
- "rcar-pci" or "rcar-legacy" for the pci-rcar-gen2.c (preference ?
  there is no urgency, no commit queued to rename, it is for future
  code)

Are we OK with that ? If yes I will rewrite the commits subjects
and push out an updated pci/rcar branch.

...DT bindings commit subjects - should I change their tag subject
too ?

Lorenzo
