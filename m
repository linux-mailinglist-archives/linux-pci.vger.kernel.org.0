Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0F2E25B4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgLXJqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 04:46:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38704 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgLXJqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 04:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608803184; x=1640339184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mvPfouYZNgaMMEKizW/xEaa4x8brnBQUlMUMiC9UYSs=;
  b=cH0NT6p8+FxbnMA3zM9NgN0Kp9ACjn+uKd45KSknWwisuRWPrGOVDQ6H
   swBsCCBptyaN1U+yXBshsjWeJOsiAaVi1wQv4m9Ax13yJ590a9EBLkSWb
   ms+r7IC9X1ULZT7oD8wKw3Hzw020dlNgriVCX6id0KVhfmDCXmFS8vDWd
   oC+SmtFcYYqyinmDB9WXECKHGqIsmjWzlcu+tCufous9XuDxkQplWNivT
   NpRxedQhJV3/cQ79MbWzx2GwTavy2YTkiV+DHTkDGk4wpnvRQEYhWw7PD
   8JXx9mQb7afvDYwu2S+5+TQGfwq2A1T3JNH5v2oaF4gKMPEr8nc3Gi8VC
   Q==;
IronPort-SDR: FywnJjooHBTtT0GVUj9OcuH78XCxgfYiNCbaSIczJ6/AzN+iJiXZ1VB060nhMyL1ZiF+LIQbPq
 AjXsqwSXwiV23TNA/GQeVQV+KH/Vdmm/CiWAIcA2hiQI2XQE2p+zQ05lnWeJePU8nNwVgVUNlf
 gnvjXELDH2KqQKv2Q83bPuACEMyb1tTPOMT1HaZD7OSq1i+6VZK5osEhSSc8pLXzUlk742Di2a
 foymlCT0QeChzGOHzRKl79pLCLYRVzbhW5iVZRImNkGyRnDAXf/zCjuWz0QUqwyqACe1+AOHS/
 ldk=
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="108837019"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2020 02:45:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Dec 2020 02:45:08 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 24 Dec 2020 02:45:06 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v19 1/4] PCI: Call platform_set_drvdata earlier in devm_pci_alloc_host_bridge
Date:   Thu, 24 Dec 2020 09:44:57 +0000
Message-ID: <20201224094500.19149-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224094500.19149-1-daire.mcnamara@microchip.com>
References: <20201224094500.19149-1-daire.mcnamara@microchip.com>
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

