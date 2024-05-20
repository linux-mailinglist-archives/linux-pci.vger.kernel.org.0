Return-Path: <linux-pci+bounces-7648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696C8C9980
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886331C21027
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D618E1F;
	Mon, 20 May 2024 07:48:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634D17BB7;
	Mon, 20 May 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716191295; cv=none; b=civd4ru2md5Z0rRd4jrP3Z5o8zKJLWwp4MBxgwJ1Cye0M7N4R3fR2UFpGKX1u6TuUrVaB9arWyTb70I16yqPsp1hlJXYv5ycS2mEdzZI39kstq8khYuEwartwclLakJPNBY/HfLCTsJDIc3GoJ2Mz4JscIJxqEDSSz2BpffGvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716191295; c=relaxed/simple;
	bh=Wus5ztxg2Fes61KWp+gSdjO9QTU7mb8kYvG/fmzgTVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcKmml46eZeef3ly8q/Wl50SCCIrvlKAkLIZc/RlOrQxPt7pFkVRLcvs6bLB2X9wMSafj1BiY1HeOgV5Xm+KwD5OOs1UpGEGrGp3WuBNLVUYhMXckMz9829JU0cGC38s3/jRgbyBOUdllW7wx3tL/NtaMNZFdh0Ik7H3+qpa7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,174,1712588400"; 
   d="scan'208";a="205072511"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 May 2024 16:43:04 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7CB0C4005658;
	Mon, 20 May 2024 16:43:04 +0900 (JST)
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 1/5] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
Date: Mon, 20 May 2024 16:42:56 +0900
Message-Id: <20240520074300.125969-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
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


