Return-Path: <linux-pci+bounces-15273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8519AFB92
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F53B21533
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143671C07FC;
	Fri, 25 Oct 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haN3NeWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB941C07DA;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842903; cv=none; b=MWvyLUonFWJN1tG53d0/FSkRz9eUEKwDm7EcFPKLoobI/OQwBP3fVMzf3tcHX8ECvgCVx1JPYgCQvtSz/nu54uG7nK1WwEtn1uEie3SRX4whInC2gG0uSJgz4vPHPhsYA7NLdmY64U00n2xvPjyBB2YVQe5Vjkf8+YvgrtqypIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842903; c=relaxed/simple;
	bh=NQ0rYXvCzXCekz1zJkqr8dXaO2BDwBfsvs5WWor/i3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKaXc+QHNSOj84hSTJDT+LR8FlO/7ZTFJAWUwcY48It31jcRW5U7XNNlvqZpUSbxIVkNuLIQs29iv8VI0Zx5nu97onHrrzwAjgMRFIadb8PaNwB6Cye9prWycGMlwGTDeUc0Jg7eArKjXKUnhdAdoq1XmdG+ZAr2bbas9PY2ods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haN3NeWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 804BBC4CECC;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=NQ0rYXvCzXCekz1zJkqr8dXaO2BDwBfsvs5WWor/i3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=haN3NeWkxQXnd5zuCrz3Tc7Wl+AbRT99BBZYH2r3mwOjRhLB1sM9akvxgbf06hMmI
	 OxYV4nfBJ3o3DQ31LOY0CQoJm/9oP0axIUbvkwt0o1O1ChU+jxGplf0P6LCklGN61q
	 4Vdr+Q601MEdlZxESdhM5ZVWQAePhIQgfc6rh1rUfY38BppAvAGdP3LxoRaNWCYw5h
	 cvv+cfL9sKLXx8VkgC/O3rbL/uUblBCAF2RFzZsHONRo4XYGzyQZ7njzO68Ev+SCjW
	 /8YxdiyfGVD8/qkB02sSJIsjG7+NqVTIE9w4LdpNKUZwbgqIRoz+E6u4AHYaLqUOPm
	 R3vL83fV4fdpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBBD11718;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 25 Oct 2024 13:24:52 +0530
Subject: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at least
 one power supply is present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org>
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 stable+noautosel@kernel.org, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3752;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=0FY5vkiC5PpJEJdcjgkvaOcvdHuhyY/wQ5scqIVPEeI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07TayXM1r3dwqeQe2GSxL/SytuTklHNyH5pt
 7HB3USY6AyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO0wAKCRBVnxHm/pHO
 9Y88B/497DHOm4It5o4WYHFiLBngDSxzYRtGuIsLZVRYRMesmVZ7k0bDjGTfZXXgUh6/g7/7n3D
 6pF1bfl7YhKap9GGdHg9pYOwXWOr/LdSlIlqZvrZkqvv9/Fq9ZS/sw+rNGY95KwRVxMJOjna1FB
 aQV2oJiBRtSEwZ320MRM4tUtun1tvoc3069jLRxc3yk18R+8EbBAhYNrho9lR14QYJZ1TDteqgv
 Y+7rPkAPJg1gMchKQHKYPesRBlBK/dF/5HLxTalhJSw1UgyvInX2J2nuvSSQ/LwmHA3zFDYI6oe
 OBvS7S7/rezgxFKOtnuuMIK0wXUEGpaiB6yrEtvRCiiT+stG
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 11 +++++++++++
 drivers/pci/of.c  | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9d278d3a19ff..02a492aa5f17 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -354,6 +354,17 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		for_each_available_child_of_node_scoped(dn, child) {
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



