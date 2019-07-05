Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1986036C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfGEJvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 05:51:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57530 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfGEJvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 05:51:42 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 3ded838a44778bef; Fri, 5 Jul 2019 11:51:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] PCI / ACPI: Handle sibling devices sharing power resources
Date:   Fri, 05 Jul 2019 11:51:39 +0200
Message-ID: <3373307.rzzEvYTkqQ@kreacher>
In-Reply-To: <CAJZ5v0he36SF+q_0J5D_UCdhUPkKh6S3e94gqB=5XKcT=eum1A@mail.gmail.com>
References: <20190625102942.27740-1-mika.westerberg@linux.intel.com> <CAJZ5v0he36SF+q_0J5D_UCdhUPkKh6S3e94gqB=5XKcT=eum1A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 25, 2019 12:35:12 PM CEST Rafael J. Wysocki wrote:
> On Tue, Jun 25, 2019 at 12:30 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi all,
> >
> > This is third iteration of the patch series addressing issues around
> > sibling PCI devices sharing ACPI power resources.
> >
> > As a concrete example in Intel Ice Lake the Thunderbolt controller, PCIe
> > root ports and xHCI all share the same ACPI power resources. When they are
> > all in D3hot power resources (returned by _PR3) can be turned off powering
> > off the whole block. However, there are two issues around this.
> >
> > Firstly the PCI core sets the device power state by asking what the real
> > ACPI power state is. This results that all but last device sharing the
> > power resources are in D3hot when the power resources are turned off. This
> > causes issues if user runs for example 'lspci' because the device is really
> > in D3cold so what user gets back is all ones (0xffffffff).
> >
> > Secondly if any of the device is runtime resumed the power resources are
> > turned on bringing all other devices sharing the resources to
> > D0uninitialized losing their wakeup configuration.
> >
> > This series aims to fix the two issues by:
> >
> >   1. Using the ACPI cached power state when PCI devices are transitioned
> >      into low power states instead of reading back the "real" power state.
> >
> >   2. Introducing concept of "_PR0 dependent devices" that get runtime
> >      resumed whenever their power resource (which they might share with
> >      other sibling devices) gets turned on.
> >
> > The series is based on the idea of Rafael J. Wysocki <rafael@kernel.org>.
> >
> > Previous version of the series can be found here:
> >
> >   v2: https://lore.kernel.org/linux-pci/20190618161858.77834-1-mika.westerberg@linux.intel.com/T/#m7a41d0b745400054543324ce84125040dbfed912
> >   v1: https://www.spinics.net/lists/linux-pci/msg83583.html
> >
> > Changes from v2:
> >
> >   * Updated changelog of patch [1/3] according to comments I got. I left
> >     the D3C power resource and xHCI there because it shows that we can have
> >     multiple shared power resources.
> >
> >   * Added link to the discussion around v2.
> >
> >   * Use adev->flags.power_manageable in patch [2/3].
> >
> > Mika Westerberg (3):
> >   PCI / ACPI: Use cached ACPI device state to get PCI device power state
> >   ACPI / PM: Introduce concept of a _PR0 dependent device
> >   PCI / ACPI: Add _PR0 dependent devices
> >
> >  drivers/acpi/power.c    | 135 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci-acpi.c  |   5 +-
> >  include/acpi/acpi_bus.h |   4 ++
> >  3 files changed, 143 insertions(+), 1 deletion(-)
> >
> 
> The whole series looks good to me, thank you!
> 

And so it has been applied and queued for 5.3, thanks!



