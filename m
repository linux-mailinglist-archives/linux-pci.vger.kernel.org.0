Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839366B2CD9
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCISZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCISZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 13:25:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB30F6394
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 10:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63F861CB8
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 18:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215C5C4339B;
        Thu,  9 Mar 2023 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678386316;
        bh=z2uRZUd+MyMVOf7QsATaQkUcP0qAo1NHjpBJ7hGrFOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sqr0YuaMJVF+cmUpEygZ1rLxVm5Z56vRr8mn5z/LEgRPEl8oQ6IbFGsFqj60AUwZH
         ejtxoe2pn1ZjNBXMatXST+l9Kz98SoqSHX31wmeCIDq9JAGxhgVVTrb96ZbtUGQoFF
         n7D4CdcY9aKZM4J9Gfavtyu4GmKucCtReWXgq/FwJORJmkoeGf7YqiNl40Wv+RnM0F
         KyYRfjuevmEzEQxPJkRET1KSvM82LpdX6IdLuLmkvSm+JwrD9LaO5HaQRB7PnRpX0E
         R6xi+kXmpEiZwa44F7t45GZud9znYhnBZRH4Wr+7cRx568PB25KQyi68sn9pl5YrpM
         OEIt6QGzhtZBQ==
Date:   Thu, 9 Mar 2023 12:25:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230309182514.GA1152206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39644d3a-a57b-4843-b2a1-701992312e1f@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 01:04:17PM +0530, Basavaraj Natikar wrote:
> On 3/9/2023 4:34 AM, Limonciello, Mario wrote:
> >> -----Original Message-----
> >> From: Bjorn Helgaas <helgaas@kernel.org>
> >> Sent: Wednesday, March 8, 2023 16:44
> >> To: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
> >> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; Limonciello, Mario
> >> <Mario.Limonciello@amd.com>; thomas@glanzmann.de
> >> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
> >>
> >> Let's mention the vendor and device name in the subject to make the
> >> log more useful.
> 
> Sure will change subject as below.
> Add quirk on AMD 0x15b8 device to clear MSI-X enable bit

"0x15b8" is not really useful in a subject line.  Use a name
meaningful to users, like something "lspci" reports (I don't see
"1002:15b8" in https://pci-ids.ucw.cz/read/PC/1002; it would be nice
to add it) or at least something like "USB controller".   You can look
at the history of drivers/pci/quirks.c to see examples.

> >> On Mon, Mar 06, 2023 at 12:53:40PM +0530, Basavaraj Natikar wrote:
> >>> One of the AMD USB controllers fails to maintain internal functional
> >>> context when transitioning from D3 to D0, desynchronizing MSI-X bits.
> >>> As a result, add a quirk to this controller to clear the MSI-X bits
> >>> on suspend.
> > ...
> > FYI - it's not a hardware defect, it's a BIOS defect.

Commit log ("controller fails to maintain") suggested hardware defect
to me; maybe could be clarified.  If it's a defect in the way BIOS
initialized something, maybe the workaround could be a one-time thing
instead of an every-resume quirk?

> >> The quick clears the Function Mask bit, so the MSI-X vectors may be
> >> *unmasked* depending on the state of each vectors Mask bit.  I assume
> >> the potential unmasking is safe because you also clear the MSI-X
> >> Enable bit, so the function can't use MSI-X at all.
> 
> Sure, will remove Function Mask bit only clear MSI-X enable bit is enough,
> actually MSI-X enable bit doesn't change the internal hardware and there
> will be no interrupts after resume hence below command timeout and eventually
> error observed more logs below:
>
> [  418.572737] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
> *[ 423.724511] xhci_hcd 0000:03:00.0: Command timeout, USBSTS: 0x00000000****[ 423.724517] xhci_hcd 0000:03:00.0: Command timeout*
> [  423.724519] xhci_hcd 0000:03:00.0: Abort command ring
> [  425.740742] xhci_hcd 0000:03:00.0: No stop event for abort, ring start fail?
> *[ 425.740771] xhci_hcd 0000:03:00.0: Error while assigning device slot ID****[ 425.740777] xhci_hcd 0000:03:00.0: Max number of devices this xHCI
> host supports is 64*.
> [  425.740782] usb usb5-port1: couldn't allocate usb_device
> [  425.740794] xhci_hcd 0000:03:00.0: disable port 5-1, portsc: 0x6e1
> [  425.740818] hub 5-0:1.0: hub_suspend
> [  425.740826] usb usb5: bus auto-suspend, wakeup 1
> [  425.740835] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
> [  425.740842] xhci_hcd 0000:03:00.0: xhci_suspend: stopping usb5 port polling.
> [  425.756878] xhci_hcd 0000:03:00.0: // Setting command ring address to 0xffffe001
> [  425.776898] xhci_hcd 0000:03:00.0: WARN: xHC save state timeout
> [  425.776910] xhci_hcd 0000:03:00.0: PM: suspend_common(): xhci_pci_suspend+0x0/0x170 [xhci_pci] returns -110
> [  425.776917] xhci_hcd 0000:03:00.0: hcd_pci_runtime_suspend: -110
> [  425.776918] xhci_hcd 0000:03:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)
> 
> will change function name accordingly quirk_clear_msix_en
> and with only ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> 
> >> All state is lost in D3cold, so I guess this problem must occur during
> >> a D3hot to D0 transition, right?  I assume this device sets
> >> No_Soft_Reset, so the function is supposed to return to D0active with
> >> all internal state intact.  But this device returns to D0active with
> >> the MSI-X internal state corrupted?
> >>
> >> I assume this relies on pci_restore_state() to restore the MSI-X
> >> state.  Seems like that might be enough to restore the internal state
> >> even without this quirk, but I guess it must not be.
> >
> > The important part is the register value changing to make
> > the internal hardware move.  Because it restores identically it doesn't change
> > the internal hardware.
> 
> Yes correct, even though pci_restore_state restores all pci registers states
> including MSI-X bits __pci_restore_msix_state after resume but internal AMD
> controller's MSI_X enable bit is out of sync and AMD controller fails to maintain 
> internal MSI-X enable bits.

So the register value *change* is important, and you force a different
value by writing something different at suspend-time so the value at
restore-time will be different.  That's a little obscure since those
points are far separated.

Also it changes the behavior (masking MSI-X at suspend-time), which
complicates the analysis since we have to verify that we don't need
MSI-X after the quirk runs.  And the current quirk relies on the fact
that PCI_MSIX_FLAGS_ENABLE is set, which again complicates the
analysis (I guess if MSI-X is *not* enabled, you might not need the
quirk at all?)

Is there any way you could do the quirk at resume-time, e.g., if MSI-X
is supposed to be enabled, first disable it and immediately re-enable
it?

> >>> Note: This quirk works in all scenarios, regardless of whether the
> >>> integrated GPU is disabled in the BIOS.
> >>
> >> I don't know how the integrated GPU is related to this USB controller,
> >> but I assume this fact is important somehow?
> >
> > This bug is due to a BIOS bug with the initialization.  We also posted in
> > parallel a different workaround that fixes the initialization to match what
> > the BIOS should have set via the GPU driver.  
> >
> > It should be going in for 6.3-rc2.
> > https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139

That nbio_v7.2.c patch and this patch don't look anything alike.  It
looks like the nbio_v7.2.c patch might run once?  Could *this* be done
once at enumeration-time, too?

Bjorn
