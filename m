Return-Path: <linux-pci+bounces-35095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7986B3B6E2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 11:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037CC1C26155
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00E2F0680;
	Fri, 29 Aug 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="etBXYBrQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA81684AC;
	Fri, 29 Aug 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459051; cv=none; b=PDScSh657ErlbCCwOAgBBow4l/lWRgtceTcumKWNOP87B1floWz6EJhUt2gmouTXcmtrnLNDCzcXRl4+eMLDiULxcC5Tp6MAx7ZMwymFXzxO6J2aEtaO4aLApRucX8KlEhX+oYYANEAnZOfBAAYeqpcRciTH+BYOwZ9zGaYv1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459051; c=relaxed/simple;
	bh=DRV28zq6r7gz+t0IqDwLTWs9S2tyN7tSFaKdYrlmhP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnZprMz7e0NhSfCeS90g7xwtAhd7Ril/0R9vLDPLYv8HmMKb0d9KjCG1zfprxF+nRuLWkE87qW3jdVZBWEdMvJ2yFh7qr7EK8fBD+QiZH8rL/9Xxks7mw7vjsDPcoAti6ksGVOcpex91Lq7F00jskhQcqFSH50URtFoXaMH6BRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=etBXYBrQ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T9HD181722762;
	Fri, 29 Aug 2025 04:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756459033;
	bh=fXHjaQ1LRWYb/mZZ8OqDoN/mAOTqlRVHSAzjLG2Zwcs=;
	h=From:To:CC:Subject:Date;
	b=etBXYBrQHZ0jA0GtEdzd5t2SCOuT8veCbPxyhbiIeCr9mdxqDax/m7lM9jmj9Kepy
	 WxU2dQj4U1Nl48mkOJsfr2hU3LQOL/AUXUHU1jncq1YzF2I5pfTj9Sc76tXHdpkS1D
	 cJHd4MyRJ1st4MCDexhBJqz38szpv7lY69qUeCw4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T9HDcJ3550517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 04:17:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 04:17:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 04:17:13 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T9H8Z81836158;
	Fri, 29 Aug 2025 04:17:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <helgaas@kernel.org>,
        <kishon@kernel.org>, <vigneshr@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3] PCI: j721e: Fix programming sequence of "strap" settings
Date: Fri, 29 Aug 2025 14:46:28 +0530
Message-ID: <20250829091707.2990211-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
Root-Complex and Endpoint modes of operation. The Glue Layer allows
"strapping" the Mode of operation of the Controller, the Link Speed
and the Link Width. This is enabled by programming the "PCIEn_CTRL"
register (n corresponds to the PCIe instance) within the CTRL_MMR
memory-mapped register space. The "reset-values" of the registers are
also different depending on the mode of operation.

Since the PCIe Controller latches onto the "reset-values" immediately
after being powered on, if the Glue Layer configuration is not done while
the PCIe Controller is off, it will result in the PCIe Controller latching
onto the wrong "reset-values". In practice, this will show up as a wrong
representation of the PCIe Controller's capability structures in the PCIe
Configuration Space. Some such capabilities which are supported by the PCIe
Controller in the Root-Complex mode but are incorrectly latched onto as
being unsupported are:
- Link Bandwidth Notification
- Alternate Routing ID (ARI) Forwarding Support
- Next capability offset within Advanced Error Reporting (AER) capability

Fix this by powering off the PCIe Controller before programming the "strap"
settings and powering it on after that.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
of Mainline Linux.

v2 of this patch is at:
https://lore.kernel.org/r/20250819101336.292013-1-s-vadapalli@ti.com/
Changes since v2:
- Based on Bjorn's feedback at:
  https://lore.kernel.org/r/20250819221748.GA598958@bhelgaas/
  1) Commit message has been rephrased to summarize the issue and the
  fix without elaborating too much on the details.
  2) Description of the issue's symptoms noticeable by a user has been
  added to the commit message.
  3) Comment has been wrapped to fit within 80 columns.
  4) The implementation has been simplified by moving the Controller
  Power OFF and Power ON sequence into j721e_pcie_ctrl_init() as a
  result of which the code reordering as well as function parameter
  changes are no longer required.
- Based on offline feedback from Vignesh, Runtime PM APIs are used
  instead of PM DOMAIN APIs to power off and power on the PCIe
  Controller.
- Rebased patch on latest Mainline Linux.

Test Logs on J7200 EVM without the current patch applied show that the
ARI Forwarding Capability incorrectly shows up as not being supported:
https://gist.github.com/Siddharth-Vadapalli-at-TI/768bca36025ed630c4e69bcc3d94501a

Test Logs on J7200 EVM with the current patch applied show that the
ARI Forwarding Capability correctly shows up as being supported:
https://gist.github.com/Siddharth-Vadapalli-at-TI/fc1752d17140646c8fa57209eccd86ce

As explained in the commit message, this discrepancy is solely due to
the PCIe Controller latching onto the incorrect reset-values which
occurs when the strap settings are programmed after the PCIe Controller
is powered on, at which point, the reset-values don't toggle anymore.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6c93f39d0288..c178b117215a 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -284,6 +284,22 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -302,6 +318,12 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
 	/* Enable ACSPCIE refclk output if the optional property exists */
 	syscon = syscon_regmap_lookup_by_phandle_optional(node,
 						"ti,syscon-acspcie-proxy-ctrl");
-- 
2.43.0


