Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54EE1C73E5
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgEFPPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:15:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33198 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgEFPPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:15:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046FFTWn065409;
        Wed, 6 May 2020 10:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588778129;
        bh=lfI1h+3lQGMBFBStpi63mpUEBxVTfLRQlu/dzMBT+rU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UVdXiryiUy2GzhxnHBR+NqepfqIFuySgoXv7HakdfA05hiFHJ7A3wfM5G/BgaHow7
         EvCboswm8dnhRPLzzGF6LyncINDpPFEJuhDH4fpOG3c2y9YAORrO0HTVTaTDxceew1
         iFBYtBSadsGdWIsOt6YYDKS3wM890cShOgeIDpyc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FFTfc017288;
        Wed, 6 May 2020 10:15:29 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 10:15:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 10:15:28 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FEUgK119457;
        Wed, 6 May 2020 10:15:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v4 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
Date:   Wed, 6 May 2020 20:44:29 +0530
Message-ID: <20200506151429.12255-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506151429.12255-1-kishon@ti.com>
References: <20200506151429.12255-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..9d40e1318f7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12978,12 +12978,14 @@ S:	Maintained
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

