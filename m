Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC92334874
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfFDNUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:20:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55300 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfFDNUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:20:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DJWAs028463;
        Tue, 4 Jun 2019 08:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654372;
        bh=v8mkOQlj6ZUtE+6KavYFNHYT3JmxgtDfIA3TqfNwJt8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JS7LGnlKVoepjTyrc5BULAMKzps2ynnHiT+iX2qyeiH5smSSWUYojVAN1Qtv429bR
         TOyZ2BoQeDbgrVWdG2zcpvAMfPFq8pmnuZIUmhlBDKa7tx1ysjxN/1YL3loHqQU40W
         NToo66TKTov/SdeKR0f0JVJV7omF03IH00npvrOo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DJWRK055289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:19:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:19:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:19:31 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGk098972;
        Tue, 4 Jun 2019 08:19:26 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 30/30] misc: pci_endpoint_test: Enable legacy interrupt
Date:   Tue, 4 Jun 2019 18:45:16 +0530
Message-ID: <20190604131516.13596-31-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core does not enable legacy interrupt if it finds MSI or MSIX interrupt.
Explicitly enable legacy interrupt here in order to perform legacy
interrupt tests.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2a6cd9e65e67..e12a3845ad2e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -697,6 +697,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
+	pci_intx(pdev, true);
 
 	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
 		goto err_disable_irq;
-- 
2.17.1

