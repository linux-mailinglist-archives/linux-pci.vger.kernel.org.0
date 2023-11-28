Return-Path: <linux-pci+bounces-199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5927FB16C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC6A281D3A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 05:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB310792;
	Tue, 28 Nov 2023 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mcmbzLru"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05759D0;
	Mon, 27 Nov 2023 21:44:28 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i8nM001892;
	Mon, 27 Nov 2023 23:44:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701150248;
	bh=m6go9cv+AkGb2YjL9avWYu4KLMkj1Dm1Ss+5Mn8+XWs=;
	h=From:To:CC:Subject:Date;
	b=mcmbzLru0CfhpVnFwW6rP86N6VtXFPWbdLbT+zhfpGMeu+gFFXp+R2jkJr7MkrrWB
	 wnYB59ACIszb3M/2rcO4t0+jr9w4QGy/j/TLU6C1oEx/+OO/RMMeonTHE1IWL62q/D
	 Cy2yNx04VwKed+XBJWDuU8k/UvEQwedmtS2rDTlI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5i8Kr055807
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Nov 2023 23:44:08 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:44:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:44:07 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i2uO096776;
	Mon, 27 Nov 2023 23:44:03 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <tjoseph@cadence.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v13 0/5] PCI: add 4x lane support for pci-j721e controllers
Date: Tue, 28 Nov 2023 11:13:57 +0530
Message-ID: <20231128054402.2155183-1-s-vadapalli@ti.com>
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

Hello,

This series adds support to the pci-j721e PCIe controller for up to 4x Lane
configuration supported by TI's J784S4 SoC. Bindings are also added for
the num-lanes property which shall be used by the driver. The compatible
for J784S4 SoC is added.

This series is based on linux-next tagged next-20231128.

Regards,
Siddharth.

---
v12:
https://patchwork.kernel.org/project/linux-pci/cover/20230401112633.2406604-1-a-verma1@ti.com/
Changes since v12:
- Rebased series on linux-next tagged next-20231128.
- Reordered patches with bindings patches first followed by driver
  patches.
- Collected Reviewed-by tag from
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  which was missed in the v12 series as pointed out at:
  https://patchwork.kernel.org/project/linux-pci/patch/20230401112633.2406604-2-a-verma1@ti.com/


Matt Ranostay (5):
  dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
  dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add PCIe 4x lane selection support
  PCI: j721e: add j784s4 PCIe configuration

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 39 ++++++++++++++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 39 ++++++++++++++--
 drivers/pci/controller/cadence/pci-j721e.c    | 45 ++++++++++++++++---
 3 files changed, 112 insertions(+), 11 deletions(-)

-- 
2.34.1


