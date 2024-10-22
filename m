Return-Path: <linux-pci+bounces-14986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0C9A9CAE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DCF1C23342
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00997152166;
	Tue, 22 Oct 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="isz6k2P0"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834A27735;
	Tue, 22 Oct 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585932; cv=none; b=hEIBx/e8C+BfNUZAvG5s4j/dh67wgaiw6JjgEwTr9wXMEO0X2SqnnLpLQtb1lOvj7ZZU+j6z5J4GsStShdIBvLw5zBykItkKEe7fo8FdtLmMv7m0EPkR1kvFGQK5/CnXi2fstsKryFo7oonrW9CPwEx0Z1awkRhH31J921KXoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585932; c=relaxed/simple;
	bh=24FHTTIKlshgcnqTCzujRu8x5PDDvQ70ZtdJSrLkunU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyicZ4xnwhOYq73gV/eiAuhLMnK4UVS1fMy6VnJ1DifYw05PXXer+4v0ThimZiuK5pcjotGMgjHQntjw19QXN6yYALPcIwunZe2xDVtuh0148eESmdPm2mADz2iaKDp9EIOxPX8WmyqBdNXxjSsEUDuogRwQSNFe2BQklOVPTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=isz6k2P0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49M8VqwT103269;
	Tue, 22 Oct 2024 03:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729585912;
	bh=YAMUtebJLSB7p1vdKcR9hmMWoyxoGZwJK0XkcbmsWm8=;
	h=From:To:CC:Subject:Date;
	b=isz6k2P0v8fKnPaNqF5TebLSNayOh1js0lHQ4hRVh8cqllDL6AX/fVn2DeM1ZeNU6
	 SmF9yj7+a0QpNrOCHstvwgotebSqWao97gqGpKBuGy2LfYxehfLpdwbI/9IEw2GkJB
	 fAlb/p+RgaEYEiAG3yQbU5uQ23dYNZ8qkT+my4RM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49M8Vq1S033237;
	Tue, 22 Oct 2024 03:31:52 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Oct 2024 03:31:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Oct 2024 03:31:52 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49M8Vm4B052525;
	Tue, 22 Oct 2024 03:31:49 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <thomas.richard@bootlin.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS ms
Date: Tue, 22 Oct 2024 14:01:47 +0530
Message-ID: <20241022083147.2773123-1-s-vadapalli@ti.com>
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

Fixes: f96b69713733 ("PCI: j721e: Use T_PERST_CLK_US macro")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
c2ee9f594da8 KVM: selftests: Fix build on on non-x86 architectures
of Mainline Linux.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 284f2e0e4d26..e464cfc2c332 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -671,15 +671,14 @@ static int j721e_pcie_resume_noirq(struct device *dev)
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


