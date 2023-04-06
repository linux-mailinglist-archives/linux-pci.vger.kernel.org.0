Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1BA6D9F53
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDFRzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjDFRzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 13:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1C4C21
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 10:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A8962CA6
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 17:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8FAC433EF;
        Thu,  6 Apr 2023 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680803709;
        bh=8IfTDqy5nRyByCgvM3xWMAwhi9+ufdLoBzqI1b/Ccro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AVtarnXkco5cv//X/wASmjQeXEP4APE20b9TfbMoTj1ltA/5OX8C+zActZenZD+Ax
         W0MR6IijoqvTj3VWmJEplv4U/TKG84RIrstL5oDU0mlC681KVowfp0MWYwWNzgTtMs
         TSE0tDoLkQu1FcK7O3wCHe0nOwwwsEu/7ROvhbh55uA50cVm963LmioDRZeRvjlw32
         YuGfSpB3yzZ1MEMcfqSjETLvlZQDWTwx7Sw/5FtfgY7UH7LZBLQvvoOvjigamKsoPS
         VdRoJfaeD+0Tl4hOQRbk1nzW3aGHBV4o+AI/ztfq/4LU2IfSX7R8adLVDkwb51SP/K
         rVb0QTGRNnCJg==
Date:   Thu, 6 Apr 2023 12:55:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/PM: Decrease wait time for devices behind
 slow links
Message-ID: <20230406175507.GA3642351@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405093929.GR33314@black.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 12:39:29PM +0300, Mika Westerberg wrote:
> On Tue, Apr 04, 2023 at 04:36:55PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 04, 2023 at 08:27:14AM +0300, Mika Westerberg wrote:
> > > In order speed up reset and resume time of devices behind slow links,
> > > decrease the wait time to 1s. This should give enough time for them to
> > > respond.
> > 
> > Is there some spec language behind this?  In sec 6.6.1, I see that all
> > devices "must be able to receive a Configuration Request and return a
> > Successful Completion".
> > 
> > A preceding rule says devices with slow links must enter LTSSM Detect
> > within 20ms, but I don't see a direct connection from that to a
> > shorter wait time.
> 
> I think this (PCIe 5.0 p. 553):
> 
> "Following a Conventional Reset of a device, within 1.0 s the device
>  must be able to receive a Configuration Request and return a Successful
>  Completion if the Request is valid."

Right, I think this applies to all devices, regardless of link speed.

> > > While doing this, instead of looking at the speed we check if
> > > the port supports active link reporting.
> > 
> > Why check dev->link_active_reporting (i.e., PCI_EXP_LNKCAP_DLLLARC)
> > instead of the link speed described by the spec?
> 
> This is what Sathyanarayanan suggested in the previous version comments.
> 
> > DLLLARC is required for fast links, but it's not prohibited for slower
> > links and it's *required* for hotplug ports with slow links, so
> > dev->link_active_reporting is not completely determined by link speed.
> > 
> > IIUC, the current code basically has these cases:
> > 
> >   1) All devices on secondary bus have zero D3cold delay:
> >        return immediately; no delay at all
> > 
> >   2) Non-PCIe bridge:
> >        sleep 1000ms
> >        sleep  100ms (typical, depends on downstream devices)
> > 
> >   3) Speed <= 5 GT/s:
> >        sleep 100ms (typical)
> >        sleep up to 59.9s (typical) waiting for valid config read
> > 
> >   4) Speed > 5 GT/s (DLLLARC required):
> >        sleep 20ms
> >        sleep up to 1000ms waiting for DLLLA
> >        sleep 100ms (typical)
> >        sleep up to 59.9s (typical) waiting for valid config read
> > 
> > This patch changes cases 3) and 4) to:
> > 
> >   3) DLLLARC not supported:
> >        sleep 100ms (typical)
> >        sleep up to 1.0s (typical) waiting for valid config read
> > 
> >   4) DLLLARC supported:
> >        no change in wait times, ~60s total
> > 
> > And testing dev->link_active_reporting instead of speed means slow
> > hotplug ports (and possibly other slow ports that implement DLLLARC)
> > that previously were in case 3) will now be in case 4).
> 
> Yes, and we do that because if the device gets unplugged while we were
> in susppend we don't want to wait for the total 60s for it to become
> ready. That's what the DLLLARC can tell us (for ports that support it).
> For the ports that do not we want to give the device some time but not
> to wait for that 60s so we wait for the 1s as the "minimum" requirement
> from the spec before it can be determined "broken".

Ah, thanks, I think I see what you're doing here.

I think what makes this confusing is that there are several reasons
for waiting, and they're mixed together and done at various places:

  1) We want to avoid PCIe protocol errors, e.g., Completion Timeout,
  and the spec specifies how long to wait before sending a config
  request to a device below the port.

  2) We want to wait for slow devices to finish internal
  initialization even after it can respond to config requests, e.g.,
  with Request Retry Status completions.  The spec doesn't say how
  long to wait here, so we arbitrarily wait up to 60s.

  3) We want to detect missing devices (possibly removed while
  suspended) quickly, without waiting 60s.

I think this might be easier to follow if we restructured a bit, maybe
something like this:

  bool wait_for_link_active(struct pci_dev *bridge)
  {
    /* I don't see a max time to Link Active in the spec (?) */

    for (timeout = 1000; timeout > 0; timeout -= 10) {
      pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &status);
      if (status & PCI_EXP_LNKSTA_DLLLA)
        return true;
      msleep(10);
    }
    return false;
  }

  pci_bridge_wait_for_secondary_bus(...)
  {
    ...
    if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
      msleep(100);
    } else {
      link_active = wait_for_link_active(dev);
      if (link_active)
        msleep(100);
    }

    /* Everything above is delays mandated by PCIe r6.0 sec 6.6.1 */

    if (dev->link_active_reporting) {
      pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
      if (!(status & PCI_EXP_LNKSTA_DLLLA))
        /* all downstream devices are disconnected; maybe mark them? */
        return;
    }

    /* Wait for non-RRS completion */
    pci_dev_wait(child, PCIE_RESET_READY_POLL_MS);
  }
