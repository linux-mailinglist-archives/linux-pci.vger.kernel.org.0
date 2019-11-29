Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2410D939
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK2R5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:57:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2R5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 12:57:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so6289835pfb.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=c2lqMUF03+NSISePuwEOQ8Bd5i/uGHLhUPTsAK4hss2wEZNO0YtKZZP+M6/3ykCaUV
         YcetGbI59k7rYvyGajEF+jYtXpODH//HkgX/NLg+AaXkMdP88G569ABBt6CkB8/E/FCD
         wtCSgaV4vJt7qaH+XdQGLTeQx4bDc0mg8FsG9X0IH3JYGgHBs2DN1gj/oDCTZSg9GjDg
         sXjeWlR0zFuvErWy+pocrKwGJxdoPytMflbh4lLohMKQM0wIZcZk8D54+NRLdCNjRyom
         fujXxl6O0Mt6DySUUTU6s9BM1YwdYI1MCH2NmrhA7n8cGNVFY4U20ECnfVoS5trgLGgU
         yulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=n2rqmUoKoPSYjGD93kcq0acvsaw5YdHEEfFFJEC+hLFcputwwAZaRlzPyOPqj3LcDv
         eTOYxmYLCSd+otrt4yEBoi3AGjANHbqkbBJ+0ptavcxS5/B9+8hlU4mIvCH/g8ja/nBz
         tTCCNL9twvRwsWaS8BYCl8wITUO6PsAaPi6MB+oK7cSkPD0QIb9/1Sw3ftIqbBNDmC+k
         YCZlFNBgFVRTIS2BVpVH7PwG7F2tq5UIWS3cYmLe5EnixG+p8ZxE2KATQhkfZE/fwFOE
         k4ljyv1fY28mgxDp/Z0RqeZgI7xWn8sJpDAgTQUAOW98HkM/8ls5OIhgcQ6VBPPS088+
         yJ1A==
X-Gm-Message-State: APjAAAVGxCDpyBgBc008eH6/T5LS2+pAUyGy77NtzQdB5khyFq6HmDqI
        57sOyibn6aPXqDsiylI7APonbn5/ptV1cQ==
X-Google-Smtp-Source: APXvYqw9Eg6DFBj7pyzOk1ulRHR0zTPsy8bNtI9mmkXKnlGLTxoL+kXcdVsCFL9rQKLOL9a11hNA7Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr18046875pgl.224.1575050243696;
        Fri, 29 Nov 2019 09:57:23 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7sm9962922pfe.22.2019.11.29.09.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:57:22 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v5 3/3] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
Date:   Fri, 29 Nov 2019 17:57:20 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B1FC6DB-18D2-4946-A0AF-9C1EC626D3B7@arista.com>
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
 <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
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

