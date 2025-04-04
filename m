Return-Path: <linux-pci+bounces-25282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B107A7B8B6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 10:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45CB16D1C4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734C198A1A;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvzWp4Mx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B021CD3F;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754950; cv=none; b=Q4bN34MTjywb8S9dXoGZ9x3DWOSuKrDvYye2Bhv6gR1l58HQ83f5uPt9gQU5E+7+hRGuQoGhh8d9XOVXBIJ8RWIaR2d/c3fRYlA2UWo8ux6OODf+vzXJyAXMhYuVYKOBnd2EsgERxdbWRdYtGtE3VisYTTQA1GuOn+6N2strEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754950; c=relaxed/simple;
	bh=uR3vbNZ2a/5+D41P/XdyWl7V66Eh7lHpDnUcSa7NVQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjUk8tQuqTRtu63TUk7xlo53zaN+aOAWr/3GY/zbwQhSJByh8GE35V2ykbEHphBmWH3Mln7CtS9BWzEDzTaPOG0C8b+Q78yj2XE5q2ItszXq04TDlqR8s5H/bc4UzC6XauBf6RE+7op5XvoWYSNmOcSgYwpLY63DJwmFcsfLMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvzWp4Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 357D5C4CEEE;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743754950;
	bh=uR3vbNZ2a/5+D41P/XdyWl7V66Eh7lHpDnUcSa7NVQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tvzWp4Mx1qLnWFezGrRkxHSvV1jdOuhS+ihabj1WTVClDpxO1TXS4NawBTeRnqqyU
	 s5Iba0PgPBLLxiNXbDpDuLtmNO7LbNfnKLSLO3SD8JrGCFr8Ma741EjWC5MXk+wZCh
	 Dq8PLo7QM3MOuO/uTaGh6HZsy35GgrZj0Cl/GGSpXL8VChKcTAK/ECx9rP1bcIscxv
	 h5Cjs6s9P/dlfPPeARCEH+Mc764fzGM7B8sOSSLAqu9wZcOtYRcuAIcXNjpUcTL1q7
	 Sf3mXfQUzbDZMwuWr2g6wF8hm7/OCyo5pUNS3RLW01tW7Sz0rE38qmahZjqWpRY5Bh
	 AqutnLK/9/2qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC5C36010;
	Fri,  4 Apr 2025 08:22:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 04 Apr 2025 13:52:23 +0530
Subject: [PATCH 3/4] PCI: Add link down handling for host bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pcie-reset-slot-v1-3-98952918bf90@linaro.org>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
In-Reply-To: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5609;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+ITPzeoaQcEIkq+82fVSDeyUKwuRWQPYslcPdhuwyHg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn75bD4Cd8YzJEF3HRP0cKDCIO4/b18SYn1gsUN
 i3KX+KTt4aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ++WwwAKCRBVnxHm/pHO
 9WTMB/9GHKbl1ReNJXYGisTpWVPXDX3UXEsckCiGgo2A143UhTD0joeYs2wDWZD3CuxbGZAVj7W
 8dznHcVyatwu3oFqIoRqu//qlW+ioIAT8kwSZuLhoS443XFKUwXL18BkryEKc+UaZdf4v1QGoQh
 JgHksuRL1YAt7nG12tWWrP1Uj2dQ4VXb/RZRP/oy7uV3HnzUNcXPsFMJjJRPl8bZOZ00YP3CsEY
 53+R1Xua+9ku9CF2S54VyE0KATQ2cU9VolZkQ8rq0iFposlw50jF/yVyqOZhqkdhbgJ1OFNeXdc
 kdb02a9ZxCWH1z/kwPHKMFZtd00u3fMnjNVr/nNvUaITap8m
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
callback will be triggered for the bridge and the downstream devices, then
the 'reset_slot' callback for the host bridge will be called to recover the
link. Once that's done, resume message will be broadcasted to the bridge
and the downstream devices indicating successful link recovery.

In case if the AER support is not enabled in the kernel, only the
'reset_slot' callback will be called for each slots as there is no way we
could inform the drivers about link recovery.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.h      | 22 ++++++++++++++++++++++
 drivers/pci/pcie/err.c | 13 ++++++++++++-
 drivers/pci/probe.c    |  7 +++++++
 include/linux/pci.h    |  1 +
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62a3022c8b07a09f212f6888674487..7ea81d596d5f9608237f5897c5c13288d9169207 100644
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
@@ -975,6 +976,27 @@ static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
+static inline void pcie_do_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+	int ret;
+
+	if (!host->reset_slot) {
+		dev_warn(&host->dev, "Missing reset_slot() callback\n");
+		return;
+	}
+
+	for_each_pci_bridge(dev, bus) {
+		ret = host->reset_slot(host, dev);
+		if (ret)
+			dev_err(&host->dev, "failed to reset slot (%s): %d\n",
+				pci_name(dev), ret);
+		else
+			dev_dbg(&host->dev, "recovered slot (%s)\n",
+				pci_name(dev));
+	}
+}
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 77ce9354532afee209f658175b86e625bba8a5ee..0f86c228245ef80c5bba4433c109ec37c57f4a67 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int ret;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -219,7 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
+		if (reset_subordinates && reset_subordinates(bridge) !=
+						PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
@@ -280,3 +282,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+void pcie_do_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+
+	for_each_pci_bridge(dev, bus)
+		pcie_do_recovery(dev, pci_channel_io_frozen, NULL);
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



