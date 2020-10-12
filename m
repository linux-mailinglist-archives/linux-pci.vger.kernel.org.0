Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3866628B322
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgJLK6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 06:58:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:37433 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLK6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 06:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602500282; x=1634036282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/kbEbhgDc/s/e/5/7O07wFeFg1vxQWbnVk+tep/HZDg=;
  b=Eke14pHGpuI/3XEnQi3D7gT7ZCFMR84mcJ4NIpU23oiFbJzryZqADWNN
   9S20FyLzz5upDH5LZDngVyXnYZssW74PrIY1hKYk+HMHgM9K34jzDBtKl
   rtK+92NpMvjCtiRDYfrfbutgO10m8QhbtWB0WnnqVhHlJ9TsbSPKFvdRM
   N7V55U793iL5sjezKLNxGfxcV0RTUDEDAjcYbgD78FOrOIkDar+mGxR4I
   gZAs2LoQG8/klhvtBNBRz/H9MimnsFJ0LuFW4M2blhC+TEOLwks37LstC
   9rjPq4MFtSH6O9iIqP1GJNYExlN4/TqcqKvhi/fy16XE8lnIgZoNMT5wo
   A==;
IronPort-SDR: XFm23vOelJTXwR7rapvuQZO0g/uFE5WSUA2qT0ES6UASpBySaqGoSTZOwu2XcL/nElCGbUmiMD
 6voo7YQCXaTii7n3oG5DXOM5g45hg0tgJzqBR5E4AeUziiWEeN6hIR+8n2kR4sVbiZVQwPXsL/
 KXOjfvatYLdKn8/pkGf7CQqc1zmH6hwEtgn2lp/uP1QvBbVhJ46oKxTZTNyK9ohMS/W+QruI7F
 DZMf2yyx4ZT8fdUiNdjZ0FAyjptcora/pzXKWbXdsm8ygPN4I/qW+/Y9EFAtLKzSaZrmiW+onc
 yM0=
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="99123686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2020 03:58:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 03:58:02 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 12 Oct 2020 03:58:00 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v16 1/3] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Mon, 12 Oct 2020 11:57:52 +0100
Message-ID: <20201012105754.22596-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012105754.22596-1-daire.mcnamara@microchip.com>
References: <20201012105754.22596-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

