Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67E662B01E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 01:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKPAhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 19:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKPAhp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 19:37:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547832A970;
        Tue, 15 Nov 2022 16:37:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 042BCB81A66;
        Wed, 16 Nov 2022 00:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B8FC433B5;
        Wed, 16 Nov 2022 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668559061;
        bh=BNuisBrauM7r8I3QUy7HVPUK60+5GXaUDdg+V+tFKwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LA+WyWfTOWaUtNNq2tFThoTEEfrHluSWEeogkfZGw3+pGKlGo6cOVl89ZATAYaTK/
         rfRzytfqVh/+39qQG8Go0eb8E5MldwGD7sWH/0sdrSl2Qsffr4cKBOWF0j/8D7OHZJ
         XdVHz2Z8fviZpvdCrO/MVp1XqKgAn4ic7R3ysWgyKYoFU3ugIu+TjsnJ3Uy6SWSQcJ
         lYZKIoCzGuAkpC7em7cgWbzK80pTKRNMaRHSUI1X8xpunoOtwWFlI4vIQoXvdeQLRR
         z5KXMtvkBXLCqPTEfCm+YhMy8NK3osBLs5rTF2FbVSE3qNnh5KX0yn+ydtiXdje4c6
         DRIM2EPH+8O/Q==
Date:   Tue, 15 Nov 2022 18:37:39 -0600
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
Message-ID: <20221116003739.GA1061657@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g834K4ZBrEvhAbJhvGBVyq53nreG+xeBufXKQXA3VtrQ@mail.gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > devices can support D3 by a combination of the value returned by
> > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > >
> > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > device it's associated with can support D3.  This was introduced
> > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > D3 if power managed by ACPI").
> > > > >
> > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > runtime PM in the kernel [2] because of the logic within
> > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > device contains power resources.
> >
> > Wait.  Is this as simple as just recognizing that:
> >
> >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> >   mean the device can wake itself from a low-power state.  The OS has
> >   to use _S0W to learn the device's ability to wake itself.
> 
> It is.

Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
web page [1] says it identifies Root Ports capable of handling hot
plug events while in D3.  That sounds kind of related to _S0W: If _S0W
says "I can wake myself from D3hot and D3cold", how is that different
from "I can handle hotplug events in D3"?

This patch says that if dev's Root Port has "HotPlugSupportInD3", we
don't need _PS0 or _PR0 for dev.  I guess that must be true, because
previously the fact that we checked for "HotPlugSupportInD3" meant the
device did NOT have _PS0 or _PR0.

[1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
