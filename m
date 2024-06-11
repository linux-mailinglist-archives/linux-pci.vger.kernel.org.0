Return-Path: <linux-pci+bounces-8583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A14E903C37
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244F91F23077
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEDC17C20C;
	Tue, 11 Jun 2024 12:51:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287817C7C1;
	Tue, 11 Jun 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110272; cv=none; b=OMGvvryq5JhfoXpTMg7S2o+18YVdw1B1FeIB4shrjLdf/hjFXf5jrOjwAmh/hRfRpUvd/O+Vv60Nn9XG6y3Rvx+LaAsoTX3dqr2wAonFy//KQ3WoXYrqyZefX0xunAGiAzxcNK7uzbbsSS+opIJ7wX0V2yJxw6DjUjgbb5gN4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110272; c=relaxed/simple;
	bh=SAhdUcQyx4M0ikiUUTlwYdbBi13RV1HjHO5Kne+MxiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkhJeVBYEmKuCVKPZSwk0n3YJ+vC+ZJoqJPaEMlmZuEl8ZNGZkmmII4QTI6jOkSIfdy1TqwHbiW8VlURabEBkZyj/kAY66GDXHBBtZfBy7BUsDu916Wl+uj8XyIQ8YQHuq9fn5iJ2g5/9g8QNTPv3MZrX1Km/dYmZ80kEbepmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,230,1712588400"; 
   d="scan'208";a="211455260"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jun 2024 21:51:06 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3CB740104E9;
	Tue, 11 Jun 2024 21:51:05 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 1/5] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
Date: Tue, 11 Jun 2024 21:50:53 +0900
Message-Id: <20240611125057.1232873-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen4 PCIe controller needs to use the Synopsys-specific PCIe
configuration registers. So, add the macros.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..0476f9b6186b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -71,6 +71,9 @@
 #define LINK_WAIT_IATU			9
 
 /* Synopsys-specific PCIe configuration registers */
+#define PCIE_PORT_FORCE			0x708
+#define PORT_FORCE_DO_DESKEW_FOR_SRIS	BIT(23)
+
 #define PCIE_PORT_AFR			0x70C
 #define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
 #define PORT_AFR_N_FTS(n)		FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
@@ -92,6 +95,9 @@
 #define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
 #define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
 
+#define PCIE_PORT_LANE_SKEW		0x714
+#define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
+
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
-- 
2.25.1


