Return-Path: <linux-pci+bounces-15911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F19BAD60
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D51B20F54
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB350199FA8;
	Mon,  4 Nov 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lmHbUCcj"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533818C91D;
	Mon,  4 Nov 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706300; cv=none; b=FADVhJ8shT2xRV/QQ72Amc7dOi74HCrNosDy0VbXO1hdPYUPLOugvJ7BWjSs4dSHTEJRsb6xoF8EmZyi3aSdT2qvXSJgGoaAFPgOt0/di3VBZ4zjSuoCYGU7fEMNZ4bvvAzaa7gcIbTjX6xIznAxUxqcofn5JiUjGXNIDq0E8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706300; c=relaxed/simple;
	bh=sXlF1I6gJMnXOR2kcQblYeKBKy9K5X1HlVpDHibIC8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkZPQEnN2YWffa8cc6N0ng2ct4LUIfJfhjTviQt1Gi1EMZJgEkxr1zaMlGEd4ii9t/mfVv4L9GNVs+q3Kn3E+/i/pmO1H/QnulPl03Zryp2hYdOLHAJiPb2ZjFi/bNE5KmkkyxGGN9AR7vD/7OIRZaCNHdvDrHwuiTD2IKZX7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lmHbUCcj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A47iPJM075574;
	Mon, 4 Nov 2024 01:44:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730706265;
	bh=RBpswuLRxOZxNXlnIrevuU+zJUadRtGK4fTa3G3D7Cs=;
	h=From:To:CC:Subject:Date;
	b=lmHbUCcjSgY9hRjxgEpM8GRznC74D1elqB7AoasARInL54BaRHmUY4sGSOZSQwPe/
	 1bNijh5yvg+YXTmJVH0Zuokrs3Q09Oxp2tzYVhWpPt+ZsJYM8cGesb/0cQ+vUXhYXS
	 mfLCxPDjDHfA9o9PQVTZ8wJb39n/RcBWDGQmbvF8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A47iPqx117294
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Nov 2024 01:44:25 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 01:44:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 01:44:25 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A47iKNV076611;
	Mon, 4 Nov 2024 01:44:21 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <kishon@kernel.org>,
        <thomas.richard@bootlin.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS ms
Date: Mon, 4 Nov 2024 13:14:20 +0530
Message-ID: <20241104074420.1862932-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

According to Section 2.2 of the PCI Express Card Electromechanical
Specification (Revision 5.1), in order to ensure that the power and the
reference clock are stable, PERST# has to be deasserted after a delay of
100 milliseconds (TPVPERL). Currently, it is being assumed that the power
is already stable, which is not necessarily true. Hence, change the delay
to PCIE_T_PVPERL_MS to guarantee that power and reference clock are stable.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Fixes: f96b69713733 ("PCI: j721e: Use T_PERST_CLK_US macro")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
59b723cd2adb Linux 6.12-rc6
of Mainline Linux.

v1:
https://lore.kernel.org/r/20241022083147.2773123-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on Linux 6.12-rc6
- Based on Krzysztof's feedback at:
  https://lore.kernel.org/r/20241102141914.GA3440781@rocinante/
  PCIE_T_PERST_CLK_US has been replaced with PCIE_T_PVPERL_MS in
  j721e_pcie_probe() as well.
- Added Fixes tag corresponding to the above change in the commit
  message.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 26 ++++++++++------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 284f2e0e4d26..e091c3e55b5c 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -572,15 +572,14 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		pcie->refclk = clk;
 
 		/*
-		 * The "Power Sequencing and Reset Signal Timings" table of the
-		 * PCI Express Card Electromechanical Specification, Revision
-		 * 5.1, Section 2.9.2, Symbol "T_PERST-CLK", indicates PERST#
-		 * should be deasserted after minimum of 100us once REFCLK is
-		 * stable. The REFCLK to the connector in RC mode is selected
-		 * while enabling the PHY. So deassert PERST# after 100 us.
+		 * Section 2.2 of the PCI Express Card Electromechanical
+		 * Specification (Revision 5.1) mandates that the deassertion
+		 * of the PERST# signal should be delayed by 100 ms (TPVPERL).
+		 * This shall ensure that the power and the reference clock
+		 * are stable.
 		 */
 		if (gpiod) {
-			fsleep(PCIE_T_PERST_CLK_US);
+			msleep(PCIE_T_PVPERL_MS);
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
@@ -671,15 +670,14 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 			return ret;
 
 		/*
-		 * The "Power Sequencing and Reset Signal Timings" table of the
-		 * PCI Express Card Electromechanical Specification, Revision
-		 * 5.1, Section 2.9.2, Symbol "T_PERST-CLK", indicates PERST#
-		 * should be deasserted after minimum of 100us once REFCLK is
-		 * stable. The REFCLK to the connector in RC mode is selected
-		 * while enabling the PHY. So deassert PERST# after 100 us.
+		 * Section 2.2 of the PCI Express Card Electromechanical
+		 * Specification (Revision 5.1) mandates that the deassertion
+		 * of the PERST# signal should be delayed by 100 ms (TPVPERL).
+		 * This shall ensure that the power and the reference clock
+		 * are stable.
 		 */
 		if (pcie->reset_gpio) {
-			fsleep(PCIE_T_PERST_CLK_US);
+			msleep(PCIE_T_PVPERL_MS);
 			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
-- 
2.40.1


