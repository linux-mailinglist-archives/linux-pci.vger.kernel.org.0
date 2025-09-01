Return-Path: <linux-pci+bounces-35264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A20B3E226
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F93B00FB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239D24336D;
	Mon,  1 Sep 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yPIzxOa1"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEF1FC7C5;
	Mon,  1 Sep 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728252; cv=none; b=fCWW5I5sqizIc4Ukgw+SZhJyt0ht1YnAeRdFi/DfHgevk31YPqsqZY5UkHZ0mjI/jRkFYLD0aUuiIb1uSSlJiYIon+yno/DUe/qjgN7gekjYnHNo33dCw3tjOqdbxa9Sx2ROKPBeapItZoeqLKx+2bDAeWx0qvHYEtdn6JCAUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728252; c=relaxed/simple;
	bh=gHY5lSYrBmGTMeATrmCtIIDaas/UdeCZELU8716Qi/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a04KRjT5ig+z50nNE8Uvy1dcwGRUhh2RHaSVNrl9ulumQoKNWK0AgJeQ+jMm5cb3gcHnSLPmTJwv25+64PL99UfW2GQqy5JnpnKZsUAmbb1zIVfjNsfi9EcSXhWwkYclofpOOytKg9nmBM0Zc3eQViJJ6n2UkuausC8FiQoyOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yPIzxOa1; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581C44rR2801951;
	Mon, 1 Sep 2025 07:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756728244;
	bh=6s67FAZDJUizll6nPEf6TZibmkbOoVBvmJUSm6yE6vc=;
	h=From:To:CC:Subject:Date;
	b=yPIzxOa13fWYaShw/EVS1xRj4NZETT0OsRwAi3ieDNmlrKjpdwDnK9KnDNjkqQ+vo
	 eU+c4dAVhOSDKbZl1tV7QqnMHI68U1Ij7Nqlto1tTxFd8H3SMLokyeSDhBdQyCE4cC
	 X4Cp1syqPxnRI5hPkq5Ur31+FnJOSzoOaadQdL44=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581C44Za1527093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:04:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:04:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:04:03 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581C3xQj2472040;
	Mon, 1 Sep 2025 07:04:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <vigneshr@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Fix module autoloading
Date: Mon, 1 Sep 2025 17:33:55 +0530
Message-ID: <20250901120359.3410774-1-s-vadapalli@ti.com>
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

Commit under Fixes added support to build the driver as a loadable
module. However, it did not add MODULE_DEVICE_TABLE() which is required
for autoloading the driver when it is built as a loadable module.

Fix it.

Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable module")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
b320789d6883 Linux 6.17-rc4
of Mainline Linux.

Patch has been tested on J7200-EVM with the driver configs set to 'm'.
The pci-j721e.c driver is autoloaded as Linux boots and it doesn't need
to be manually probed. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/f64eed4df6fd4f714747b3c7e7876f24

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6c93f39d0288..cfca13a4c840 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -440,6 +440,7 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, of_j721e_pcie_match);
 
 static int j721e_pcie_probe(struct platform_device *pdev)
 {
-- 
2.43.0


