Return-Path: <linux-pci+bounces-2139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD882D44F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 07:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC88A1C21068
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D21FB9;
	Mon, 15 Jan 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V8Xpxit+"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7096FA1;
	Mon, 15 Jan 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40F5qfME121268;
	Sun, 14 Jan 2024 23:52:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705297961;
	bh=kHXNzqbBb5FPPwGvP0vugldGfFsecWuQTVR1E17V5YQ=;
	h=From:To:CC:Subject:Date;
	b=V8Xpxit+Nl1Idr2XbZF5kvWzK+mDoHOe4e3/WYprvQckWQejoanEM2vQIvte67ImM
	 vcP90DIrGQc/GlV+R291FQyTDSp3Y8cgBMU4GnxhosQJ9fYi3tzb5quEQH1svs2p+f
	 5gFSwSJCj60hZ564Z+aWzxFzJprPZMDZzQtDQRyE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40F5qfYU026086
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Jan 2024 23:52:41 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 14
 Jan 2024 23:52:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 14 Jan 2024 23:52:40 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40F5qbWo065972;
	Sun, 14 Jan 2024 23:52:37 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] dt-bindings: PCI: ti,j721e-pci-host: Add device-id for TI's J784S4 SoC
Date: Mon, 15 Jan 2024 11:22:36 +0530
Message-ID: <20240115055236.1840255-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the device-id of 0xb012 for the PCIe controller on the J784S4 SoC as
described in the CTRL_MMR_PCI_DEVICE_ID register's PCI_DEVICE_ID_DEVICE_ID
field. The Register descriptions and the Technical Reference Manual for
J784S4 SoC can be found at: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---

This patch is based on linux-next tagged next-20240112.

v1:
https://lore.kernel.org/r/20240108050735.512445-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on linux-next tagged next-20240112.
- Collected Acked-by tag from Rob Herring <robh@kernel.org>
  https://lore.kernel.org/r/170511031475.3817032.5482957589582376350.robh@kernel.org/

Regards,
Siddharth.

 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b7a534cef24d..0b1f21570ed0 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -68,6 +68,7 @@ properties:
       - 0xb00d
       - 0xb00f
       - 0xb010
+      - 0xb012
       - 0xb013
 
   msi-map: true
-- 
2.34.1


