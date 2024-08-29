Return-Path: <linux-pci+bounces-12425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE6964259
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 12:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AF1C24853
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD58191496;
	Thu, 29 Aug 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EDlQzT32"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54419148D;
	Thu, 29 Aug 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928827; cv=none; b=o3gw17x5tbT4jRcz6SBCbD45JMfgU8hLvq5VdPUx4YHSqES8QbMhfdAQO+lcdy306dZ3/almj/UXwN2a4HGVP1zFNOmVuEsEu+1wufrh//i5N+MeyF6MPEPJk9WlQp+UxfUo1TcdXUrxRHQ1qGkgx3Hei62fluZG1HYMHaCxgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928827; c=relaxed/simple;
	bh=W+d9Jim0nEEIZkLVc5JOyipYeC6MdWhZ9+Fm9Fk3Q5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP9LvFEHXWtiDA4Ri7XUwsx9FU5Xjr/wBkcxVfU/N1IoNoaOklecaY34tlxfgf/D0RPb8sJ+nHX/50JYtJMSfGIVEuvayN+EhLGn1TEpYU1/p924KXb13+3KOp8i2VXL4tgExRj7ru7q99TeeSKBnOKOuNsyo2/DAk9XlMr/b0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EDlQzT32; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TArVR3026554;
	Thu, 29 Aug 2024 05:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724928811;
	bh=8hOk9PuXGBpXAe2XkNZFCwoENS4wBkLV7iENTvnk1I4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EDlQzT32Mz6oq9+jtgsZgmL9v+wcg96oHj9WDJ8XE6URUq1dMZpG39PGrHVx49EaK
	 Wmdam/9N2SMNL9iYcE7WZfqARpPZO95UZI+RUsno2P48IbMd9W6fEzV9ieYyKd1575
	 7LE2O15zToL+A7z4jU6eAFBdONh8H6bAWkd1bV8Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TArUEs081129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 05:53:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 05:53:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 05:53:30 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TArHpT070385;
	Thu, 29 Aug 2024 05:53:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 2/2] PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
Date: Thu, 29 Aug 2024 16:23:16 +0530
Message-ID: <20240829105316.1483684-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829105316.1483684-1-s-vadapalli@ti.com>
References: <20240829105316.1483684-1-s-vadapalli@ti.com>
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

v3:
https://lore.kernel.org/r/20240827055548.901285-3-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20240829.
- Addressed Bjorn's feedback at:
  https://lore.kernel.org/r/20240828211906.GA38267@bhelgaas/
  with the following changes:
  1) Updated the implementation of j721e_enable_acspcie_refclk() by
  reducing the nested IF conditions to make it easier to read.
  2) Updated the section invoking j721e_enable_acspcie_refclk() within
  j721e_pcie_ctrl_init() by returning 0 if "ti,syscon-acspcie-proxy-ctrl"
  isn't present and returning j721e_enable_acspcie_refclk() otherwise.

v2:
https://lore.kernel.org/r/20240729092855.1945700-3-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20240826.

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

 drivers/pci/controller/cadence/pci-j721e.c | 39 +++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..7f7732e2dcaa 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -44,6 +44,7 @@ enum link_status {
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 struct j721e_pcie {
@@ -220,6 +221,36 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
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
+	if (ret) {
+		dev_err(dev,
+			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
+		return ret;
+	}
+
+	/* Clear PAD IO disable bits to enable refclk output */
+	val = ~(args.args[0]);
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -259,7 +290,13 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
-	return 0;
+	/* Enable ACSPCIE refclk output if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node,
+						"ti,syscon-acspcie-proxy-ctrl");
+	if (!syscon)
+		return 0;
+
+	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
 
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
-- 
2.40.1


