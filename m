Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE252CD539
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgLCMLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:11:51 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24373 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgLCMLu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606997511; x=1638533511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mvPfouYZNgaMMEKizW/xEaa4x8brnBQUlMUMiC9UYSs=;
  b=z4QEpny5PyGnW0zTolpzX6jf0yUxEINNs1BZ+ohNknfbyppIr9MGpws2
   WQyBrLGiCE7rlU0uB/+Dvx+Zb7BwDBckA0BNrKeHFfYwD/usxGp5hV6Kb
   7FxawddXM6IVBfU0i5k73kcqfGnq+Q1t7D3FKr0G57rAYV7H90f4PNPDp
   PQ+LjrOErm3VbvfZEVsAhDi2/Q4HCOB0+CZW2sRvksv9vycigrncaqdS/
   YrqgqGkIyywcwbzhuuGScwMOoiwkMXTa7FV0bOg3wdFM4ekE4Qa9yIrpY
   Q3ly109/+nrblOUPGbUZYDEuKu52RJJ6RrfXl/kiuFOIlF7v24OZjQ7YH
   Q==;
IronPort-SDR: 8j6tRjpH1fy4Q4RvFQlzyMl0TyO+qD9Hp93yj2sWbh8OiJX/jZ2tRJeCuvnQpucQLldJzhA5Nt
 502rwG2X+yNKtK9o0V7UMMt/sWDML+zEppCETS0gNnWI4plr9roXAeOAGb4OOOT/5b+Tn6FxAX
 qy7SEBAulontDOpbwtc+yPaqU13QqcrnxwVO5YNBGXkU/zIl+wUYZCX2kEweE9hgtHN4MJejcH
 2Uo3EdOJFWLvpYPxurOBTT5fDKIo6zNojccuqlm/xApFhrvCVZwT5aucQUIbXD6S5cU+B1q/VO
 8ag=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="100731148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 05:10:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 05:10:44 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 05:10:42 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v18 1/4] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Thu, 3 Dec 2020 12:10:15 +0000
Message-ID: <20201203121018.16432-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203121018.16432-1-daire.mcnamara@microchip.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
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

