Return-Path: <linux-pci+bounces-26021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1582A908F5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD2D3BDF1B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECF212D6C;
	Wed, 16 Apr 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSbbxdoT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0666211A3E;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820956; cv=none; b=DTugjtOn1U3kZ9RMt8u3cOhFqm8X9tFJ3PaksnN4MxqZ96+pf1oNRH1ROhBt7Ne2CxmNj3TDQzmyj5m+VffqhvdahBe7Ay+4yl3SJNj0EPFnHa0IpyZszM8riuqhcTLGXbAhzPuOoz/bfJ8txW9vAPPX12dyxcnlRCGeuAjshD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820956; c=relaxed/simple;
	bh=8etcX5m2jbSq0K/R7mPNsIwKXhQl02h3G20oYrpddy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWezvsNH3A8ieH00oYhuw+TXmxG2rXvfJ+h0+f+rJL/Tg6vBOU3cgtyBIwfrztXAu8Zttj6EYPRuYQbELQrwZn6NPtEDWHOEfXNLUsMZeGHdSoP3iD5a6NvD1ZdqIL6GASvl4WPj4G2Xoq+uII2wHT1tCC/d95sxhO7gLLuLs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSbbxdoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B4BC4CEE4;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820955;
	bh=8etcX5m2jbSq0K/R7mPNsIwKXhQl02h3G20oYrpddy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DSbbxdoTngHcPcjdOpqMWsYrTsrTM1IaydKW0w1IJNAHwt22Rd5EtBKyyXy8uESoK
	 Bhknzq7by4+crREApaITdosNs9j3IvGIvwsjvm1Mw3lLGQAmeEZTtrKs5cZi/Czf5f
	 iQf/GsiUNVv+ObYzFeOF1WuiAr+9qPvRh3DyR0Kzh8agFiBIl7MAfATSVHZXHVydQ1
	 iBGNrSteddU1s4TxR34Ehed8ikxJAVRTDMVVc1g61XgIBvRUsjYO5e96une5kOk9EK
	 JE1dg0EywjDpUAJrnsq/0+bJW+CVg5yOD9Wpyx8PjKL+EEmyHhRL9YnS1KhY2MW8Ls
	 TFhbjbnTPcGjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F4C369BA;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 16 Apr 2025 21:59:05 +0530
Subject: [PATCH v2 3/4] PCI: Add link down handling for host bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-pcie-reset-slot-v2-3-efe76b278c10@linaro.org>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
In-Reply-To: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5199;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=lEJMTheXv7TkxX7FcSXxWDHTdFlcl4i5pVx1YeWN9fA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn/9rXxS8C/6Fb1mSogflJ2GvH10SSe2Bg+GkU9
 4/sP5k6EA2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ//a1wAKCRBVnxHm/pHO
 9deGB/0SC83yXRK8fZirz8yjVN0ZOkIq2gfWTRyPBDR3lbS/TtJ7RN2RdTMGJZWi2QmsH9dlpkc
 eGKL1tllmLi60EyApZlpGqXksaN7OpGLI2pTxoCveILLrzdVhVP4795rU+xuqXwtd7TOGVy9Pey
 rH4aPWbus6UWsax1CaUClmo+wnmK73R67QIiv/o/Rz/BDXSh6JZ+asx02rDLBN7Wb4JbMvlR8Of
 sGxktWntkan/7siYofP9FbPU2Bplq+0PNyFNJQrh8CYCs2BvESumMUzJerDqcY++II0w9k6ZndP
 XGE3WzHMxek22XMzPv+Xh1KIiXBtWVrtZcu8CDBZtoNXnziP
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The PCI link, when down, needs to be recovered to bring it back. But that
cannot be done in a generic way as link recovery procedure is specific to
host bridges. So add a new API pci_host_handle_link_down() that could be
called by the host bridge drivers when the link goes down.

The API will iterate through all the slots and calls the pcie_do_recovery()
function with 'pci_channel_io_frozen' as the state. This will result in the
execution of the AER Fatal error handling code. Since the link down
recovery is pretty much the same as AER Fatal error handling,
pcie_do_recovery() helper is reused here. First the AER error_detected
callback will be triggered for the bridge and the downstream devices. Then,
pcie_do_slot_reset() will be called for each slots, which will reset the
slots using 'reset_slot' callback to recover the link. Once that's done,
resume message will be broadcasted to the bridge and the downstream devices
indicating successful link recovery.

In case if the AER support is not enabled in the kernel, only
pci_bus_error_reset() will be called for each slots as there is no way we
could inform the drivers about link recovery.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.h      | 21 +++++++++++++++++++++
 drivers/pci/pcie/err.c | 27 +++++++++++++++++++++++++++
 drivers/pci/probe.c    |  7 +++++++
 include/linux/pci.h    |  1 +
 4 files changed, 56 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62a3022c8b07a09f212f6888674487..6c1d4c5a82d68e5842636ff296a8d3a06487cb11 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -966,6 +966,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
+void pcie_do_recover_slots(struct pci_host_bridge *host);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
@@ -975,6 +976,26 @@ static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
+static inline void pcie_do_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+	int ret;
+
+	if (!host->reset_slot)
+		dev_warn(&host->dev, "Missing reset_slot() callback\n");
+
+	for_each_pci_bridge(dev, bus) {
+		if (!pci_is_root_bus(bus))
+			continue;
+
+		ret = pci_bus_error_reset(dev);
+		if (ret)
+			pci_err(dev, "Failed to reset slot: %d\n", ret);
+		else
+			pci_info(dev, "Slot has been reset\n");
+	}
+}
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b834fc0d705938540d3d7d3d8739770c09fe7cf1..70d8cd37255c5638fddf38e13ea87cb8ebe8553f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -270,3 +270,30 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+static pci_ers_result_t pcie_do_slot_reset(struct pci_dev *dev)
+{
+	int ret;
+
+	ret = pci_bus_error_reset(dev);
+	if (ret) {
+		pci_err(dev, "Failed to reset slot: %d\n", ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_info(dev, "Slot has been reset\n");
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+void pcie_do_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+
+	for_each_pci_bridge(dev, bus) {
+		if (pci_is_root_bus(bus))
+			pcie_do_recovery(dev, pci_channel_io_frozen,
+					 pcie_do_slot_reset);
+	}
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8a68fb18bded3259c6847d3932f8b..60ad20eea0259797e68afa7979bb1fc24b6f213b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3249,6 +3249,13 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
 
+void pci_host_handle_link_down(struct pci_host_bridge *bridge)
+{
+	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
+	pcie_do_recover_slots(bridge);
+}
+EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
+
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
 	struct resource *res = &b->busn_res;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8d7d2a49b76cf64b4218b179cec495e0d69ddf6f..76e977af2d524200b67f39a6d0417ee565cf5116 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1157,6 +1157,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
+void pci_host_handle_link_down(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);

-- 
2.43.0



