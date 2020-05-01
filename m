Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40E1C2011
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgEAVwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 17:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgEAVwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 17:52:30 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3192166E;
        Fri,  1 May 2020 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588369950;
        bh=1D8RX5PJmzztVI5nfEj33i+vmKP0DavgpDBKvVSk568=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2LiI5Q41sZ7IuVg7kSvKqmCGXVMVME7kMGXqKF2+jaeheYWJL/4CIvP5pvEGDXguJ
         wtJz99iTMpRUQ+gy5D9c3J/4iuMiojxBSic2TWDEQLCoECxlkHf1Z4Fu0nOMy+70Vh
         KetefdBdu87qgfpUH29HuJem5emKyLn+lmCOFnkY=
Date:   Fri, 1 May 2020 16:52:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
Message-ID: <20200501215228.GA136733@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 09:32:31AM +0100, Lorenzo Pieralisi wrote:
> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > 
> > The PHY initialization function pointer does not change during the
> > lifetime of the driver instance, it is therefore sufficient to get
> > the pointer in .probe(), cache it in driver private data, and just
> > call the function through the cached pointer in .resume().
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> >       branch pci/rcar
> > NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> > ---
> >  drivers/pci/controller/pcie-rcar.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Squashed in https://patchwork.kernel.org/patch/11438665
> 
> Do you want me to rename the $SUBJECT (and the branch name while at it)
> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> the commit subject tag renaming from this cycle (and in the interim you
> send a rename for the drivers files ?)

My vote is a tag of "rcar" for the pcie-rcar driver because almost all
new drivers are PCIe, and none of the others use "pcie-" in the tag.

For pci-rcar-gen2.c, we could use "rcar-gen2" (already used by the
last 5 commits, last touched over two years ago).  It's slightly
confusing to use "gen2" to refer to some internal R-Car thing instead
of PCIe Gen 2, so we could use something like "rcar-pci", but I'm not
sure it's worth it.

Bjorn
