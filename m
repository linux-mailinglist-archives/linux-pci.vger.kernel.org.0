Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843D22ECA8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgG0M7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 08:59:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34284 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0M7o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 08:59:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RCxauw093112;
        Mon, 27 Jul 2020 07:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595854776;
        bh=LzR8z4E5Taxan1m4qb+Cxn/bpv2ZQiV0SHVJ1wXbvwQ=;
        h=From:To:CC:Subject:Date;
        b=CxBRY5/Mjd+xMYy9aEni9G063X/+ehMSuDIZ9yOKFiYlLQN9P1QgcMCht/0Mk0Vis
         6lTouZwvPRlvmyeM/JWC4cEOEjchNRmdwXLOLc0rFtXzRbHfCspCYXF/XSFTsvgzNc
         +sV1SQ0PulNaDgv+MC8R9dB5imcUt0et6uVr7gO4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RCxaq2054434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 07:59:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 07:59:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 07:59:36 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RCxWvn127194;
        Mon, 27 Jul 2020 07:59:33 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: cadence: Fix static checker warning
Date:   Mon, 27 Jul 2020 18:29:32 +0530
Message-ID: <20200727125932.8951-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following static checker warning

drivers/pci/controller/cadence/pcie-cadence-host.c:322 cdns_pcie_host_map_dma_ranges()
	warn: ignoring unreachable code.

Fixes: 	82d8567259b1 ("PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Hi Lorenzo,

If possible can you squash this patch to "PCI: cadence: Use "dma-ranges" instead of
"cdns,no-bar-match-nbits" property".

Thanks
Kishon

 drivers/pci/controller/cadence/pcie-cadence-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ba157278fb0f..8d86560196aa 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -321,9 +321,10 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		err = cdns_pcie_host_bar_config(rc, entry);
-		if (err)
+		if (err) {
 			dev_err(dev, "Fail to configure IB using dma-ranges\n");
-		return err;
+			return err;
+		}
 	}
 
 	return 0;
-- 
2.17.1

