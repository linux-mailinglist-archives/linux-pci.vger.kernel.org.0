Return-Path: <linux-pci+bounces-22967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171EA5007A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA5D3AFCF9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A71248866;
	Wed,  5 Mar 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TUrSuYzp"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B40244EAB;
	Wed,  5 Mar 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180839; cv=none; b=djVUQetD74adR0eN7YMfsCTMt9LzW2aknqqWJbh4VHgRZWgHrTPqfNJvGM3N5N/KW7HvOSiUZrjxBN+t6HD4hqNVTWc5vdj8rZhCZC0CgBNo5Nvq58jAGCjGTu9x+/icK8N1E0NBQo1EE2d24D5ebcAHsUeZhSuXps0dwAZLBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180839; c=relaxed/simple;
	bh=zH2/4JizMiAMVXhTiVjJB3Lhravh6eEMRHBsD4S9ULo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6WyTsMMK9NXNUhgOKWGm0RjYQCvF69UD/Tm3NU6pYvcPEyDpkwVJ46IDmad4bAsDHhruNsqXkA8J8DdBq7i5TuVIv1WTWPUUTnBu1LS4Ae/Auqu5/Ru1MX/8OvoykMMEU84vYIp2c0sXfjo17pfCv3tgZFYdhZRKurROUdiItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TUrSuYzp; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525DKOoI3317275
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 07:20:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741180824;
	bh=P/KXpuyFB30i1d562EaQZDZEqM46LSzSTn8A8q72DM0=;
	h=From:To:CC:Subject:Date;
	b=TUrSuYzpfWMoOwbN9hfX5/dawgO/BL8WRpXonYkwgg8GT0pwL81tQtkLl0WFuQzD2
	 KNbuvw0VhzDo2ie+L1F90YGar5MZ2AuWnmxvzbxWt3ilYf5Zr49Wm4hTJwHTL1kcKK
	 WELP7VjjvREuBwKpnhTARTW7jI3gtCmF8Imj2OrU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 525DKOFq019757
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 07:20:24 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 07:20:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 07:20:23 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525DKJ35105399;
	Wed, 5 Mar 2025 07:20:19 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <rogerq@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for J784S4
Date: Wed, 5 Mar 2025 18:50:18 +0530
Message-ID: <20250305132018.2260771-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Commit under Fixes assigned the value of 'linkdown_irq_regfield' for the
J784S4 SoC as 'LINK_DOWN' which corresponds to BIT(1). However, according
to the Technical Reference Manual and Register Documentation for the J784S4
SoC [0], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1" which is __NOT__
the field for the link-state interrupt. Instead, it is BIT(10) of the
"PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds to the link-state
field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".

Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
already reuse this macro since it accurately represents the link-state
field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.

[0]: https://www.ti.com/lit/zip/spruj52
Fixes: e49ad667815d ("PCI: j721e: Add TI J784S4 PCIe configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
48a5eed9ad58 Merge tag 'devicetree-fixes-for-6.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
of the master branch of Linux.

Patch has been tested on J784S4-EVM, validating that disconnecting an
Endpoint Device connected to J784S4-EVM results in the following message
on the J784S4-EVM:
	j721e-pcie 2900000.pcie: LINK DOWN!
which wasn't seen earlier.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0341d51d6aed..1da9d9918d0d 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -376,13 +376,13 @@ static const struct j721e_pcie_data j784s4_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data j784s4_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
-	.linkdown_irq_regfield = LINK_DOWN,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.max_lanes = 4,
 };
 
-- 
2.34.1


