Return-Path: <linux-pci+bounces-12277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BF960A04
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040DB1F21CDB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035481B4C55;
	Tue, 27 Aug 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aKG8e5Hm"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E21B3F35;
	Tue, 27 Aug 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761498; cv=none; b=WEPet+5c5f9QNXJ6E6h/YnySu2OpQRofoT0PnCKd4/qfVZFEZCmfNQ50deDtVWfokSiox12tKAvWwpVn6EuDFhNx1VVOTGY1QOq7Kqzj03rIKVVxGraUw24x/7+UvATWRX6TT9oX+nJoruAnpaZRSM06/EeIQiOQARbXyYL3lN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761498; c=relaxed/simple;
	bh=jFHcTYxKauKn2j4L1ebE8sDM6pDpVTJdYTkal9P+V2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moW2Gzc2DlL9LW4d5MtuzN+1HHLtoyQZ9t3gv35zYPTs3m5mcmIIrTBB+w6hldzg0HZGpzl5NeaAbJ3GOLZQGz4WoHo3AxoQ83OXRZhHHci6I5knVIDzjYnfNg/cZX5DrW7N437bMkrk6ff3b1fimEakUQruhbV1RkIg7gVloXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aKG8e5Hm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RCOecH092068;
	Tue, 27 Aug 2024 07:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724761480;
	bh=Jxki9UuRPZGgt+9UKSYU76B9FROiegSaoeKr9g9BOz4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aKG8e5HmJLcG0AdEFGK6Nx9YhpT/Jn6ycieCkLnedh8WtcxdRnwzOcA+hbwjJAOrp
	 W/cvjWzlWtbrjXA8iFltjB/5sqZT++5bL7cttTSO8lcGxnrakYgZdbSYwDo1Z4h0Ft
	 5eMOs6jNZ5ZKqbzmhcxbssiCJsX+fmnQkHYnWTN4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RCOeL7051182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 07:24:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 07:24:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 07:24:40 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RCONYE011388;
	Tue, 27 Aug 2024 07:24:34 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <j-keerthy@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <u-kumar1@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] PCI: dra7xx: Fix error handling when IRQ request fails in probe
Date: Tue, 27 Aug 2024 17:54:22 +0530
Message-ID: <20240827122422.985547-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240827122422.985547-1-s-vadapalli@ti.com>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the
bottom of probe") moved the IRQ request for "dra7xx-pcie-main" towards
the end of dra7xx_pcie_probe(). However, the error handling does not take
into account the initialization performed by either dra7xx_add_pcie_port()
or dra7xx_add_pcie_ep(), depending on the mode of operation. Fix the error
handling to address this.

Fixes: d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the bottom of probe")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 20fb50741f3d..5c62e1a3ba52 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -854,11 +854,17 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 					"dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto err_gpio;
+		goto err_deinit;
 	}
 
 	return 0;
 
+err_deinit:
+	if (dra7xx->mode == DW_PCIE_RC_TYPE)
+		dw_pcie_host_deinit(&dra7xx->pci->pp);
+	else
+		dw_pcie_ep_deinit(&dra7xx->pci->ep);
+
 err_gpio:
 err_get_sync:
 	pm_runtime_put(dev);
-- 
2.40.1


