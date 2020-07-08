Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA62183B9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGHJay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 05:30:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59296 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgGHJax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 05:30:53 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0689UgQ0103018;
        Wed, 8 Jul 2020 04:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594200642;
        bh=CWIKltqarvAYPvUpTOXv+9gnETqUvut1kE2gYgu5r3Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cSG8wSO4rJiPvVfZ3xSchQTR1lNa6KqywznDEz/rQabJ2vRKXaJ9uDOvW91vhhv57
         Zft7pJf2TWzbRp2RLdzeHt8BUJC2kiASLwjzoefkl4Tk5BZuG7wYFOfRzdsjXI8UG+
         97tCjNk0UrzzSZ1mRMiiBZbmMr40VOzRKR6e7WkY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0689UgFL095666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jul 2020 04:30:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 04:30:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 04:30:42 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0689UJEM098512;
        Wed, 8 Jul 2020 04:30:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 05/14] PCI: cadence: Allow pci_host_bridge to have custom pci_ops
Date:   Wed, 8 Jul 2020 15:00:09 +0530
Message-ID: <20200708093018.28474-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708093018.28474-1-kishon@ti.com>
References: <20200708093018.28474-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like TI's J721E allows only 32-bit configuration
space access. In such cases pci_generic_config_read and
pci_generic_config_write cannot be used. Add support in Cadence core
to let pci_host_bridge have custom pci_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index de02fadc4809..a8303258874c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -505,7 +505,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->busnr = pcie->bus;
-	bridge->ops = &cdns_pcie_host_ops;
+	if (!bridge->ops)
+		bridge->ops = &cdns_pcie_host_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-- 
2.17.1

