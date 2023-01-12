Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8166871B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjALWlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjALWlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:41:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8175BC3C;
        Thu, 12 Jan 2023 14:41:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85CA2621D1;
        Thu, 12 Jan 2023 22:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A440EC433EF;
        Thu, 12 Jan 2023 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673563259;
        bh=pCHG33j4SuQY0dNiZzwuDmzLjQWMe7kgUnvywi47kOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iDPITSBrSwIaZBqTl9WM43v1tDW+XIfQV20BECVurcimIiDvJpDHaqknb9ES/v14h
         10IqM7G9sFDooNKJYsg3ALJHjNcxJ4wnwaaUwOhQZAeYgOUUakSw0tB+FfBap51akb
         04xMxNY/Dmg9fiUaOcM9+2RHpWRGQDU1peNJGDBocLNBxM9MTx9Cy3F6y6zIaCeUo4
         /TXeztvOdmsmZ0ItqyNF3OrP9ey0606/W2WqpqqJMZd4iXfHAgS67Ai+EhI5ZaPl6D
         9qYiXX53J4RphmiginHA45FXqp3E85n2EFo7zVi2cNo50C67xx7OYKr8phyv3+tu0F
         PKGyWqwsDyZ0Q==
Date:   Thu, 12 Jan 2023 16:40:58 -0600
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
Message-ID: <20230112224058.GA1799052@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61013E30A82224755A81B0BEE2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 10:09:21PM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, January 12, 2023 16:02
> > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: linux-pci@vger.kernel.org; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Len
> > Brown <lenb@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> > Westerberg <mika.westerberg@linux.intel.com>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>; Rafael J .
> > Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
> > account in acpi_pci_bridge_d3(()
> > 
> > On Thu, Jan 12, 2023 at 09:51:24PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is generally questionable to allow a PCI bridge to go into D3 if
> > > it has _S0W returning D2 or a shallower power state, so modify
> > > acpi_pci_bridge_d3(() to always take the return value of _S0W for the
> > > target bridge into accout.  That is, make it return 'false' if _S0W
> > > returns D2 or a shallower power state for the target bridge regardless
> > > of its ancestor PCIe Root Port properties.  Of course, this also causes
> > > 'false' to be returned if the PCIe Root Port itself is the target and
> > > its _S0W returns D2 or a shallower power state.
> > >
> > > However, still allow bridges without _S0W that are power-manageable via
> > > ACPI to enter D3 to retain the current code behavior in that case.
> > >
> > > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-
> > mario.limonciello@amd.com/
> > > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Applied to pci/pm for v6.3, thanks!
> > 
> > It'd be great if we could include a short description of the problems
> > users might see.  I think the original problem was that on some AMD
> > systems we put a USB4 router in D3 when it should remain in D0.  And I
> > assume this means something doesn't wake up when it should?  Or maybe
> > we miss a hotplug event?
> > 
> > If somebody has an example or some text, I'll add it to the commit
> > log.
> 
> Here's a blurb for what happens on AMD side:
> 
> When the platform is configured to not allow the PCIe port used for
> tunneling to wakeup from D3 it will runtime suspend into D0 and the
> USB4 controller which is a consumer will runtime suspend into D3.
> 
> This inconsistency leads to failures to initialize PCIe tunnels for
> USB4 devices.

And what is J. Random User going to see?  DisplayPort not working
ever?  It works to begin with, but not after a suspend?  Devices in a
dock not being able to wake the system?

I don't really know what "PCIe tunnels for USB4 devices not being
initialized" means for me.  I want to know what a problem report from
a non-expert user might look like.

Bjorn
