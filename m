Return-Path: <linux-pci+bounces-38976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2FBFB43A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D0505FB7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678E322A0A;
	Wed, 22 Oct 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jwtAsl8A"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6932FFF9C;
	Wed, 22 Oct 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127092; cv=none; b=qsgekAJ57rBHWFoZwVC/v1/6hK/Ggk18zWpVoojEhapivU6nMBcLONY9IeCBh6qo6xa/QtI4Z6sW8TgsdvsEQA+Zem27wL8w9oIFeZvDChkNnfkN8oqBJBFeplNkngVJZltuZSaSWJh4Qz2sfr4u1lTRipDnLHXNn6p34423TRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127092; c=relaxed/simple;
	bh=BRgu9hnNVZHsgVj0pzqJL+qbJN9qRwliDHyhzZUGgq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZplPURT1yVuvZ5u4SjT7dEwWAv0w8ojuI6lEhEdcYqfG6oxObvlmFT2okExuoPHSCGV/AP7ziws0wG3pZvyuOHcvLoUuB7SWYc5PdqO4iDf+6HFlaF+MBx5BzScPUJAvP6br3USCaqpspXmBZnP2evB3YCCqXVgnW1sGKlHPtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jwtAsl8A; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59M9vYJA1376542;
	Wed, 22 Oct 2025 04:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761127054;
	bh=11ikX1sFn7k/YSRdSbKKr00GnN/L9b+csqVGwtKcwdY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jwtAsl8ASyy6in/v9KTdZsJqK/VQHrQyzAN16br0IQq0Y7ZRif+cCd9My5wa5c5Gv
	 pUHiEu8XEE4vgKn5ER3TAB+GLvY1Ts0rkSZrYHWjXgdPx80iO+9nz9RGE+8aPeWL14
	 +hPVebUkaN/9X2kf93Otipcq9cPVlg186ZpN4SQM=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59M9vYU61842698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 04:57:34 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 04:57:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 04:57:34 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59M9vFcX1029418;
	Wed, 22 Oct 2025 04:57:28 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
Date: Wed, 22 Oct 2025 15:27:10 +0530
Message-ID: <20251022095724.997218-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022095724.997218-1-s-vadapalli@ti.com>
References: <20251022095724.997218-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The pci-keystone.c driver uses the functions 'dw_pcie_allocate_domains()'
and 'dw_pcie_ep_raise_msix_irq()'. In preparation for enabling the
pci-keystone.c driver to be built as a loadable module, export them.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3:
https://lore.kernel.org/r/20250922071222.2814937-3-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on 6.18-rc1 tag of Mainline Linux.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7f2112c2fb21..19571ac2b961 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -797,6 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
 
 /**
  * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..d74bc571f65d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -232,6 +232,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
 
 void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
-- 
2.51.0


