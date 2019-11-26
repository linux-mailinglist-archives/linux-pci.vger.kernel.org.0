Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0598810A365
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfKZRgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 12:36:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKZRgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 12:36:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so23549288wrr.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oQnkvcGSn3FnEJK1c4dN5xwxykVF7o2DUxDzMF/X+eI=;
        b=Mnkk/0t0RTn7IldxKQ3Eup+9Qromr30JeG+ClpG/lEi7SvhU08fLh3sTUwi3fRXn8o
         voqfByxV6S1yQs7duEUcBQ+otoKhhYWSzZo1+I1m10ZThT3NnZjbg0OTRaF5BkOhlixk
         kua+SDFmNUIKqGyx4nkaK4GfJ8JSvs72ytszQfmqdcfr0nbPSHMJ4HZSMUx2L/hrj4RR
         mVRLHqw2Vs4pYWOHyD33y+RKWFglL1Yy1zoVn3HVpdRAy2/ztShsyHvkLHpz5lSv4Bcu
         eaoAMINu4XfTT7/oouyZoP2thSGXxNQJrJl0VRILeMb8Rc6Gmt/mlb8Ut9EY7Toj61q7
         lo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oQnkvcGSn3FnEJK1c4dN5xwxykVF7o2DUxDzMF/X+eI=;
        b=VjQy0+lq27MBPPQ1CN9rGXaF4rQE1AMbSHYn3V9IEGixghF6Km90QCL/vP/Eo4TGb4
         gi3UXqQccNyAJYIsq7XpVn+C7cte5zYKNJIiVLGy1c9zIYH9h3k6U7P0IGODgza6lUPl
         RtyMoWHPn4MXsDm5yQancmmc3sN6V+QzRpXgXWNBlDSSRTMU1vrbNIP3HTaI0g92Qoq1
         pH71pOit02Clu6CXwe9nln7eGFQxywdMaipv6fygTDgrzFmRM2ix8p8NNlSrqw8i61hS
         18pzovFhDj61+ABkxkyngS3C1ypOOWmnbLr+g1pPdeiosznAuDUzHcPR1ij6jd6yvjiV
         eCPQ==
X-Gm-Message-State: APjAAAUfpI/C8fy5x+y6bxlSyhTD5+DX46QskC+nFkUouqgICxLdLpOT
        4/MPlBNGJqrlOw9bb0w6PNGA6FhmbHWWcCoT
X-Google-Smtp-Source: APXvYqwwyrGNIbRS/1qiWBQIFeTr+lTeHiS5H7x0RANPsRpLXbMnbMrkarvfrwaOtJUga4n5tQr3WQ==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr29615883wrp.12.1574789774900;
        Tue, 26 Nov 2019 09:36:14 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m9sm15092174wro.66.2019.11.26.09.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 09:36:14 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 1/2] PCI: Add helper pci_add_dma_alias_range
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
Date:   Tue, 26 Nov 2019 17:36:13 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_add_dma_alias_range can be used to create a dma alias for range of
devfns.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c   | 30 +++++++++++++++++++++++-------
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..68339309c0f4 100644
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
@@ -5875,18 +5887,22 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
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
+
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

