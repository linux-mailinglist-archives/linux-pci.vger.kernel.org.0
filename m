Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC466A150
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAMR6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 12:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAMR6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 12:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91F7F9D7;
        Fri, 13 Jan 2023 09:51:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2D3622D0;
        Fri, 13 Jan 2023 17:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1C0C433D2;
        Fri, 13 Jan 2023 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632298;
        bh=3LnsMdjPcXTZVEHkBWK5abIQvnrNhWuNASnKmgc+Fgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cipZBDKw064GTZrUKI/yNHcV+IPnDLtFInQKkG04Ax3FbPKeiZqrZm57AqWLKN5SG
         TrxYhMa50EX7bQGyspOBPhY0eHqZ4yfLOpuGLytRrPWPlPCjpazbWTAh45Z9pBA3l7
         xu18lp3TMgnsUejX781ScR+woiUWTpvS8k9kzVgyqxMI9UdTzDkt6m2FqzF0ykcYCe
         09K639BJ5Jmi/QEn0BJ+NLiln2FbLEkEvYT72bMEJHcWyDrIZYka5U60C+itgD5lzn
         9jCLmip8J1cXtv36jstTU6rh9X67XvMrnWOZ3m2VvfOe3VigHrnTtJ0rZpQz+0Mp48
         NVkLzTbc41Pyw==
Date:   Fri, 13 Jan 2023 11:51:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
 account in acpi_pci_bridge_d3(()
Message-ID: <20230113175136.GA1848594@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61016E8166D73C4BD7C720D4E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 10:45:03PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> 
> 
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, January 12, 2023 16:41
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; linux-pci@vger.kernel.org; Rafael J.
> > Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Bjorn Helgaas
> > <bhelgaas@google.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Mehta, Sanju <Sanju.Mehta@amd.com>;
> > Lukas Wunner <lukas@wunner.de>; Rafael J . Wysocki
> > <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
> > account in acpi_pci_bridge_d3(()
> > 
> > On Thu, Jan 12, 2023 at 10:09:21PM +0000, Limonciello, Mario wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Thursday, January 12, 2023 16:02
> > > > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: linux-pci@vger.kernel.org; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; Rafael J. Wysocki <rafael@kernel.org>;
> > Len
> > > > Brown <lenb@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> > > > Westerberg <mika.westerberg@linux.intel.com>; Mehta, Sanju
> > > > <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>; Rafael J .
> > > > Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > > > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
> > > > account in acpi_pci_bridge_d3(()
> > > >
> > > > On Thu, Jan 12, 2023 at 09:51:24PM +0100, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > It is generally questionable to allow a PCI bridge to go into D3 if
> > > > > it has _S0W returning D2 or a shallower power state, so modify
> > > > > acpi_pci_bridge_d3(() to always take the return value of _S0W for the
> > > > > target bridge into accout.  That is, make it return 'false' if _S0W
> > > > > returns D2 or a shallower power state for the target bridge regardless
> > > > > of its ancestor PCIe Root Port properties.  Of course, this also causes
> > > > > 'false' to be returned if the PCIe Root Port itself is the target and
> > > > > its _S0W returns D2 or a shallower power state.
> > > > >
> > > > > However, still allow bridges without _S0W that are power-manageable via
> > > > > ACPI to enter D3 to retain the current code behavior in that case.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-
> > > > mario.limonciello@amd.com/
> > > > > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Applied to pci/pm for v6.3, thanks!
> > > >
> > > > It'd be great if we could include a short description of the problems
> > > > users might see.  I think the original problem was that on some AMD
> > > > systems we put a USB4 router in D3 when it should remain in D0.  And I
> > > > assume this means something doesn't wake up when it should?  Or maybe
> > > > we miss a hotplug event?
> > > >
> > > > If somebody has an example or some text, I'll add it to the commit
> > > > log.
> > >
> > > Here's a blurb for what happens on AMD side:
> > >
> > > When the platform is configured to not allow the PCIe port used for
> > > tunneling to wakeup from D3 it will runtime suspend into D0 and the
> > > USB4 controller which is a consumer will runtime suspend into D3.
> > >
> > > This inconsistency leads to failures to initialize PCIe tunnels for
> > > USB4 devices.
> > 
> > And what is J. Random User going to see?  DisplayPort not working
> > ever?  It works to begin with, but not after a suspend?  Devices in a
> > dock not being able to wake the system?
> > 
> > I don't really know what "PCIe tunnels for USB4 devices not being
> > initialized" means for me.  I want to know what a problem report from
> > a non-expert user might look like.
> 
> DP tunnels aren't affected, so monitors should still work.
> 
> In terms of what doesn't work it depends on the architecture of the
> the connected device.  Here's some concrete up-leveled examples:
> 
> USB4 docks contain that a PCIe network adapter and that adapter won't
> work when the dock is plugged in after the system boot.
> 
> USB4 docks that contain a USB network adapter should work properly,
> but downstream USB4 or TBT3 devices connected to that USB4 dock will
> not work when the device or dock is plugged in after the system boots.
> 
> TBT3 storage devices connected after the system has booted will not work.

Thanks, this is exactly the sort of thing I was looking for.  Since
they all mention "connected after boot," I assume the issue with the
current code is that a hotplug notification is being missed because a
bridge is in D3.

If the devices are present and enumerated at boot, there's no issue
with suspend/resume, right?

What do you think of the following possible text?  I don't want to be
overly specific because I don't think it's practical to list every
scenario.  We just need a hook to make people think "Hmm, I'm seeing a
dock issue; maybe this is the fix."

  This fixes problems where a hotplug notification is missed because a
  bridge is in D3.  That means hot-added devices such as USB4 docks
  (and the devices they contain) and Thunderbolt 3 devices may not
  work.
