Return-Path: <linux-pci+bounces-31375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CAAF704F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FA1897DC9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7A2EA728;
	Thu,  3 Jul 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJiSWJHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A642E54A3;
	Thu,  3 Jul 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538447; cv=none; b=ZbpMzcmynzOtPxLlrXNjTdHIZyt1R3Q+3xLPDwhAHhfn4M1jtGBhgyslBLcKngzMtc6nJ9zehQNhpWRImTL+j3cyjZ1VV+FpgRzGEFYLajs8KCHimgZDSl+f1UedI0fZ8Up1/b3dSVOpcgwLQYifY1UzNvHkNzs5gO2uOx+UVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538447; c=relaxed/simple;
	bh=DChQwWXvs3tE8B+jpm3p7q+cSXi9YVq9StAkRX8XLr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiD3jXqEod94sIqrudgDlgoC8WOV4w3MmbbglbGV6ILrI8Sc6HgOzFw2tKFre0v8NLKzx4PlbsmLfhlws3SgdF1srVbKoQjpOMMGng+vzU+6Y+54NmYxHdcAn/5MEGNpywp2hyw1KIPM1Xprkyd1ZAFlxeiHRekWGAPprjWeXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJiSWJHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B21C4CEE3;
	Thu,  3 Jul 2025 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538447;
	bh=DChQwWXvs3tE8B+jpm3p7q+cSXi9YVq9StAkRX8XLr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJiSWJHbV0OO0RGsSqGg8xwEU7oc30gH/MunHTuNLIT2ezbdIi4/y9UnFvOUpijKm
	 9XnhyhhdtUub0PitHfrLibSPJAQqKJVvsCZZXcmxtk5CZl2oIIAjKt1osi8dVHYpVf
	 g9PRlwpO3+U8nD/3E2C8YpCzYZtO6h2o/mPwSr19idZynLNJXsnj9BZnLoiPVA2Oib
	 YfH1rXbp0MsotBDTRJyBHkZI3Q+qwyOJPhmFOBdnWGWCPzbMbYj+aeNpHm9e3WyDG6
	 MlDt28xttTeY5I1sjEh+ArAweZgBJYl+AOZMQfNIFwLjobmVP89sKhVPbB8CudI6X3
	 meMA7p9anJBHg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:14 +0200
Subject: [PATCH v7 24/31] of/irq: Add of_msi_xlate() helper function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

Add an of_msi_xlate() helper that maps a device ID and returns
the device node of the MSI controller the device ID is mapped to.

Required by core functions that need an MSI controller device node
pointer at the same time as a mapped device ID, of_msi_map_id() is not
sufficient for that purpose.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 22 +++++++++++++++++-----
 include/linux/of_irq.h |  5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b9b1c9..74aaea61de13 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -670,8 +670,20 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
-static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
-			    u32 id_in)
+/**
+ * of_msi_xlate - map a MSI ID and find relevant MSI controller node
+ * @dev: device for which the mapping is to be done.
+ * @msi_np: Pointer to store the MSI controller node
+ * @id_in: Device ID.
+ *
+ * Walk up the device hierarchy looking for devices with a "msi-map"
+ * property. If found, apply the mapping to @id_in. @msi_np pointed
+ * value must be NULL on entry, if an MSI controller is found @msi_np is
+ * initialized to the MSI controller node with a reference held.
+ *
+ * Returns: The mapped MSI id.
+ */
+u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 {
 	struct device *parent_dev;
 	u32 id_out = id_in;
@@ -682,7 +694,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
 		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
-				"msi-map-mask", np, &id_out))
+				"msi-map-mask", msi_np, &id_out))
 			break;
 	return id_out;
 }
@@ -700,7 +712,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
  */
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
-	return __of_msi_map_id(dev, &msi_np, id_in);
+	return of_msi_xlate(dev, &msi_np, id_in);
 }
 
 /**
@@ -719,7 +731,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
 {
 	struct device_node *np = NULL;
 
-	__of_msi_map_id(dev, &np, id);
+	of_msi_xlate(dev, &np, id);
 	return irq_find_matching_host(np, bus_token);
 }
 
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 6337ad4e5fe8..a480063c9cb1 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -54,6 +54,7 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 id,
 							u32 bus_token);
 extern void of_msi_configure(struct device *dev, const struct device_node *np);
+extern u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)
@@ -100,6 +101,10 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
 static inline void of_msi_configure(struct device *dev, struct device_node *np)
 {
 }
+static inline u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
+{
+	return id_in;
+}
 static inline u32 of_msi_map_id(struct device *dev,
 				 struct device_node *msi_np, u32 id_in)
 {

-- 
2.48.0


