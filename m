Return-Path: <linux-pci+bounces-14303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8899A39D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BA61F22520
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F644212F13;
	Fri, 11 Oct 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLHnEHlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172652141CE;
	Fri, 11 Oct 2024 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648875; cv=none; b=jftD0P04S+zr/y34MfaC8Q7ja1g4vxYmYYvKsX717elP+n8kZXb9kuoWGhswgMPaNR4ADsgS7dFTEhs0yjauFVacTbSdOO9VG+kN6MOg9N0Nm1X/ESH0+sGQps4YThj6kxPkUBrdosLDRO0kovuM67cunuIMRT2+rd3U6oP35gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648875; c=relaxed/simple;
	bh=jP3LO0itroOL9qK97CHA3fpmUsI/rZLQkh7ixXovqIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3pBzGPTnJtlkqCCocyhIVPEFI2QY9lUxL/R171VSmlAEg9epBeDIaYXK8EkkReLPJCdZ9zYZb7hkZ1vO2hig6il0j6VhFrts4wNkNvJbCyZu7J+BZrPxmXOWSSrn43vP6JZ6QVkU21C12NoTpQcCIxjLuhjQicyPmUrvQI41Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLHnEHlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7430C4CECF;
	Fri, 11 Oct 2024 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648874;
	bh=jP3LO0itroOL9qK97CHA3fpmUsI/rZLQkh7ixXovqIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLHnEHlCIxTbt/+I+40Zl12jDTkfGL1GkDmEMm9L//Vd7aMKcmNgy6HdyFD68CCFF
	 XcIgfXG30eXzW2KypEH0rnuJ4DQzAfaunLJHCy5cXhvXhK02HHdHozKrNGe2ogtz0e
	 5r8URmqmMR99ax/DHRZDW8teYnXiyG+EtVMdQ5spKWjX/pGBmVEAOz4bf60QfRQSaQ
	 myTVKwm5OaB3NQTZT4LEuslC33H/64omsjR7cZoqdGNF/FcW7rrMMWl558u9jpls2m
	 W4/pfwjMg2BXLLxrlQUKd1/l4lJGIRzW32zIg7vpbyd/0ryQRuEXlP43BL1ALD+x25
	 W0l1BtoYCuvxg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 10/12] PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
Date: Fri, 11 Oct 2024 21:14:06 +0900
Message-ID: <20241011121408.89890-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121408.89890-1-dlemoal@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the EPC operation ->stop() for the Rockchip endpoint driver with
the function rockchip_pcie_ep_stop(). This function disables link
training and the controller configuration, as the reverse to what
the start operation defined with rockchip_pcie_ep_start() does.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 13 +++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 56dd4466cae5..431862a87e04 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -468,6 +468,18 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static void rockchip_pcie_ep_stop(struct pci_epc *epc)
+{
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+
+	/* Stop link training and disable configuration */
+	rockchip_pcie_write(rockchip,
+			    PCIE_CLIENT_CONF_DISABLE |
+			    PCIE_CLIENT_LINK_TRAIN_DISABLE,
+			    PCIE_CLIENT_CONFIG);
+}
+
 static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
@@ -492,6 +504,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_msi	= rockchip_pcie_ep_get_msi,
 	.raise_irq	= rockchip_pcie_ep_raise_irq,
 	.start		= rockchip_pcie_ep_start,
+	.stop		= rockchip_pcie_ep_stop,
 	.get_features	= rockchip_pcie_ep_get_features,
 };
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 30398156095f..0263f158ee8d 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -32,6 +32,7 @@
 #define   PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE_BIT(0x0001)
 #define   PCIE_CLIENT_CONF_DISABLE       HIWORD_UPDATE(0x0001, 0)
 #define   PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_LINK_TRAIN_DISABLE  HIWORD_UPDATE(0x0002, 0)
 #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
 #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
 #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
-- 
2.47.0


