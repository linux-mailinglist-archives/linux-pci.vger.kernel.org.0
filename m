Return-Path: <linux-pci+bounces-14998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B69AA00B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4862873F8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F219ABBB;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SToYvcxf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437619A292;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592882; cv=none; b=B0MqT85F90GXyyNPj9UbxNkD7Pf53WTOS9PKJnWKGzyTXSJY2zYP9ZJKLMVeDS2ihkLXNq5oZnVG6YcXO1iDHT0iqkEtioNXzvM6ZQO1TGozLAvX3NIypRoDGjojskVIw7Y4yfJiMYSdr/V4+Au0IgAg6iBCggDkEMAxvdDgk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592882; c=relaxed/simple;
	bh=01Nb+7M5sXaBv6N3XSYUTbtuO/IWYV2WZrjBElXovog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URHgQYBXM0lUWmGHopJrJXj0TDlyC+PizrHJBKdprwaBQ4YuURQuK8vMkqXQIzNKvFZHWzHy3DdJXgZq6f5MZ9a7heva8muQAwtdYIJoTbb/xQSW6l8VKjL+zzdrWK4a2gjTwR423EacC+Bj46/jf8SFRgYEfarQyk28dsxIdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SToYvcxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 429B8C4CECD;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592882;
	bh=01Nb+7M5sXaBv6N3XSYUTbtuO/IWYV2WZrjBElXovog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SToYvcxfwiEItYylBc0eRpMY68AjUVRz1ZzVG2ztnqFckJgO3nqQrwsESkPpaNDGr
	 Smta6BFCb2d8svnwWFkQogc/6YzZ3cRaaMqC0cs4DetzwlD4nn8tS96N8WopJ9iHnI
	 Tj+s4qa1j9FzF2Gha8g9mt6ZJ+l0HbRS6/m8eESVTgTlRkqULTl47s2Z5Ox8QxvWFG
	 qIC9qPLYxM0FSlrAAcPjYld68NHJu9zevtNDX4uSaVvNzGQb/Z2qezu3DCvb+AdMK+
	 5qSyATemVws3CXizr1Z5V1pmNL1GV+2EVq93t7z4VGBjKiNlvjmSxHoZrQtX5GLNQF
	 ikCOhD/ovOcug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F86D1CDD4;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 22 Oct 2024 15:57:29 +0530
Subject: [PATCH 1/5] PCI/pwrctl: Use of_platform_device_create() to create
 pwrctl devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-pci-pwrctl-rework-v1-1-94a7e90f58c5@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=MGzatbYJniVLg7BZgRAG2FQoP+AtAWyuUZzih9eO9g4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34utpei03sy9L2UxAgWs45Ed1FfiX7hVSSOx
 Q7B8FKTJnCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LgAKCRBVnxHm/pHO
 9WgbB/9jmbynDRZTrQAupCu4BsISZu3OHHosTFflg8Ss3KvfJ86aP1cHNuegSpYBtwXYNIfSHu+
 8+LYfuz9Hot9J+WUzvFtpAi8g8o+tKnOlGhayndJneAInm04GhZRP5elSCtzVObI/c5iKPgk8SC
 /PVJUq+PKZRBxRE62p5IbnY3L1NW+doZ6QXSEtBrEDM5pfhOughejsMbCyNVRdrOBzDyyFigGCS
 mY0ZzLYne//VJ75TLQsdKrZUDvxHwlsg2PEfpaaqUX7q7DgCpqIbPhvKiZzphGS7+8cbm3Ev+vR
 y7OVOizOhxGfe7LKXAZjxaYRSIYwyhgjTDaDkW6mV2IF211A
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

of_platform_populate() API creates platform devices by descending through
the children of the parent node. But it provides no control over the child
nodes, which makes it difficult to add checks for the child nodes in the
future. So use of_platform_device_create() API together with
for_each_child_of_node_scoped() so that it is possible to add checks for
each node before creating the platform device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 55c853686051..959044b059b5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -329,6 +330,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
+	struct platform_device *pdev;
 	int retval;
 
 	/*
@@ -351,11 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_dev_assign_added(dev, true);
 
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
-		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
-					      &dev->dev);
-		if (retval)
-			pci_err(dev, "failed to populate child OF nodes (%d)\n",
-				retval);
+		for_each_child_of_node_scoped(dn, child) {
+			pdev = of_platform_device_create(child, NULL, &dev->dev);
+			if (!pdev)
+				pci_err(dev, "failed to create OF node: %s\n", child->name);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);

-- 
2.25.1



