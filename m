Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067D714C25B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 22:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgA1Vvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 16:51:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1Vvf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 16:51:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAE21ACE0;
        Tue, 28 Jan 2020 21:51:32 +0000 (UTC)
Message-ID: <1580248285.18755.2.camel@suse.de>
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        lukas@wunner.de, Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 28 Jan 2020 18:51:25 -0300
In-Reply-To: <41285254-1bc1-3ffe-383e-276dc7193990@gmail.com>
References: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
         <41285254-1bc1-3ffe-383e-276dc7193990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-01-20 at 10:10 -0600, Stuart Hayes wrote:
> On 11/20/19 4:20 PM, Stuart Hayes wrote:
> > Without this patch, a pciehp hotplug port can stop generating
> > interrupts
> > on hotplug events, so device adds and removals will not be seen.
> > 
> > The pciehp interrupt handler pciehp_isr() will read the slot status
> > register and then write back to it to clear the bits that caused
> > the
> > interrupt. If a different interrupt event bit gets set between the
> > read and
> > the write, pciehp_isr will exit without having cleared all of the
> > interrupt
> > event bits. If this happens, and the port is using an MSI interrupt
> > where
> > per-vector masking is not supported, we won't get any more hotplug
> > interrupts from that device.
> > 
> > That is expected behavior, according to the PCI Express Base
> > Specification
> > Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification
> > of Hot-
> > Plug Events".
> > 
> > Because the "presence detect changed" and "data link layer state
> > changed"
> > event bits are both getting set at nearly the same time when a
> > device is
> > added or removed, this is more likely to happen than it might seem.
> > The
> > issue was found (and can be reproduced rather easily) by connecting
> > and
> > disconnecting an NVMe storage device on at least one system model.
> > 
> > This issue was found while adding and removing various NVMe storage
> > devices
> > on an AMD PCIe port (PCI device 0x1022/0x1483).
> > 
> > This patch fixes this issue by modifying pciehp_isr() by looping
> > back and
> > re-reading the slot status register immediately after writing to
> > it, until
> > it sees that all of the event status bits have been cleared.
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > ---
> > v2:
> >   * fixed ctrl_warn() call
> >   * improved comments
> >   * added pvm_capable flag and changed pciehp_isr() to loop back
> > only when
> >     pvm_capable flag not set (suggested by Lukas Wunner)
> >   
> >  drivers/pci/hotplug/pciehp.h     |  3 ++
> >  drivers/pci/hotplug/pciehp_hpc.c | 50
> > ++++++++++++++++++++++++++++----
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> > 
> 
> Bjorn,
> 
> Please let me know if I could do anything to help get this patch
> accepted.
> 
> Thanks!
> Stuart
> 

Hi, can someone please review/accept this patch please? It fixes NVMe
hotplug operations in SLES15-SP1.

Thanks,

Enzo
