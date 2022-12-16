Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6C64F09D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiLPRs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 12:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiLPRsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 12:48:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356E6F0EB;
        Fri, 16 Dec 2022 09:48:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6D86216D;
        Fri, 16 Dec 2022 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7104AC4339B;
        Fri, 16 Dec 2022 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671212901;
        bh=hMB2FhazVydSSDyeFONqUk55IYJavlKCCinGabQMRQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cRa9aWsUrF054V9v3/oSv0TFtG6cYFf0223HRml6wgQI2/t9eHzOrKIqDo7i2tp90
         3Hzbzw/imlxTzJWhz1iB/pKxJ0uSc4KZFzW7V0GuzhPOfKubN1TAvrTXl5ms6MLDxP
         RvoLtvcp0lECcIb7/8gT6QYg1jAP5NmvGZdA4b6iDrH6mj8rN+XmIpl4kBL/7Hb9wk
         VhKN4ZLoPpYkJPLZOsjQNK0FYTMj3mkjMADoMXO8EA1qWzpyNu5Dse1/9COfhTJgbl
         wh2eyFAuY0gHEhhxTDMWzVq3itj4aqAHYaBXxKgKKQ5QOXILQaSPKljZwdslH4iKVA
         s0SaZtqPhOEIQ==
Date:   Fri, 16 Dec 2022 11:48:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Lee, Ron" <ron.lee@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lmajczak@google.com" <lmajczak@google.com>,
        "Jain, Rajat" <rajatja@google.com>,
        Ron Lee <ron.lee.intel@gmail.com>
Subject: Re: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Message-ID: <20221216174820.GA209655@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB34577E415B692A2B1CB000ACFEE69@BL0PR11MB3457.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 16, 2022 at 04:29:39PM +0000, Lee, Ron wrote:
> > On Thu, Dec 15, 2022 at 05:13:57PM +0800, Ron Lee wrote:
> > > On Google Coral and Reef family chromebooks, the PCIe bridge lost its
> > > L1 PM Substates capability after resumed from D3cold, and identify
> > > that the pointer to the this capability and capapability header are
> > > missing from the capability list.

> > This should say what problem we're solving.  I assume some devices
> > used L1 PM Substates before suspend, but after resume they do not,
> > so the user-visible effect is that battery life is worse after
> > resume.
>
> This bug has existed since these series of Chromebooks was shipping,
> it seems no harm for system execution, and we didn't identified
> battery life drop after resume. However we still expect this issue
> could be solved and follow spec criteria as per PCIe spec rev6.0,
> section 5.5.4 L1 PM Substates Configuration
> 
>     An L1 PM Substate enable bit must only be Set in the Upstream
>     and Downstream Ports on a Link when the corresponding supported
>     capability bit is Set by both the Upstream and Downstream Ports
>     on that Link, otherwise the behavior is undefined

Even if you haven't seen a battery life issue, I suspect you might be
able to measure a power consumption difference if you looked for it
and likely could see issues with manual ASPM enable/disable using
sysfs.  That might be a legitimate reason for this quirk, and if it
is, we should mention it here.

> The following merged commit can save/restore the
> L1SubCap/L1SubCtl1/L1SubCtl2 registers for this bridge, However this
> bridge not only lost its capability contents but also lost the link
> to this capability.
> 
>     PCI/ASPM: Save/restore L1SS Capability for suspend/resume
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/pcie/aspm.c?h=v6.1&id=4257f7e008ea394fcecc050f1569c3503b8bcc15

The current version of that code:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aspm.c?id=v6.1#n760
doesn't search for the L1SS capability; it uses dev->l1ss just like
your patch does.  So it should restore the capability even though the
linked list is broken.

> > > This patch fix up the header and the pointer to the L1SS
> > > capability after resuming from D3Cold.
> > 
> > The main problem here is that this patch covers up an issue
> > without saying what the root cause is.  Presumably this is a
> > firmware issue.  Has that been identified?  Has it been fixed for
> > future firmware releases?
>
> This issue could be and should be fixed by BIOS, however the
> manufacturers have no resource for firmware validation and it's
> risky for firmware update per their assessment.

This fix is risky, too, because it writes to random places in config
space and there's no guarantee that this is safe or even that the
capabilities are at those locations.

> > Is there a bug report for this issue?  Include the URL here.
> > 
> > Is there a bug report for the firmware?
> > 
> There is a Google's internal issue tracker for this bug, seems not
> available for public.

Maybe you can make a public report with any secret details removed?
A simple email would be enough.  I haven't seen the internal issue;
hopefully it has more details than are in this patch.

> Actually this bug had a discussion on this thread, and Lukasz
> Majczak identified this issue on Apollo Lake platform.
> https://patchwork.kernel.org/project/linux-pci/patch/20220705060014.10050-1-vidyas@nvidia.com/

That patch mentions Dell XPS 13, not a Chromebook, so your patch
wouldn't affect it.  Are you saying this issue is common across all
Apollo Lake platforms?  If so, maybe a fix should be more generic?

> > > +#ifdef CONFIG_PCIEASPM
> > > +static void chromeos_fixup_apl_bridge_l1ss_capability(struct pci_dev
> > > +*pdev) {
> > > +	if (!dmi_match(DMI_SYS_VENDOR, "Google") ||
> > > +		(!dmi_match(DMI_PRODUCT_FAMILY, "Google_Coral") &&
> > > +		 !dmi_match(DMI_PRODUCT_FAMILY, "Google_Reef")))
> > > +		return;
> > > +
> > > +	pci_info(pdev, "Fix up L1SS Capability\n");
> > > +	/* Fix up the L1SS Capability Header*/
> > > +	pci_write_config_dword(pdev, pdev->l1ss, (0x220 << 20) | (1 << 16) |
> > > +(PCI_EXT_CAP_ID_L1SS));
> > 
> > This looks like it adds a link to another capability at offset
> > 0x220.  What is that, and how do we know this is safe?
>
> The following is the dump of this bridge config before suspend, the
> L1SS capability is at offset 0x200 and it point to offset 0x220
> which is a null capability. This patch just add it to keep
> consistent during suspend/resume.
> ...

My point is that there is no PCI requirement for capabilities to be at
0x150 and 0x220.  The only defined way to find these capabilities is
to traverse the list starting at offset 0x100.

The L1SS capability at pdev->l1ss is reasonable since we found it by
traversing that list, but 0x150 and 0x220 are magic numbers with no
justification.  We have no reason to believe there are capabilities
there.

We might know this based on device-specific knowledge of the Root
Port.  If that's the case, please cite the Intel spec for device 5ad6
so we can tell this quirk can't be blindly applied to other Root
Ports.

> > > +	/* Fix up the pointer to L1SS Capability*/
> > > +	pci_write_config_dword(pdev, 0x150, pdev->l1ss << 20); }
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6,
> > > +chromeos_fixup_apl_bridge_l1ss_capability);
> > > +#endif
