Return-Path: <linux-pci+bounces-12242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F12C96013C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB741C2196F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D8145348;
	Tue, 27 Aug 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="el/kp47H"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E645028;
	Tue, 27 Aug 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738175; cv=none; b=J2YM6NJqvcXajbEcGpT0/fHjnJDWDHHaw+ebepkcXAJXpnWSLr75KTVOtPthrpejzL6iEfDla20hOV+5hugfRepXfb4Af0iIB1GTDa8RFpKsSO4o8tZxhnEPBAW+kR+bR+2SjWAhHmkAEkz3L5ZQBhSeKXOLIq1ItjPSBe8LbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738175; c=relaxed/simple;
	bh=o4PUkT1ndfyiYg9yUNMhnRNcUI0/Err8UUsboDfP/c8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7i/sJp3EAOkUAui2ekXJ1RMfZeSMAHO9AZvSwA9Ihn8UoxO2rPoseBKpnWQREFoDZcOuFuPGg/RYamFHRQveR2nN/4x68X27RjR5PDYWIGnnB4P2fvzjGOR+C+YSB72f5ws1PA5JiJmCVxMzACAguSQz+e8rX+64Nxyj0I5kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=el/kp47H; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R5u4rn116401;
	Tue, 27 Aug 2024 00:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724738164;
	bh=iCNZUhycfyj1kY3kt5uCHhGpAcrMxjqleOLxhg4VqI8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=el/kp47H5X5wCO0MolnMuiy8U2xqIaqKq+kgreQOnGv6SGeowWeSRMe2jiV2uk1fJ
	 7OfyyPmNu8rnTdnNqMDXvL70B+9PwBwmiJk6gvlzJ+zMQ7O8AX7jBpb9oqywRxeTYl
	 1BZ2brOolUF3HoaxC3PFD06DnfjcXB7dGNIGJBdg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R5u4gl094810
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 00:56:04 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 00:56:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 00:56:04 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R5tn7f103422;
	Tue, 27 Aug 2024 00:55:59 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/2] PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
Date: Tue, 27 Aug 2024 11:25:48 +0530
Message-ID: <20240827055548.901285-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240827055548.901285-1-s-vadapalli@ti.com>
References: <20240827055548.901285-1-s-vadapalli@ti.com>
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


