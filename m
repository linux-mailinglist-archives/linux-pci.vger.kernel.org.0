Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D005F1FFE88
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgFRXUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 19:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFRXUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 19:20:14 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58C7206E2;
        Thu, 18 Jun 2020 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592522413;
        bh=NS0PQoZ4D7dKborXS9BkdpVpGPMGRYqY0rGf2tcmk/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LmrzciU9LATqeSx7hJ1B2LhdeaSx9Pb5+dlU+KoEUueAeM4uyv2Khhm7K09cmW/Cc
         V/ehu2uzvVPRvYKR0/cq+4K39GOFMRS83CkDcgPeWogHA0gfZWL/BDVwRfTLhjztpV
         UCzlqpAx15dHNevwWUNhARkXBpSR+sAAOVdC9DgM=
Date:   Thu, 18 Jun 2020 18:20:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, vkoul@kernel.org,
        sanm@codeaurora.org, mgautam@codeaurora.org, agross@kernel.org,
        bhelgaas@google.com, robh@kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable power management for uPD720201 USB3
 controller
Message-ID: <20200618232011.GA2128408@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616211711.GA1981914@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 04:17:11PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 15, 2020 at 09:24:13PM +0300, Georgi Djakov wrote:
> > The uPD720201 USB3 host controller (connected to PCIe) on the Dragonboard
> > 845c is often failing during suspend and resume. The following messages
> > are seen over the console:
> > 
> >   PM: suspend entry (s2idle)
> >   Filesystems sync: 0.000 seconds
> >   Freezing user space processes ... (elapsed 0.001 seconds) done.
> >   OOM killer disabled.
> >   Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> >   printk: Suspending console(s) (use no_console_suspend to debug)
> >   dwc3-qcom a8f8800.usb: HS-PHY not in L2
> >   dwc3-qcom a6f8800.usb: HS-PHY not in L2
> >   xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
> >   space inaccessible)
> >   xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
> >   space inaccessible)
> >   xhci_hcd 0000:01:00.0: Controller not ready at resume -19
> >   xhci_hcd 0000:01:00.0: PCI post-resume error -19!
> >   xhci_hcd 0000:01:00.0: HC died; cleaning up
> > 
> > Then the USB devices are not functional anymore. Let's disable the PM of
> > the controller for now, as this will at least keep USB devices working
> > even after suspend and resume.

Georgi, can you collect the complete dmesg log and "sudo lspci
-vvxxxx" output somewhere?  A new report at bugzilla.kernel.org would
be a good spot.

Maybe we're missing a delay here.  The "config space inaccessible"
message means we read 0xffff from PCI_PM_CTRL, which probably means
the device is still in D3cold.  If it were in any other power state,
PCI_PM_CTRL should be readable, and 0xffff is not a valid value.

Could you also insert a dump_stack() right after we print that "config
space inaccessible" message?  I don't know enough about power
management to understand why we see that message twice.

> This seems like we're just covering up a deeper problem here.  I think
> it would be better to fix the underlying problem.
> 
> The quirk you're adding is specific to the Renesas 0x0014 device.  Is
> there some reason to think the problem is specific to that device, or
> might other devices have the same problem?
> 
> Maybe we're missing something in pcie-qcom.c?  Is there any
> suspend/resume support required in that driver?  It doesn't look like
> it has anything except that it calls pm_runtime_enable().
> 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 138e1a2d21cc..c1f502682a19 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1439,6 +1439,13 @@ static void qcom_fixup_class(struct pci_dev *dev)
> >  {
> >  	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> >  }
> > +
> > +static void qcom_fixup_nopm(struct pci_dev *dev)
> > +{
> > +	dev->pm_cap = 0;
> > +	dev_info(&dev->dev, "Disabling PCI power management\n");
> > +}
> > +
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
> > @@ -1446,6 +1453,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, qcom_fixup_nopm);
> 
> The convention is that DECLARE_PCI_FIXUP_*() comes immediately after
> the quirk function itself, so the whole patch would be a single diff
> hunk.  See drivers/pci/quirks.c for many examples.
> 
> >  static struct platform_driver qcom_pcie_driver = {
> >  	.probe = qcom_pcie_probe,
