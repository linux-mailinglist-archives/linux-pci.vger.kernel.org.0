Return-Path: <linux-pci+bounces-518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A43805ADD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F41F21AAF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705369295;
	Tue,  5 Dec 2023 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz7aiQkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E769288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0D1C433C9;
	Tue,  5 Dec 2023 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796286;
	bh=SHRKGwDoVF1G5pI2uXdiU2j2HD1GhNV1bFDWy1EgiQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz7aiQkW8Riza4Ilemm9GNYNXNd8o78kRd0umW+FYYavHtzRjmbSvhY+XnsuAKS1R
	 ETZ16KI3ktKyiPVGQCwWVQBMIPBb2ORwdv6fczHVgAS7FW+cz762RTMkuog4P9izWu
	 VtyKND0Rh/0Xi7QGg9VKSIMYbkpjcOHEBleijIaF+MzndkG9HRYO6GFmamuOTxp/f1
	 SPCRqil0ia6q41yeHBm3eq493FY9BE6I2kNLIKBaJmvG3eyvBx9AuZREcYEFFOj3CI
	 zqPVpyKAmXs2ddX26uJIDty1pUDfVpIUbGdIt8AbqXaoZLohjHGt9ZhNS8DOSAyUS1
	 z4RjwMjEX6+lA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/7] PCI: Log device type during enumeration
Date: Tue,  5 Dec 2023 11:11:13 -0600
Message-Id: <20231205171119.680358-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Log the device type when enumeration a device.  Sample output changes:

  - pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
  + pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint

  - pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
  + pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400 PCIe Root Port

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..1dbc06f0305c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1817,6 +1817,43 @@ static void early_dump_pci_device(struct pci_dev *pdev)
 		       value, 256, false);
 }
 
+static const char *pci_type_str(struct pci_dev *dev)
+{
+	static const char *str[] = {
+		"PCIe Endpoint",
+		"PCIe Legacy Endpoint",
+		"PCIe unknown",
+		"PCIe unknown",
+		"PCIe Root Port",
+		"PCIe Upstream Switch Port",
+		"PCIe Downstream Switch Port",
+		"PCIe to PCI/PCI-X bridge",
+		"PCI/PCI-X to PCIe bridge",
+		"PCIe Root Complex Integrated Endpoint",
+		"PCIe Root Complex Event Collector",
+	};
+	int type;
+
+	if (pci_is_pcie(dev)) {
+		type = pci_pcie_type(dev);
+		if (type < ARRAY_SIZE(str))
+			return str[type];
+
+		return "PCIe unknown";
+	}
+
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+		return "conventional PCI endpoint";
+	case PCI_HEADER_TYPE_BRIDGE:
+		return "conventional PCI bridge";
+	case PCI_HEADER_TYPE_CARDBUS:
+		return "CardBus bridge";
+	default:
+		return "conventional PCI";
+	}
+}
+
 /**
  * pci_setup_device - Fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1887,8 +1924,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	pci_set_removable(dev);
 
-	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
-		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x %s\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class,
+		 pci_type_str(dev));
 
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
-- 
2.34.1


