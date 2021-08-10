Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D533E7D84
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhHJQbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 12:31:46 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:50073 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhHJQbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Aug 2021 12:31:46 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 12:31:45 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6E5D9300002A0;
        Tue, 10 Aug 2021 18:21:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 57C13260B31; Tue, 10 Aug 2021 18:21:44 +0200 (CEST)
Date:   Tue, 10 Aug 2021 18:21:44 +0200
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
Message-ID: <20210810162144.GA24713@wunner.de>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com>
 <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
 <20210809150005.GA6916@wunner.de>
 <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 10, 2021 at 11:37:12PM +0800, Kai-Heng Feng wrote:
> On Mon, Aug 9, 2021 at 11:00 PM Lukas Wunner <lukas@wunner.de> wrote:
> > If PME is not granted to the OS, the only consequence is that the PME
> > port service is not instantiated at the root port.  But PME is still
> > enabled for downstream devices.  Maybe that's a mistake?  I think the
> > ACPI spec is a little unclear what to do if PME control is *not* granted.
> > It only specifies what to do if PME control is *granted*:
> 
> So do you prefer to just disable runtime PM for the downstream device?

I honestly don't know.  I was just wondering whether it is okay
to enable PME on devices if control is not granted by the firmware.
The spec is fairly vague.  But I guess the idea is that enabling PME
on devices is correct, just handling the interrupts is done by firmware
instead of the OS.

In your case, the endpoint device claims it can signal PME from D3cold,
which is why we allow the root port above to runtime suspend to D3hot.
The lspci output you've attached to the bugzilla indicates that yes,
signaling PME in D3cold does work, but the PME interrupt is neither
handled by the OS (because it's not allowed to) nor by firmware.

So you would like to rely on PME polling instead, which only works if the
root port remains in D0.  Otherwise config space of the endpoint device
is inaccessible.

I think the proper solution is that firmware should handle the PME
interrupt.  You've said the vendor objects because they found PME
doesn't work reliably.  Well in that case the endpoint device shouldn't
indicate that it can signal PME, at least not from D3cold.  Perhaps
the vendor is able to change the endpoint device's config space so
that it doesn't claim to support PME?

If that doesn't work and thus a kernel patch is necessary, the next
question is whether changing core code is the right approach.

If you do want to change core code, I'd suggest modifying 
pci_dev_check_d3cold() so that it blocks runtime PM on upstream
bridges if PME is not handled natively AND firmware failed to enable
the PME interrupt at the root port.  The rationale is that upstream
bridges need to remain in D0 so that PME polling is possible.

An alternative would be a quirk for this specific laptop which clears
pdev->pme_support.

Thanks,

Lukas
