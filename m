Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403124A7704
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiBBRm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:42:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60468 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiBBRm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:42:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC17B831CE;
        Wed,  2 Feb 2022 17:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D35C004E1;
        Wed,  2 Feb 2022 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643823776;
        bh=CvG8ii+9YGkPWVWDFhYOlfrAwbJIQDmwvlL7Cx3lywg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bPExBU/v4gXvP4NE7IFiqWBZJg9dt9hHChNbHnf92/KY+4qe1TdMyJNwC00O7JrXU
         3X//Sy26N3xCsYRmSozlMeOx4RLP7CeLVGujFCJ38OTitlniOJGo4G4caNoB1+mo1c
         eroTbPl1Q4exl5dIl4kerIDKXCgPo1uWLrv0wW/N9+eR7a16znlLOp+f0ENxo905LC
         8pFFBYgsDR/ztBYZ+x8H1PJqo/HCqZ8ye+LTYSBxQvGt8Nw98TdYPVt8f1ULeKcTvq
         TJABHCYxfAQOVEWmICHsK8ZZbM8MM97yN9aYY/tGwSY1L0PcibuATaEfrhO/ZyaeTw
         OWp9CKaKK7t+A==
Date:   Wed, 2 Feb 2022 11:42:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     pierre.gondois@arm.com
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Bug 215560] New: _PRS/_SRS methods should be optional
Message-ID: <20220202174255.GA22220@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bug-215560-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pierre,

Thanks a lot for the report!

On Wed, Feb 02, 2022 at 10:20:44AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215560
> 
>             Bug ID: 215560
>            Summary: _PRS/_SRS methods should be optional
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: v5.17-rc2
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: enhancement
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: pierre.gondois@arm.com
>         Regression: No
> 
> The PCI legacy interrupts can be described with link devices, cf ACPI 6.4,
> s6.2.13 "_PRT (PCI Routing Table)".
> Link devices can have optional _SRS/_PRS methods to set the interrupt.

Is this a direct quote?  I don't see text similar to this in ACPI
v6.4.

I do see this in sec 6.2.13:

  There are two ways that _PRT can be used. Typically, the interrupt
  input that a given PCI interrupt is on is configurable.  For
  example, a given PCI interrupt might be configured for either IRQ 10
  or 11 on an 8259 interrupt controller. In this model, each interrupt
  is represented in the ACPI namespace as a PCI Interrupt Link Device.

  These objects have _PRS, _CRS, _SRS, and _DIS control methods to
  allocate the interrupt. Then, OSPM handles the interrupts not as
  interrupt inputs on the interrupt controller, but as PCI interrupt
  pins. The driver looks up the device’s pins in the _PRT to determine
  which device objects allocate the interrupts. To move the PCI
  interrupt to a different interrupt input on the interrupt
  controller, OSPM uses _PRS, _CRS, _SRS, and _DIS control methods for
  the PCI Interrupt Link Device.

  In the second model, the PCI interrupts are hardwired to specific
  interrupt inputs on the interrupt controller and are not
  configurable. In this case, the Source field in _PRT does not
  reference a device, but instead contains the value zero, and the
  Source Index field contains the global system interrupt to which the
  PCI interrupt is hardwired.

For the first model (configurable inputs), it says "These objects have
_PRS, _CRS, _SRS, and _DIS," which could be read as requiring those
objects.

For the second model (hardwired inputs), the interrupts are not
configurable, and I don't think there would be any reason to have an
interrupt link device at all.

> In PCI Firmware Specification Revision 3.3, s4.3.2.1. "Resource Setting":
> """
> A non-configurable device only specifies _CRS. However, if they are
> configurable, devices include
> _PRS to indicate the possible resource setting and _SRS to allow OSPM to
> specify a new resource
> allocation for the device.
> """

My copy of the PCI Firmware spec r3.3 (dated Jan 20, 2021), sec
4.3.2.1 says:

  Host bridges resources programming is communicated to the operating
  system using ACPI methods _CRS, _SRS, and _PRS. _CRS indicates the
  current resource setting for the host bridge. This includes I/O
  space, memory space, and bus range assigned to the bridge by
  platform firmware.

  A non-configurable device only specifies _CRS. However, if they are
  configurable, devices include _PRS to indicate the possible resource
  setting and _SRS to allow OSPM to specify a new resource allocation
  for the device.

So this is specifically talking about methods of a PCI host bridge
(PNP0A03 or PNP0A08), not about methods of an interrupt link device
(PNP0C0F).

> However, _PRS/_SRS methods are checked in drivers/acpi/pci_link.c, and the
> driver aborts if they are absent.
> E.g.: When _PRS is missing:
> ACPI: \_SB_.PCI0.LNKA: _CRS 36 not found in _PRS
> ACPI: \_SB_.PCI0.LNKA: No IRQ available. Try pci=noacpi or acpi=off

I assume this bug report is because something isn't working.  Can you
update the bugzilla with a note about what specifically isn't working
and also attach a complete dmesg log and acpidump?

Bjorn
