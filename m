Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED717116931
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfLIJVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 04:21:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49524 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfLIJVc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 04:21:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99LPHq026154;
        Mon, 9 Dec 2019 03:21:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575883285;
        bh=cTJomjNQR0NW5SRIkkORWQfkiTKy/NfWuwZUGbbS3uA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OAleDUDjlZrmKYS+2pxGC/MILdtul2ndm1T8f/23r67hG0phlm7zivhm2j55WszWv
         r5oReC8nsFTwMKKWg7+GQHBpLAlNn9Cm/nMTKlYAZN5ylm4UEn2H59yF6fciiSnp/O
         8ExJYRSQ1+x7NxBuefTLcudPpqVk55e4ojIwdYsk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99LPBZ064204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:21:25 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:21:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:21:25 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99KcdB087697;
        Mon, 9 Dec 2019 03:21:22 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 13/13] MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
Date:   Mon, 9 Dec 2019 14:51:47 +0530
Message-ID: <20191209092147.22901-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
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
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..a9533d0752de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12691,13 +12691,14 @@ S:	Maintained
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
+F:	drivers/pci/controller/cadence/pci-j721e.c
 
 PCI DRIVER FOR TI KEYSTONE
 M:	Murali Karicheri <m-karicheri2@ti.com>
-- 
2.17.1

