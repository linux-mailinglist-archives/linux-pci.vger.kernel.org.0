Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21B23486B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfFDNUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:20:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50654 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFDNUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:20:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DJAAb082616;
        Tue, 4 Jun 2019 08:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654350;
        bh=UKvZFHhLfWqJN8szV0n3HDRRib7xlqnLbQ1/SCsgu+A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hIQ5qd7WEl6VSmRQ8gB2DGA1lPMHQAUJLcGd9vXHB7Oax1YgSsEyjQR8TUSpX+/Mo
         poFfVHGSwDMH5XCHHbYjJvQqbRLL49824VPcgdX9pfpyK5HcEusrBTJ28juqwZAMvD
         6LozB3ajkSgfW+5PqESueCxhGFVEW1ROMG+/7x8w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DJApZ045197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:19:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:19:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:19:09 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGg098972;
        Tue, 4 Jun 2019 08:19:04 -0500
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
Subject: [RFC PATCH 26/30] MAINTAINERS: Add MAINTAINER entry for PCIe on TI's J721E SoC
Date:   Tue, 4 Jun 2019 18:45:12 +0530
Message-ID: <20190604131516.13596-27-kishon@ti.com>
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

Add MAINTAINER entry for PCIe on TI's J721E SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..8a421949f335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12122,13 +12122,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	drivers/pci/controller/dwc/*designware*
 
-PCI DRIVER FOR TI DRA7XX
+PCI DRIVER FOR TI DRA7XX/J721E
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
 F:	drivers/pci/controller/dwc/pci-dra7xx.c
+F:	drivers/pci/controller/pci-j721e.c
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
-- 
2.17.1

