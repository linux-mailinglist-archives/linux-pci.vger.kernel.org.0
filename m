Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367C44BC29
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 08:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhKJHg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 02:36:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54890 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKJHgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 02:36:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7Xvpr087459;
        Wed, 10 Nov 2021 01:33:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636529637;
        bh=Sk3ObvVytjQMAmV+/5MeG1AT2qz2GdCxjih7w+8/iO4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g0VXSYSLkO47EH6mU8F1HwdtnA0W2ssNXhz2D3VSeMqqQwmQUr0HkIXA9kfERx2Sa
         m47NnRtqi7naTuOfEVnpbJHVi3ANqe1z3wSCPGUZDU7Q4Md5Bq0IIj3UwxGtG92o2U
         p7o7AnIXT+3gJXilECEECNUR6/dWslkjndyQR8Lk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AA7XvC5065168
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 01:33:57 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 10
 Nov 2021 01:33:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 10 Nov 2021 01:33:57 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AA7XiT4020054;
        Wed, 10 Nov 2021 01:33:54 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/3] PCI: keystone: Set DMA mask and coherent DMA mask
Date:   Wed, 10 Nov 2021 13:03:43 +0530
Message-ID: <20211110073343.12396-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110073343.12396-1-kishon@ti.com>
References: <20211110073343.12396-1-kishon@ti.com>
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
 drivers/pci/controller/dwc/pci-keystone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 6a352528d971..23649c01fe41 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1203,6 +1203,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+		dev_err(dev, "Cannot set DMA mask\n");
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
-- 
2.17.1

