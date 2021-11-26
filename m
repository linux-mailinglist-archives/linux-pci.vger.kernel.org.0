Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A829245E971
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359652AbhKZIhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:37:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44072 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353051AbhKZIfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:35:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VhD1038136;
        Fri, 26 Nov 2021 02:31:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915503;
        bh=rfSsCVruqpaxxllAnn66mkt6kvzxK7REyk9p1WoT/Sk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vWcAILyOWp9sSgjEeszqJwIgevUxF7Y9ASckfQaKvbG6x1WI/Lv2gb8+RPLa6ORnR
         KYAgoa4ir56qfySNGAipPDw2599hNpludrXmwdstyJ2/UqSzM6U9hPfl0W1GxyDkek
         4Q+5qTqKhGEOh1lQ5OQbP0M9lpVk7iUnZd9HtJXM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8Vhfe035383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:43 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:43 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEp127547;
        Fri, 26 Nov 2021 02:31:39 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 5/5] PCI: keystone: Set DMA mask and coherent DMA mask
Date:   Fri, 26 Nov 2021 14:01:19 +0530
Message-ID: <20211126083119.16570-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set DMA mask and coherent DMA mask such to indicate the device
can address the entire address space (32-bit in the case of
K2G and 48-bit in the case of AM654).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 73e6626a0d8f..80dbab267f7b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1224,6 +1224,11 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48))) {
+		dev_err(dev, "Cannot set DMA mask\n");
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
-- 
2.17.1

