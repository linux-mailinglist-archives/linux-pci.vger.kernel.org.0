Return-Path: <linux-pci+bounces-2709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B2840331
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805CA1F2357F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836656740;
	Mon, 29 Jan 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pq0MY3Db"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A956469;
	Mon, 29 Jan 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525423; cv=none; b=fT2wP1YzzGquvFOCNoDc75mQREtd2RCnYkV4yqOAtdpADIbMnqwNoqZGYPE3ez1wFgGjy0l1VrilTloz8YTQ5KK3+oVTKwqrI8nTDmNrEbfV9jiuMZedUde5bs+wLLTZYWH26JsKoPSFDKjf4l6uKOhlnpP0hUtTHAC+2i/ynbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525423; c=relaxed/simple;
	bh=je4BCKddaeJFCgeD8nlqFK65Ey9jQCjtMpDtUG1yxqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1+1pACAi6hFvkVYQB4MlYWg5XAEfMoxqTnKIHUV+4lFXOzXUIbtz6XygAQqaMZzcQMtzyHEdqnJ0EOPkaHaRwtaDuVQjrJ7WaANhpPCtMbN4a7ZEWVEGDtXe2KpnptejoMurGCP4MxiGLrKa8fTtTJftkwXhhvrg8lTSXLJ/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pq0MY3Db; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TAo3CC022630;
	Mon, 29 Jan 2024 04:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706525403;
	bh=m0htI7go7or/yzNzVCGjz5hppU2wqyr8vuBJ7cUUKzs=;
	h=From:To:CC:Subject:Date;
	b=pq0MY3DbCuwjGFSt3hP10A1JzEymc3OC0rI+bosIlb/TCrzTgTjdsrYhJSPOGuqoF
	 0l0/lPPOGrYdeHoEcJJbi1tOKkGNDDqgyPEmUEOLAfpmeiGhMueuVSxeIR+6KV2oSn
	 D8HSvHThPk9E+6O0Pt0p0M9XBXhO1sHICKx/OGjI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TAo3hD030235
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 04:50:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 04:50:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 04:50:03 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TAnxhF088113;
	Mon, 29 Jan 2024 04:49:59 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Extend j721e_pcie_ctrl_init() for non syscon nodes
Date: Mon, 29 Jan 2024 16:19:58 +0530
Message-ID: <20240129104958.1139787-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The "ti,syscon-pcie-ctrl" device-tree property is used to obtain
reference to the "pcie_ctrl" register within the System Controller Module
in order to configure the link speed, number of lanes and the mode of
operation of the PCIe controller. The existing implementation of the
"j721e_pcie_ctrl_init()" function handles the case where the compatible for
the System Controller Module node specified using the "ti,syscon-pcie-ctrl"
property is "syscon". Since the System Controller Module can be modelled as
a "simple-bus" as well, extend the implementation of the
"j721e_pcie_ctrl_init()" function to handle the "simple-bus" case.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240129.

The System Controller Module is modelled as a "simple-bus" in J784S4 SoC at
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#L45
The existing SoCs such as J721E and J7200 which currently model the node as
a Syscon node will also be updated to model it as a "simple-bus".
Therefore this patch aims to update the driver in order to handle the
migration of the System Controller Module to the "simple-bus" compatible
without breaking PCIe functionality on existing TI SoCs which make use
of the pci-j721e.c driver.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..2ace7e78a880 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -224,12 +224,20 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *node = dev->of_node;
+	struct device_node *scm_conf;
 	struct of_phandle_args args;
 	unsigned int offset = 0;
 	struct regmap *syscon;
 	int ret;
 
-	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
+	scm_conf = of_parse_phandle(node, "ti,syscon-pcie-ctrl", 0);
+	if (!scm_conf) {
+		dev_err(dev, "unable to get System Controller node\n");
+		return -ENODEV;
+	}
+
+	syscon = device_node_to_regmap(scm_conf);
+	of_node_put(scm_conf);
 	if (IS_ERR(syscon)) {
 		dev_err(dev, "Unable to get ti,syscon-pcie-ctrl regmap\n");
 		return PTR_ERR(syscon);
-- 
2.34.1


