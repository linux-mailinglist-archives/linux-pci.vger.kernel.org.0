Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391F6351776
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhDARmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234616AbhDARiZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14AFF6136F;
        Thu,  1 Apr 2021 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617294053;
        bh=7Y7ul8AkwhwhKfJSNO9nkANQeJ+H6xwHYD7bCFrPITQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LK8HKhIvAkcmLNQ1cEZmnxlOBlKPJAPsT96nchl4HJl65u2hrh5HU8vFJvdQ3sD6y
         uXkNsgBqxmjUR4co+TxIMftJdMbDkVd185fHt0Hdb9GQAsv3WYodD1I3fvjxFKwSj8
         ssytb8fwAKqV8Bai9pWA9Vi9PU77Ot6Ix7ofLzmSq01WcoFAyC2Z8woXUqVFGdD1Rf
         Shk+Dnd7WS02LwoKlceOLE1CQwuwd7JaBUWyM6ZxQlWR1G6VNiAyO4/FE0O85m6Mb/
         ZgWUCNP2eXrkFazUArQeU7Pa9J6a2n/MQvmudp5Y8wn3uRuJK6f/Yz/SJmdwm2D4Z4
         ZeoFBLkII7Zvw==
Date:   Thu, 1 Apr 2021 11:20:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Don't try to read CLS from PCIe devices in
 pci_apply_final_quirks
Message-ID: <20210401162051.GA1515670@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4549ac90-8830-100e-2f53-8ba1a622cb71@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 05:26:57PM +0200, Heiner Kallweit wrote:
> On 31.03.2021 23:00, Bjorn Helgaas wrote:
> > On Tue, Dec 08, 2020 at 02:26:46PM +0100, Heiner Kallweit wrote:
> >> Don't try to read CLS from PCIe devices in pci_apply_final_quirks().
> >> This value has no meaning for PCIe.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/pci/quirks.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index d9cbe69b8..ac8ce9118 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -163,6 +163,9 @@ static int __init pci_apply_final_quirks(void)
> >>  	pci_apply_fixup_final_quirks = true;
> >>  	for_each_pci_dev(dev) {
> >>  		pci_fixup_device(pci_fixup_final, dev);
> >> +
> >> +		if (pci_is_pcie(dev))
> >> +			continue;
> > 
> > This loop tries to deduce the platform's cache line size by looking at
> > the CLS of every PCI device.  It doesn't *write* CLS for any devices.
> > 
> > IIUC skipping PCIe devices would only make a difference if a PCIe
> > device had a non-zero CLS different from the CLS of other devices.
> > In that case we would print a "CLS mismatch" message and fall back to
> > pci_dfl_cache_line_size.
> > 
> > The power-up value is zero, so if we read a non-zero CLS, it means
> > firmware set it to something.  It would be strange if firmware set it
> > to something other than the platform's cache line size.
> > 
> > Skipping PCIe devices probably doesn't hurt anything, but I don't
> > really see a benefit either.  What do you think?  In general I think
> > we should add code to check PCI vs PCIe only if it makes a difference.
> > 
> There is no functional change, right. The benefit is just that we
> avoid some unnecessary traffic on the PCI bus.
> If you think that this is not really worth a patch, then this is also
> fine with me.

OK, I think I'll drop it just to avoid the cost of convincing
ourselves that there's no risk.  If we see "CLS mismatch" warnings or
if is a real performance cost, we should do something.  But I don't
think the extra PCI traffic will be measurable in this case.

> >>  		/*
> >>  		 * If arch hasn't set it explicitly yet, use the CLS
> >>  		 * value shared by all PCI devices.  If there's a
> >> -- 
> >> 2.29.2
> >>
> 
