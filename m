Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC960EF76
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiJ0FYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 01:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0FYL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 01:24:11 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170015A324;
        Wed, 26 Oct 2022 22:24:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B5FA02800C974;
        Thu, 27 Oct 2022 07:24:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA95E43217; Thu, 27 Oct 2022 07:24:07 +0200 (CEST)
Date:   Thu, 27 Oct 2022 07:24:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221027052407.GA18319@wunner.de>
References: <20221026215237.18556-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026215237.18556-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 04:52:37PM -0500, Mario Limonciello wrote:
> Firmware typically advertises that ACPI devices that represent PCIe
> devices can support D3 by a combination of the value returned by
> _S0W as well as the HotPlugSupportInD3 _DSD [1].
> 
> `acpi_pci_bridge_d3` looks for this combination but also contains
> an assumption that if an ACPI device contains power resources the PCIe
> device it's associated with can support D3.  This was introduced
> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> D3 if power managed by ACPI").
> 
> Some firmware configurations for "AMD Pink Sardine" do not support
> wake from D3 in _S0W for the ACPI device representing the PCIe root
> port used for tunneling. The PCIe device will still be opted into
> runtime PM in the kernel [2] because of the logic within
> `acpi_pci_bridge_d3`. This currently happens because the ACPI
> device contains power resources.

So put briefly, in acpi_pci_bridge_d3() we fail to take wake capabilities
into account and blindly assume that a bridge can be runtime suspended
to D3 if it is power-manageable by ACPI.

By moving the acpi_pci_power_manageable() below the wake capabilities
checks, we avoid runtime suspending a bridge that is not wakeup capable.

The more verbose explanation in the commit message is useful to
understand how the issue was exposed, but it somewhat obscures
the issue itself.


> When the thunderbolt driver is loaded two device links are created:
> * USB4 router <-> PCIe root port for tunneling
> * USB4 router <-> XHCI PCIe device

Those double arrows are a little misleading, a device link is
unidirectional, so it's really <-- and not <->.


> Currently runtime PM is allowed for all of these devices.  This means that
> when all consumers are idle long enough, they will enter their deepest allowed
> sleep state. Once all consumers are in their deepest allowed sleep state the
> suppliers will enter the deepest sleep state as well.
> 
> * The PCIe root port for tunneling doesn't support waking from D3hot or
>   D3cold so it stays in D0.

Huh?  I thought it's runtime suspended to D3hot even though it should stay
runtime resumed in D0 because it's not wakeup capable in D3hot?


> * The XHCI PCIe device supports wakeup from D3cold so it goes to D3cold.
> * Both consumers are in their deepest state and the USB4 router supports
>   wakeup from D3cold, so it goes into this state.
> 
> The expectation is the USB4 router should have also remained in D0 since
> the PCIe root port for tunneling remained in D0 and a device link exists
> between the two devices.

This paragraph sounds like the problem is the router runtime suspended.
IIUC the router could only runtime suspend because its consumer, the
Root Port, runtime suspended.  By preventing the Root Port from runtime
suspending, you're implicitly preventing it's supplier (the router)
from suspending.


> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3 [1]
> Link: https://github.com/torvalds/linux/blob/v6.1-rc1/drivers/pci/pcie/portdrv_pci.c#L126 [2]
> Link: https://github.com/torvalds/linux/blob/v6.1-rc1/drivers/thunderbolt/acpi.c#L29 [3]

I think git.kernel.org links are preferred to 3rd party hosting services.

Thanks,

Lukas
