Return-Path: <linux-pci+bounces-27054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245BFAA598A
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 03:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7346F9A151D
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4522DFAF;
	Thu,  1 May 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEBzk1/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034822E3F0;
	Thu,  1 May 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746064680; cv=none; b=oUzkhBpfW3nabqh4B4P+WbLuM+kZXwUn4wqMCynQ9FpIzmxMlWzHNHnoVyoL4ElZuXczweKNE6RT96NkkzzCt+gpyaxedI9fkSpiI/+1JM3nswTQ6/fhWlP1a8xLbhRCO9JBnHIveKT/NOcZQNYpHUZIRlpkFhoto85yow9E8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746064680; c=relaxed/simple;
	bh=/Ah4B3NAr+Kc927n6CgMEs8gtOCzYDo9eWib5uzVPDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ozjt7GbSCaEUUQx36Ny31q7ohS22nWEwK8NxXDQJkEHLC9xrd/zIJyYoNDVEND7OUuHUXwWEfaVXwNiUCIc3ZUfi3G679cbXgRKCXIhqLkorw2BC2RdwePaTK0boUnEUSzvNGHlXrWrff//jWKBlnIpyl7qSZSuQ3CNfcHqbFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEBzk1/T; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af59c920d32so338961a12.0;
        Wed, 30 Apr 2025 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746064678; x=1746669478; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3HdnQQ7Lh7tqptK4W9tkQbnlg3dmorsc2Pl8mD4q/M=;
        b=HEBzk1/TLOMP3NoyIG1eGG6uGbdf/ixPuUupqC1Imwi2aeLBqC0tK6M9kzDGe5xWh6
         4Ww3MQREaghEa0BdSUghQBrXM3o+7ptBJvu09B57bysevz7gwkygo6+0cWitbiAwRKkb
         1Y9Q/1uR6VAqfb2svfowHhadRGi8dXU+MHJV6OB8URi61SPQ+jVekH3Jld7pC85el2Vx
         PhGRPcse22CX+ClynwXOktph3UR04yb2py7VmL0fXdua75RmQYdR9IfEbV9bRxwK4pMO
         yp3J3ycUB9j0KGLmVqsc8k46jM/wYMJ01+Yu0C0p1wfT4WoWdr16ZQD1mkfXbIsPUZ52
         urXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746064678; x=1746669478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3HdnQQ7Lh7tqptK4W9tkQbnlg3dmorsc2Pl8mD4q/M=;
        b=HqMofHR0IIa9CMh8IXoZvUZyoil8CoXbnLSEs2QHsd12yyV/D2+Pj8kNG1qsP84Hhl
         +Fk18SjA7GsPOgkYLA+CIa1DECreccCSafDZdZFZekdIr7NWiipxsrs8ixYnmg+58XD2
         6t3uKg5uhp5CC/JU299+Y+XeXUv6DlDy8cWJe8qdNESxwLCxW+0gURDy2mM5def5zqK9
         Vhq58sOKLGpaHjJqWrzyhBe9i4fhKg+TbORXJb8UR/Hph5bQc52Wl2Q0buzKCw6v0EjL
         HcQ+ymvuvRVwCX20HGUlhyLLtL+ZfWc8bACjlrgmpNwYESWErtnwmCuRf+0G5z9BxjRJ
         H+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVFKp0hx/iJBjfPdDrB7VFO/0DOYVb54p/PrDhx19ZHFsIpR0iV0GpzzKcYnBCK96KcBbdS0rXG+Eal+r0=@vger.kernel.org, AJvYcCWNxvGoInWuM1it7FTAuwODzx43mzwEuv3zxF8yTC8FrSbs5JBLpsVPC+vChWXN2rXJxxtv9Lq/EL9L@vger.kernel.org
X-Gm-Message-State: AOJu0Yya28jq/yqLjijAsQ63I+anBYtFcQ6t608ONOULqCvCqCUylvky
	WMkYXEI4UkTDIhMbhPTs+JNL2/Kk0WdwdEOkRXhbzsNqBgXChmFx
X-Gm-Gg: ASbGncvjrQangqcbnYnhXjQ9z4yHcM9Ik4Mx2/O96DEXVmgv5/NREom9xx0tal02rBL
	OO7wXEhre9DWuWJwj5ZGk+446SKf1/aun8bvx90P2OO0jXRYVO14iaFMcixMxAoEEs8g9Gmt4yw
	94/wo/yPZbTzZF9NZ4RJHvbyBtWsLAWNIQt/hIqhN0kNK16FS5+M2INSJMdgcPCEueAKCPt2nTV
	yd1YykzpzY3F9QYgJc19SJTBARv+RnWp1anXjXD3WBcTa/YbYrC0rpvkSN4jOxWNAERKkwfy9S0
	TQQC6O5xOfTFi1carTlFAs77rPZQ3h4cooQK4edzLWXp/E1k9bhNfFk=
X-Google-Smtp-Source: AGHT+IF2WAQ6u6BUakZzN4fH3Qie907SR8WIaTRHAciW0cHWcMbgl7LsGYCK5MbNO946abRXqL8u9A==
X-Received: by 2002:a17:90b:578b:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-30a41cfc306mr1391942a91.3.1746064677565;
        Wed, 30 Apr 2025 18:57:57 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480ea0dsm2405977a91.37.2025.04.30.18.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 18:57:56 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
Date: Thu, 01 May 2025 11:57:39 +1000
Subject: [PATCH v2] PCI: dwc: Add support for slot reset on link down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com>
X-B4-Tracking: v=1; b=H4sIABPVEmgC/4XPTW7DIBAF4KtYsy4VBmOwV71HFVn8DA1SE1wgT
 qPIdw8hm+66fGh4880dMqaAGebuDgm3kEM818DeOrBHff5CElzNwCgTdOCUmIGsNizuapeEGcu
 SL+saUyFOMuqM9kaihvp9TejDb6v+PLxywp9L3VBej2B0RmLj6RTK3FElOadKGTGORiimuKe+Z
 7WOe+HMqCc9OeQU/soqtLloQyFpIpK/YyGSU+O17HWdmDcOT8Ix5BLTrR279c3w/11bT3riRzH
 oZ9/ExMfV2ffKhsO+7w9/6N5AQQEAAA==
X-Change-ID: 20250430-b4-pci_dwc_reset_support-d720dbafb7ea
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746064672; l=7785;
 i=wilfred.mallawa@wdc.com; s=20250430; h=from:subject:message-id;
 bh=fQbwUUTN1gpul4279z5HHNPBrxwyTc+m4i94uBkh6VE=;
 b=7NSdJlp2U95ab1vI4/p/BCj6VkXTEmSaUc41LRhFtY64AYcBWmncQYGWuEogibsCLEgxrjoN5
 9wV/Fc4Sa0RDLtSAo+g5gDBtuxIOeI0fQPAWLSBcOTHYi8tQfdAdPKT
X-Developer-Key: i=wilfred.mallawa@wdc.com; a=ed25519;
 pk=DpjNSsEpzUYRunwCxBmAJ/fv9YKUmAPOIoBDL0qeAQU=

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

The PCIe link may go down in cases like firmware crashes or unstable
connections. When this occurs, the PCIe slot must be reset to restore
functionality. However, the current driver lacks link down handling,
forcing users to reboot the system to recover.

This patch implements the `reset_slot` callback for link down handling
for DWC PCIe host controller. In which, the RC is reset, reconfigured
and link training initiated to recover from the link down event.

This patch by extension fixes issues with sysfs initiated bus resets.
In that, currently, when a sysfs initiated bus reset is issued, the
endpoint device is non-functional after (may link up with downgraded link
status). With this patch adding support for link down recovery, a sysfs
initiated bus reset works as intended. Testing conducted on a ROCK5B board
with an M.2 NVMe drive.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
Hey all,

This patch builds ontop of [1] to extend the reset slot support for the
DWC PCIe host controller. Which implements link down recovery support
for the DesignWare PCIe host controller by adding a `reset_slot` callback.
This allows the system to recover from PCIe link failures without requiring a reboot.

This patch by extension improves the behavior of sysfs-initiated bus resets.
Previously, a `reset` issued via sysfs could leave the endpoint in a
non-functional state or with downgraded link parameters. With the added
link down recovery logic, sysfs resets now result in a properly reinitialized
and fully functional endpoint device. This issue was discovered on a
Rock5B board, and thus testing was also conducted on the same platform
with a known good M.2 NVMe drive.

Thanks!

[1] https://lore.kernel.org/all/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org/
---
Changes in v2:
- In the reset_slot callback, use clk_bulk_disable_unprepare() to
  disable clks.
- If dw_pcie_start_link() fails, goto deinit procedure
- Skip error checking for dw_pcie_wait_for_link(), as the link may come
  up later.
- Fixup alignment.
- Link to v1: https://lore.kernel.org/r/20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com
---
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 88 ++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..878c52de0842e32ca50dfcc4b66231a73ef436c4 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -347,6 +347,7 @@ config PCIE_ROCKCHIP_DW_HOST
 	depends on OF
 	select PCIE_DW_HOST
 	select PCIE_ROCKCHIP_DW
+	select PCI_HOST_COMMON
 	help
 	  Enables support for the DesignWare PCIe controller in the
 	  Rockchip SoC (except RK3399) to work in host mode.
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3c6ab71c996ec1246954f52a9454c8ae67956a54..9e68761fd6d106a6e2bf14635b6d19d53cb019b9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -23,6 +23,8 @@
 #include <linux/reset.h>
 
 #include "pcie-designware.h"
+#include "../../pci.h"
+#include "../pci-host-common.h"
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
@@ -83,6 +85,9 @@ struct rockchip_pcie_of_data {
 	const struct pci_epc_features *epc_features;
 };
 
+static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
+				       struct pci_dev *pdev);
+
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
@@ -256,6 +261,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 					 rockchip);
 
 	rockchip_pcie_enable_l0s(pci);
+	pp->bridge->reset_slot = rockchip_pcie_rc_reset_slot;
 
 	return 0;
 }
@@ -455,6 +461,11 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
 	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
 
+	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
+		dev_dbg(dev, "hot reset or link-down reset\n");
+		pci_host_handle_link_down(pp->bridge);
+	}
+
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
@@ -536,8 +547,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* unmask DLL up/down indicator */
-	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
+	/* unmask DLL up/down indicator and hot reset/link-down reset irq */
+	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
 	return ret;
@@ -688,6 +699,79 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
+				       struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
+	u32 val;
+	int ret;
+
+	dw_pcie_stop_link(pci);
+	rockchip_pcie_phy_deinit(rockchip);
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+
+	ret = reset_control_assert(rockchip->rst);
+	if (ret)
+		return ret;
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret)
+		goto disable_regulator;
+
+	ret = reset_control_deassert(rockchip->rst);
+	if (ret)
+		goto deinit_phy;
+
+	ret = rockchip_pcie_clk_init(rockchip);
+	if (ret)
+		goto deinit_phy;
+
+	ret = pp->ops->init(pp);
+	if (ret) {
+		dev_err(dev, "Host init failed: %d\n", ret);
+		goto deinit_clk;
+	}
+
+	/* LTSSM enable control mode */
+	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret) {
+		dev_err(dev, "Failed to setup RC: %d\n", ret);
+		goto deinit_clk;
+	}
+
+	/* unmask DLL up/down indicator and hot reset/link-down reset irq */
+	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		goto deinit_clk;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
+	dev_dbg(dev, "Slot reset completed\n");
+	return ret;
+
+deinit_clk:
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+deinit_phy:
+	rockchip_pcie_phy_deinit(rockchip);
+disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };

---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250430-b4-pci_dwc_reset_support-d720dbafb7ea
prerequisite-change-id: 20250404-pcie-reset-slot-730bfa71a202:v3
prerequisite-patch-id: 2dad85eb26838d89569b12c19d70f392fa592667
prerequisite-patch-id: 6238a682bd8e9476e5911b7a59263c3fc618d63e
prerequisite-patch-id: a01300083e94a67ea7c8bfcde320081d90b384d4
prerequisite-patch-id: ff711f65cf9926374646b76cd38bdd823d576764
prerequisite-patch-id: a5ee9d4b728b80d32844c5108a5b453eaa4f653f

Best regards,
-- 
Wilfred Mallawa <wilfred.mallawa@wdc.com>


