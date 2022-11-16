Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D962CEB4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiKPX2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKPX2o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 18:28:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89959FC2;
        Wed, 16 Nov 2022 15:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AB95B81F2E;
        Wed, 16 Nov 2022 23:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996AEC433B5;
        Wed, 16 Nov 2022 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668641319;
        bh=1zBpfGyr9uizob8bMvX0NxzH7tfCiWb/ipmk6cC1kgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bYtSabnYqm/WvoU9MYqsHKIoeQLBGZCnaff2fP/BFlz66dHeMs9tLxjF5ILTr8Dn/
         lEH2aWsd+uBxVnycPs6uUQZpzJrKIRg4/4qysBrTaDN/qaUwuaTNsL4PN6hkkAthDz
         hfiN9C0jm6iyPUss8FAJyTcYfjs/4wblV1HZ8aVV6qpWXGMeWWNxEmumqotgZ/1nFj
         DyeFsl7mEYBDXfDL6t1sm2ubwO8mZUGiT4M8rFUqhIJ/AnTlbl9zWVj56ou4XnO+Zu
         e+5+MoIW/bN5SdPBQ9aURVrvmbrnLW9KaOsDu4GjwmIUqmJ3M60jXJgY+56d2oKYpA
         MlSsvafVu/JvQ==
Date:   Wed, 16 Nov 2022 17:28:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221116232838.GA1140883@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gyVq0AOM1_kd3QWHj+jihL-vxBv=fcEJ_Zcp8QiOymcg@mail.gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > >
> > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > D3 if power managed by ACPI").
> > > > > > >
> > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > device contains power resources.
> > > >
> > > > Wait.  Is this as simple as just recognizing that:
> > > >
> > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > >   mean the device can wake itself from a low-power state.  The OS has
> > > >   to use _S0W to learn the device's ability to wake itself.
> > >
> > > It is.
> >
> > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > web page [1] says it identifies Root Ports capable of handling hot
> > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > says "I can wake myself from D3hot and D3cold", how is that different
> > from "I can handle hotplug events in D3"?
> 
> For native PME/hot-plug signaling there is no difference.  This is the
> same interrupt by the spec after all IIRC.
> 
> For GPE-based signaling, though, there is a difference, because GPEs
> can only be used directly for wake signaling (this is related to
> _PRW).  In particular, the only provision in the ACPI spec for device
> hot-add are the Bus Check and Device Check notification values (0 and
> 1) which require AML to run and evaluate Notify() on specific AML
> objects.
> 
> Hence, there is no spec-defined way to tell the OS that "something can
> be hot-added under this device while in D3 and you will get notified
> about that".

So I guess acpi_pci_bridge_d3() looks for:

  - "wake signaling while in D3" (_S0W) and
  - "notification of hotplug while in D3" ("HotPlugSupportInD3")

For Root Ports with both those abilities (or bridges below such Root
Ports), we allow D3, and this patch doesn't change that.

What this patch *does* change is that all bridges with _PS0 or _PR0
previously could use D3, but now will only be able to use D3 if they
are also (or are below) a Root Port that can signal wakeup
(wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).

And this fixes the Pink Sardine because it has Root Ports that do
Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
they cannot wake from D3.  Previously we put those in D3, but they
couldn't wake up.  Now we won't put them in D3.

I guess there's a possibility that this could break or cause higher
power consumption on systems that were fixed by c6e331312ebf
("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
I don't know enough about that scenario.  Maybe Lukas will chime in.

> > This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> > don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> > previously the fact that we checked for "HotPlugSupportInD3" meant the
> > device did NOT have _PS0 or _PR0.
> >
> > [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
