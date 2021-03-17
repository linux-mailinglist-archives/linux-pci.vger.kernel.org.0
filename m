Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F733F8CE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhCQTKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:10:16 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:44953 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhCQTJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 15:09:56 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id BC444100D940D;
        Wed, 17 Mar 2021 20:09:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 88A032A9D51; Wed, 17 Mar 2021 20:09:52 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:09:52 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210317190952.GB27146@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 10:45:21AM -0700, Dan Williams wrote:
> Ah, ok, we're missing a flush of the hotplug event handler after the
> link is up to make sure the hotplug handler does not see the Link Up.
> I'm not immediately seeing how the new proposal ensures that there is
> no Link Up event still in flight after DPC completes its work.
> Wouldn't it be required to throw away Link Up to Link Up transitions?

If you look at the new code added to pciehp_ist() by my patch...

      atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
      if (pciehp_check_link_active(ctrl) > 0)
              events &= ~PCI_EXP_SLTSTA_DLLSC;

... the atomic_and() ignores the Link Up event which was picked
up by the hardirq handler pciehp_isr() while pciehp_ist() waited for
link recovery.  Afterwards, the Link Down event is only ignored if the
link is still up:  If the link has gone down again before the call to
pciehp_check_link_active(), that event is honored immediately (because
the DLLSC event is then not filtered).  If it goes down after the call,
that event will be picked up by pciehp_isr().  Thus, only the DLLSC
events caused by DPC are ignored, but no others.

A DLLSC event caused by surprise removal during DPC may be incorrectly
ignored, but the expectation is that the ensuing Presence Detect Changed
event will still cause bringdown of the slot after DPC has completed.
Hardware does exist which erroneously hardwires Presence Detect to zero,
but that's rare and DPC-capable systems are likely not affected.

I've realized today that I forgot to add a "synchronize_hardirq(irq);"
before the call to atomic_and().  Sorry, that will be fixed in the
next iteration.

Thanks,

Lukas
