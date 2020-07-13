Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1521D45A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgGMLCv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 07:02:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47058 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgGMLCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 07:02:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DB2dqV071729;
        Mon, 13 Jul 2020 06:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594638159;
        bh=ZmLHKDhhFvQEACU9S2JTUSC0cmWio3Xl+uM9GiBjHGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nax7QOFOXZLbMbqQ9+/+LOpKABhhH79r4NtDFg0b7qt5+XZIZfHtbSt8xTr1InSRK
         iIDK1oAHEWlfMJMxOo50GDoMP8I1AOsWjZXIHw/ErYI2unqtqRTzUwGDaLcf0jUSFK
         pxVXG3LvqRwIF/2P2bo88k+E8xGa1HtHb585Yahs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06DB2dm7023449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 06:02:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 06:02:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 06:02:38 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DB1gVo031460;
        Mon, 13 Jul 2020 06:02:35 -0500
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
Subject: [PATCH v7 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
Date:   Mon, 13 Jul 2020 16:31:41 +0530
Message-ID: <20200713110141.13156-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713110141.13156-1-kishon@ti.com>
References: <20200713110141.13156-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbc2649566b..bdec73c3069e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13119,12 +13119,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	drivers/pci/controller/dwc/*designware*
 
-PCI DRIVER FOR TI DRA7XX
+PCI DRIVER FOR TI DRA7XX/J721E
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
+F:	drivers/pci/controller/cadence/pci-j721e.c
 F:	drivers/pci/controller/dwc/pci-dra7xx.c
 
 PCI DRIVER FOR TI KEYSTONE
-- 
2.17.1

