Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3877373B7D
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhEEMjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 08:39:24 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:48601 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhEEMiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 08:38:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3295D2800B6C9;
        Wed,  5 May 2021 14:37:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1D07588EB8; Wed,  5 May 2021 14:37:53 +0200 (CEST)
Date:   Wed, 5 May 2021 14:37:53 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210505123753.GA29101@wunner.de>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJKK7SDIaeH1L/fC@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 02:09:17PM +0200, Greg KH wrote:
> On Wed, May 05, 2021 at 02:01:17PM +0200, Pali Rohár wrote:
> > [   72.511899] Internal error: synchronous external abort: 96000210 [#1] SMP
[...]
> > [   72.636415] Call trace:
> > [   72.638936]  xhci_irq+0x70/0x17b8
> > [   72.642360]  usb_hcd_irq+0x34/0x50
> > [   72.645876]  usb_hcd_pci_remove+0x78/0x138
> > [   72.650106]  xhci_pci_remove+0x6c/0xa8
> > [   72.653978]  pci_device_remove+0x44/0x108
> > [   72.658122]  device_release_driver_internal+0x110/0x1e0
> > [   72.663521]  device_release_driver+0x1c/0x28
> > [   72.667931]  pci_stop_bus_device+0x84/0xc0
> > [   72.672162]  pci_stop_and_remove_bus_device+0x1c/0x30
> > [   72.677373]  pciehp_unconfigure_device+0x98/0xf8
> > [   72.682138]  pciehp_disable_slot+0x60/0x118
> > [   72.686457]  pciehp_handle_presence_or_link_change+0xec/0x3b0
> > [   72.692386]  pciehp_ist+0x170/0x1a0
> > [   72.695984]  irq_thread_fn+0x30/0x90
                    ^^^^^^^^^^^^^
[...]
> > I suspect that issue is in usb_hcd_pci_remove() function which calls
> > local_irq_disable()+usb_hcd_irq()+local_irq_enable() functions but do
> > not take into care that whole usb_hcd_pci_remove() function may be
> > called from interrupt context.
> 
> usb_hcd_pci_remove() should NOT be called from interrupt context.
> 
> What is causing that to happen?

Nothing.  It's called from an IRQ *thread*, i.e. task context, see above.


> > Can you look at this issue if it is really safe to call usb_hcd_irq()
> > from interrupt context? Or rather if it is safe to call functions like
> > pciehp_disable_slot() or device_release_driver() from interrupt context
> > like it can be seen in call trace?
> 
> What is removing devices from an irq?  That is wrong, pci hotplug never
> used to do that, what recently changed?

Nothing changed, the allegation that something is called from interrupt
context is wrong.

Thanks,

Lukas
