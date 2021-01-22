Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF829300622
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhAVOxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 09:53:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56791 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbhAVOxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 09:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611327183; x=1642863183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mvPfouYZNgaMMEKizW/xEaa4x8brnBQUlMUMiC9UYSs=;
  b=dImwqLDDVHFPS5zzwFxLyUAshVUzCMx4KGFkUWtoxWgNdEEl8M4Sryfk
   40mTBS6YIoQYENIdUjGFCquvi5pSR5V6DslBGxQj96zVvE2ibHHV4CnAu
   2Rf3f9kMfrL3nm3LPPfcsJGraL1/uyIiHO/zQLPdMsVQ16BqAchEJy4ho
   GOEPJfIdZtJx/S+3Lh9U4wW3aX5eEdZJI7B13LENQD3G06RsGu90Vy1Q5
   fICjTtMl56FH6KAaDX48hJw5iW7JxXH9UhjF9eHeiW/lMCr0XcO+Z1D79
   exDNGIovHJcP96Yo9M2UQk2M+9nCSFMROFg+gZuJdeICsgsCvv/oV39ba
   Q==;
IronPort-SDR: 6c9WwcbcVN/trrD/L/mUvkSGIP2YpkfAshpsCIXRwqEAwINjD1wfXdaivnsWIVCpDFUS0jmL0C
 MTW3msQc8kS/oO3J8zhaFjSMZTL5FHbiHzZJh3arhqwzwD4iono1Dp0tF+QFFjyaMruO1sdEkD
 PQfYf3mF3/Sqx+JFJdBloUIr3R+1SaEZ7fqJ/Pl4MdFH3C2ARtYgZBYMul12T8JiZ2mkeyjZmt
 eAe6h3SaTZlKwO8fjlGHX/5xMn5w5ayOZ15AUUdAdcOU6ftFY7Gv1ECBJ3jcPI5msoudhTHY2t
 9f0=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="103844752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 07:51:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 07:51:47 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 07:51:45 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v20 1/4] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Fri, 22 Jan 2021 14:51:34 +0000
Message-ID: <20210122145137.29023-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122145137.29023-1-daire.mcnamara@microchip.com>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
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

