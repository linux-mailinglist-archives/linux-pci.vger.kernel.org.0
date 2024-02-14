Return-Path: <linux-pci+bounces-3438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D48548AF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F6728CCC6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2618EB0;
	Wed, 14 Feb 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mgi9IlDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0B1B95C
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911177; cv=none; b=a29jSywR/KDxry4V6X3YclO4EcXXnYbwO/BLTGwkSIbNnmSYMc1ujfwf9ObJN9x9V0oF728DtSn6zpiygryqzp1o026Y46JMauYFSHbB0YthEsk4fo8aIFeCr3LG9rkaXghjQNi6EBFz+JFAOVU3KWMh7vYVwA9yYgVxlr7kSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911177; c=relaxed/simple;
	bh=iaFhux7+ftCQreqL4+9rxGj5oghyh3WmJyVki73C+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z19KWh8/Ra28qFubH/YiaekMzjB581wkOr1g+9lLcaaAdnaFEyi+Qffuu7RZu0qH/sotElYId/NJ9IUB5vLUKYNCtU2OF/JsbatnfC1iHN42DEy3pgWkZ1fKD3+MsUkm6bGAJtY6604CPfUGCuryHuy9VUH8Z2QUem1co0QrqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mgi9IlDT; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59f6f376f91so110486eaf.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911175; x=1708515975; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stU+R4KG+NyQbt4ql0bZhshhmz0bDBsi5UUfG+CKyak=;
        b=Mgi9IlDThPJqe5w4Qu/TPIQC9vhvcSB0iPqI1PeOCHDncgzMm+uoXA8YgU8fX5fCTA
         9l1IBhnL2VxVPR97Ea/vW+0C+/zRdKWBk7WOFACsdGmLzVXh5gmVjALxJrJz6zRsmHWP
         GQW3l8j3FOVdixcvlhTZvXMQ96sV7D7qno3CcXMzqSm2asfEMS4OhY3y1/EajTnmOiM1
         G7qvQp9L3ZLPSoYLTmeGJucVk5FN7Nj5yWriW/wOcjeiVVOjBrVkj7xEBvrpeo90lb26
         buIHoJRGknozEYAeySNURmGUInZ6US0IeTYwMBYzMucFvGPH/p41+boRkXY8BkVjaMQP
         hCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911175; x=1708515975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stU+R4KG+NyQbt4ql0bZhshhmz0bDBsi5UUfG+CKyak=;
        b=GIeOJvS5pEpdGnFw0rh+kNIq2bA/JLY7Sh0rTPgvBZVYzvuPxn0Fknu4aYkJBX8vUg
         97FURb8d9K0ZDiKHB41AYRspgUbd8MvPZFJU8qBHiuz3rEo6Vab+tT20apu6oJnI+9Tz
         qbXXzbb6aYYJXw/EvZ1kaWluoatSbe/9VjK3MKMBzPMZu0zfa6QXRZjg0vrIn/wynhzk
         c6EonHe71uIlRb3cBA+wM+r8mxreD+U6eL0uEu6i2PLQcY7sudTUA63ZfO6LCFaJWmjd
         XOUB18WJ5hkH7S+8qOm53hrTS4K4j8H071xqgwj1gjoWyYjQ7ncXlwPlONUA4OX+mOEZ
         2cVg==
X-Forwarded-Encrypted: i=1; AJvYcCVBBWxLfv91On1inJb4yRQA0NH0xStxJSzSlCDn51uetWvqFhjstJPIhGass9Wb0Q88e7AzUlB9wGGxl3hQriSheRnzSaF1gRaS
X-Gm-Message-State: AOJu0Yw82QwHVhRiNXRJ2Quh1xUaeCHPxq4plk3J7xMBKKSMJLeOO7Mm
	8NsdRGWbxELws7eJFmZEkymg2CG4EL9Qe0EpqLV36vWjfLC8LVUQk6MaiGiwoQ==
X-Google-Smtp-Source: AGHT+IExOXztcpJuZehy39qkAgIJjMeLNBIE1g7Y0XjwPk1GFEOHTHyOZ8MtrSFaaWBsuecca5y8PQ==
X-Received: by 2002:a05:6358:b00d:b0:176:40d5:2bd5 with SMTP id l13-20020a056358b00d00b0017640d52bd5mr2310044rwn.6.1707911174688;
        Wed, 14 Feb 2024 03:46:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT9B6A1cp+QOKPZkvk+EwZp++YLu3rcZe5XHi3LJPDwegVbg5YoQNUr/IRQzOR4W/UNqypDIlwKgEsy1WfzcUeEUUDoNmPd6wFJNhdGMVJ7vDtUmaogh1BNAj+ebpQ8Uz6qxK4NBfQLVKH1AC3ef/HMZDk5yj43xW9zn+yJ7d37oM1EZPpmNDamtf33G8ZhlQEJVgFvbKLmMe5MY7ZGD8XSFXYmPV93t8Q8kQJH/8Lgkf89yLGVqEMFpZQvLjvBAubk84IpYZPqNvH5WMoHre1Pn0kDY+PTdYAz/LLFwynQKg9QZ4FdmfB3HBbFWIK1LQrHqv19JjObAfB3JKFnzrc+Mzzsrwf4mTr1FJsrRI+ZjUgLnDxeZNlbfe/GRFNhy49k57ljD0YhGwLvgsNDY51wmEBi8AraTrrT4h7JSMb2LKFLQDO43LIhw==
Received: from [127.0.1.1] ([103.28.246.124])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b006e0d1e6036bsm6674283pfg.129.2024.02.14.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:46:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 14 Feb 2024 17:16:09 +0530
Subject: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAACozGUC/3WOQQ6CMBBFr2K6tqbTIi2uvIdh0dICkyjF1hAN4
 e4WdIEJLv+fvPdnJNEFdJGcdiMJbsCIvktB7HekanXXOIo2ZcIZzxgIoH2Fjt4rf6MmoE13kyv
 GdSEl04IkrA+uxueivJQptxgfPryWhQHm9iPjbEM2AGW0dk4W0tTmyOT5ip0O/uBDM8u/JP9DZ
 rmVUhVK5BVbk/MfA19tQ7Zh4BRoYW1ujQGj4Ge7nKbpDWmfCRotAQAA
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, quic_krichai@quicinc.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3809;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=iaFhux7+ftCQreqL4+9rxGj5oghyh3WmJyVki73C+Bc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlzKgCyomV+XS6Wz5pwRsl7Pq4qvnDSmu3D+FVx
 gggOTH/97qJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZcyoAgAKCRBVnxHm/pHO
 9R9nB/9dmzL8gNylVCHcQQfkMcfyzrnKwuvQ6ASSQ3DXHhdDWw08KgwxD3Cfm2G0GLZo08Mj+me
 hoIqviztRLCA/stpX3XDSqhoOlbECFUuWumoXrdjWd6JskL5rhljSyu7ol51qEkD/9NpmfolqIJ
 S+Al6CQJP6OluE7WZI1vtTCMHLJ+cF/bicicceBSerjNdIh6/ziBvs9yhytrODKmS3bvBvN5bwV
 ogNqJLvo5Qxb2MDslQNdwKQZhF5/JlONMqQbmB+5RTY/ltCESJ7kIYq/u9xwBBm3OucAMZGPYZJ
 VGflmQpHGohZagBRbBwV2grEKa5LnPHdZ831PQWQD0vzUcf/
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, PCI core will enable D3 support for PCI bridges only when the
following conditions are met:

1. Platform is ACPI based
2. Thunderbolt controller is used
3. pcie_port_pm=force passed in cmdline

While options 1 and 2 do not apply to most of the DT based platforms,
option 3 will make the life harder for distro maintainers. Due to this,
runtime PM is also not getting enabled for the bridges.

To fix this, let's make use of the "supports-d3" property [1] in the bridge
DT nodes to enable D3 support for the capable bridges. This will also allow
the capable bridges to support runtime PM, thereby conserving power.

Ideally, D3 support should be enabled by default for the more recent PCI
bridges, but we do not have a sane way to detect them.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
This patch is tested on Qcom SM8450 based development board with an out-of-tree
DT patch.

NOTE: I will submit the DT patches adding this property for applicable bridges
in Qcom SoCs separately.

Changes in v3:
- Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
- Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org

Changes in v2:
- Switched to DT based approach as suggested by Lukas.
- Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
---
 drivers/pci/of.c  | 12 ++++++++++++
 drivers/pci/pci.c |  3 +++
 drivers/pci/pci.h |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..24b0107802af 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+/**
+ * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
+ *
+ * @node: device tree node of the bridge
+ *
+ * Return: %true if the bridge is supporting D3 states, %false otherwise.
+ */
+bool of_pci_bridge_d3(struct device_node *node)
+{
+	return of_property_present(node, "supports-d3");
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..8678fba092bb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	if (pci_use_mid_pm())
 		return false;
 
+	if (dev_of_node(&dev->dev))
+		return of_pci_bridge_d3(dev->dev.of_node);
+
 	return acpi_pci_bridge_d3(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..10387461b1fe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
+bool of_pci_bridge_d3(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
+static inline bool of_pci_bridge_d3(struct device_node *node)
+{
+	return false;
+}
+
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-pcie-qcom-bridge-b6802a9770a3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


