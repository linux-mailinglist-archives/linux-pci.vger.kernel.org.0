Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DD49B7B7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 16:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357899AbiAYPfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 10:35:17 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:45975 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356706AbiAYPdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 10:33:19 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2001C280472B8;
        Tue, 25 Jan 2022 16:33:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 127582B19AE; Tue, 25 Jan 2022 16:33:14 +0100 (CET)
Date:   Tue, 25 Jan 2022 16:33:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220125153314.GA31653@wunner.de>
References: <bug-215525-41252@https.bugzilla.kernel.org/>
 <20220124214635.GA1553164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124214635.GA1553164@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 24, 2022 at 03:46:35PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 24, 2022 at 11:46:14AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215525
> > 
> > While testing on latest upstream kernel we noticed that with the
> > merge commit d0a231f01e5b hotplug and hotunplug of nvme drives
> > stopped working.
[...]
> Only three commits touch pciehp:
> 
>   085a9f43433f ("PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors")
>   23584c1ed3e1 ("PCI: pciehp: Fix infinite loop in IRQ handler upon power fault")
>   a3b0f10db148 ("PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check config reads")

Those commits pertain to *native* hotplug, however the machine in question
does not grant hotplug control to OSPM, so pciehp isn't even probed for
any ports on that machine:

  acpi PNP0A08:09: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
  acpi PNP0A08:09: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

Are these ports supposed to be handled by native hotplug or acpiphp?
Perhaps CONFIG_HOTPLUG_PCI_PCIE was erroneously not enabled?

It's unfortunate that the bugzilla only contains the dmesg dump of
broken hotplug, but not of working hotplug.  That would make it easier
to determine what's going wrong.

Thanks,

Lukas
