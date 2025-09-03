Return-Path: <linux-pci+bounces-35373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A41B41F87
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470617A64C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2B3009D9;
	Wed,  3 Sep 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GzM+8BMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FF3009D2;
	Wed,  3 Sep 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903560; cv=none; b=pU1q34UBsEj2CeD9qzeQuFoXssZyStyskM7Z16yemHYUfqJ6atqix11CgVKiBGVrELEHWij3luKM4QLYLTIr+knRLAFOlclYWfTEHQc+lowvXDnpVRxlSIFwkRhLdRFwxvTQ/nh6y2qw9RUh5NAPxQVPcWMUUNiVBjiQpCtQitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903560; c=relaxed/simple;
	bh=0rKjCIL53ZoGeIJRbde0G9R9L27t56ANYAdlbkr0gmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+bXoZn7dpR3B68ruJDDiZTTAKCmfRjaiq4cFXdWVvDGZiMpq/Y+eD3dQ80b5RBxTRIPjgTV/1rf803a3xE9MM5Stz4BWFEVfsVtp38C4ebZQ2mThSoQHkLVEarOSibbHIO34vbrU66BYXm0Uvn7TTW7wbHslZ1oSJv5BEYgGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GzM+8BMV; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CjfCH3263832;
	Wed, 3 Sep 2025 07:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903541;
	bh=de2p5C/waBqZ9EMEHsftDi3gvYva/KwdwBS7gBzFpNM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GzM+8BMVO73Tgb1VeptkY0P5xGIfdNHcpCo/e2OSH8K1ckOCashQWK5KWplbsVZCQ
	 H4erpzqc1u/wfQpuHVtpvMs9jDxaxTglIc621hK1CqLBxGSPYUeQp36gRHBKfkKMgJ
	 d+nX5Cw1yK1XzXUeR04PAUfEYubs/pAVhXrLsnHE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CjeGX3522764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:39 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wV1576150;
	Wed, 3 Sep 2025 07:45:33 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 04/11] PCI: dwc: ep: Export dw_pcie_ep_raise_msix_irq() for pci-keystone
Date: Wed, 3 Sep 2025 18:14:45 +0530
Message-ID: <20250903124505.365913-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The pci-keystone.c driver uses the 'dw_pcie_ep_raise_msix_irq()' helper.
In preparation for enabling the pci-keystone.c driver to be built as a
loadable module, export 'dw_pcie_ep_raise_msix_irq()'.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.43.0


