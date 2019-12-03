Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39C11017E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLCPoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 10:44:20 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36012 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfLCPoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 10:44:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so1685239pjc.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=EBwqc6MulSxDWmm7FdPAlxIr1bsXOSVCfKzrNL1doUXKxjR7GgAOrbgPO8OBy0Z3G9
         Bm5CZmA9BZ/TbmkovBpvwhZIJ30cFgj4XLfb9ILKVsr87CAknH81elcvsIszKP1NoAKR
         aGoWTjt56RQiNo6Q7npeqkPdw3vqrupsnmyNtB545Okihe9VojG2/NA2Ckyu3YYNO8Ta
         C1ZIdxjKY/1vUndUI8IXOAd6NhogSj/gSUsdveQKA62ryk1FVsjhdXZ10hz3jkr3p0Dh
         n+eWdL0KL9P0/2mppivVB0C8itzjIFmTufIqXQ7MSmQ672wzoes8agSVU8kh0p/b22CV
         uykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=GBUlj8sJW/XoQsRCksCvZwDrD7iVzAyCT2HDCgmuT8H+8ck0/dkj8bamixuvQfhrHr
         3ilI9jUhwkDHovqSvZtUyHRjpr5gIDikw1Q1OIYzMpU2EI7q6Zj248OX5CxqcRMAEJJM
         xfKb5PFHxLmuKNgPGD9ibLK8BDi94jyv+r+txTYDgTFuGAbDhh1U36/pDdo/IIP/Ejgy
         vDBAsgC5ZWKjEv8KnbE9WFLQVMAATNVZPZzFebeDgws+AiBXbWemTRSQoyTZ5FJDql+d
         YItF3SZBDnpOxH+NAFOWc++Sg4pm8N2fazW8NqRzTUrN+qV4xoFOizUhCfBXL8Pojx6E
         UFvQ==
X-Gm-Message-State: APjAAAU7oFixoMCooQQMzKvhcQTjDmee6eJdfxnWBN+f2UKZ02f8vPoN
        7k0cMYhOrA+71YxdTLDb5FUG2qveGRLRQa3s
X-Google-Smtp-Source: APXvYqwi1quFBuB5qYP3TcIJe8VNkDjJWejd8MLtlpQR7IQidLMT9GSnDbiV/IMnm1WNzKlpfKtONQ==
X-Received: by 2002:a17:90a:d353:: with SMTP id i19mr6306671pjx.43.1575387858722;
        Tue, 03 Dec 2019 07:44:18 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e11sm3953969pgh.54.2019.12.03.07.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:44:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v6 3/3] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
Date:   Tue, 3 Dec 2019 15:44:15 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB3DFAF8-D126-4ECB-A4E0-C314F4F46205@arista.com>
References: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
 <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
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

