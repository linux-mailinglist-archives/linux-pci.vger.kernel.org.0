Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843873027E5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbhAYQc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:32:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49305 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbhAYQbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 11:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611592296; x=1643128296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mvPfouYZNgaMMEKizW/xEaa4x8brnBQUlMUMiC9UYSs=;
  b=x9za29Ntyqrhhk7Oj97lJ8xj3Me0CDZgStu3XCxDDigjboMmMQ+QFGEi
   36x1koLUeZ4oBrM//3u5r57j3J2cwGxpgsv44H9ZnSOfcMnrfFe+etHrX
   vucdNMWhYgrEvVEDgDnQC4/nZ1x2HHV+Pacg1MpikcEuzX9VJXuTEhSJU
   9cbR+6mLI3+Y44Xmfps4Wsv0QbYQgGYlbpgfAWlkAEahhNhM4FHkIPGgC
   1BR0wRP8HFhIRjrVOGCd6ILIp/fIiCASI73a38tZ9bJw066LFl2W8ZVHK
   2QpAerEojJ/oJt3Bq4H1fxphfRA0rRqjOY/1JaZdSop4Pqrw1IUugk21/
   Q==;
IronPort-SDR: bx66WicgDk9yST/rg6mEAJDBWfWm0kJAoc/NplQ4Swi5cv3QNA7hZLo+C5Ck8XBKsBfhvtuLL6
 rEc9hHoHVXj7DpmvuQLLblhkJtCzN310BRN1ZZKHyKqEZ/JLMl+kHBTQ0+2HnQMN1Q/qBmncnl
 XTQn9dA00jlNfUMseBr75pnIcfZb5eZ5ksm/f5yxBkAWzpUT4phhjfd/55fCZfFEx3VHWe3gXE
 OgdXZGheriOB8i2JItr5qUk0/J1peJsdej6kXA+dw6n5fe4wVGSFuoj3YUtUKvHAM9Q2BHMAcd
 EUQ=
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="101330568"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2021 09:29:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 09:29:42 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 25 Jan 2021 09:29:40 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v21 1/4] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Mon, 25 Jan 2021 16:29:31 +0000
Message-ID: <20210125162934.5335-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210125162934.5335-1-daire.mcnamara@microchip.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Many drivers can now use pci_host_common_probe() directly.
Their hardware window setup can be moved from their 'custom' probe
functions to individual driver init functions.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6ce34a1deecb..6ab694f8d283 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -64,6 +64,8 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (!bridge)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, bridge);
+
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
@@ -78,8 +80,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 
-	platform_set_drvdata(pdev, bridge);
-
 	return pci_host_probe(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
-- 
2.25.1

