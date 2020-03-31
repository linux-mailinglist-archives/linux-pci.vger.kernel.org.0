Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B325199AFD
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgCaQJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 12:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgCaQJS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 12:09:18 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA96206CC;
        Tue, 31 Mar 2020 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585670958;
        bh=g+2oQeN73eEpy7w1yZdo/plA5ttpFIkMcxGJMp+J8EI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XnVGAD3lzsW/4E34B1uA2eyIxvIa7GOt8B0+kyEBgjwDT22t1cnHQuB5Vs1zOl+ud
         qTJq+rNCXthCe6JvZQWLss5ZQpIHi8Z5SFEE0glMC1UllBOaJsNvHwys5kXf2qOdGX
         K5SAnY1zIZpQsP6p2nvqEpFRdELJHLRoIzo1ASQw=
Date:   Tue, 31 Mar 2020 11:09:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
Message-ID: <20200331160914.GA195472@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhbxv979.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 11:12:10PM +0200, Thomas Gleixner wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Fri, Mar 27, 2020 at 03:24:34PM +0530, Vignesh Raghavendra wrote:
> >> Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
> >> needs to ensure that there are no pending MSI IRQ vector set (i.e
> >> PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
> >> Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
> >> PCIE_MSI_INTR0_STATUS shows IRQs are pending.
> >
> > I'm not an IRQ guy (real IRQ guys CC'd), but I'm wondering if this is
> > really a symptom of a problem in the generic DWC IRQ handling, not a
> > problem in dra7xx itself.
> >
> > I thought it was sort of standard behavior that a device would not
> > send a new MSI unless there was a transition from "no status bits set"
> > to "at least one status bit set".  I'm looking at this text from the
> > PCIe r5.0 spec, sec 6.7.3.4:
> 
> That's for the device side. But this is the host side and that consists
> of two components:
> 
>      1) The actual PCIe host controller (DWC)
> 
>      2) Some hardware wrapper around #1 to glue the host controller IP
>         into the TI SoC.
> 
> #1 contains a MSI message receiver unit. PCIE_MSI_INTR0_STATUS is part
> that.
> 
> If there is a MSI message sent to the host then the bit which is
> corresponding to the sent message (vector) is set in the status
> register. If a bit is set in the status register then the host
> controller raises an interrupt at its output.
> 
> Here, if I deciphered the above changelog correctly, comes the wrapper
> glue #2 into play, which seems to be involved in forwarding the host
> controller interrupt to the CPU's interrupt controller (GIC) and that
> forwarding mechanism seems to have some issue.

Sorry for muddying the waters, and thanks for clarifying it, Thomas.

This patch is on its way to v5.7, and I guess we'll worry about
whether the interrupt chip reimplementation is overkill later.

Bjorn
