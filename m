Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758A5E565E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 00:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIUWxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUWxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 18:53:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368DA8963;
        Wed, 21 Sep 2022 15:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6321B8233D;
        Wed, 21 Sep 2022 22:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8D9C433D6;
        Wed, 21 Sep 2022 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663800824;
        bh=FdIa27SWPDMGLCdX1VXeZ1En6voNOFpY4QHXOclcR6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QL/xvaoGNBWdp6ygoBAgZOwKlo2l5BwIvVUIp1XVJXQg92PGKZt9yXEWympGsL6j7
         e90ZYVw1zuVuCwuReDo2xs0nNot7aKbrpEl4gwv2RexOFo9t+L7qwjgwX9TKCf0ypB
         4Iidf4llmDbsrdfcllLXAhXltndTDexm/oGDMTfxxzOIed1RUGEe/rbqk8NuIZkZ5K
         AY+Svj6+6tzMXJyPJsMR0yCibv7QqK1JqWIu0g4qwSn++oOQFo0ZGOHxoY/kk3Pt/r
         G62kZCwgk90vPKfitnweMegFvCEqANFaniegw0yyDE9N2a9gzGFQ/G27qr1KJqKiCW
         1LBNPaaoRFUKg==
Date:   Wed, 21 Sep 2022 17:53:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Sanitise firmware BAR assignments behind a
 PCI-PCI bridge
Message-ID: <20220921225342.GA1233029@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2209211921250.29493@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 21, 2022 at 08:49:16PM +0100, Maciej W. Rozycki wrote:
> Fix an issue with the Tyan Tomcat IV S1564D system, the BIOS of which 
> does not assign PCI buses beyond #2, where our resource reallocation 
> code preserves the reset default of an I/O BAR assignment outside its 
> upstream PCI-to-PCI bridge's I/O forwarding range:
> 
> pci 0000:06:08.0: BAR 4: no space for [io  size 0x0020]
> pci 0000:06:08.0: BAR 4: trying firmware assignment [io  0xfce0-0xfcff]
> pci 0000:06:08.0: BAR 4: assigned [io  0xfce0-0xfcff]
> [...]
> pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
> 
> Consequently when the device driver tries to access 06:08.0 according to 
> its designated address range it pokes at an unassigned I/O location, 
> likely subtractively decoded by the southbridge and forwarded to ISA, 
> causing the driver to become confused and bail out:
> 
> uhci_hcd 0000:06:08.0: host system error, PCI problems?
> uhci_hcd 0000:06:08.0: host controller process error, something bad happened!
> uhci_hcd 0000:06:08.0: host controller halted, very bad!
> uhci_hcd 0000:06:08.0: HCRESET not completed yet!
> uhci_hcd 0000:06:08.0: HC died; cleaning up
> 
> if good luck happens or if bad luck does, an infinite flood of messages:
> 
> uhci_hcd 0000:06:08.0: host system error, PCI problems?
> uhci_hcd 0000:06:08.0: host controller process error, something bad happened!
> 
> making the system virtually unusable.
> 
> This is because we try to retain any BAR assignment the firmware may 
> have made here, which may be necessary for devices on the root bus with 
> some systems, but cannot work for devices that are behind a PCI-to-PCI 
> bridge where the BAR assignment is outside the upstream bridge's 
> forwarding range.
> 
> Make sure then for a device behind a PCI-to-PCI bridge that any firmware 
> assignment is within the bridge's relevant forwarding window or do not 
> restore the assignment, fixing the system concerned as follows:
> 
> pci 0000:06:08.0: BAR 4: no space for [io  size 0x0020]
> pci 0000:06:08.0: BAR 4: failed to assign [io  0xfce0-0xfcff]
> [...]
> pci 0000:06:08.0: BAR 4: assigned [io  0x2000-0x201f]
> 
> and making device 06:08.0 work correctly.
> 
> Cf. <https://bugzilla.kernel.org/show_bug.cgi?id=16263>
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203012338460.46819@angie.orcam.me.uk
> Fixes: 58c84eda0756 ("PCI: fall back to original BIOS BAR addresses")
> Cc: stable@vger.kernel.org # v2.6.35+
> ---
> Hi Bjorn,
> 
>  I have trimmed the change description down as you requested and left the 
> change proper unmodified, as discussed in my earlier response.

I think this is great.  It shouldn't have taken me this long, so
thanks for persevering.

I think we can use pci_upstream_bridge() as below.  Let me know if
not.

Here it is as I applied to pci/resource for v6.1:

commit 0e3281839742 ("PCI: Sanitise firmware BAR assignments behind a PCI-PCI bridge")
Author: Maciej W. Rozycki <macro@orcam.me.uk>
Date:   Wed Sep 21 20:49:16 2022 +0100

    PCI: Sanitise firmware BAR assignments behind a PCI-PCI bridge
    
    When pci_assign_resource() is unable to assign resources to a BAR, it uses
    pci_revert_fw_address() to fall back to a firmware assignment (if any).
    Previously pci_revert_fw_address() assumed all addresses could reach the
    device, but this is not true if the device is below a bridge that only
    forwards addresses within its windows.
    
    This problem was observed on a Tyan Tomcat IV S1564D system where the BIOS
    did not assign valid addresses to several bridges and USB devices:
    
      pci 0000:00:11.0: PCI-to-PCIe bridge to [bus 01-ff]
      pci 0000:00:11.0:   bridge window [io  0xe000-0xefff]
      pci 0000:01:00.0: PCIe Upstream Port to [bus 02-ff]
      pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]   # unreachable
      pci 0000:02:02.0: PCIe Downstream Port to [bus 05-ff]
      pci 0000:02:02.0:   bridge window [io  0x0000-0x0fff]   # unreachable
      pci 0000:05:00.0: PCIe-to-PCI bridge to [bus 06-ff]
      pci 0000:05:00.0:   bridge window [io  0x0000-0x0fff]   # unreachable
      pci 0000:06:08.0: USB UHCI 1.1
      pci 0000:06:08.0: BAR 4: [io  0xfce0-0xfcff]            # unreachable
      pci 0000:06:08.1: USB UHCI 1.1
      pci 0000:06:08.1: BAR 4: [io  0xfce0-0xfcff]            # unreachable
      pci 0000:06:08.0: can't claim BAR 4 [io  0xfce0-0xfcff]: no compatible bridge window
      pci 0000:06:08.1: can't claim BAR 4 [io  0xfce0-0xfcff]: no compatible bridge window
    
    During the first pass of assigning unassigned resources, there was not
    enough I/O space available, so we couldn't assign the 06:08.0 BAR and
    reverted to the firmware assignment (still unreachable).  Reverting the
    06:08.1 assignment failed because it conflicted with 06:08.0:
    
      pci 0000:00:11.0:   bridge window [io  0xe000-0xefff]
      pci 0000:01:00.0: no space for bridge window [io  size 0x2000]
      pci 0000:02:02.0: no space for bridge window [io  size 0x1000]
      pci 0000:05:00.0: no space for bridge window [io  size 0x1000]
      pci 0000:06:08.0: BAR 4: no space for [io  size 0x0020]
      pci 0000:06:08.0: BAR 4: trying firmware assignment [io  0xfce0-0xfcff]
      pci 0000:06:08.1: BAR 4: no space for [io  size 0x0020]
      pci 0000:06:08.1: BAR 4: trying firmware assignment [io  0xfce0-0xfcff]
      pci 0000:06:08.1: BAR 4: [io  0xfce0-0xfcff] conflicts with 0000:06:08.0 [io  0xfce0-0xfcff]
    
    A subsequent pass assigned valid bridge windows and a valid 06:08.1 BAR,
    but left the 06:08.0 BAR alone, so the UHCI device was still unusable:
    
      pci 0000:00:11.0:   bridge window [io  0xe000-0xefff] released
      pci 0000:00:11.0:   bridge window [io  0x1000-0x2fff]   # reassigned
      pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]   # reassigned
      pci 0000:02:02.0:   bridge window [io  0x2000-0x2fff]   # reassigned
      pci 0000:05:00.0:   bridge window [io  0x2000-0x2fff]   # reassigned
      pci 0000:06:08.0: BAR 4: assigned [io  0xfce0-0xfcff]   # left alone
      pci 0000:06:08.1: BAR 4: assigned [io  0x2000-0x201f]
      ...
      uhci_hcd 0000:06:08.0: host system error, PCI problems?
      uhci_hcd 0000:06:08.0: host controller process error, something bad happened!
      uhci_hcd 0000:06:08.0: host controller halted, very bad!
      uhci_hcd 0000:06:08.0: HCRESET not completed yet!
      uhci_hcd 0000:06:08.0: HC died; cleaning up
    
    If the address assigned by firmware is not reachable because it's not
    within upstream bridge windows, fail instead of assigning the unusable
    address from firmware.
    
    [bhelgaas: commit log, use pci_upstream_bridge()]
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=16263
    Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203012338460.46819@angie.orcam.me.uk
    Link: https://lore.kernel.org/r/alpine.DEB.2.21.2209211921250.29493@angie.orcam.me.uk
    Fixes: 58c84eda0756 ("PCI: fall back to original BIOS BAR addresses")
    Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org # v2.6.35+

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 439ac5f5907a..b492e67c3d87 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -214,6 +214,17 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
+		/*
+		 * If dev is behind a bridge, accesses will only reach it
+		 * if res is inside the relevant bridge window.
+		 */
+		if (pci_upstream_bridge(dev))
+			return -ENXIO;
+
+		/*
+		 * On the root bus, assume the host bridge will forward
+		 * everything.
+		 */
 		if (res->flags & IORESOURCE_IO)
 			root = &ioport_resource;
 		else
