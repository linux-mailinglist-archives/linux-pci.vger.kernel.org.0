Return-Path: <linux-pci+bounces-25623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0AA8411A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56DA1B61679
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266E283C94;
	Thu, 10 Apr 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f4TF52hp"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349F256C75;
	Thu, 10 Apr 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281908; cv=none; b=U24URGCGhmZYRLpaGvnxcQNaiQ3tG1VnPtGnduWX0c4OqHWh9Q1EeE6WcJyJIZJ4i2eIwBW3CrIK3PczWYZ4NfPRf1lBjYAnTaXd18qiPdLTh30302P0jrIizOBTVVyvoD5t0o4CMhVYxfrKrPB7On4UbB+tOd3zt1TCTYZMl0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281908; c=relaxed/simple;
	bh=qJMep0IuR1hUg4kNR5ox2qtiaKWex0TeOOR6JHM6XeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9qwlAT1k+1zhwbxMXDqs4l70ASQsQWhTkiB6RX6GyTg+BFZ7nDmFC0HGf2k803DP8L3hrI7Dx93lPImDMw7/c9COSovLn2fi3hvZcTt7nKDLjZcZDBvHiapFKGX3fVmcRcsxx97mA5owiI/kxVgp8K0nYpQtulII6QRbqqy95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f4TF52hp; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAim4o1783713
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 05:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744281888;
	bh=d+wIYi/J/bVt76+nQq066VNDmULEdyty0tMuUEshfLQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=f4TF52hpYRbI9chP/rPsADwSkW5PdouymuiY5lCFixBS2HT2XHgUQabfySydcvPqj
	 2TNSh5RzmW1sEmbrzniwX52mT0dARajNkXRezkm/R1K6prOH/O66SthVvBnqrwYauL
	 1GR3sPFaUjnRp96PLfZTs1nZsI27qEQ/9BqND/g8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAil9G010070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 05:44:47 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 05:44:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 05:44:47 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AAiRfe029210;
	Thu, 10 Apr 2025 05:44:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <18255117159@163.com>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
Date: Thu, 10 Apr 2025 16:14:25 +0530
Message-ID: <20250410104426.463453-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410104426.463453-1-s-vadapalli@ti.com>
References: <20250410104426.463453-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Introduce the helper function cdns_pcie_ep_disable() which will undo the
configuration performed by cdns_pcie_ep_setup(). Also, export it for use
by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
to cleanup on their exit path.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

v2 of this patch is at:
https://lore.kernel.org/r/20250330083914.529222-4-s-vadapalli@ti.com/
Changes since v2:
- Collected Reviewed-by tag from
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

 drivers/pci/controller/cadence/pcie-cadence-ep.c | 11 +++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b4bcef2d020a..ffd19cb25eed 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -645,6 +645,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
+void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
+{
+	struct device *dev = ep->pcie.dev;
+	struct pci_epc *epc = to_pci_epc(dev);
+
+	pci_epc_deinit_notify(epc);
+	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
+			      SZ_128K);
+	pci_epc_mem_exit(epc);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_disable);
 
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 0b6bed1ac146..387174d6e453 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -555,11 +555,16 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
 
 #if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
+void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep);
 #else
 static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
 	return 0;
 }
+
+static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
+{
+}
 #endif
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
-- 
2.34.1


