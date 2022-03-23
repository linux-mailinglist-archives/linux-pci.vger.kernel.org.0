Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404604E5A33
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 21:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiCWUxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbiCWUxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 16:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F8710C6;
        Wed, 23 Mar 2022 13:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24147616D4;
        Wed, 23 Mar 2022 20:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1CC340E8;
        Wed, 23 Mar 2022 20:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648068723;
        bh=Ss7Fr2ZAmiX1mlEh8EbszXqHlZQYQthlgHDYkYJmJ8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DJnsP2mR4gLRakDJn1ofS7sJ/3nh8MptJCxOyRXnZLq3dKZUJdUMwVOLW+2sePmid
         X9AX9T7jGcFPPNmifxodGFUK9I1j32Au1ZEFvgBHH4zsRpxeVBxd9m2gmNpOuSPA07
         ForsDuWICS7SsdWQzFQpeuMMVATd1nhMAL8/KeOnujwjHpSLf9pqP5URHPUlHbRiL0
         WTOTh4TocUmldysHndbaMOpe78DtJ7OGhNiymU+dYz8Nn3ruNcYFryPwJ1oZDv4uBl
         s8Hed58KiXMy4xTFfJyheXo3Rh9OSZgOEfvrglY1jukd7Hp/2QPiclipL6e3G6ea8M
         BEXj3RDTIVm6w==
Date:   Wed, 23 Mar 2022 15:52:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Message-ID: <20220323205201.GA1320371@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83aee1d8-5700-d2bb-fae5-d952240c6fb8@amd.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 11:01:05AM -0500, Mario Limonciello wrote:
> On 3/15/22 11:36, Rafael J. Wysocki wrote:
> > On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > 
> > > On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > > 
> > > > According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> > > > indicates the ability for a bridge to be able to wakeup from D3:
> > > > 
> > > >    This ACPI object [HotPlugSupportInD3] enables the operating system
> > > >    to identify and power manage PCIe Root Ports that are capable of
> > > >    handling hot plug events while in D3 state.
> > > > 
> > > > This however is static information in the ACPI table at BIOS compilation
> > > > time and on some platforms it's possible to configure the firmware at boot
> > > > up such that _S0W returns "0" indicating the inability to wake up the
> > > > device from D3 as explained in the ACPI specification:
> > > > 
> > > >    7.3.20 _S0W (S0 Device Wake State)
> > > > 
> > > >    This object evaluates to an integer that conveys to OSPM the deepest
> > > >    D-state supported by this device in the S0 system sleeping state
> > > >    where the device can wake itself.
> > > > 
> > > > This mismatch may lead to being unable to enumerate devices behind the
> > > > hotplug bridge when a device is plugged in. To remedy these situations
> > > > that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
> > > > check that the ACPI companion has returned _S0W greater than or equal
> > > > to 3 and the device has a GPE allowing the device to generate wakeup
> > > > signals handled by the platform in `acpi_pci_bridge_d3`.
> > > > 
> > > > Windows 10 and Windows 11 both will prevent the bridge from going in D3
> > > > when the firmware is configured this way and this changes aligns the
> > > > handling of the situation to be the same.
> > > > 
> > > > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cae5d5d8f4ac1452dac0c08da06a200b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637829590116901616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3cTSyBgSEOBo5mPeUcNDrc9qhdMJeZ4cVtLqroDRZqY%3D&amp;reserved=0
> > > > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cae5d5d8f4ac1452dac0c08da06a200b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637829590116901616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rZHk%2FgII0qOvr9cmmB8N1auNc1nLSFViVTG9f%2FwEREY%3D&amp;reserved=0
> > > > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > No more comments from me:
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Or please let me know if I should pick it up.
> 
> Bjorn,
> 
> Friendly reminder on this one.

Thanks; we're in the middle of the merge window now, so I'll wait till
that's over unless this is an emergency.

IIUC the bug this fixes is that "when a bridge is in D3cold, we don't
notice when a device is hot-added below it," right?  So we need to
avoid putting the bridge in D3cold?

Is there a typical scenario where this bites users?  I don't think we
ever saw an actual problem report?

> > > > ---
> > > > changes from v3->v4:
> > > >   * rework comment
> > > >   * only evaluate _S0W if necessary
> > > >   * drop static function with only one caller
> > > > 
> > > >   drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
> > > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > index a42dbf448860..e535dab2c888 100644
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > >          const union acpi_object *obj;
> > > >          struct acpi_device *adev;
> > > >          struct pci_dev *rpdev;
> > > > +       unsigned long long ret;
> > > > 
> > > >          if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> > > >                  return false;
> > > > @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > >                                     ACPI_TYPE_INTEGER, &obj) < 0)
> > > >                  return false;
> > > > 
> > > > -       return obj->integer.value == 1;
> > > > +       if (!obj->integer.value)
> > > > +               return false;
> > > > +
> > > > +       /*
> > > > +        * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
> > > > +        * the former cannot be trusted anyway, so validate it by verifying the
> > > > +        * latter.
> > > > +        */
> > > > +       if (!adev->wakeup.flags.valid)
> > > > +               return false;
> > > > +
> > > > +       if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
> > > > +               return false;
> > > > +
> > > > +       return ret >= ACPI_STATE_D3_HOT;
> > > >   }
> > > > 
> > > >   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> > > > --
> > > > 2.34.1
> > > > 
> 
