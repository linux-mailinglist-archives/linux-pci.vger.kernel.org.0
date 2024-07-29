Return-Path: <linux-pci+bounces-10934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379593F121
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAB81F22B2B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD5142E6F;
	Mon, 29 Jul 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ptnM+vYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4B13B7BE;
	Mon, 29 Jul 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245363; cv=none; b=XOeUTLUrBY3avF6EKUc6dmeMt3qY+3bWPDl1r7EUPzOoYsJ9W5FzbCL+ZhMcRXuDaZx8Uing4WfN8OoLDJjleBBvuMDMbqlBH/K4TnmQNhbDKZSUR5MsQovmWwfN05986BFbjnB+T93Vm5PzhWzHd3Nis9UGcIt9NsTP+MDBqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245363; c=relaxed/simple;
	bh=wxDXeJ/5FDwKLYNsZJ0UJ/CJu8TaQjVD0XHpl0xYpFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN9gGGF+jBwXJCA6f8tmthy9lIKWxxSLX5w+GGP2Eq4up/HsCrI+Mg68pgZ5VbYVyZKyvdlSthhykqKlGRSipq7iMo6Jje1yzWSqsFzhDUofI+QJmvl+7wd07x7BM8NgrmjtzchoFmF0d2w4zxChilwBW2FkQAPb8j32SO2cgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ptnM+vYC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T9TAFq025699;
	Mon, 29 Jul 2024 04:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722245351;
	bh=j0A5DuPXCW8kIo64gE9NE0q15LdOr6ia0mr3YO2tDiE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ptnM+vYCSP3W5J4ergRrCNVP2ogB73Urza0NPpwrqElM1a7ITx2Mb/yyr3/ULlax8
	 Ibsw1DK99iseGHjYsgB+6h8N/VjN0Tm0CEZ0YvS9JuiJaRBc6AvChlMPbQnrninAf1
	 atdgdZ4dqyyLMwpN2kyLlpfanfvdHFa21GTgAioc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T9TAsA025888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 04:29:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 04:29:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 04:29:10 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T9Stc7087068;
	Mon, 29 Jul 2024 04:29:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
Date: Mon, 29 Jul 2024 14:58:55 +0530
Message-ID: <20240729092855.1945700-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240729092855.1945700-1-s-vadapalli@ti.com>
References: <20240729092855.1945700-1-s-vadapalli@ti.com>
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

Add support to enable the ACSPCIE reference clock output using the optional
device-tree property "ti,syscon-acspcie-proxy-ctrl".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://lore.kernel.org/r/20240715120936.1150314-4-s-vadapalli@ti.com/
Changes since v1:
- Addressed Bjorn's feedback at:
  https://lore.kernel.org/r/20240725211841.GA859405@bhelgaas/
  with the following changes:
  1) Updated $subject and commit message to indicate that this patch
  enables ACSPCIE reference clock output if the DT property is present.
  2) Updated macro and comments to indicate that the BITS correspond to
  disabling ACSPCIE output, due to which clearing them enables the
  reference clock output.
  3) Replaced "PAD" with "refclk" both in the function name and in the
  error prints.
  4) Wrapped lines to be within the 80 character limit to match the rest
  of the driver.

 drivers/pci/controller/cadence/pci-j721e.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..ed42b2229483 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -44,6 +44,7 @@ enum link_status {
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 struct j721e_pcie {
@@ -220,6 +221,34 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	return ret;
 }
 
+static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
+				       struct regmap *syscon)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node,
+					       "ti,syscon-acspcie-proxy-ctrl",
+					       1, 0, &args);
+	if (!ret) {
+		/* Clear PAD IO disable bits to enable refclk output */
+		val = ~(args.args[0]);
+		ret = regmap_update_bits(syscon, 0, mask, val);
+		if (ret)
+			dev_err(dev, "failed to enable ACSPCIE refclk: %d\n",
+				ret);
+	} else {
+		dev_err(dev,
+			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
+	}
+
+	return ret;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -259,6 +288,15 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	/* Enable ACSPCIE refclk output if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node,
+						"ti,syscon-acspcie-proxy-ctrl");
+	if (syscon) {
+		ret = j721e_enable_acspcie_refclk(pcie, syscon);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.40.1


