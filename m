Return-Path: <linux-pci+bounces-24981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C3A758EE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B6188B30A
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16A18DF6E;
	Sun, 30 Mar 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nQwRnD8M"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5818D620;
	Sun, 30 Mar 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323996; cv=none; b=I3hDNBU0ljRTJqZZajy6O2lqAfWPQbKN6rW6/w8ZihpwPYB5v4xZkFCTpc4qVHxuV9VgopjGOyJtHnsRrwGMk4rvSmLWQLts9vJcOXgsaejjEbgWUeok/wBTslu7dGE0DOGCk6uPmVSwLxUlD2FQ7zm/GRrQoGu84XBFJ4rgwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323996; c=relaxed/simple;
	bh=jzfUdFh38S7kep++X+9RcIkt8Ey2ejNjv5Tx9YZiLyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8s7gUMNGJUZCLLGrzWEW23jcXTQy2SlUgduEmaqcokhWW6mMlzgTm4JruTY+p427q7HZdtQ8jmZxxcIcIzYgazhtiB8hBhGODoC+gBYateXpTWb2yyrljGlXs1+DQB9uwZ7EqD4Qs03rD9KtJkscgQBn7vUORhOhaLFOauKiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nQwRnD8M; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52U8dZ8X2526495
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Mar 2025 03:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743323975;
	bh=0OvibrkHCj6OYMNdUB0hqSZ+ASu0ihoTHEbmaPG4+MQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nQwRnD8MsvAaFKzMAr+MjYX5mSSydDTGARQRWS6iTROWWhLMDa6cwkIyvm+DiSW9H
	 7D+HbRPhZ7hJcIl+te+g19rTIILRSEgdxFEEn3BNeyuYIbRoSOhvbjJ4ascPDBE7HF
	 YyLGI/plIwfg7vyPN+UsKXWdOhF/HP07QS2j74A0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52U8dZPr020435
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 30 Mar 2025 03:39:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Mar 2025 03:39:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Mar 2025 03:39:34 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52U8dE4j015769;
	Sun, 30 Mar 2025 03:39:30 -0500
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
Subject: [PATCH v2 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
Date: Sun, 30 Mar 2025 14:09:13 +0530
Message-ID: <20250330083914.529222-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250330083914.529222-1-s-vadapalli@ti.com>
References: <20250330083914.529222-1-s-vadapalli@ti.com>
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
---

v1:
https://lore.kernel.org/r/20250307103128.3287497-4-s-vadapalli@ti.com/
Changes since v1:
- Based on feedback from Mani at:
  https://lore.kernel.org/r/20250318080304.jsmrxqil6pn74nzh@thinkpad/
  pci_epc_deinit_notify() has been included in cdns_pcie_ep_disable().

Regards,
Siddharth.

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


