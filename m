Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226224EED71
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiDAMuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbiDAMuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 08:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668717041;
        Fri,  1 Apr 2022 05:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52FAD61A27;
        Fri,  1 Apr 2022 12:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C74C3410F;
        Fri,  1 Apr 2022 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648817308;
        bh=04zyeDsZ6CNbvQr7rW+IhI8pPOVuT9A45/e25mj++TA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bI6yf39YJKo9McA4h6YHBK7oVRqv+L2OJDugPhUl7+yu5KHctX7vgaqrqL3uXPZAN
         121BtaVVRpUN1qhqd6wAjqi2B0lBVsZZZ2E91uRztR+0vGVtIueesq4N/XSoE9FwKl
         5zZON9+16Um6lNjSZ9vTkvNfpWtSvQz4dL826FOFFxhoo3/doxKD2aZD1+aKZf2ijH
         70N3eEDFO7W6SB9fdpL9tnaNqriXAMxRY6MdctRZTknpTzIgxDL/z0dEfbi/awL0Qo
         igmpUvHtD52bAV+nOJyMLYeGl5NTXHtTHDtYLKHOs4zkTC73bjaLbaehpRgjCbGDTh
         KKGxcge5BNLBQ==
Date:   Fri, 1 Apr 2022 07:48:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if
 device can wake from D3
Message-ID: <20220401124826.GA89698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34612803-5038-f727-f12a-8f71929301ac@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 01, 2022 at 07:32:58AM -0500, Limonciello, Mario wrote:
> On 4/1/2022 07:29, Bjorn Helgaas wrote:
> > On Fri, Apr 01, 2022 at 01:44:42PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Apr 1, 2022 at 5:40 AM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > > 
> > > > acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
> > > > that can handle hotplug events while in D3.  Previously this meant:
> > > > 
> > > >   1) "dev" has a _PS0 or _PR0 method, or
> > > > 
> > > >   2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
> > > >      property with value 1.
> > > > 
> > > > This did not consider_S0W, which tells us the deepest D-state from
> > > > which a device can wake itself (ACPI v6.4, sec 7.3.20).
> > > > 
> > > > On some platforms, e.g., AMD Yellow Carp, firmware may supply
> > > > "HotPlugSupportInD3" even though the platform does not supply power
> > > > resources through _PRW and _S0W tells us the device cannot wake from
> > > 
> > > More importantly, it doesn't supply a wakeup GPE number through _PRW,
> > > so from the ACPI perspective the bridge has no way of generating
> > > wakeup signals.
> > 
> > Perfect, thanks.  That's the missing piece about _PRW.
> > 
> > > > D3hot.  With the previous code, these devices could be put in D3hot
> > > > and hotplugged devices would not be recognized without manually
> > > > rescanning.
> > > > 
> > > > If _S0W exists and says the Root Port cannot wake itself from D3hot,
> > > > return "false" to indicate that "dev" cannot handle hotplug events
> > > > while in D3.
> > > > 
> > > >   1) "dev" has a _PS0 or _PR0 method, or
> > > > 
> > > >   2a) The Root Port above "dev" has _PRW and
> > > > 
> > > >   2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
> > > >       D3cold and
> > > > 
> > > >   2c) The Root Port above "dev" has a _DSD with a
> > > >       "HotPlugSupportInD3" property with value 1.
> > > > 
> > > > Windows 10 and Windows 11 both will prevent the bridge from going in D3
> > > > when the firmware is configured this way and this change aligns the
> > > > handling of the situation to be the same.
> > > > 
> > > > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cc8ff8ac0568049a166bd08da13db41f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637844129686586061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=bjd5NnFaGslXcSVvShZMRHzuedEx8VgGnEnCGlWZ%2F2Q%3D&amp;reserved=0
> > > > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cc8ff8ac0568049a166bd08da13db41f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637844129686586061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=r11UKOwL6SvGv4VCxaDyH0k15dsJib%2BJvRCS2MRobUQ%3D&amp;reserved=0
> > > > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > --
> > > > v5->v6:
> > > >   * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
> > > >   * Adjust commit message wording
> > > >   * Drop rewording comment patch, just apply it while moving text to avoid
> > > >     ping-ponging the same lines in the commits.
> > > > v4-v5:
> > > >   * Don't fail if _S0W is missing
> > > > ---
> > > >   drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
> > > >   1 file changed, 19 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > index 1f15ab7eabf8..5ab797e2709d 100644
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > >   {
> > > >          const union acpi_object *obj;
> > > >          struct acpi_device *adev;
> > > > +       unsigned long long state;
> > > >          struct pci_dev *rpdev;
> > > > +       acpi_status status;
> > > > 
> > > >          if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> > > >                  return false;
> > > > @@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > >          if (acpi_pci_power_manageable(dev))
> > > >                  return true;
> > > > 
> > > > -       /*
> > > > -        * The ACPI firmware will provide the device-specific properties through
> > > > -        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
> > > > -        * for the root port and if it is set we know the hierarchy behind it
> > > > -        * supports D3 just fine.
> > > > -        */
> > > >          rpdev = pcie_find_root_port(dev);
> > > >          if (!rpdev)
> > > >                  return false;
> > > > @@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > >          if (!adev)
> > > >                  return false;
> > > > 
> > > > +       /*
> > > > +        * If the bridge can't wake from D3hot, it can't signal hotplug
> > > > +        * events in D3hot.
> > > 
> > > I would say "If the bridge cannot signal wakeup signals at all, it
> > > cannot signal hotplug events from low-power states including D3hot and
> > > D3cold."
> > > 
> > > With the two above remarks addressed, please feel free to add
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Great, thanks!
> 
> Bjorn,
> 
> Please let me know if you want me to send up a v7 with the minor remark
> updates, or if you can just fix those up while committing.

Fixing those up right now.  I'll post the updates shortly so you can
make sure I didn't make it worse.

Bjorn
