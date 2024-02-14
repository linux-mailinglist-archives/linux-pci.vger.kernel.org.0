Return-Path: <linux-pci+bounces-3432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BE854441
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D6B21B3C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E27475;
	Wed, 14 Feb 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNAL7XDr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C706FD5
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900530; cv=none; b=eMdM73bggLuWw2ECBXL+1yuha0pTwDjqRStalEhgHUg8RWMz4YB/oFX9BajKnh3xdcVEjEq5zMdvP7QIzpJjwMpVPTCJ4V5SI++MMWCa6pA6vJhFTCj3hjkm3aXu96Q59W16M1mYJMkEjC7JuDmzP2QM0io2YfR0xoD6n/O76Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900530; c=relaxed/simple;
	bh=TwT82vyqx3budLWaWyEGG1wI/RIEzRBWQO73BeFdsz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=adgjy36GsiXdUvnX8F8WPIIYxy6CVn29loYJnbUteQYkfUZQDSdhJOc0FpiQyRMJrZjQ+oxcATtL1XtYxhx9Y83SBaD66KusvzpPsgx89K4LMMw+fnrrXhL2asuTaN0IQVYeh0FvzoSWyLw/r+m0eGPWVLUlLVWXsErUkIHQvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNAL7XDr; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c031776e0cso3063817b6e.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707900528; x=1708505328; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2QsMDmGqJoWMPmHJHJyeqK54LlDoNHzofHmtYahPTk=;
        b=WNAL7XDr0EYyQF9RrSavbFEOgP8Uo2Y207vifbvDUW1idYVmnH/5MMCWd/1rfD0TBl
         UoRDorjqHFHqkgc8zAwD+2QguVwv0+8iZ3tn057/wc8fkG3MLIsUfSACVYoST6kfWA/s
         tOq7+mGT1PGkSdkt+eSBab/2S4dpFNoQbrnN2ZGstV7rByE1WRYx91bKxFZESxuRgsIo
         S2VAjk3sgptQStGoFRS9G18YH7UQy5r2s4HFG9Mu7C/8eh8QEfYz08g4fMnRhJOpgyPT
         l0Xbc7S/ONqETidFlrOjSmB0WDGOpvw90WPo05xlzVeN9/Wm3s6+6AwS9dm/osofGYz/
         rSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900528; x=1708505328;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2QsMDmGqJoWMPmHJHJyeqK54LlDoNHzofHmtYahPTk=;
        b=tfvWfcS90YkqAVkhDEe379LpGc1g6y7GbK69lnVACnnhS2+TCqhWJQ6QKYGDYedsMu
         YeKkrx36+hFUYxIb8faCa5IGxp561QmTfNW7MOIYzInXN0LYYNvIKpxaF7M0OhCqyebq
         QpzzskPtTyP1B9b8hP/PV/q7IVEnnhJInmuThfvNIVmW+ZYGxRR5S8aR7njN8I2T0Hz3
         IZiQyqaY7GeHyaMLjbvw8X7gGn1TG71koHcNOhwvAi0+6JIr8X6HBZOl8GZRv7FddB8f
         NpBn/IceBH4pA0sVY11GjziqdXSnAMHNDhUQoezWkr+KxK7Q0+x3UZnhtvfOb5oQs74i
         BfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEDQxPtoxE1xaPt+rHnmsZyOqZelo2XYw1NVxhAWwbhXMqVIF1+1JX92KHwsgBeW9wbp/N3Z5havULnn7S2VvrkBR3Ic0FWPui
X-Gm-Message-State: AOJu0Yx0+x9V8Vp0c5sxyLLsnPegu8K60x3S/dYK56YLxGUZcMm/r2Fn
	Hb9wjxVkq9RGC9Mtr5wQsSqH/mzrGsMqU9q4abGCRykDtlrdlxjIvYgoylHzHA==
X-Google-Smtp-Source: AGHT+IFwjTGyw6+J8VkJeGhXkMVcUp3EjQE3wIXUE+lfEWHEM6SNVtQiA4t/Nz+7yUvWhM1KHJa6Ig==
X-Received: by 2002:a05:6808:2f08:b0:3c0:32ad:7427 with SMTP id gu8-20020a0568082f0800b003c032ad7427mr3257111oib.2.1707900528270;
        Wed, 14 Feb 2024 00:48:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtvfKVRwyS0Hzu7uI50q1HD48nWKnoDs88DD2wvLSKCnsi/CquqM0RS7EJlq437jjmd05CPo51+1g84uFgM61mIlSywO9KVPcp1Z5VpBBPJLIvj/JVoTJWAI7IAEbK6moui2VbziQcVSxu/lkwe/FN40VVjcvkBq9IREsDeGENGGqByzg/iUgWyD/29KGFF3KI8heebzu7TXjMF4Jnf1fa0IFRFk94CKGbsncDA15t2EPojhYG3RYrkCEnJtLDADHoC2xeskXMPjHvUYOpl1z9Vm06SfcWQGEZlihNaC5v9s6LT2QDsqXF1ovCitP01GY3Yf+GYE3GZarGZ1JCjsBTBBo6zbca8iiuq/8E8/BSy0Vf1UYr9ZIK7RFS2NG3nAnbNw1WFiqwJDnVMqmgUFkfdQlag9kG169/iXaXIsXohWE4X52XsgszBA==
Received: from [127.0.1.1] ([103.28.246.124])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b006dda103efe6sm6083930pfb.167.2024.02.14.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:48:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 14 Feb 2024 14:18:31 +0530
Subject: [PATCH v2] PCI: Add D3 support for PCI bridges in DT based
 platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF5+zGUC/3WNQQ6CMBBFr0K6tmbaIgVX3sOwaMsAkyjF1hAN4
 e4WdOFCl+9P3puZRQyEkR2zmQWcKJIfEshdxlxvhg45NYmZBJmDUIKPjpDfnL9yG6hJd1uUIE2
 lNRjFkjYGbOmxJc914p7i3Yfn9mES6/qOSfgRmwQH3iLqStvWHkCfLjSY4Pc+dGv8Y8o/Zl40W
 pdVqQoH32a9LMsL2QkzsesAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=TwT82vyqx3budLWaWyEGG1wI/RIEzRBWQO73BeFdsz4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlzH5sGhjF7J1FtVOKJx9eRXLfbFkb5+6yag7MX
 OOkW60PAhyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZcx+bAAKCRBVnxHm/pHO
 9VuIB/98qb1C2T1l8XOGquybgU2brNTm+9pRP8Vxy5BH8+tiSMtGprtKXvWLjFtQPDdar3OgpL0
 5qarp886xtZHtNGk9lOxayzaJG5tbD8KfHBvehbn469Qqg8s+vlW0qlDFLMPiPjd1Ek5uPU0BAK
 gpqf7A0dIMciJps7ig/5DS0rZWv8KXw0nXl6zPZhpOx+FVkHsw6QUb8AM1N52yg3aU9IsSRI3O+
 NTfNw4WW8IyfPddqXUpM0kZZ2iflPZw2KSnRqj7e2h/iM+wrnaLoB+xuOu42m5L/fXoCUSvrSKk
 NOXPIhckauJNyaPkTwptDaLWAxiAnmmZhwrzlTClBzzMKdor
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

Changes in v2:
- Switched to DT based approach as suggested by Lukas.
- Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
---
 drivers/pci/of.c  | 12 ++++++++++++
 drivers/pci/pci.c |  3 +++
 drivers/pci/pci.h |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..77dc14a3c91d 100644
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
+ * Return: True if the bridge is supporting D3 states, False otherwise.
+ */
+bool of_pci_bridge_d3(struct device_node *node)
+{
+	return of_property_read_bool(node, "supports-d3");
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..3309c45b656c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	if (pci_use_mid_pm())
 		return false;
 
+	if (dev->dev.of_node)
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


