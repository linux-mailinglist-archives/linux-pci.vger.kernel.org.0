Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328A52D4D42
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgLIWGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 17:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388521AbgLIWGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 17:06:12 -0500
Date:   Wed, 9 Dec 2020 16:05:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607551532;
        bh=NRmjl76QtNuV/wif/5gsS8SlkBI3WP3SYGnwAzcAoIk=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=ke+i/bOPO8oqw4snKSRZqWgA+X70pBTq3TlLU6+f/sBwRMDnK3UQVuxBAlbz+5JuG
         HbsmkIgSr2l223J1gFfhDBWIQt198XfTfVvZ6h7Rs+UeyTu70cWLUFU0BrxvgM9rLB
         NS6CnGtlISHesQmPZ1CicrW8sCDa75BpNlClKad00vgXbdeNDE+Biz+Pd+AHMRKqri
         wZRFqVv3t7igKtAUoiYiLgsG0Z45HNSQgVeX4M/ia18c28B75TzLVFuIgeVEBDvwDx
         wrMbUSHfnlPhp0Fj6zIVeapwE/2HW4eZHz3/Fa6LOC85UB/rD6X+eleGUFnNKeSP67
         6XwImIuzTnqmg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209220530.GA2551354@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209214359.gt4wisqh65oscd4i@skbuf>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 11:43:59PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 09, 2020 at 03:34:49PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 09, 2020 at 11:20:17PM +0200, Vladimir Oltean wrote:
> > > On Wed, Dec 09, 2020 at 02:59:13PM -0600, Bjorn Helgaas wrote:
> > > > Yep, that's the theory.  Thanks for testing it!
> > >
> > > Testing what? I'm not following.
> >
> > You posted a patch that you said fixed the bug for you.  The fix is
> > exactly the theory we've been discussing, so you have already verified
> > that the theory is correct.
> >
> > I'm sure Krzysztof will update his patch, and we'll get this tidied up
> > in -next again.
> 
> If you were discussing this already, I missed it. I was copied to this
> thread out of the blue two emails ago. I also looked at the full thread
> on patchwork, I don't see anything being said about the culprit being
> the size of the config space mapping.

Oh, sorry, this was an IRC discussion on #linux-pci (OFTC):

  10:51 AM <bjorn_> so the fault is on the first read for 00:00.1.  forget my noise about extracting the device/func from the *virtual* address.  the *physical* address is supposed to be aligned so you can do that, but not the virtual address
  10:55 AM <bjorn_> kwilczynski: oh, i think i see it: pci_ecam_create() does "bsz = 1 << ops->bus_shift", but we removed .bus_shift for this case
  10:55 AM <bjorn_> needs to default to 20 if it's not specified
  10:56 AM <bjorn_> result is that we only map one page of the ECAM space, so we fault when we access the second page (which is where 00:00.1 starts)

Anyway, thanks very much again for fixing this and confirming the fix!

Bjorn
