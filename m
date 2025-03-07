Return-Path: <linux-pci+bounces-23101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E2A56574
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A71899866
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7772215066;
	Fri,  7 Mar 2025 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cclTrlp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44B215042;
	Fri,  7 Mar 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343527; cv=none; b=Cu9wxqPiFB0ta0PUun6qo2xo5vrFwJTieJHjjvaGzWkCbe9UHcnMeU7o47801PavS9tCxtcYg5Ubm4+4ifmjNcoorDv2ePh5FUWYRnVZmaiOHl/Llbhv/Kvcz5RnaMXTz5Wx/zfYtlzw+xDwMzk1qogn/qxEEUspOP9HxcKunq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343527; c=relaxed/simple;
	bh=OMVhUyYWlgdX7TcTI4E0FGFHjos5oeLgVuXBYMCvOv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKzPDvESrf2m9SSk2o8vF77V38P3BPINIqawGvvSAYjFqzqR6yWgioOVTj3G4FIZOAlRw5JBiAPlicv0rDCxTfpNee7U/IvUPV3u5yYN+HLUx5d2fottI9DReJGWr4s4gli8tt/ej3GeIkzgo76VD3uzYQuln8ved/7GoRFu5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cclTrlp3; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVm9I4039238
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 04:31:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343508;
	bh=JM5PPJ5fDsXxzfleks7tYbcFK1AazkhPSR9dE79PglE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cclTrlp3LyuMRERDTi2Tv8IHBMiZBL2PF0hkn5BzXwF5oW+ykd+6pVnwODjCCEI6l
	 fI38C3Ud+q4HyHPRO6XyhDRkVdJzHPzyX5gjPO/H8mt/ux0LP+aRTlkXVlbiRIohv9
	 D2vnD48j+C5JgeLPR+WvmUVT9c61A2Vw6vVwBiOw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVmU7085238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 04:31:48 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:31:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:31:48 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AVSQ5016876;
	Fri, 7 Mar 2025 04:31:43 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
Date: Fri, 7 Mar 2025 16:01:27 +0530
Message-ID: <20250307103128.3287497-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307103128.3287497-1-s-vadapalli@ti.com>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
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
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index eeb2afdd223e..85bec57fa5d9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
+void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
+{
+	struct device *dev = ep->pcie.dev;
+	struct pci_epc *epc = to_pci_epc(dev);
+
+	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
+			      SZ_128K);
+	pci_epc_mem_exit(epc);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_disable);
 
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 9068f140596a..c2b9dbb7e1db 100644
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


