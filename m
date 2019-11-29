Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC74410D5D9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfK2Mto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 07:49:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39851 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfK2Mto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 07:49:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so8168427wmh.4
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=OFr2xRM6+3SE+J561j8El5HiW8f7yc8oGUzpj/7E8POne7eTulFBtYHtJn5fz4hyvz
         zDUXVHTDDC5F7dsjGLRwsDmoW0oUZVv4AY2omdXXWIZSS+YF0GIjHSObhdQi6CIkzbth
         SxWAjc3L/6KTQSXP77E3ONhr9VEu+17vM5Ufu9aWoGQ/02qc1OrOAbkgZylu8WgA5ssX
         dS7BuDadYqG1zlSol3JsmFepDRZV93pwGhrP8thfqJPXcUF3L6/SDi7b2Yf5i9fCBsjv
         H4XTWEc1Ac6vYIy/bZaTfDt7+romyqPW4NOxZIpDn+T1My0NZVHRHRq+bCFgP6D5UvOI
         UfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=QtmcZko4TjsyGMMUKnhN4shRHbNZRky1CrVwto7rG3Pwb7fBi2O3XUTWqTvy6MCZmy
         E+xlwLg/DeHcoH0SiQQ+2/vk6ZsXK23bZba+SagnB5nl71zjmyIUJFLu96MbXQMdwM/6
         fXacLYE7RSePMTojcoq2Dv2ormD6F+iHSrpxdbHPKCQpKj4ThA+rpWs2FXHZd9LiQsa7
         LYhhBCYcqrrCEPS+sCBozdarHywKyijx2Gp4aRi2ijZoyslM35yswEvuYPLdhdYbSu5N
         PvUQOU3oSSmRUgfSpIEnJSvy5CbM9AYodfU7ECSaUmATlnt+iAURboh3mEjfs77RO6ed
         PjJQ==
X-Gm-Message-State: APjAAAWMVlKlTFFkJZr4fWXeyWKSx1LLyGA8S2lXUBxK4Zsct5LJmjYY
        wRWWjyYAvCTUqQifQjIFHs30w8VeKYtVWMOE
X-Google-Smtp-Source: APXvYqzrFnew0Xg726sQyLozIpTyofkdje1WOGBoORFXdlnSGE+sAJRA2NS18bWiUsqdxxmHWnZTzw==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr15129630wmb.40.1575031781981;
        Fri, 29 Nov 2019 04:49:41 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l10sm29695601wrg.90.2019.11.29.04.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 04:49:41 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v4 2/2] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
Date:   Fri, 29 Nov 2019 12:49:40 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAD9A3CA-59E4-4982-B902-7032CA96FAD1@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
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

This patch aliases all possible devfn's to the NTB device so that any
transaction coming in is governed by the mappings for the NTB.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f3f5afc73fd..3a67049ca630 100644
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
+	pci_add_dma_alias(pdev, 0, 256);
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
--=20
2.24.0

