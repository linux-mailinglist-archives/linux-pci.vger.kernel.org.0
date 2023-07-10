Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57274DF5B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGJUdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGJUdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 16:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4341198;
        Mon, 10 Jul 2023 13:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666C2611DC;
        Mon, 10 Jul 2023 20:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE8C433C8;
        Mon, 10 Jul 2023 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689021201;
        bh=gGXXrojuoIWNAw/sxFKlgIo61HCLR9eouOaOtd2kFFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WxQ3lhE4kDYn/Xwd0L0OWRfY5888FCT8p5MyQuEjhey5NBcmhBXk0BbpwlkXWvJq0
         8L+0DqBfTkOZagZByJmL/tWmzd3Ub0dzdocQZ/HWHaX6TclyE1JOdFnDMQp106iW09
         vVIqQ0AmKWBst5DuP7Szk+3om36A+qxe3ew2ol8myPwawn0aF01U2r9ytdzMs2YrsT
         B5zXq3O0QwKG1fMVJ4NIVXdFwnytxh68kBaA7IZ4JQe06lqTUZJ256kwKa1tMENn2D
         Z++ivouPlmekYMu9UMF7Puw5kX6N8gLOG11566uoLezcZbFedh2QJGiVP3fsDOboIL
         VYRUCOHonuV5Q==
Date:   Mon, 10 Jul 2023 15:33:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 1/1] PCI: Avoid putting some root ports into D3 on
 some Ryzen chips
Message-ID: <20230710203319.GA220162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f052692-9406-3812-0c53-7edf8360115d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, author of 9d26d3a8f1b0]

On Mon, Jul 10, 2023 at 02:44:23PM -0500, Limonciello, Mario wrote:
> On 7/10/2023 14:32, Bjorn Helgaas wrote:
> > On Sat, Jul 08, 2023 at 04:44:57PM -0500, Mario Limonciello wrote:
> > > commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > sets the policy that all PCIe ports are allowed to use D3.  When
> > > the system is suspended if the port is not power manageable by the
> > > platform and won't be used for wakeup via a PME this sets up the
> > > policy for these ports to go into D3hot.
> > > 
> > > This policy generally makes sense from an OSPM perspective but it leads
> > > to problems with wakeup from suspend on laptops with AMD chips:
> > > 
> > > - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
> > >    interrupt.
> > > - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> > > 
> > > Add a quirk for the PCI device ID used by the problematic root port on
> > > both chips to ensure that these root ports are not put into D3hot at
> > > suspend.
> > 
> > What is problematic about these root ports?  Is this a hardware
> > erratum?
> 
> I mentioned some of this in earlier versions; but the problem is deeper
> in the platform firmware and only happens when the root ports are in D3hot
> across an s2idle cycle.
> 
> When looked at independently they can be moved in and out of D3hot no
> problem.
> 
> From the perspective of hardware designers they say this is a software bug
> that Linux puts PCI RP into D3hot over Modern Standby when they don't
> specify for this to be done.  I don't expect any erratum for it.

It sounds like there's someplace the hardware designers specify how
this should work?  Where is that?  "Modern Standby" doesn't mean
anything to me, but maybe there's some spec that covers it?

> > Some corner of the ACPI spec that allows undefined behavior?
> 
> These root ports are not reported as power manageable by ACPI.
> 
> As I mentioned in the cover letter how the OSPM handles this case is outside
> of any spec AFAICT.

If it's truly outside the spec, then I don't think Linux should use D3
until we have some standardized way to tell whether it's safe.

> > Does AMD have any guidance about generic ways to use D3, or does AMD
> > expect to add quirks piecemeal as problems are discovered?  How does
> > Windows handle all this?
> 
> Windows doesn't put root ports into D3hot over suspend unless they are power
> managed by ACPI (as described in section 7.3 of the ACPI spec).
> 
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html
> 
> So on Windows these ports are all in D0 and none of the issues happen.

Maybe this is the clue we need.  My eyes glaze over when reading that
section, but if we can come up with a commit log that starts with a
sentence from that section and connects the dots all the way to the
platform_pci_power_manageable() implementation, that might be a good
argument that 9d26d3a8f1b0 was a little too aggressive.

> Linux if PCI devices aren't power managed by ACPI will either follow deepest
> state it can wake from PME or fall back to D3hot.
> 
> > Adding quirks as we discover random devices that don't behave
> > correctly for reasons unknown is not very sustainable.
> 
> I don't disagree but in v5 I tried to align this to the Windows behavior and
> it wasn't accepted.

I like the fact that v5 ([1] for anybody following along at home) is
very generic:

  @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
  ...
  +       if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
  +           !platform_pci_power_manageable(bridge))
  +               return false;

My objection was that we didn't have a clear connection to any specs,
so even though the code is perfectly generic, the commit log mentioned
specific cases (USB keyboard/mouse on xHCI device connected to USB-C
on AMD USB4 router).

But maybe we *could* make a convincing generic commit log.  I guess
we'd also have to explain the PCI_EXP_TYPE_ROOT_PORT part of the
patch.

Bjorn

[1] https://lore.kernel.org/r/20230530163947.230418-2-mario.limonciello@amd.com

> > > Cc: stable@vger.kernel.org # 6.1+
> > > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/pci/quirks.c | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 321156ca273d5..e0346073e5855 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3867,6 +3867,22 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
> > >   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
> > >   			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
> > >   			       quirk_apple_poweroff_thunderbolt);
> > > +
> > > +/*
> > > + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
> > > + * may cause problems when the system attempts wake up from s2idle.
> > > + *
> > > + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
> > > + * interrupt.
> > > + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> > > + */
> > > +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> > > +{
> > > +	if (!acpi_pci_power_manageable(pdev))
> > > +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
> > >   #endif
> > >   /*
> > > -- 
> > > 2.34.1
> > > 
> 
