Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B54EED26
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiDAMbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiDAMbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 08:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64D935AB8;
        Fri,  1 Apr 2022 05:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B4BFB824BC;
        Fri,  1 Apr 2022 12:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCACC2BBE4;
        Fri,  1 Apr 2022 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648816160;
        bh=pQ9aYMPYtweggJYVEPu/V1OoUPowzTKvTXimQ6DbotM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A6T2UBbQuFJDD6CBH2bhQ63JngOkTzZOHZKrUtFtZRT7lK9wvewQ/j0NtrRsKKWEa
         fBxLQDTLzCJuUspBUH4qBw9VYc0pgx6ZwE4A8J9S8qiagldOteqxfX0FWdZ8tg+jr8
         DrW/zXxCGWTYmb8UtXqaMJw71H1JJFuLm/PDj1ntBlJJ8Nf5QzdiV/F3Tqsh+VRQpl
         1ABn8zan5FqK9CPJPtYh5JhgffMgLEZC38faT/oic60CMAOQA3upV9Ntg8/ublBqJL
         KpYCZCllk+IU2nO7Jf2/iHk4i9ufC/7AfMYLA1nPRUFKZLqGwXf4JhiNOmM0zkaF5m
         sCIDR/JOrg7dg==
Date:   Fri, 1 Apr 2022 07:29:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if
 device can wake from D3
Message-ID: <20220401122918.GA87920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jqWZRp2ZcyO+w66EgE8SHFZ+ZeNka2aUMfLwU93wuxpQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 01, 2022 at 01:44:42PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 1, 2022 at 5:40 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
> > that can handle hotplug events while in D3.  Previously this meant:
> >
> >  1) "dev" has a _PS0 or _PR0 method, or
> >
> >  2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
> >     property with value 1.
> >
> > This did not consider_S0W, which tells us the deepest D-state from
> > which a device can wake itself (ACPI v6.4, sec 7.3.20).
> >
> > On some platforms, e.g., AMD Yellow Carp, firmware may supply
> > "HotPlugSupportInD3" even though the platform does not supply power
> > resources through _PRW and _S0W tells us the device cannot wake from
> 
> More importantly, it doesn't supply a wakeup GPE number through _PRW,
> so from the ACPI perspective the bridge has no way of generating
> wakeup signals.

Perfect, thanks.  That's the missing piece about _PRW.

> > D3hot.  With the previous code, these devices could be put in D3hot
> > and hotplugged devices would not be recognized without manually
> > rescanning.
> >
> > If _S0W exists and says the Root Port cannot wake itself from D3hot,
> > return "false" to indicate that "dev" cannot handle hotplug events
> > while in D3.
> >
> >  1) "dev" has a _PS0 or _PR0 method, or
> >
> >  2a) The Root Port above "dev" has _PRW and
> >
> >  2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
> >      D3cold and
> >
> >  2c) The Root Port above "dev" has a _DSD with a
> >      "HotPlugSupportInD3" property with value 1.
> >
> > Windows 10 and Windows 11 both will prevent the bridge from going in D3
> > when the firmware is configured this way and this change aligns the
> > handling of the situation to be the same.
> >
> > Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> > Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > --
> > v5->v6:
> >  * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
> >  * Adjust commit message wording
> >  * Drop rewording comment patch, just apply it while moving text to avoid
> >    ping-ponging the same lines in the commits.
> > v4-v5:
> >  * Don't fail if _S0W is missing
> > ---
> >  drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 1f15ab7eabf8..5ab797e2709d 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >  {
> >         const union acpi_object *obj;
> >         struct acpi_device *adev;
> > +       unsigned long long state;
> >         struct pci_dev *rpdev;
> > +       acpi_status status;
> >
> >         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> >                 return false;
> > @@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         if (acpi_pci_power_manageable(dev))
> >                 return true;
> >
> > -       /*
> > -        * The ACPI firmware will provide the device-specific properties through
> > -        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> > -        * for the root port and if it is set we know the hierarchy behind it
> > -        * supports D3 just fine.
> > -        */
> >         rpdev = pcie_find_root_port(dev);
> >         if (!rpdev)
> >                 return false;
> > @@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         if (!adev)
> >                 return false;
> >
> > +       /*
> > +        * If the bridge can't wake from D3hot, it can't signal hotplug
> > +        * events in D3hot.
> 
> I would say "If the bridge cannot signal wakeup signals at all, it
> cannot signal hotplug events from low-power states including D3hot and
> D3cold."
> 
> With the two above remarks addressed, please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Great, thanks!

> > +        */
> > +       if (!adev->wakeup.flags.valid)
> > +               return false;
> > +
> > +       status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> > +       if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> > +               return false;
> > +
> > +       /*
> > +        * The ACPI firmware will provide the device-specific properties through
> > +        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> > +        * for the root port and if it is set we make an assumption that the
> > +        * hierarchy behind it supports D3 as well.
> > +        */
> >         if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
> >                                    ACPI_TYPE_INTEGER, &obj) < 0)
> >                 return false;
> > --
> > 2.34.1
> >
