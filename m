Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DD78DB39
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjH3Sir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbjH3QzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 12:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4C19A
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 09:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4406361E1D
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 16:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BB1C433C7;
        Wed, 30 Aug 2023 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693414506;
        bh=+bolCTDxpIQPgjGfzHrY0iX6tb7Uc/IlfmucbFxtZkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M7ZLnLLdP3f2YTQjE995t8557MFSw320uhZ6ZuW0buOO3+sZJ0cVczVqsa3gjNZix
         96x7EK4szcpHxAA414F1md43c10OTVDp6sbjrOF+8St1dDUnfbwh2QkEQ1IWvxicvV
         WkOQKMmgW59RQB1RMNwfDH4DTHGogqDNr0Y0O9LfxrriUhjtcVSuUihssL2rTu9FcN
         cfTeEt7xbSZcUdyQ2aCG618xOWxn1Q1zQT4SZfsL1iFyU3lXGCi2RteLE/gEfUmg66
         HUNi6jGoROqiICFFs7V9BFb0AQxKclIsaMn8lIJPpDCLlNhKRTWMrvgYiftxsubMzc
         fZvzA/UL+B/7A==
Date:   Wed, 30 Aug 2023 11:55:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <20230830165503.GA812174@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7046d5-2e2c-4a6b-9e3d-507717528567@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng, Lorenzo, Rafael]

On Tue, Aug 29, 2023 at 02:35:36PM -0700, Patel, Nirmal wrote:
> On 8/29/2023 11:00 AM, Bjorn Helgaas wrote:
> > On Tue, Aug 29, 2023 at 01:10:22AM -0400, Nirmal Patel wrote:
> >> Currently during Host boot up, VMD UEFI driver loads and configures
> >> all the VMD endpoints devices and devices behind VMD. Then during
> >> VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
> >> AER, DPC, PM and enables these features based on BIOS settings.
> >>
> >> During the Guest boot up, ACPI settings along with VMD UEFI driver are
> >> not present in Guest BIOS which results in assigning default values to
> >> Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
> >> rootports in the Guest OS.
> >>
> >> VMD driver in Guest should be able to see the same settings as seen
> >> by Host VMD driver. Because of the missing implementation of VMD UEFI
> >> driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
> >> Guest OS. Hot inserted drives don't show up and hot removed drives
> >> do not disappear even if VMD supports Hotplug in Guest. This
> >> behavior is observed in various combinations of guest OSes i.e. RHEL,
> >> SLES and hypervisors i.e. KVM and ESXI.
> >>
> >> This change will make the VMD Host and Guest Driver to keep the settings
> >> implemented by the UEFI VMD DXE driver and thus honoring the user
> >> selections for hotplug in the BIOS.
> > These settings are negotiated between the OS and the BIOS.  The guest
> > runs a different BIOS than the host, so why should the guest setting
> > be related to the host setting?
> >
> > I'm not a virtualization whiz, and I don't understand all of what's
> > going on here, so please correct me when I go wrong:
> >
> > IIUC you need to change the guest behavior.  The guest currently sees
> > vmd_bridge->native_pcie_hotplug as FALSE, and you need it to be TRUE?
> 
> Correct.
> 
> > Currently this is copied from the guest's
> > root_bridge->native_pcie_hotplug, so that must also be FALSE.
> >
> > I guess the guest sees a fabricated host bridge, which would start
> > with native_pcie_hotplug as TRUE (from pci_init_host_bridge()), and
> > then it must be set to FALSE because the guest _OSC didn't grant
> > ownership to the OS?  (The guest dmesg should show this, right?)
> 
> This is my understanding too. I don't know much in detail about Guest
> expectation.
> 
> > In the guest, vmd_enable_domain() allocates a host bridge via
> > pci_create_root_bus(), and that would again start with
> > native_pcie_hotplug as TRUE.  It's not an ACPI host bridge, so I don't
> > think we do _OSC negotiation for it.  After this patch removes the
> > copy from the fabricated host bridge, it would be left as TRUE.
> 
> VMD was not dependent on _OSC settings and is not ACPI Host bridge. It
> became _OSC dependent after the patch 04b12ef163d1.
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e
> 
> This patch was added as a quick fix for AER flooding but it could
> have been avoided by using rate limit for AER.
> 
> I don't know all the history of VMD driver but does it have to be
> dependent on root_bridge flags from _OSC? Is reverting 04b12ef163d1
> a better idea than not allowing just hotplug flags to be copied from
> root_bridge?

It seems like the question is who owns AER, hotplug, etc for devices
below VMD.  AER rate limiting sounds itself like a quick fix without
addressing the underlying problem.

> > If this is on track, it seems like if we want the guest to own PCIe
> > hotplug, the guest BIOS _OSC for the fabricated host bridge should
> > grant ownership of it.
> 
> I will try to check this option.

On second thought, this doesn't seem right to me.  An _OSC method
clearly applies to the hierarchy under that device, e.g., if we have a
PNP0A03 host bridge with _SEG 0000 and _CRS that includes [bus 00-ff],
its _OSC clearly applies to any devices in domain 0000, which in this
case would include the VMD bridge.

But I don't think it should apply to the devices *below* the VMD
bridge.  Those are in a different domain, and if the platform wants to
manage AER, hotplug, etc., for those devices, it would have to know
some alternate config access method in order to read the AER and
hotplug registers.  I think that config access depends on the setup
done by the VMD driver, so the platform doesn't know that.

By this argument, I would think the guest _OSC would apply to the VMD
device itself, but not to the children of the VMD, and the guest could
retain the default native control of all these services inside the VMD
domain.

But prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
features"), the guest *did* retain native control, so we would have to 
resolve the issue solved by 04b12ef163d1 in some other way.

Bjorn

> >> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> >> ---
> >> v3->v4: Rewrite the commit log.
> >> v2->v3: Update the commit log.
> >> v1->v2: Update the commit log.
> >> ---
> >>  drivers/pci/controller/vmd.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> >> index 769eedeb8802..52c2461b4761 100644
> >> --- a/drivers/pci/controller/vmd.c
> >> +++ b/drivers/pci/controller/vmd.c
> >> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> >>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> >>  				       struct pci_host_bridge *vmd_bridge)
> >>  {
> >> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> >> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> >>  	vmd_bridge->native_aer = root_bridge->native_aer;
> >>  	vmd_bridge->native_pme = root_bridge->native_pme;
> >>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
> >> -- 
> >> 2.31.1
> >>
> 
