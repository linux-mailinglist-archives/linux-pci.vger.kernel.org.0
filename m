Return-Path: <linux-pci+bounces-15000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9639AA00E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC99B23756
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9C19ABCE;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd42zyw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3819AA72;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592882; cv=none; b=eYg/SMTawTgYN0a/F7Utm7Kc9QRQqcs9TKEEdkGrlR6tDyWr4YlEkzZP/A+wjRNKxn/W+EhKXZWrRy4CY9TZtoddEZa5a856fu3QM3BwQejBWjrF+o3/Nern99Sk6blb5y31a6Ds2RoU0qeFRSIWssT7Tv6jsfd5WmFwQWeq1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592882; c=relaxed/simple;
	bh=o3IZO0OTXROleL/1SbqdS0nrBWIejoK+UE07q4umg6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5DykM5FjR6wSySg1skuVUsVMoIofIp3HSwwGAngjSUDNQ3GzXzp2yt+RBXNo5JNpVgyC4D5ICEhrj+VdW81Coikld0WUnDqZ7Tt98k4vwM44HXipkaRr17NUdk8MKIh7+j8CZwc4HURJa3yJpdz8+2bxUwXroHzB69sB95Y3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd42zyw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57673C4CEE7;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592882;
	bh=o3IZO0OTXROleL/1SbqdS0nrBWIejoK+UE07q4umg6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fd42zyw6s67xQ4Wt9wJdAZjbepFC0AAJthXVvSQRdDXwdrWd7RZdqD1Pi1lrunKzv
	 CrtzuxEalm6SGRILvcu7k7UjDYEGtbefqQy9tvG9T8ttnaZoL0GsTG+h5sn1TXFRJF
	 bi9WsapAPVHrjOEyNwxBnE5fNARTDrqReh8xdB8L0QQ3OId1qliv96tVieKu6htWv2
	 dAMWOIbHsSpe3TMo72wmfV9v52u/RNCeERrOr2YCF96AQqoGgMYCT1kgk00gmQqsUQ
	 8o6Aegej+OTSarTCcSr+laL5Zkw+9ZkV+ol3QpLvdDOdEke5USegBVzrzDQJB7+atO
	 jG0bYrPcFJzRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B2D1CDD7;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 22 Oct 2024 15:57:30 +0530
Subject: [PATCH 2/5] PCI/pwrctl: Create pwrctl devices only if at least one
 power supply is present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-pci-pwrctl-rework-v1-2-94a7e90f58c5@linaro.org>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3545;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=oJ/OQynblPqFLnYyBuZFpwZHxzKNTbVvMhdHbuUg+mY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34u3E/YNcybcWcET91/0zg1s6CUet/6wi8CR
 JW3UcOvPZyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LgAKCRBVnxHm/pHO
 9UcbB/4yGoMHkD92oNUaj+8WGeH746ttw23Q7vNQytniw26Mb69OFcezMMNT3JkpJY2EWD/UbD/
 K+PDVrZzh8BcIEhwtrnLjDJTqDOKlyRpx55VsuPEUhMTpLTAP0EUQVQSvL2C7g2yMM77D3BE5Ey
 TufCOoBlv5L6MkXJNymktzhuKZgddElRRTaWCRW38PQg5jCNReQw8E7At2nJufuBhfiSIABQEaI
 yHmDKr0Ajx1brh+KXfOGBRTj/UBnPyRtUB4kXaERCzYNITzIQncSyxOckpPpsxiBulW5XZRMrZN
 GrqlkfA7majXF1wBmU9sBCczx5Wxhd7KUCJmyaxJ8R7PB93Z
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, pwrctl devices are created if the corresponding PCI nodes are
defined in devicetree. But this is not correct, because not all PCI nodes
defined in devicetree require pwrctl support. Pwrctl comes into picture
only when the device requires kernel to manage its power state. This can
be determined using the power supply properties present in the devicetree
node of the device.

So add a new API, of_pci_is_supply_present() that checks the devicetree
node if at least one power supply property is present or not. If present,
then the pwrctl device will be created for that PCI node. Otherwise, it
will be skipped.

Cc: stable+noautosel@kernel.org # Depends on of_platform_device_create() rework
Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 11 +++++++++++
 drivers/pci/of.c  | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 959044b059b5..698ec98b9388 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -354,6 +354,17 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		for_each_child_of_node_scoped(dn, child) {
+			/*
+			 * First check whether the pwrctl device needs to be
+			 * created or not. This is decided based on at least
+			 * one of the power supplies being defined in the
+			 * devicetree node of the device.
+			 */
+			if (!of_pci_is_supply_present(child)) {
+				pci_dbg(dev, "skipping OF node: %s\n", child->name);
+				continue;
+			}
+
 			pdev = of_platform_device_create(child, NULL, &dev->dev);
 			if (!pdev)
 				pci_err(dev, "failed to create OF node: %s\n", child->name);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..1f6a15a35a82 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -728,6 +728,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 }
 #endif
 
+/**
+ * of_pci_is_supply_present() - Check if the power supply is present for the PCI
+ *				device
+ * @np: Device tree node
+ *
+ * Check if the power supply for the PCI device is present in the device tree
+ * node or not.
+ *
+ * Return: true if at least one power supply exists; false otherwise.
+ */
+bool of_pci_is_supply_present(struct device_node *np)
+{
+	struct property *prop;
+	char *supply;
+
+	if (!np)
+		return false;
+
+	for_each_property_of_node(np, prop) {
+		supply = strrchr(prop->name, '-');
+		if (supply && !strcmp(supply, "-supply"))
+			return true;
+	}
+
+	return false;
+}
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..c8081b427267 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -746,6 +746,7 @@ void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
+bool of_pci_is_supply_present(struct device_node *np);
 
 #else
 static inline int
@@ -793,6 +794,10 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static inline bool of_pci_is_supply_present(struct device_node *np);
+{
+	return false;
+}
 #endif /* CONFIG_OF */
 
 struct of_changeset;

-- 
2.25.1



