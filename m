Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F783E8ADC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHKHM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 03:12:26 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:37307 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhHKHMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 03:12:24 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 98E9F28015488;
        Wed, 11 Aug 2021 09:11:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8BFB835897; Wed, 11 Aug 2021 09:11:58 +0200 (CEST)
Date:   Wed, 11 Aug 2021 09:11:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
Message-ID: <20210811071158.GB6104@wunner.de>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com>
 <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
 <20210809150005.GA6916@wunner.de>
 <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
 <20210810162144.GA24713@wunner.de>
 <CAAd53p7bMm5KyjXvUOTevspm9e0mtPP2KWoq5xZSWng8q1kGPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7bMm5KyjXvUOTevspm9e0mtPP2KWoq5xZSWng8q1kGPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 01:06:27PM +0800, Kai-Heng Feng wrote:
> On Wed, Aug 11, 2021 at 12:21 AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Tue, Aug 10, 2021 at 11:37:12PM +0800, Kai-Heng Feng wrote:
> > I honestly don't know.  I was just wondering whether it is okay
> > to enable PME on devices if control is not granted by the firmware.
> > The spec is fairly vague.  But I guess the idea is that enabling PME
> > on devices is correct, just handling the interrupts is done by firmware
> > instead of the OS.
> 
> Does this imply that current ACPI doesn't handle this part?

Apparently not, according to the "lspci-bridge-after-hotplug" you've
attached to the bugzilla, the PME Interrupt Enable bit wasn't set in
the Root Control register.  The kernel doesn't register an IRQ handler
for PME because firmware doesn't grant it control, so it's firmware's
job to enable and handle the IRQ (or poll the relevant register or
whatever).

  RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                                                   ^^^^^^^^^^

> The Windows approach is to make the entire hierarchy stays at D0, I
> think maybe it's a better way than relying on PME polling.

Including the endpoint device, i.e. the NIC?


> > If you do want to change core code, I'd suggest modifying
> > pci_dev_check_d3cold() so that it blocks runtime PM on upstream
> > bridges if PME is not handled natively AND firmware failed to enable
> > the PME interrupt at the root port.  The rationale is that upstream
> > bridges need to remain in D0 so that PME polling is possible.
> 
> How do I know that firmware failed to enable PME IRQ?

Check whether PCI_EXP_RTCTL_PMEIE was set by firmware in the Root Control
register.


> > An alternative would be a quirk for this specific laptop which clears
> > pdev->pme_support.
> 
> This won't scale, because many models are affected.

We already have quirks which clear pdev->pme_support, e.g.
pci_fixup_no_d0_pme() and pci_fixup_no_msi_no_pme().
Perhaps something like that would be appropriate here.

Thanks,

Lukas
