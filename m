Return-Path: <linux-pci+bounces-27470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43BAB07EF
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2060E3B3997
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690C4B1E5C;
	Fri,  9 May 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ5ZA2JM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CA1CF96;
	Fri,  9 May 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757827; cv=none; b=GTJGnQUfA5rCmuQkc6SLgcyrkBL5AFzXPkbCeLV0p1Ea0Qa28qQLamKNwO9ZSjfZ+FyuNh5anVL5o4ygGzItHaqEfOJFApUA9GDuaRvdCaRZPPKRqLveK0P8KoLdeK7iOIOvB2ZadR2u9qwtTZylRtF4RSfsGe3BYbLjp3Hqowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757827; c=relaxed/simple;
	bh=B5yV1kC5XCKbV/KL9F/NuhFBqBNJbnVkOPP9wL0QsV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o74YjQYxCNsTskom7MiPXIUdlWBXUGfimTYwTanKzRkA99FPxQWded3i30D51WfZlvXicpm9oc3vvt74jOx4SPMezZAoLObq8+NBxABAFStO6pqLdHTo37SqtcwyDBn2vjSMQIUJ8BEwRyaOe9BKI+Y8WcSfpF+KQ6/5PhrnNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ5ZA2JM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fcf9cf3c2so2452745ad.0;
        Thu, 08 May 2025 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746757825; x=1747362625; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayNz8xbJGSHoOUDc3h0sfGxA9EOkAoi9Fqia99FoZh8=;
        b=CQ5ZA2JMfzCoym+Wk+JVQAtz92QGyAaosWnss4q8JNWGpAEeXXUpOgMQ30nYNL+WkE
         /T6Dd0tgc0aMFzcgQjYdpCq9CGJ+8sdy5xCx+bFhcdPAeVOTUh110ov9R+UHF1HRNyEO
         F/HyDIPy9oW1ocmMOYpfaUlmfkmq3jbssbrIkBhpogdyb9FdeEl5Vm4sufBvVjAmZUHd
         vEMektnA96ixpRdGpyi7VIB9/O1YclHK3W2+s8Ugi1WZecQgeCJhQUm0qZJiRVWvjDrD
         Ynca2HIC4iROj1ny7+ngdPcwrCM/BCVmeldXQO0frAJdPlVPrAYVMAmquAYtKlGh4wKa
         0Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746757825; x=1747362625;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayNz8xbJGSHoOUDc3h0sfGxA9EOkAoi9Fqia99FoZh8=;
        b=LUw4/8L6rinFXKhkp0MZ2fllFuvnVBU/zylQYuFykquhWKXY28iSDZzXmdqRWcTDQq
         aauiIQzRbI1dzx7dO6s+0d+06+qfvkKPQuWQ1K/vBeZ+8hsntT2mQjGCs1Uaq2TE+nLu
         NqoH/1n/4h2Ips1S1KPjc6BTBeyPom3ouXV+vrb6rI2f8ajqbHsqscahiFkYMBxgT66k
         az1bzVjQ8p9yku/HuzRdDoQ0cdPaw14rIUtSN8a2vD2Zsn7rDJAY+05oV89QGHEpRh3j
         tjGCav7IEDvtmeFjxE1Gt5T87QyE+fguR6AjRUO6BJVQhDMGv+nF/w+d+XsrWvt6ZNMy
         K5aA==
X-Forwarded-Encrypted: i=1; AJvYcCUghkM+l9qwsxVT32G2jbq/FIhaOdPPZ9lqOLGsIIRbs/T775s4DHs2wLKOoxUWcD/4Bs1dwnLcIut5@vger.kernel.org, AJvYcCXVU7TDkHdE9xb3tRwxNzD7V4Q59Xtpd+GgWVj4jcmlY0/9mdx/1i73vleiuwjfEz7weSbKJgFwm5VgCaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oZmm97fIUueSL3ac6HGnV9BbXWhv844IWhDak7DN/KlH0nMv
	+N3/Gc4RezWthBnOcPgrjtEqPspweDupvtFgHVviGAIV/yMfXNIo
X-Gm-Gg: ASbGnctWl0TOw5x32yE1AITzxmQYiXwGJzNjD6ltCBqkf8DLXpVvlJoDCHR35WUtp0r
	T5jjwsT/Z4iA4G1/WkjNF+pfQODdkTmQ/xx20nSfrEW4MyIE/l7HXnnnF+c6z4tnx9pBjwm7Ju1
	k47AnJopuOOKLJrbh6IYEVnhyGXylRjbmQV1xWOYV0gs+khoLL2oPD/0HHkktlUm+qZ0SggSW5R
	j5ydkQtd+PyYt2Sqzw1llNR2rvxB48n68dvQXsZO4IiS++1qkpjw4OHnah49Gi4o23VEb8uXZzy
	Tb+dZzfvsV4RuT1zOw9rP2kAsB+QVQwXZMLm4kzs+amIHSprnceFnzo=
X-Google-Smtp-Source: AGHT+IHUihWhsBv2QvUM6cAvRwFIrobhLw88ajBtO87cz3YL19YzISXaSRhyFjxbTS9vW/T7d+TUdQ==
X-Received: by 2002:a17:902:ecc7:b0:22e:7c8b:7e66 with SMTP id d9443c01a7336-22fc8c7b4c1mr22897415ad.26.1746757825141;
        Thu, 08 May 2025 19:30:25 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540ca4sm7097145ad.52.2025.05.08.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 19:30:24 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
Date: Fri, 09 May 2025 12:30:12 +1000
Subject: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
X-B4-Tracking: v=1; b=H4sIALRoHWgC/4WPy07DMBBFfyXyGqPxK06y4j8QivwYU0u0Cbabg
 qr8O667KCtY3tHMmXOvJGOKmMnUXUnCLea4nGoQTx1xB3N6Rxp9zYQDVyAFUCvp6uLsL25OmLH
 M+byuSyrUaw7emmA1GlLP14QhfjX069s9J/w81w/lPiTWZKRuOR5jmToYtBAwDFb1vVUDH0SAw
 HjFiaC87c1oRo8CyG+zqbt7QZNC2oxo/lgK1QJsMJqZujFtktwUDjGXJX23shtrDv/32hhlNPR
 Kmhtv5Orl4t1z1W7IjT8wCtgfGF4xvh8ZN5Zp6eQDs+/7D8+bqLqIAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746757819; l=8117;
 i=wilfred.mallawa@wdc.com; s=20250430; h=from:subject:message-id;
 bh=+V/tDzibuaj38Gy6kM40dIFHAZUrMXDXAper3/mIQWo=;
 b=jV1M3gxcKKLam0lXxXfe4PHOLCsaW5UvrjFbfWb+aqkJ6ApwzZUs4Nhz+lDUtm/tmULGxDAJk
 Ht4v5t2vUOqCV17oWp+gMCBKE2xyPP//253xA36Zhw/X0k8AHAb6y18
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

[1] https://lore.kernel.org/linux-pci/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org/T/#t
---
Changes in v3:
- Update the rockchip_pcie_rc_reset_slot() initial deinit sequence such
  that it is the reverse of the subsequent init sequence.
- Rebased and tested on the latest V4 from Manivannan Sadhasivam [1].
- Link to v2: https://lore.kernel.org/r/20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com

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
index 3c6ab71c996ec1246954f52a9454c8ae67956a54..714cad40657afe5a6025a8c9ff0e0ab79f1dc1dd 100644
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
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
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
prerequisite-change-id: 20250404-pcie-reset-slot-730bfa71a202:v4
prerequisite-patch-id: 2dad85eb26838d89569b12c19d70f392fa592667
prerequisite-patch-id: 6238a682bd8e9476e5911b7a59263c3fc618d63e
prerequisite-patch-id: 37cab00bc255a62b1e8396a48a3afba5e1751abd
prerequisite-patch-id: ff711f65cf9926374646b76cd38bdd823d576764
prerequisite-patch-id: 1654cca919d024b9a9190b28e90f722975c797e8

Best regards,
-- 
Wilfred Mallawa <wilfred.mallawa@wdc.com>


