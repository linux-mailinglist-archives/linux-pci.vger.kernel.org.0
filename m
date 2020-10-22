Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B68295FDD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507172AbgJVNWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 09:22:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43662 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507167AbgJVNWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 09:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603372955; x=1634908955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=roRpsYdtoRbYCNEFe5JThtGTJAd4WNqe6E3N8dhPrII=;
  b=F2zCw50d8i7JYLxmdLCJKp4qam/TmIeJWkUSHB352fMNHod+mlJALJzY
   vKlW50GpEBfwEc3UYj+3k+6W1NqYo0BWzx2qV5rkMFqVY0ovs0fqJo3XD
   xUDOLSKImf7Fm3yOhTx74OHP/YYUxV1sOOqJQjwC61RdkP4VKmhc49Oca
   fC7boP5Us58Gf2x7dVZmqMq9q5n/mxnbgdlARwuQGXvP1PXkl3JzyGWuJ
   zC4b/ocvcix0s98YDW16DeD1bICY3J+tS4wCVNg3bFySTIOnMe9UCILwo
   H5D6239oIutdeZg5tIZuN46VFEpTFCbtdhIZaTn3sgLF0U9GyGuDUM0xM
   w==;
IronPort-SDR: 68X5FedlTA7yWJK0HCUk4wJMT9pBI0EBxyzLS0wHhBjCeHoa1O1KBUzno+IxcMIXw7axIh6nZY
 x0mXquYssDZ7H93QSKadVUVcEUwVmpxT8IHm10ZPOkDHANhYl9asI86vKQryh3QWD/lIW1jP3+
 QqRS10OzCUVHp7hWHxUSD4AJXuXRoIQudZhFWjpBJpfWLnROEJj6ll0ywfHeXDX1lSe7/u6Jdl
 TrtGbWrrSfUH01FjewOi9ELwFUE2sAucdcV0R7PmpoMYo/HrYxqK/QmLncWV6Q1HrlRCam5xtT
 1tI=
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="96256404"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Oct 2020 06:22:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 06:22:32 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 22 Oct 2020 06:22:30 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v17 1/3] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Thu, 22 Oct 2020 14:22:21 +0100
Message-ID: <20201022132223.17789-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022132223.17789-1-daire.mcnamara@microchip.com>
References: <20201022132223.17789-1-daire.mcnamara@microchip.com>
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

