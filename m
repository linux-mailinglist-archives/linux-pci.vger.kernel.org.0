Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4192EE2680
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405970AbfJWWkF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 18:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389112AbfJWWkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 18:40:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A77205F4;
        Wed, 23 Oct 2019 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571870404;
        bh=Mvc796uh7XdGeYEf88nGaaIFTmKKJuc15645rrTX+T8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CaKDo0ra+NoXHBObmBxTilzzkUjyfFexh4UhQkrkGTAhGpcwL+LsvDCOLnCiXalVj
         foE/IXg6310WUDiwe0NUxwjN2zZTr5YAzXv524UtMkLT42q4RZz7WYYzUKP3ReFsb5
         um/bTnDT9P4vNxFa01l5Q78bRo9k8lGj7JTFoK7w=
Date:   Wed, 23 Oct 2019 17:40:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191023224003.GA31692@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022093349.GC2819@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 12:33:49PM +0300, Mika Westerberg wrote:
> On Tue, Oct 22, 2019 at 10:40:00AM +0800, Daniel Drake wrote:
> > On Mon, Oct 21, 2019 at 7:33 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > Just to be sure, did you try the patch or just looked at it? Because
> > > what the patch does is that it does the delay when the downstream/root
> > > port is resumed, not the xHCI itself.
> > 
> > I tried it, it didn't fix the problem.
> 
> :(
> 
> It may very well be that this particular xHCI controller needs more than
> that 10ms from D3hot -> D0 transition. Again the PCIe spec says the 10ms
> is the minimum time system software needs to delay but it does not say
> what would be the maximum time the function absolutely must be properly
> in D0.

Hmm, PCIe r5.0, sec 2.3.1, says devices are permitted to return
Configuration Request Retry Status (CRS) after a "reset initiated in
response to a D3hot to D0uninitialized" transition.

I think that applies to this device because your lspci [1] shows:

	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

so No_Soft_Reset is clear, which means the D3hot to D0 transition goes
to D0uninitialized.

pci_raw_set_power_state() *does* delay, generally for 10ms:

  pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
  if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
    pci_dev_d3_sleep(dev);
  pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);

but there's no mention of CRS, so I think that config read is liable
to fail with CRS if the device isn't ready, and we won't notice.

I think we need something like the patch below.  We already do
basically the same thing in pci_pm_reset().

[1] https://gist.github.com/dsd/bd9370b35defdf43680b81ecb34381d5

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..e8702388830f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -883,9 +883,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	 * Mandatory power management transition delays; see PCI PM 1.1
 	 * 5.6.1 table 18
 	 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot) {
 		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2 || dev->current_state == PCI_D2)
+		pci_dev_wait(dev, "D3 transition", PCIE_RESET_READY_POLL_MS);
+	} else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
