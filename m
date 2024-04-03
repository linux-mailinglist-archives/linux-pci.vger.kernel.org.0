Return-Path: <linux-pci+bounces-5585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6E89641E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7CB1F226E3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826A50A75;
	Wed,  3 Apr 2024 05:33:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED424CB55;
	Wed,  3 Apr 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122397; cv=none; b=Y0b6gD2BcGwBk/3mUpcnZ2rY0tnI6V/xoRs7vaNVvuyBE1ObXlio63IbzTBUz6pe8Z6DfoWB7VSvsbWXWmfUJRNiO7gwfaG0aB9Z9Pa/oNEHLoZ3vMjglxI3Rek7SGansHHbLA3YjjOc3eiCc1L2vV+r4Z4D+LaRYk9xEZQ/wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122397; c=relaxed/simple;
	bh=he+6NGrhJHI5YonJXCPkU2iB/F89fg/iVTKIZyLwyDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKsGO5kYuw/Yop+cQOHwJPCWJpGhDi2/BI85rEkOnG/Ck7euPePdeVf8Y2TUV0R6z/AetmHTlFEaM1moWlwPaHBiTAJq3kUaz1fc/3bxg3ql/34oT+r0HndcT//3ta3zfBT/LeHisDePQzwuv3FRqWFJhLZRtLG/XLIT4BNkrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="204148822"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2024 14:33:09 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F2E3A40029A6;
	Wed,  3 Apr 2024 14:33:08 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 3/7] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
Date: Wed,  3 Apr 2024 14:33:00 +0900
Message-Id: <20240403053304.3695096-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
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
---
 drivers/pci/controller/dwc/pcie-designware.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..aa4db6eaf02a 100644
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


