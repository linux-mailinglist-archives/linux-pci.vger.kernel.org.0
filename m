Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C593D7A3F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhG0PzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 11:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG0PzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 11:55:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE6861B70;
        Tue, 27 Jul 2021 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627401314;
        bh=Pa9nsMD8rP9mrO/HgZx0xcU6Rf5Qu6640KU7ffl5QT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YMDa/gobW7Cg0PVHBE4admAtpgsFeUnHk2VnU2EDjOvMP4ea5xj/RxniPjPM2TnQU
         ZNN2wvHSBucJocBq974u+eLg6WlWyhOFcBaJbSLJL+xM53XQvEuLk+wd+GLpF0LqnK
         dx89IQepjUOteOEAKpgcH+CsgiJr3j2LgWSEZJPEZJcsCD3No/Jdx3t6b/ti4p/mXj
         vA7XxtJ3vnqdHMy+890MeRyQ2UTZ7VqK+rS052mKVwADsX/bCRoeW8Uqp60wqjf3u2
         doxtMHNuqOUEdMWYsAsIAJa4sO9BQfXaup3wnJxi2OjsUarciPT6o9pZZtfaHSnwFF
         mv/DdlUj4dWVA==
Date:   Tue, 27 Jul 2021 10:55:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [Bug 213873] New: Hotplug ethernet cable to runtime suspended
 Realtek NIC doesn't raise PCIe PME IRQ on Intel ADL
Message-ID: <20210727155512.GA716431@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-213873-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 27, 2021 at 06:10:13AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=213873
> 
>             Bug ID: 213873
>            Summary: Hotplug ethernet cable to runtime suspended Realtek
>                     NIC doesn't raise PCIe PME IRQ on Intel ADL
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: mainline
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kai.heng.feng@canonical.com
>         Regression: No
> 
> Both PCIe bridge and Realtek NIC are runtime suspended. When ethernet cable is
> plugged, PMEStatus and PMEPending are marked:
> RootSta: PME ReqID 0200, PMEStatus+ PMEPending+
> 
> But the IRQ isn't raised:
> $ cat /proc/interrupts  | grep PME
>  145:          0          0          0          0          0          0        
>  0          0          0          0          0          0   VMD-MSI  126  PCIe
> PME, aerdrv, pcie-dpc
> 
> So the hotplug event isn't detected.
> 
> -- 

From the lspci after cable hotplug (comment #3):

  0000:00:1c.0 PCI bridge ...
    RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
    RootSta: PME ReqID 0200, PMEStatus+ PMEPending+

So it looks like the root port is not enabled to generate a PME
interrupt.  pcie_pme_interrupt_enable() looks like it *could* enable
that.  From a quick look, my guess is that pme.c doesn't claim this
root port because the platform says it doesn't support it:

  acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
  acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]

Does booting with "pcie_ports=native" make it work?  That's not a very
good solution, of course, because then both the firmware and Linux
think they own this functionality.

Is there a BIOS update that would fix this?

Bjorn
