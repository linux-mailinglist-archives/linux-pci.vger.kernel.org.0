Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2743010B028
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0N17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 08:27:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK0N14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 08:27:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so26664214wru.3
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2019 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VDd3PX5r0IXOzmkyTrzEXTYUHrFHIDqiVg1+tNrjv8w=;
        b=maolk9YWYMKMfuluXkZFpnm52NDrJTCTxQky+PoiisyFjZ6DauabZ8d2ZocnFMFj5x
         UVYQA1RYDEgR6aX///JK0Jrr/GkKGzOjPXHLzPx+GXGjzQT6dvbTgvbG4uflGxIqg5xJ
         Za282/TlilQr+CgI4wPTakgBI3E9Lpjn4B6fgM5cOTC91o+mpjjsSmK0TULilhdnqh/O
         N7YngQTcmZ+l2n4oFyWqJME53zLW3YiBoojO9nBDo2btWWrZyqAb3eu93AbctUXdUsAa
         NUIxJ2HRWrks3icNNqGGHFCb+1SpE/s/SqxHf+SsqM8jwBrA2ek/uso+V1Ew54mhMfvP
         gPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VDd3PX5r0IXOzmkyTrzEXTYUHrFHIDqiVg1+tNrjv8w=;
        b=AGsXgsE975Fz1pJu/eYr2eCTdGoTltyfraDhRw0ySyLywTNxWcEa4+mMwKpYY5b9DT
         H+O4oAtBPtk7NzFpwZV7xxiNc1v3X5ykFaXp+kbvx40trR4/1AJH7RazQolCh78rFSHp
         ojqQs2vXiN40+Ftl0sAni2fxPUOu+wJjvAFRQvT9ybwNX1SLfRuxMBLSUOWqIxBhcXQY
         rkPLTfWmz6MVUXNpaoWNMu0d8oSr66THu8KlOezuZIxDuMWVnkZk7sPmJw1+i/DMV11i
         7rRhkA/ACnzmGc2Qm7JQnFKiDpKwNvm6sfLEpkKxRzbSOXV6Vz3AvC9MQja2lo+8j/4u
         YTIw==
X-Gm-Message-State: APjAAAVEk9Tyn+el5PKTzNOaef3fO5Rb+CIRHFaLEsRvqSchlwsfV9dm
        KrZcpAhywCKoviY1Ucqldl0O2zzlLB/smA==
X-Google-Smtp-Source: APXvYqzCV/9jwG77cqrkvWacOPQsnSCXquwEmL9QvOofnkih5XXDRREZvFEZHFONVFLsFNqTm55aJw==
X-Received: by 2002:adf:9185:: with SMTP id 5mr44094064wri.389.1574861272711;
        Wed, 27 Nov 2019 05:27:52 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v15sm6609957wmh.24.2019.11.27.05.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 05:27:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <20191126173833.GA16069@infradead.org>
Date:   Wed, 27 Nov 2019 13:27:50 +0000
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_add_dma_alias can now be used to create a dma alias for a range of
devfns.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 21 ++++++++++++++++-----
 drivers/pci/quirks.c | 14 +++++++-------
 include/linux/pci.h  |  2 +-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..71dbabf5ee3d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
- * @devfn: alias slot and function
+ * @devfn_from: alias slot and function
+ * @nr_devfns: Number of subsequent devfns to alias
  *
  * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
  * which is used to program permissible bus-devfn source addresses for =
DMA
@@ -5873,8 +5874,12 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
  * cannot be left as a userspace activity).  DMA aliases should =
therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, int =
nr_devfns)
 {
+	int devfn_to =3D devfn_from + nr_devfns - 1;
+
+	BUG_ON(nr_devfns < 1);
+
 	if (!dev->dma_alias_mask)
 		dev->dma_alias_mask =3D bitmap_zalloc(U8_MAX, =
GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
@@ -5882,9 +5887,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 =
devfn)
 		return;
 	}
=20
-	set_bit(devfn, dev->dma_alias_mask);
-	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
-		 PCI_SLOT(devfn), PCI_FUNC(devfn));
+	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
+
+	if (nr_devfns =3D=3D 1)
+		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
+				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from));
+	else
+		pci_info(dev, "Enabling fixed DMA alias for devfn range =
from %02x.%d to %02x.%d\n",
+				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from),
+				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
 }
=20
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..0f3f5afc73fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, =
int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) !=3D 0)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0), 1);
 }
=20
 /*
@@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, =
0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) !=3D 1)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1), 1);
 }
=20
 /*
@@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev =
*dev)
=20
 	id =3D pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id)
-		pci_add_dma_alias(dev, id->driver_data);
+		pci_add_dma_alias(dev, id->driver_data, 1);
 }
=20
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, =
quirk_fixed_dma_alias);
@@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, =
quirk_use_pcie_bridge_dma_alias);
  */
 static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
 {
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, =
quirk_mic_x200_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, =
quirk_mic_x200_dma_alias);
@@ -5273,7 +5273,7 @@ static void quirk_switchtec_ntb_dma_alias(struct =
pci_dev *pdev)
 			pci_dbg(pdev,
 				"Aliasing Partition %d Proxy ID =
%02x.%d\n",
 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
-			pci_add_dma_alias(pdev, devfn);
+			pci_add_dma_alias(pdev, devfn, 1);
 		}
 	}
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a6cf19eac2d..f51bdda49e9a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2323,7 +2323,7 @@ static inline struct eeh_dev =
*pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
=20
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, int =
nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
--=20
2.24.0

