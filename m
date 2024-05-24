Return-Path: <linux-pci+bounces-7810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4E8CE348
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 11:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237BB1C21299
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3083CDB;
	Fri, 24 May 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XigUxglO"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079E29422;
	Fri, 24 May 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542651; cv=none; b=NiJGsf7I3ig9y93/IqQBuEjKfjxSG6k+5SPsts3idTgG/c91IJyF6bnGAir9wvUFLLn5o9JRpGNu6o9QB/aZ/itu52ltWI2MDVnNZr4pEP0wKXvf66sIhTTJGBhMA4fhXWyHfojMMKnU69wrTDU0zR7dk3hT0Hqjmbo59pPh5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542651; c=relaxed/simple;
	bh=RAmab92sujYQvz3UDC4GHF4aqlxWZk/kyqGztRV6jRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irHkN19q/5xmaOK4u/uuEbG6Ttn8+fQ6IV6ziWJot0j/HJyPBjFqAUc54/CJXd9/6msuYYCeX1jcT4oNdCnVk/fHn7Uxf7ZvvXr0TzbBbVr7D+ANUrC1QXg3DiWwYRR/VeHPdnwXwBiFcJkFQOBz2dtgny5b/dgsbDaUZb14ioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XigUxglO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O9NstN036306;
	Fri, 24 May 2024 04:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716542634;
	bh=vXHiKvNpLjQ6FdW1+zjJDk/5vz/rj1Ewk5lFM49oMuM=;
	h=From:To:CC:Subject:Date;
	b=XigUxglOAF9ge4CzQnNEospxrB9WVbUmIBUvIIMS4Axa/wQZSTu0ipmU91d8lXlP0
	 zrzL7ykYH21PKrL/xJomgGhWv9jnweO0GL9NkF9vR9lP2/DbqFJxIGE+FaRYM3/IUo
	 0SruhOd5OiJJE2oYy3ODL58j8AdBZbxiwbrZDmmE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O9NsG8113217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:23:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:23:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:23:54 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O9NouT022831;
	Fri, 24 May 2024 04:23:50 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Add PCIe support for J722S SoC
Date: Fri, 24 May 2024 14:53:49 +0530
Message-ID: <20240524092349.158443-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J722S SoC has one instance of PCIe namely PCIe0 which is a Gen3
single lane PCIe controller. Add support for the "ti,j722s-pcie-host"
compatible specific to J722S SoC.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240523.
The dt-bindings patch for the compatible at:
https://lore.kernel.org/r/20240124122936.816142-1-s-vadapalli@ti.com/
has been accepted and merged:
https://git.kernel.org/pci/pci/c/01fec70206d4

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..cde6cd77e406 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -344,6 +344,13 @@ static const struct j721e_pcie_data j784s4_pcie_ep_data = {
 	.max_lanes = 4,
 };
 
+static const struct j721e_pcie_data j722s_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+	.max_lanes = 1,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -377,6 +384,10 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,j784s4-pcie-ep",
 		.data = &j784s4_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j722s-pcie-host",
+		.data = &j722s_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.40.1


