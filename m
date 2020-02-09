Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9906156A2A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBIMzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 07:55:46 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:38087 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgBIMzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 07:55:46 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D916628004EA1;
        Sun,  9 Feb 2020 13:55:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AD5FAECCD6; Sun,  9 Feb 2020 13:55:43 +0100 (CET)
Date:   Sun, 9 Feb 2020 13:55:43 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200209125543.k7u5y6omptbpmwo6@wunner.de>
References: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
 <20200129005151.GA247355@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129005151.GA247355@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 28, 2020 at 06:51:51PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 20, 2019 at 05:20:43PM -0500, Stuart Hayes wrote:
> > -	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> > +	if (status) {
> > +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
> > +
> > +		/*
> > +		 * If MSI per-vector masking is not supported by the port,
> > +		 * all of the event bits must be zero before the port will
> > +		 * send a new interrupt (see PCI Express Base Specification
> > +		 * Revision 5.0 Version 1.0, section 6.7.3.4, "Software
> > +		 * Notification of Hot-Plug Events"). So in that case, if
> > +		 * event bit gets set between the read and the write of
> > +		 * PCI_EXP_SLTSTA, we need to loop back and try again.
> > +		 */
> > +		if (!ctrl->pvm_capable) {
> 
> I don't know what whether the MSI vector is masked or not at this
> point

I think MSIs are handled by handle_edge_irq(), which, unlike
handle_level_irq(), does not mask the IRQ by default.

We could call disable_irq_nosync() / enable_irq() to mask the IRQ and
immediately unmask it after writing to the slot status register if the
interrupt uses MSI / MSI-X (and not INTx), thereby forcing another
interrupt if new bits have been set in the meantime.  But I suspect this
approach may not work if PVM is unsupported.


> I see that Lukas took a look at this earlier; I'd really like to have
> his reviewed-by, since he's the expert on this code.

Hm, should we add an entry for pciehp to MAINTAINERS and list me as R: or M:?

Thanks,

Lukas
