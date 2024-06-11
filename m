Return-Path: <linux-pci+bounces-8570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67151902FAF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DBC1C23037
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 04:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8616FF4E;
	Tue, 11 Jun 2024 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6RaaXoG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E2140E30;
	Tue, 11 Jun 2024 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081636; cv=none; b=EMBKtpCG+8egvneL3FTD5CTA+lZnRMuXlH6cE54DgfXC4IWR8AJijKxut9yH16vLgq5OK+wwM1Dcng7y7nmWsPZ8T7AS+2Ob7ZQH7s/ILm6NObmGD6xjr4dEVzvwgKSv1baqcpbKtefCn8e6kazzu++70WUL8H7mYuBWKcikncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081636; c=relaxed/simple;
	bh=lzUuMsC0hDi35gO/XT2gOUyHThQaK3xjaSaCHrDN14M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ttg7ofy7hFukS19QBsxedt6v1y+v2LoTzpUEh7bPOEHn0w5GmiFMB0yV7nefSPSWEUrZGCe/mbhh4aGo2QvJ839Feu7T9xYdyGtVP2tZsYiX6T/WiXV5tI9ZHW9xG47Snu0cKDIG6yqmykfHMYA5afbsRZDNDq/+b0ZdAP40p88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6RaaXoG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso583603a91.1;
        Mon, 10 Jun 2024 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718081633; x=1718686433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ry5v2vYLIuxqgnekdqJjBLVdWfPxh72pMUHkFG2k4=;
        b=G6RaaXoGtSU2OMjCEExOI4arQ5FnTRAXD95RTfZi7ZNYb3pCKtbR0pM17JMzI/NhOV
         2q69rl7jUGED9xR7RZaMaUskq9vFKk2NDLKEu3/ue5nVYIpvOkAnnko1/6Cft/58x7Me
         2i9A3/IGTgUstmufXWurTOgAtBc9C7WarDLc9qkmixQkG9wzF3BCnCk0L8+mPkus5I4q
         S7ryjIR9FhytTfTbs/eq9Ywa9Fahwi56UaWj0ReQV01/55Dmb2zgw8EoWgI1Wc8W8MRd
         NPw7pM7TrBX24N10khHuIhfWJSr6zDgJN2h4YmPBlBFr660IMkXjEzXbNuTb5QJE1zs1
         gZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081633; x=1718686433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0ry5v2vYLIuxqgnekdqJjBLVdWfPxh72pMUHkFG2k4=;
        b=gtwvIrNPtpdNiFe9K9OCfjUlLI8FP/F21oYzK69RNQ+BWEgs9x0c8nXhrEuAPFY5EX
         1D2N97XHiwh6uMoktaKpDY+M0NdySQjyr0ldIi3tDDV2wIbwhLedND+KB2nldweQM3MH
         QClJ1nTH6D7EHQvYtvlc8PGItU5LWmSbKn1LU/zdnUDIxLsYP/l7+o+rtrZ2dl7Ct0AO
         aHjzxttT60ripa6JJDtJNvQDNbENWTdkuPFOrXJshW3dHs0ZqDQDVMfwXOOcF3XZD2ta
         GJwxuAVAYbQu8OBZxEDIDqij4cFyz1m6duMP3Zrrmn6MnXAEPJm2ujFcUMFIMcUmB4Wc
         tnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi4Vm/KGB4UOrooYHU2GL7TSNe3LopLeSE5DouOwp3TkNXKVz5nfQRrUEXb664nFjlVdE98zd2ED8qfwjJ+o26HSN49Ac5BvND
X-Gm-Message-State: AOJu0Yz1jqLokdHqRv3dCZXUpS9vIkNZB4ADDBzK+0YCVJLkypdu+E7c
	nHw2IUoXw7ZQhSIqVXkrgrsyfZzAhi5VLR677B0S4q7+gRJ0NpgfwUP1ghqL
X-Google-Smtp-Source: AGHT+IHjrY0dZ3Jhljr9qE59CDqvXTYEQH7epQTclxlpvmeI2wAJ25lx1Pd7V/DrPem2LGLy149ZKQ==
X-Received: by 2002:a17:90a:4591:b0:2bf:eddc:590b with SMTP id 98e67ed59e1d1-2c2bcad64d2mr11129295a91.1.1718081633485;
        Mon, 10 Jun 2024 21:53:53 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31bb3c141sm1967277a91.10.2024.06.10.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:53:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next v10 2/7] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Tue, 11 Jun 2024 13:52:12 +0900
Message-Id: <20240611045217.78529-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611045217.78529-1-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just adds the scaffolding for an ethernet driver for Tehuti
Networks TN40xx chips.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS                          |  8 +++-
 drivers/net/ethernet/tehuti/Kconfig  | 12 ++++++
 drivers/net/ethernet/tehuti/Makefile |  3 ++
 drivers/net/ethernet/tehuti/tn40.c   | 55 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   |  9 +++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..8dc47317f4ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22138,7 +22138,13 @@ TEHUTI ETHERNET DRIVER
 M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	drivers/net/ethernet/tehuti/*
+F:	drivers/net/ethernet/tehuti/tehuti.*
+
+TEHUTI TN40XX ETHERNET DRIVER
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/tehuti/tn40*
 
 TELECOM CLOCK DRIVER FOR MCPL0010
 M:	Mark Gross <markgross@kernel.org>
diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 8735633765a1..849e3b4a71c1 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -23,4 +23,16 @@ config TEHUTI
 	help
 	  Tehuti Networks 10G Ethernet NIC
 
+config TEHUTI_TN40
+	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
+	depends on PCI
+	help
+	  This driver supports 10G Ethernet adapters using Tehuti Networks
+	  TN40xx chips. Currently, adapters with Applied Micro Circuits
+	  Corporation QT2025 are supported; Tehuti Networks TN9310,
+	  DLink DXE-810S, ASUS XG-C100F, and Edimax EN-9320.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called tn40xx.
+
 endif # NET_VENDOR_TEHUTI
diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/tehuti/Makefile
index 13a0ddd62088..1c468d99e476 100644
--- a/drivers/net/ethernet/tehuti/Makefile
+++ b/drivers/net/ethernet/tehuti/Makefile
@@ -4,3 +4,6 @@
 #
 
 obj-$(CONFIG_TEHUTI) += tehuti.o
+
+tn40xx-y := tn40.o
+obj-$(CONFIG_TEHUTI_TN40) += tn40xx.o
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
new file mode 100644
index 000000000000..6ec436120d18
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/pci.h>
+
+#include "tn40.h"
+
+static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int ret;
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set DMA mask.\n");
+		goto err_disable_device;
+	}
+	return 0;
+err_disable_device:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void tn40_remove(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id tn40_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_DLINK, 0x4d00) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ }
+};
+
+static struct pci_driver tn40_driver = {
+	.name = TN40_DRV_NAME,
+	.id_table = tn40_id_table,
+	.probe = tn40_probe,
+	.remove = tn40_remove,
+};
+
+module_pci_driver(tn40_driver);
+
+MODULE_DEVICE_TABLE(pci, tn40_id_table);
+MODULE_AUTHOR("Tehuti networks");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Tehuti Network TN40xx Driver");
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
new file mode 100644
index 000000000000..b45a2eef2850
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_H_
+#define _TN40_H_
+
+#define TN40_DRV_NAME "tn40xx"
+
+#endif /* _TN40XX_H */
-- 
2.34.1


