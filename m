Return-Path: <linux-pci+bounces-10259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6979313AE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C0C281C6F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310818A958;
	Mon, 15 Jul 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PM9bN5nW"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CC18A94D;
	Mon, 15 Jul 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045426; cv=none; b=gcC/SnJ24fjxxmP+CWWbHw1/8Mo5QCwHYjyN/I1QShWJLZAcrn50p1kaFvysH003tn1SmAe90JWBD9loEz4Ef84d2cp6xvcDd6jGrTtwe3I7M0x3lKTwHKjnt6lKQp11qAdII/zlDN5KFv6F4GIvr7ZjjVHGoN1pAyvoZTjoTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045426; c=relaxed/simple;
	bh=v3553iIgcc42jQYcQ+pstZfsr9CSKDdUoEVW71SEanM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=likf+CGWT/wceqVRp8BAEnsJjRptf8uXumNMnDPQAcoYQKg/K15omHqHuVnZ7eu65SIvSIywdoR7jxammV65znKd7dCa6Wa82cdmMfW0DodnSsD8IPIIaNb5UeT0h5KzGE7Vr2QEm+VbhBiYEk9D4KLYxFTRTJS5Vo2dt7bjnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PM9bN5nW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9uJn128448;
	Mon, 15 Jul 2024 07:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721045396;
	bh=ghvzRkFVMnN78k4235eqbUPodO5QMcK9davRELJsKEI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PM9bN5nWM5kuQ00txO1vEO1EbCFOBkRJpzS8t31wgjiUhe8H7BbLBK20m8fpFlCKM
	 VMnubsFt7dLROD+sdZGi5dV/CoXTI7Ob30Eb+rv7dbe6eYHUAm01YNssDSqTlZkLYo
	 XLk5C1V8fu1OfTS2C8tRu2xcFGfuShDtFzsMwXM8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FC9u3X107180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 07:09:56 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 07:09:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 07:09:55 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9anY060344;
	Mon, 15 Jul 2024 07:09:51 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/3] PCI: j721e: Add support for enabling ACSPCIE PAD IO Buffer output
Date: Mon, 15 Jul 2024 17:39:36 +0530
Message-ID: <20240715120936.1150314-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715120936.1150314-1-s-vadapalli@ti.com>
References: <20240715120936.1150314-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The ACSPCIE module is capable of driving the reference clock required by
the PCIe Endpoint device. It is an alternative to on-board and external
reference clock generators. Enabling the output from the ACSPCIE module's
PAD IO Buffers requires clearing the "PAD IO disable" bits of the
ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..2fa0eff68a8a 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -44,6 +44,7 @@ enum link_status {
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_ENABLE_MASK		GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 struct j721e_pcie {
@@ -220,6 +221,30 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	return ret;
 }
 
+static int j721e_acspcie_pad_enable(struct j721e_pcie *pcie, struct regmap *syscon)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	u32 mask = ACSPCIE_PAD_ENABLE_MASK;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-acspcie-proxy-ctrl",
+					       1, 0, &args);
+	if (!ret) {
+		/* PAD Enable Bits have to be cleared to in order to enable output */
+		val = ~(args.args[0]);
+		ret = regmap_update_bits(syscon, 0, mask, val);
+		if (ret)
+			dev_err(dev, "Enabling ACSPCIE PAD output failed: %d\n", ret);
+	} else {
+		dev_err(dev, "ti,syscon-acspcie-proxy-ctrl has invalid parameters\n");
+	}
+
+	return ret;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -259,6 +284,14 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	/* Enable ACSPCIe PAD IO Buffers if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node, "ti,syscon-acspcie-proxy-ctrl");
+	if (syscon) {
+		ret = j721e_acspcie_pad_enable(pcie, syscon);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.40.1


