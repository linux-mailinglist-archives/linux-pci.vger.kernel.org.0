Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000EC1DDE03
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEVDhK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:37:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40764 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgEVDhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:37:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3avUQ037552;
        Thu, 21 May 2020 22:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118617;
        bh=E1+nl2POLr4YXcESrC9ndScOG8Z4RvVi75igtox9xS0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hv6/zer0dLOtFpZvMFxRWatLhJXAmx97BmIaqQeULy0ypCTmfBJPZv3Wag/okBZ0D
         zReUJPEEaPtnq40Oq/8o3ZsILfhMpZMlScwUAEPu2bU6e4tOik657iqaLdrtfxzfHl
         VIQ2d3caRiXnynFoPYtVrapSZ8YAG46jH+hdl2wM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M3avRt028478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:36:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:36:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:36:57 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aYc1062596;
        Thu, 21 May 2020 22:36:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 05/14] PCI: cadence: Allow pci_host_bridge to have custom pci_ops
Date:   Fri, 22 May 2020 09:06:22 +0530
Message-ID: <20200522033631.32574-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522033631.32574-1-kishon@ti.com>
References: <20200522033631.32574-1-kishon@ti.com>
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
index 93a9414932a9..62796791f02c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -508,7 +508,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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

