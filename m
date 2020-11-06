Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64442A98A5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgKFPkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 10:40:15 -0500
Received: from mr014msr.fastwebnet.it ([85.18.95.110]:51252 "EHLO
        mr014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFPkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 10:40:15 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 10:40:14 EST
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfetuffvhgfguedpucfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkfffhrhfvufggtgfgihesthejtgdttddtjeenucfhrhhomhepoegrlhgsvghrthhordhvihhgnhgrnhhisehfrghsthifvggsnhgvthdrihhtqeenucggtffrrghtthgvrhhnpeelleevkeegteetkeelteelfffggfffieffhfelkeetteejtdeuhfdtjeekuddugeenucffohhmrghinheprhhnvghlrdhorhhgpdguihhouggvshdrtghomhenucfkphepuddtrdefuddrudejgedrvdefledpleefrdehtddrudekvddrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepphhrtddtiehmshhrpdhinhgvthepuddtrdefuddrudejgedrvdefledpmhgrihhlfhhrohhmpeeorghlsggvrhhtohdrvhhighhnrghnihesfhgrshhtfigvsghnvghtrdhitheqpdhrtghpthhtohepoegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmqedprhgtphhtthhopeeosghhvghlghgrrghssehgohhoghhlvgdrtghomheqpdhrtghpthhtohepoehjohhhrghnsehkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgt
        phhtthhopeeolhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from pr006msr (10.31.174.239) by mr014msr.fastwebnet.it (5.8.208)
        id 5F56293C0334ED7B; Fri, 6 Nov 2020 16:34:25 +0100
Message-ID: <33436598.119601604676865427.JavaMail.root@pr006msr>
Date:   Fri, 6 Nov 2020 16:34:25 +0100 (CET)
From:   <alberto.vignani@fastwebnet.it>
Reply-To:  <alberto.vignani@fastwebnet.it>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <johan@kernel.org>, <linux-usb@vger.kernel.org>
Subject: R: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Cc:     <andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: 93.50.182.19
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tested-by: alberto.vignani@fastwebnet.it

>----Messaggio originale----
>Da: andriy.shevchenko@linux.intel.com
>Data: 06/11/2020 11.05
>A: "Bjorn Helgaas"<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <johan@ke
rnel.org>, <linux-usb@vger.kernel.org>
>Cc: "Andy Shevchenko"<andriy.shevchenko@linux.intel.com>, <alberto.vignani@fast
webnet.it>
>Ogg: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
>
>Pericom PCIe-USB adapter advertises MSI, but documentation says
>"The MSI Function is not implemented on this device." in the chapters
>7.3.27, 7.3.29-7.3.31.
>
>Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
>Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
>Reported-by: alberto.vignani@fastwebnet.it
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---
>v2: dropped confusing word (David), added ifdeffery (Ben)
> drivers/pci/quirks.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index f70692ac79c5..e66e0cc8f99b 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -5567,17 +5567,26 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
> 
> /*
>- * Device [12d8:0x400e] and [12d8:0x400f]
>+ * Device 12d8:0x400e [OHCI] and 12d8:0x400f [EHCI]
>+ *
>  * These devices advertise PME# support in all power states but don't
>  * reliably assert it.
>+ *
>+ * These devices advertise MSI, but documentation (PI7C9X440SL.pdf) says
>+ * "The MSI Function is not implemented on this device." in the chapters
>+ * 7.3.27, 7.3.29-7.3.31.
>  */
>-static void pci_fixup_no_pme(struct pci_dev *dev)
>+static void pci_fixup_no_msi_no_pme(struct pci_dev *dev)
> {
>+#ifdef CONFIG_PCI_MSI
>+	pci_info(dev, "The MSI is not implemented on this device, disabling it\n");
>+	dev->no_msi = 1;
>+#endif
> 	pci_info(dev, "PME# is unreliable, disabling it\n");
> 	dev->pme_support = 0;
> }
>-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
>-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_msi_no_pme
);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_msi_no_pme
);
> 
> static void apex_pci_fixup_class(struct pci_dev *pdev)
> {
>-- 
>2.28.0




