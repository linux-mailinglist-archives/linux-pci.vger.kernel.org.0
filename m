Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD07810D936
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfK2R5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:57:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfK2R5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 12:57:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id e6so14669560pgi.11
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qRbvRGI95q9n8HmLSu7axtCeZCjpjfZCyst7xGr13mA=;
        b=YOA8tU6R8Q32dCBcenMm/PsZbZlt/QOW7oQA6kvbFcfemmSpUti2yX6o2bT6xy4IUs
         rfGyEbX2vQWY3Stbj+TDXnF2DrZQjTpIX/mgmmYSr2QtQHsTnBPSlwggTRfsf8yYICPq
         CDNlmBE8FK3Eb5xv7jNiETGY8VR0iBUxsyAsxwU9stA0F3OEJFx89HNjQvN7N2Xe4nNb
         FvaqSKguwEQJq++MmxTky5tULwQeZAFAauLtby/OeHQvoDqeCB0QHX7fIVbrMQg4Q2M1
         fF7N+vn3GA6DC7rRIQ4j4kJYQkm2wYuEmjNx89MdfG+NT27RtiktQEXUdTZTvXkI8eVv
         u1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qRbvRGI95q9n8HmLSu7axtCeZCjpjfZCyst7xGr13mA=;
        b=R3fwU6JN16oax4VPBF+HAvI85Mg6kwvuWCKW6qiFb8TV76ydB9/L3UCAIgQgzmIPpS
         1P+BgD0M2NKc0Abmxmtf+RA7ubuS1y3ghDIptl0mvETRn2Yb5yQOOcqDu8W44YVQdz73
         ykwHYlRKklqGdHRVPKWIZT8lnpbaC6YvK1Mo/xeokRfcXsZ+YC8DLzk0deS9lFv1bJj7
         jeGie5vSz0Z/V0B8lCTMYB7QJ4xYiQMSkb0+6bCVaXeJ47/47y0eeU5kTsW4mjoa5CKp
         VIWDF6PNfo/Dli6Vsm+o/Y2q9H/ihGchJN2U40FmO3dvmVbLGvtx4YS80nEUdJj181LI
         0dzQ==
X-Gm-Message-State: APjAAAXLMYLtjxDhKYivTAjg8ixvGgy2fAMrKJTkrAi2OfbwtljuPIry
        0JrNMnt4xjgiPOgNix+7ZoUl0pTvtiK/WQ==
X-Google-Smtp-Source: APXvYqwAT3uzkjkz+anc+nX8KobmkmHzI+Sw5M0xnZcf5Ma8eI4N+Ywc38p5EMTNNnf1LcnLtmCCyg==
X-Received: by 2002:a63:da13:: with SMTP id c19mr17488191pgh.435.1575050218308;
        Fri, 29 Nov 2019 09:56:58 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7sm9962922pfe.22.2019.11.29.09.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:56:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v5 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
Date:   Fri, 29 Nov 2019 17:56:55 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
 <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
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
 drivers/pci/pci.c    | 23 ++++++++++++++++++-----
 drivers/pci/quirks.c | 14 +++++++-------
 include/linux/pci.h  |  2 +-
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0a4449a30ace..f9800a610ca1 100644
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
@@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
  * cannot be left as a userspace activity).  DMA aliases should =
therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns)
 {
+	int devfn_to;
+
+	if (nr_devfns > U8_MAX+1)
+		nr_devfns =3D U8_MAX+1;
+	devfn_to =3D devfn_from + nr_devfns - 1;
+
 	if (!dev->dma_alias_mask)
 		dev->dma_alias_mask =3D bitmap_zalloc(U8_MAX+1, =
GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
@@ -5882,9 +5889,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 =
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
+	else if (nr_devfns > 1)
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
index 1a6cf19eac2d..84a8d4c2b24e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2323,7 +2323,7 @@ static inline struct eeh_dev =
*pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
=20
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
--=20
2.24.0


