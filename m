Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31810A2EA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 18:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKZRDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 12:03:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfKZRDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 12:03:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4003702wmj.4
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 09:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YDMkod26jBuYIctmZERW8YY/mOMbA2drn1QF1QAAIto=;
        b=oG4z8HUair3Guh/qOumEgxFQ6aBIbp46KkUmOTfHLc1N6N6/R9FKZH98lfCfS7K3cP
         gho0Bc8vDd7Y8WKXwjtG4rwG40ORm4nem3ny7EZDqZuEB/lMXSIdZtW2HokCNwyR+38t
         7Fe+gFVuCePWsD1JlCD/t1PA4VdaKONbLApcgQBKvw62AAPRzDvNuiczBT1mWUxDpaVW
         KMbgfYl7Gu6b9fZopFI2I6IL/ADvgD8sQ/pZYqdQ1i/hgRzumn81ik79ASXic9H7heMW
         mZ62q79cHrJcNi789FodWJgNEu1yxddYXSsj7JfuwXHeQCsIL+ZS004Cr5KPJcoybqqG
         hoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YDMkod26jBuYIctmZERW8YY/mOMbA2drn1QF1QAAIto=;
        b=PdEgK5hSmrhNhtxpPmxyvrPnqYxYmCi4P5Nkg/v0sw6dWabatSRw5ZAzkHHIMxkEDG
         Ou91r7PUCd8rGqdz9TT5kpUMMrz7cGYfpn0ez3+83KI+SLGCbgNQJMIVbm3Tc2MT2Sjl
         N3BRN7GyflUDCjY/vJcvyxjznOrJU/yYVj70PFpIai0OSsbOYEhOQDFJCunwMSUtkfiA
         Xopltwjo22ddScElgSNCWunIIXCwh7tjjtbugLSvNhBanoPUML9cU4wZTuz+Vi1LEJih
         i4awmZZ1h0Uoe8OlChFP4RPHCsOhMVdflpk3hqJ6sdTWga4q5lOJGCjEfhuOl6OYf3kK
         yqug==
X-Gm-Message-State: APjAAAXHYKbiMkEyHFt71ALepQkaNF5JkBmO284FVtML52Uf4506hyIO
        RaZHodTJQBGpsnUXI7r+x5ZATn9b8Js4E0uR
X-Google-Smtp-Source: APXvYqwReaa4bwtmNp/NSgCoIIpzSMoMUduHgUDieWiBxVI+QLcOG66Jh98wtBHj+VxoZ+3N5o8lkg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr61452wmk.18.1574787808072;
        Tue, 26 Nov 2019 09:03:28 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 19sm17789770wrc.47.2019.11.26.09.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 09:03:27 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <20191120193228.GA103670@google.com>
Date:   Tue, 26 Nov 2019 17:03:23 +0000
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
References: <20191120193228.GA103670@google.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PLX PEX NTB forwards DMA transactions using Requester ID's that
don't exist as PCI devices. The devfn for a transaction is used as an
index into a lookup table storing the origin of a transaction on the
other side of the bridge.

Add helper pci_add_dma_alias_range that can alias a range of devfns in=20=

dma_alias_mask.

This patch aliases all possible devfn's to the NTB device so that any
transaction coming in is governed by the mappings for the NTB.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 29 ++++++++++++++++++++++-------
 drivers/pci/quirks.c | 15 +++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..f502af1b5d10 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5854,6 +5854,18 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
 	return 0;
 }
=20
+int _pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int =
len)
+{
+	if (!dev->dma_alias_mask)
+		dev->dma_alias_mask =3D bitmap_zalloc(U8_MAX, =
GFP_KERNEL);
+	if (!dev->dma_alias_mask) {
+		pci_warn(dev, "Unable to allocate DMA alias mask\n");
+		return -ENOMEM;
+	}
+	bitmap_set(dev->dma_alias_mask, devfn_from, len);
+	return 0;
+}
+
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
@@ -5875,18 +5887,21 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
-	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask =3D bitmap_zalloc(U8_MAX, =
GFP_KERNEL);
-	if (!dev->dma_alias_mask) {
-		pci_warn(dev, "Unable to allocate DMA alias mask\n");
+	if (_pci_add_dma_alias_range(dev, devfn, 1) !=3D 0)
 		return;
-	}
-
-	set_bit(devfn, dev->dma_alias_mask);
 	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
 		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
=20
+void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int =
len)
+{
+	int devfn_to =3D devfn_from + len - 1;
+	if (_pci_add_dma_alias_range(dev, devfn_from, len) !=3D 0)
+		return;
+	pci_info(dev, "Enabling fixed DMA alias for devfn range from =
%02x.%d to %02x.%d\n",
+		 PCI_SLOT(devfn_from), PCI_FUNC(devfn_from), =
PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
+}
+
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2)
 {
 	return (dev1->dma_alias_mask &&
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..1ed230f739a4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5315,6 +5315,21 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
=20
+/*
+ * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. =
These IDs
+ * are used to forward responses to the originator on the other side of =
the
+ * NTB. Alias all possible IDs to the NTB to permit access when the =
IOMMU is
+ * turned on.
+ */
+static void quirk_plx_ntb_dma_alias(struct pci_dev *pdev)
+{
+	pci_info(pdev, "Setting PLX NTB proxy ID aliases\n");
+	/* PLX NTB may use all 256 devfns */
+	pci_add_dma_alias_range(pdev, 0, 256);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, =
quirk_plx_ntb_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, =
quirk_plx_ntb_dma_alias);
+
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS =
does
  * not always reset the secondary Nvidia GPU between reboots if the =
system
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a6cf19eac2d..6765f3d0102b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2324,6 +2324,7 @@ static inline struct eeh_dev =
*pci_dev_to_eeh_dev(struct pci_dev *pdev)
 #endif
=20
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int =
len);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
--=20
2.24.0

