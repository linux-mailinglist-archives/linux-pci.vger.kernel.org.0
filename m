Return-Path: <linux-pci+bounces-5991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAC89E72A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 02:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589E41F2234A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AFD1FAA;
	Wed, 10 Apr 2024 00:48:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194D910E3;
	Wed, 10 Apr 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710128; cv=none; b=AXcgt2APtNVJXVGrKFIvKFU3UxVEi3GrBo3zah/358Qfr3EW6Vmy2+HMtLT0lEWmmpHlaE1259JwfMYthLoOO1qV7+1nucOc15UWhnOFb+rK4naA6bCIYiux0glaHGVkhlCQLUzvWY7AWXkQcNFzqlsyK26Y5Ty9dSrrjxgD8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710128; c=relaxed/simple;
	bh=he+6NGrhJHI5YonJXCPkU2iB/F89fg/iVTKIZyLwyDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJ9FLwFprBPznpSA474r1CmLt+nrMmzzx2u8tbgDiKQUOr0dT1Zmj0qyGBwmDHZdzpfZHj2EQyl2WlT1cjABPmWHrWw8xzyJIzRseOHK55MrtK4p6A2vSlb7PfCopQrxcFDNr/HU6bVT+KAcxIlikxl8zIcTwDhatBfElLJMzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; 
   d="scan'208";a="200918518"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Apr 2024 09:48:36 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A0451400CF08;
	Wed, 10 Apr 2024 09:48:36 +0900 (JST)
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
Subject: [PATCH v6 3/7] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
Date: Wed, 10 Apr 2024 09:48:28 +0900
Message-Id: <20240410004832.3726922-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
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


