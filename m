Return-Path: <linux-pci+bounces-30732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF9AE9B6F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39B716894A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82E26B2A9;
	Thu, 26 Jun 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaSTU0ON"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9825B2E8;
	Thu, 26 Jun 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933714; cv=none; b=Mgf0NzVhYQG1BuRkohgj86yy5UiVupsFay96z/0fYq3PxaEWTEhQaBLZ1e9Cc4uqIRItqNrWSiONNSWpi9/I/hKLvj98Aya7xx7N6PX4hApA5tGG1ShqUrV8L2oC3eJGIIjF34gLYK6G8qS1S+ICAwj4sU1J0pAxaRw/eCXTpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933714; c=relaxed/simple;
	bh=eRi7cgKtm7Hi83Dms6X9G6hUMNMcr8aq7kDLX+cs8k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMYQysQLBHr8EaoH2ntsyE9sHh5lsAZmT8+WixK4jpV+3+V+zDkweKJunp7IHeZuZa0ju34UjOfYwqrmU+whM8OlXDVQMUPUAdpulCnauSmQcuID/Yvo3kDsmkrt8N5g9c20lF66WE3XrjLBPFssu7Pu3dYy2v85Y8iQ5xIUGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaSTU0ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A67CC4CEEE;
	Thu, 26 Jun 2025 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933714;
	bh=eRi7cgKtm7Hi83Dms6X9G6hUMNMcr8aq7kDLX+cs8k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AaSTU0ON63d9u0kaKt7uvaiiDvjwqzapfYhPLgKPC4AW8OUwqHD142e6btpx8cWh4
	 71fhZ+yEiNG0Ok3FtJ3fkQCq2lX3h4e9KH+kyTqoymEffcgIbSBc4YvydG95JPgaKN
	 OEwHvBYhS8HA2OJFVnya4sOqznGBiif6OKuwBXQmEU/ffjn7udFVpq6CDq+vOVgnaM
	 NZ5vTSH33BI6QdCPZAbBGnUhPkq1Bwntzh1iLD4/epMPj2yKD7hmI+34LSyrlFW4HM
	 GjZKx3uMmdPo3N9RLO7VFwL/2GK6ZIaqeSWiKFXly9YzjxR4rgz7/gTcI+x5u4Hsj+
	 CWSdRLAmXbXlA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:15 +0200
Subject: [PATCH v6 24/31] of/irq: Add of_msi_xlate() helper function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-24-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
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


