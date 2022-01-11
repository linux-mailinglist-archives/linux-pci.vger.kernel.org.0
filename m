Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B148BA42
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 22:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiAKV4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 16:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiAKVz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 16:55:58 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BFC06173F;
        Tue, 11 Jan 2022 13:55:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7FF7F100D5855;
        Tue, 11 Jan 2022 22:55:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 612A8350DA7; Tue, 11 Jan 2022 22:55:55 +0100 (CET)
Date:   Tue, 11 Jan 2022 22:55:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yao Hongbo <yaohongbo@linux.alibaba.com>, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2] PCI: Waiting command completed in
 get_port_device_capability()
Message-ID: <20220111215555.GA19605@wunner.de>
References: <1641525769-113099-1-git-send-email-yaohongbo@linux.alibaba.com>
 <20220111185538.GA152548@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111185538.GA152548@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 12:55:38PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 11:22:49AM +0800, Yao Hongbo wrote:
> > According to the PCIe specification Revision 5.0, section
> > 7.5.3.11 (slot Status Register), if Command Complete notification

Hm, I only have the PCIe r4.0 Base Spec available and the section
number is 7.8.11 there.  Is 7.5.3.11 really correct for the r5.0 spec?


> > However, before probing the pcie hotplug service, there needs to set
> > HPIE bit in the slot ctrl register to disable hotplug interrupts,
> > and there is no wait currently.

There is a similar issue on resume.  The PCI core writes to the
Slot Control register in...

  pci_pm_resume_noirq()
    pci_pm_default_resume_early()
      pci_restore_state()
        pci_restore_pcie_state()

...and to ensure that the proper Command Completed dance is performed,
we do this in pciehp_resume_noirq() and pciehp_runtime_resume():

	/* pci_restore_state() just wrote to the Slot Control register */
	ctrl->cmd_started = jiffies;
	ctrl->cmd_busy = true;

That was introduced by 469e764c4a3c.

I'd prefer that we do the same in pciehp_probe() (or pcie_init())
if we come to the conlusion that we want to continue disabling HPIE
and CCIE in get_port_device_capability().  It's a much simpler and
smaller solution than the one proposed in the present patch.


> But now, on ACPI systems, we only clear HPIE and CCIE here if we *do*
> have the hotplug driver (because host->native_pcie_hotplug only
> remains set if we have been granted control via _OSC, and we only
> request control when CONFIG_HOTPLUG_PCI_PCIE is enabled).  On these
> systems, we should be able to remove this disable code because pciehp
> will do whatever it needs.

I guess an argument could be made that even though CONFIG_HOTPLUG_PCI_PCIE
is enabled, pciehp may fail to probe, e.g. because the call to kzalloc()
in pcie_init() returns NULL due to insufficient memory.  Then the interrupt
would remain enabled if the BIOS neglected to disable it.  That could be
accounted for by rearranging pciehp such that the interrupt is disabled
first thing on probe.  Of course that approach doesn't solve the problem
if CONFIG_HOTPLUG_PCI_PCIE is disabled and we'd still have to disable
the interrupt in get_port_device_capability() in that case.

I think it generally makes sense to assume the worst and compensate for
broken BIOSes.

Hotplug and PME share the same MSI or MSI-X vector per section 6.7.3.4
of the PCIe Base Spec, so enabled but unhandled hotplug interrupts will
cause the PME interrupt handler to run.  That's probably not fatal,
but still undesirable.

Thanks,

Lukas
