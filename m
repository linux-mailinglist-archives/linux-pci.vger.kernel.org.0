Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E01A3992
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDISIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 14:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDISIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 14:08:42 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959E320757;
        Thu,  9 Apr 2020 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586455722;
        bh=MsGX1SfhMW4ovXuqbWilSF5jIbE9R1UyfD7bGlZDWHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FotAMXTw7YaKugwZ+xSTW2c1GKrWkQssxCvA5vOnZu+1gfRBQRXwEmgsuOymO0kFQ
         DSGllnGmsEVdIi3ALihd8zHj719kAIOY27T+32lFE8QDDa7WKndQqWMNyYe66FnguA
         us4VrgA6YnlTAJw1LgWNF8310GbOVj2D9HIwX7t8=
Date:   Thu, 9 Apr 2020 13:08:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200409180840.GA23054@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409163010.GA8879@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Todd]

On Thu, Apr 09, 2020 at 11:30:10AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 09, 2020 at 04:25:40PM +0100, Luís Mendes wrote:
> > Hi Bjorn,
> > 
> > I've good news. I've found the culprit and it is a pretty simple
> > issue, however the good solution is not obvious to me.
> > Can you help in finding the best way to patch this issue?
> > 
> > So first detailing the problem in file setup_bus.c there is this *if
> > condition* to ignore resources from classless devices and so
> > it is that this Google/Coral Edge TPU is a classless device with class 0xff:
> > 
> > static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
> > {
> >     u16 class = dev->class >> 8;
> > 
> >        pci_info(dev, "%s\n", __func__);
> >     /* Don't touch classless devices or host bridges or IOAPICs */
> >     if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
> >         return;
> >    ....
> > 
> > So the one possible trivial, non generic, attempt that works is to do:
> > static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
> > {
> >     u16 class = dev->class >> 8;
> > 
> >        pci_info(dev, "%s\n", __func__);
> >     /* Don't touch classless devices or host bridges or IOAPICs */
> >     if ((class == PCI_CLASS_NOT_DEFINED &&  !(dev->vendor == 0x1ac1 &&
> > dev->device==0x089a)) || class == PCI_CLASS_BRIDGE_HOST)
> >         return;
> >    ....
> > 
> > What is your suggestion to make the solution generic? Create a
> > whitelist? Remove this verification? I have no idea... nothing sounds
> > good to me...
> 
> Good detective work, thanks for chasing this down!
> 
> I should have seen that check when adding the debug.  Guess I thought
> "sort", hmmm, that just re-orders things without actually changing the
> content.  But pdev_sort_resources() in fact *adds* resources to a
> list, and if resources aren't on the list, we apparently don't assign
> space for them.
> 
> In any event, I would first check to see if there's an Edge TPU
> firmware update that might set the class code.
> 
> If not, we should probably add a quirk to override the class code,
> similar to quirk_eisa_bridge(), fixup_rev1_53c810(),
> fixup_ti816x_class(), quirk_tw686x_class().

In fact, apex_pci_fixup_class() already exists!  But it's in
apex_driver.c.  Do you happen to have CONFIG_STAGING_APEX_DRIVER=m
(built as a module)?  If so, that quirk won't be run until the module
is loaded, and that happens long after resource assignment.

Building with CONFIG_STAGING_APEX_DRIVER=y (not =m) should be a
workaround.  But I think the real fix would be moving
apex_pci_fixup_class() from apex_driver.c to drivers/pci/quirks.c,
like the following.  Would you mind testing it?


commit 59f3165318b3 ("PCI: Move Apex Edge TPU class quirk to fix BAR assignment")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Apr 9 12:43:45 2020 -0500

    PCI: Move Apex Edge TPU class quirk to fix BAR assignment
    
    Some Google Apex Edge TPU devices have a class code of 0
    (PCI_CLASS_NOT_DEFINED).  This prevents the PCI core from assigning
    resources for the Apex BARs because __dev_sort_resources() ignores
    classless devices, host bridges, and IOAPICs.
    
    On x86, firmware typically assigns those resources, so this was not a
    problem.  But on some architectures, firmware does *not* assign BARs, and
    since the PCI core didn't do it either, the Apex device didn't work
    correctly:
    
      apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x00000000-0x00003fff 64bit pref] not claimed
      apex 0000:01:00.0: error enabling PCI device
    
    f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI class") added a
    quirk to fix the class code, but it was in the apex driver, and if the
    driver was built as a module, it was too late to help.
    
    Move the quirk to the PCI core, where it will always run early enough that
    the PCI core will assign resources if necessary.
    
    Link: https://lore.kernel.org/r/CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=Ha8TD8XroVqiZjgg@mail.gmail.com
    Fixes: f390d08d8b87 ("staging: gasket: apex: fixup undefined PCI class")
    Reported-by: Luís Mendes <luis.p.mendes@gmail.com>
    Debugged-by: Luís Mendes <luis.p.mendes@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 28c9a2409c50..ca9ed5774eb1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5567,3 +5567,10 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
 	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
+
+static void apex_pci_fixup_class(struct pci_dev *pdev)
+{
+	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
+			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 46199c8ca441..f12f81c8dd2f 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -570,13 +570,6 @@ static const struct pci_device_id apex_pci_ids[] = {
 	{ PCI_DEVICE(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID) }, { 0 }
 };
 
-static void apex_pci_fixup_class(struct pci_dev *pdev)
-{
-	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
-}
-DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
-			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
-
 static int apex_pci_probe(struct pci_dev *pci_dev,
 			  const struct pci_device_id *id)
 {
