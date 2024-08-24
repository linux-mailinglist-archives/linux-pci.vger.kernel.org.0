Return-Path: <linux-pci+bounces-12154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5095DC67
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C0F1C21379
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B92A8D0;
	Sat, 24 Aug 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qg1YFWNA"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319A1EA73;
	Sat, 24 Aug 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484120; cv=none; b=BcSsqS85mCP2Hl7duVJhyBv6mi/6CH8EtAY2Q8r5Eu0Hdh8GD/rQEaUKR7/R0spneYkH2KELu9x1maGicmJRmlUjJzXS12f8xNRfn+Vxq7k7+K32+GP7+ZJMd95qm1JPHZVnY/WJqcW4d7lFlv+1F8tWCGYx7WKC1zM+Em44kgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484120; c=relaxed/simple;
	bh=tXyryG63dPBdeemA6SlMHRobqdlPhVPxegQQarntW6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppOFcboBOtj6yhzUswG5zXWkgIjpZBPTfnf91jI60nWIedvMTnJ1BZOC8pyQdmD01knuIZKpSEkiYXpDdPwMb7076su66W1TsMUOJjfwgmf26iczHt0uLu4tgED6IB6LVBUi3bkShD6PMIoSn4APT4wPzu862gUbePp9rQttr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qg1YFWNA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47O7Lf0K065162;
	Sat, 24 Aug 2024 02:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724484101;
	bh=ODPIDf4BAemrhSs5Esn8hvNfqijRS+PSG4hA/zWEYHM=;
	h=From:To:CC:Subject:Date;
	b=qg1YFWNAN/K2+CrCpnjMlOm1buTP7WWXHJ17jTwCTSHqtoUeratPgrwrBhmSwaFls
	 ZRBsT3AtdexdyeTcGd1L1MjR1FURLTIwkv/T3QTaIoxUs+7bjuikVpeEAVnOLWhAjg
	 ilRqpFQ4bRdb21C2D5yIo02OQ+yolo7je+m4MG94=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47O7LfGQ026118
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 02:21:41 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 02:21:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 02:21:40 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47O7LaJQ114055;
	Sat, 24 Aug 2024 02:21:36 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <u-kumar1@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] PCI: dra7xx: Fix threaded IRQ handler registration
Date: Sat, 24 Aug 2024 12:51:35 +0530
Message-ID: <20240824072135.9691-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for
"dra7xx-pcie-main" IRQ") switched from devm_request_irq() to
devm_request_threaded_irq(). In this process, the "handler" and the
"thread_fn" parameters were erroneously interchanged, with "NULL" being
passed as the "handler" and "dra7xx_pcie_irq_handler()" being registered
as the function to be called in a threaded interrupt context.

Fix this by interchanging the "handler" and "thread_fn" parameters.
While at it, correct the indentation.

Fixes: da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ")
Cc: <stable@vger.kernel.org>
Reported-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
of Mainline Linux.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-dra7xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4fe3b0cb72ec..4c64ac27af40 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -849,8 +849,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 	dra7xx->mode = mode;
 
-	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
-			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
+	ret = devm_request_threaded_irq(dev, irq, dra7xx_pcie_irq_handler, NULL,
+					IRQF_SHARED, "dra7xx-pcie-main",
+					dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_gpio;
-- 
2.40.1


