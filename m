Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF378F1EF9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfKFTgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 14:36:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39083 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFTgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 14:36:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id a11so27452716wra.6;
        Wed, 06 Nov 2019 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yf803qGOor/Cot7/OEfF6HTN0BEeLkegGJ0D7t2YoFs=;
        b=QytuGrv5RaR8aHt2W6tADBMSK2iQnketqSww+UVW4+YHUos01ZC70IfPiU1ae0l8qy
         EJrDiVxd2jztoK/QS4LEgMtoPk3aik9YUmAwXk1AwLGl1V4X7zUv8cJXwNIhMATYlOXn
         bW3qI/FDnQ0+R01cCECxVGt7X1RrUW3SnkfkdE4hFzo0W4SFm+dF/RReN0CoPNDthv47
         oPMQS65MuUFV0MYWPqsU9Eetkt7BOPlHzW0u2C9nhm7e3QSFxdnIKJDq4n61s9CaYG7X
         7EqeJ+lilFzCWetYDPeNufRQiMHXEg3pgRy8g7JkRGbhECdh4NsNGqCP2tVBoesBlw0N
         SwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf803qGOor/Cot7/OEfF6HTN0BEeLkegGJ0D7t2YoFs=;
        b=Ocyh6451wW1PJlOwDeACw3kigGTnionBEqmk7pgnczpvw04Zw/zwirtWraWLL6LAn6
         bfodq48pKsbR+jOwvpPAghQYlqtl/mxfXXjPLklJZ/lN5o/bUUuxH5Q0QZ0f2oLv7Nn3
         UgfXkNv0aJ9yhHRRxH3KGmYiN/vyiKHBxAaz4JpdVZ4eSUA3JT6JtBa/SA+7L/fmS8g2
         yybR5m+dQMkLbteaNMxETi6viLKBR1STc1CU/4UWocxD+68GCqZjgjxgy/AEXS57P2UF
         pXnQQvjNHB9vVVm5vxQmib1sobtwve1y2UqNiJZ7hV0pBH41E/cfEV1sV/IAYY5OUtxi
         i72g==
X-Gm-Message-State: APjAAAXqRtCZsB9sIqJpbYxJMBWEy6LYn/1ZTkiIYaS6mO7lSvwHdfrZ
        6HqxJOpZV1bYkQh0SIKdz24=
X-Google-Smtp-Source: APXvYqwiFZfPLdQy6v/nz6k2CH2RqPsaqZfFr+dpybZn29YX1r2YujalQoWrrhG/dLD8IDDpq/MJXg==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4555540wrt.249.1573068994407;
        Wed, 06 Nov 2019 11:36:34 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:1d3d:daa8:4e74:8240])
        by smtp.gmail.com with ESMTPSA id 76sm4311737wma.0.2019.11.06.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:36:33 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/5] misc: pci_endpoint_test: add device-id for RZ/G2 pcie controller
Date:   Wed,  6 Nov 2019 19:36:09 +0000
Message-Id: <20191106193609.19645-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a5e317073d95..346b03b6e4b9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -66,6 +66,8 @@
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 
+#define PCI_DEVICE_ID_RENESAS_RZG2		0x002d
+
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
 
@@ -797,6 +799,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_RZG2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.20.1

