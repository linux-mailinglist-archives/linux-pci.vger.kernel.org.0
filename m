Return-Path: <linux-pci+bounces-27028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3AAA443B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DBB1BA7D75
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA8204F9C;
	Wed, 30 Apr 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnHt92+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D81EA7F1;
	Wed, 30 Apr 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999062; cv=none; b=NLJMKWT2ISupcFwVCOFQ/iP0sprNOkgsBDCkeTj8e04B0H99NsMv+tSifVNsUPcResq9cmXPaPt3svghWZgIFm4uRGmDs8bRHZlLMIR1KNG+pQLPX+sYAbkqSfMKaeAsPeIG+Gadl3j2WQlHL2Z1Uq2sr04QJBvkBIkuqijmUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999062; c=relaxed/simple;
	bh=Ldw9+JIs2VadCmgGdhJYNkZUOfEJZqed92VMp+S4NLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UrYKfduQ3/kUkU+sE5XzrJYE2q/D4R8nkJiB4ABLCLVdZJJeorNEqEbYhyUUkF8yNmyhaLK7qinlrRAlbR8CR+A0/fiNZApPuOcawh7sJE6fFKl42AFOiPrxYnx89PISeWiUE42K6zwQhb8Y0O6ij7ikssdZyLLbKZSrvGg0FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnHt92+P; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso6987010b3a.2;
        Wed, 30 Apr 2025 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745999057; x=1746603857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrESOHG0sLCCbiiaT25hID1gO0oTlv+4VenA0x68Mew=;
        b=HnHt92+PfnJhQ7xwdfAIMQ8E2HWnuU1GybxCZ0iFXtmo/4rGWH5acvFegfB4bNmyWo
         RPSqUVQ6pA/idLLTOk0iJoTlXjknT2jNc0s7CWWrisCTJDIhFnFZq55w3ym798GPsRq7
         oAz4M42Jkh+2ctaDkn9aIZRwEeZLoRXCfXbUxN5+TENdWkcPcWRACToETXB4O3Pc++59
         UwOfjisliMB5aTst3rFbN+6+U2wMAW+7fIvdi/H9kJR2kyyzTfAaTeEUzxPZznWkDP7p
         cxuxvwPi05lrQATboFRrusMGNHO50EMfQFAuCzuXCtpo2ewlaLeDDrvfyGzPxaPDbcWy
         4z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999057; x=1746603857;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrESOHG0sLCCbiiaT25hID1gO0oTlv+4VenA0x68Mew=;
        b=wqkU7jjEtM5UiC9xbmX7qhGYr/fojGr9x4RDY4iyliUVMOWxymaxM6O2UtEHGbhpoW
         VzdaAVp9G8lSFCvoiXxN1uMvNwIbqtcswvZrYTLa1Drrn5mfxC8f7h4Z0xmubluzQ/yO
         RpfjLhjqCiFHROPASSTWu1u/mAUk1zr8R/ReUYDuf8DaHh+QM1cNe564gvT30UWPNMNi
         yKgk+daUbB5965VJwrgSbZqLPfHtxp1JWbwU946NMLhM6HQj3aCrhose/hqiLeHr6L3n
         yVPg5PgBdHoOoP8io6oLRmHJVDSb0eI49v2TUPTZfKdQQP9rgI/ZUd12BZX+Lxpfx53i
         Sgkg==
X-Forwarded-Encrypted: i=1; AJvYcCW99WBlhctL0Yvi35HJ6fOCFUoHCqKM+qKJwUqSc3O2OeoMnPk+XlOG5smAblkTBiWlixXycZxr32R0Ayo=@vger.kernel.org, AJvYcCX5df4kl5/0B1j827+tULeppv/tuLBis+zzk5ToH0xqZxmBzgZUVUm+31XmJH2jgnyV0NP3dRw2FlC4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpo4QXdyDg0WlfHZV+AI6Jpb7hRam4jky5AvYebQtD9/gvLf4B
	9Lg8GgRBDTm/zH0IlKiU+6hSDF2XXimiRObIpAqZK8mkZ1IDqv61
X-Gm-Gg: ASbGncskFCgkfpa+nu3v0ZUsUrhBhqmdIGuENjnQ17IYbYeI3tQ3m3RK6gva6wbr54Q
	ZJbGX+acEaJLni43AvRPw1Rm5IUKIcpyqBsAJRHRK4teLUF7iV8ng/KQatdvwJu6LnniCSTkRbJ
	4Kj6M2E4Y47bTfpJXfZsP6g9juTSw/oUTK3ssMSSSKUwfq7uKl+Qytz/9J7nZyy/8fvrqgvVHDW
	+zL7ZT5vOS9hNGgtLr7phXR9iHQ7eo5cJZj5IsS1u6oeJD8o99wnoQRHMNSCXNt5BKVzZpWQ/Zn
	WbVxZ5+v1s0AJjmMTUbKyLQ0Rt1WTbGut13C/GNUkcvhes4I/1AigW6g92Z7attr4Q==
X-Google-Smtp-Source: AGHT+IF06NW1ClQUAO/SIEO6133O5k9N280oeUAGSpUbGow1VaGJ774XRxZ1c6pEdx19wXl+cXkOKw==
X-Received: by 2002:a05:6a21:139b:b0:1f5:82ae:69d1 with SMTP id adf61e73a8af0-20a8832fa04mr2672867637.20.1745999057268;
        Wed, 30 Apr 2025 00:44:17 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a94780sm976673b3a.168.2025.04.30.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:44:16 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
Date: Wed, 30 Apr 2025 17:43:51 +1000
Subject: [PATCH] PCI: dwc: Add support for slot reset on link down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>
X-B4-Tracking: v=1; b=H4sIALbUEWgC/02OQQ6DIBBFr2JmXZIRVNCrNMaADC1JWy2gbWK8e
 4luunyTP/+/DSIFTxG6YoNAq49+emUoLwWMd/26EfM2M3DkNVYCmanYPPrBfsYhUKQ0xGWep5C
 YlRyt0c5I0pDf50DOf4/qa39yoPeSF9J5BKMjsXF6Pn3qClRSCFTK1E1jasWVcOhKnuuEq61pd
 KtbSwLh36wrTi88pIgdRiw+psSkQOO0LHVOdKuAft9/ChD0vO0AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745999051; l=7327;
 i=wilfred.mallawa@wdc.com; s=20250430; h=from:subject:message-id;
 bh=NUb75iKsIETzPGTbAEgEuTM/+CXDTu6qPlclj4TgXHQ=;
 b=lNZp+VJHmjh4wYkVkCS7+XbaMTYDvOO1JXAzciWZJrGbWA2jT1JmIEe2qeFc5hOAqdkdfc+MR
 jdUAhikEGktDHEnC2cs0nkW4VAttUzdLO6eSHTNLHSss8fAQzrrvwqC
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
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 89 ++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

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
index 3c6ab71c996ec1246954f52a9454c8ae67956a54..4c2c683d170f19266e1dfe0efde76d6feb23bf7a 100644
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
@@ -688,6 +699,80 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
+				  struct pci_dev *pdev)
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
+		return ret;
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		return ret;
+
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


