Return-Path: <linux-pci+bounces-10844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7B93D4AC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CB8283788
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717017C200;
	Fri, 26 Jul 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vRyt2KUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDAF17B4ED;
	Fri, 26 Jul 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002363; cv=none; b=OMNQaFUKcSD6Ns43JaD9fmwT6SbcR0MyEI8UJNH0L4fBEo3NOE6hCEg/AbiGyhPKKL5fleITm/IlzKpcSt4rHYmeecla/P40g5Cxvy3ZUbkQGt/nWXrK/L8wEPbjYb0VrtjexwUWR2LaNGt/YjqKFJHmDi8vX0FcMiHBORI9X/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002363; c=relaxed/simple;
	bh=IOW6X+kI/aWBjXQHCWzPTGFWFkLYr2xyeVi9e7KAsgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FTMoNex7ElHZaDepz2nAqXx/6G4uQjfrJd2VOEmHYxhkFXtw+C2TE1vLagzqjwm+5Xdpr6gYjv6TmmXgXi5IikrGPhPwkrne5HpYWxMGkkZrESg+O+SeXbvoo6wUXT4Fo8Ex+lAgUvQfWf+LHmNw+YLOi5KkEaXsRAL0StAzhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vRyt2KUg; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QDx969096928;
	Fri, 26 Jul 2024 08:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722002349;
	bh=jvorCvGOcAYrhGu0dno5dA4WxVxdFg+bw/5zZzT/sNU=;
	h=From:To:CC:Subject:Date;
	b=vRyt2KUgZdAHgmcxOe/6tOJmYo919FYfsHnwWkiVS1qcA+VQCFujWF0Rmbh5JBjKp
	 yH1Kx5cmErQ726wknl8XKLyUMQBCO0NJoKsIKU2ibh7pq6Ec+fZCLyi2/Et8knog3A
	 YuCwfv+1jZIMfaiqPGKfwoMF8/I1Acl2GOeo5fTs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QDx9Zh021179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 08:59:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 08:59:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 08:59:08 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QDx4AW120001;
	Fri, 26 Jul 2024 08:59:05 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>,
        <ahalaney@redhat.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] PCI: j721e: Disable INTx mapping and swizzling
Date: Fri, 26 Jul 2024 19:29:03 +0530
Message-ID: <20240726135903.1255825-1-s-vadapalli@ti.com>
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

Since the configuration of INTx (Legacy Interrupt) is not supported, set
the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
  of_irq_parse_pci: failed with rc=-22
when the pcieport driver attempts to setup INTx for the Host Bridge via
"pci_assign_irq()". The device-tree node of the Host Bridge doesn't
contain Legacy Interrupts. As a result, Legacy Interrupts are searched for
in the MSI Interrupt Parent of the Host Bridge with the help of
"of_irq_parse_raw()". Since the MSI Interrupt Parent of the Host Bridge
uses 3 interrupt cells while Legacy Interrupts only use 1, the search
for Legacy Interrupts is terminated prematurely by the "of_irq_parse_raw()"
function with the -EINVAL error code (rc=-22).

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Cc: stable@vger.kernel.org
Reported-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
of Mainline Linux.

v1:
https://lore.kernel.org/r/20240724065048.285838-1-s-vadapalli@ti.com
Changes since v1:
- Added "Cc: stable@vger.kernel.org" in the commit message.
- Based on Bjorn's feedback at:
  https://lore.kernel.org/r/20240724162304.GA802428@bhelgaas/
  the $subject and commit message have been updated. Additionally, the
  comment in the driver has also been updated to specify "INTx" instead of
  "Legacy Interrupts".
- Collected Tested-by tag from Andrew Halaney <ahalaney@redhat.com>:
  https://lore.kernel.org/r/vj6vtjphpmqv6hcblaalr2m4bwjujjwvom6ca4bjdzcmgazyaa@436unrb2lav7/

Patch has been tested on J721e-EVM and J784S4-EVM.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..eaa6cfeb03c7 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		if (!bridge)
 			return -ENOMEM;
 
+		/* INTx is not supported */
+		bridge->map_irq = NULL;
+		bridge->swizzle_irq = NULL;
+
 		if (!data->byte_access_allowed)
 			bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
-- 
2.40.1


