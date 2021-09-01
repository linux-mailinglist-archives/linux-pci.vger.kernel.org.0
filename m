Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF093FD33C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhIAFti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 01:49:38 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:56331 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbhIAFtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 01:49:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D7DE82801E519;
        Wed,  1 Sep 2021 07:48:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CBDEBFDCD6; Wed,  1 Sep 2021 07:48:18 +0200 (CEST)
Date:   Wed, 1 Sep 2021 07:48:18 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     stuart hayes <stuart.w.hayes@gmail.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210901054818.GA7877@wunner.de>
References: <9e31bae7-d7c7-d40a-9782-c59dcaf83798@gmail.com>
 <20210831215801.GA152955@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831215801.GA152955@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 31, 2021 at 04:58:01PM -0500, Bjorn Helgaas wrote:
> I just think it's
> conceivable that one might *want* portdrv to not claim an intermediate
> switch like that.

It's possible to manually unbind portdrv from the device via sysfs
(because portdrv is a driver).  In that case the port will not restore
config space upon an error-induced reset and any devices downstream
of the port will be inaccessible after the reset.

That's the only possible way to screw this up I think.
And it requires deliberate, manual action.  One *could* argue that's
not correct and the kernel shouldn't allow the incorrect behavior
in the first place.  The behavior follows from portdrv being a driver,
instead of its functionality being baked into the PCI core.


> Or maybe you don't have portdrv configured at all.  Do we still
> save/restore config space for suspend/resume of the switch?

We do, because the PCI core takes care of that.  E.g. on resume
from system sleep:

  pci_pm_resume_noirq()
    pci_pm_default_resume_early()
      pci_restore_state()

However after an error-induced reset, it's the job of the device
driver's ->slot_reset() callback to restore config space.
That's a design decision that was made back in 2005 when EEH
was introduced.  See Documentation/PCI/pci-error-recovery.rst:

  It is important for the platform to restore the PCI config space
  to the "fresh poweron" state, rather than the "last state". After
  a slot reset, the device driver will almost always use its standard
  device initialization routines, and an unusual config space setup
  may result in hung devices, kernel panics, or silent data corruption.

I guess it would be possible to perform certain tasks such as
pci_restore_state() centrally in report_slot_reset() instead
(in drivers/pci/pcie/err.c) and alleviate each driver from doing that.

One has to bear in mind though that a device may require specific
steps before pci_restore_state() is called.  E.g. in the case of portdrv,
spurious hotplug DLLSC events need to be acknowledged first:

https://patchwork.ozlabs.org/project/linux-pci/patch/251f4edcc04c14f873ff1c967bc686169cd07d2d.1627638184.git.lukas@wunner.de/


If portdrv isn't configured at all, AER and DPC support cannot be
configured either (because they depend on PCIEPORTBUS), and it's the
reset performed by AER or DPC which necessitates calling pci_restore_state().

If a port supports none of portdrv's services, portdrv still binds to
the port and is thus able to restore config space if a reset is performed
at a port further upstream.  That's because of ...

	if (!capabilities)
		return 0;

... in pcie_port_device_register().  So that should be working correctly.

Thanks,

Lukas
