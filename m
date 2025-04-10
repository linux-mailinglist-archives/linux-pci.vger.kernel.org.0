Return-Path: <linux-pci+bounces-25622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BCA84122
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 12:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D349C3BF181
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A6281527;
	Thu, 10 Apr 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L6QbayLA"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3128137A;
	Thu, 10 Apr 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281904; cv=none; b=t4RsLCvmiNAl9QD5Z//KmAt2Xg9EeN7CEJWQ6bHDETdBZraFz5pR+GGQDC7rF5dKOlZhxRnpKx8fbLl9vzYGIjt6BYUmtpk9pX2L65FSwlMlOUMoAegmblADGDiDKTR8JU4urvUYHfHEREZ1s9HTQScdXwBfhRmCvdYQC5dmLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281904; c=relaxed/simple;
	bh=eedXCPmCCorDOsO4XojZMpdVqKfg+pev9xgm9hTBjHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nviBYv48FipsBLkJCJVD8izGr8pWgvckBdJmPXkydWhW0jICvhMm6EnGWFF+hwIJgYZlawCfzzmTh6TvS3bVuyNDSOgqjtrVCky4ydefJzVniksjd8ogqiSjpxAUL/+zPPEh4sPOcPuj3IAGKaDmP5fwyGSXM22LuWxXVGFZQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L6QbayLA; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAigmq1262915
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 05:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744281883;
	bh=6oNhVhBQDe0ExOICI7uEi3QjAgNGfBSq7YsxJHzBLhs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L6QbayLA9nV4PU5AqlGhdfMOL24ssJrpils2hZGyiq9hTeilqHNAEqWHh/LQs4ldj
	 r3+N90SUmm/JDQk1C4i3qbtFAnqfgPHZ2IubsuFwxJfEHdRnRVG7XY7S3LqyY8Tym0
	 f+3LH1/cpM2VeLGQCDZnC9XUm9Q4buslHS9egdMg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAigSx010046
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 05:44:42 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 05:44:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 05:44:42 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AAiRfd029210;
	Thu, 10 Apr 2025 05:44:37 -0500
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
Subject: [PATCH v3 2/4] PCI: cadence-host: Introduce cdns_pcie_host_disable helper for cleanup
Date: Thu, 10 Apr 2025 16:14:24 +0530
Message-ID: <20250410104426.463453-3-s-vadapalli@ti.com>
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

Introduce the helper function cdns_pcie_host_disable() which will undo
the configuration performed by cdns_pcie_host_setup(). Also, export it
for use by existing callers of cdns_pcie_host_setup(), thereby allowing
them to cleanup on their exit path.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

v2 of this patch is at:
https://lore.kernel.org/r/20250330083914.529222-3-s-vadapalli@ti.com/
No changes since v2.

 .../controller/cadence/pcie-cadence-host.c    | 104 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |   5 +
 2 files changed, 109 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 96055edeb099..741508738f88 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -152,6 +152,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 	return ret;
 }
 
+static void cdns_pcie_host_disable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val & ~CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+}
+
 static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 {
 	u32 val;
@@ -177,6 +185,26 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 	return ret;
 }
 
+static void cdns_pcie_host_deinit_root_port(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 value, ctrl;
+
+	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, 0xffff);
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0xff);
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0xff);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, 0xffffffff);
+	cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, 0xffff);
+	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
+	value = ~(CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
+}
+
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -393,6 +421,32 @@ static int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
         return resource_size(entry2->res) - resource_size(entry1->res);
 }
 
+static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	enum cdns_pcie_rp_bar bar;
+	u32 value;
+
+	/* Reset inbound configuration for all BARs which were being used */
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (rc->avail_ib_bar[bar])
+			continue;
+
+		cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar), 0);
+		cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar), 0);
+
+		if (bar == RP_NO_BAR)
+			continue;
+
+		value = ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+			  LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+			  LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+			  LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+			  LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
+	}
+}
+
 static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -430,6 +484,29 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static void cdns_pcie_host_deinit_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource_entry *entry;
+	int r;
+
+	cdns_pcie_host_unmap_dma_ranges(rc);
+
+	/*
+	 * Reset outbound region 0 which was reserved for configuration space
+	 * accesses.
+	 */
+	cdns_pcie_reset_outbound_region(pcie, 0);
+
+	/* Reset rest of the outbound regions */
+	r = 1;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		cdns_pcie_reset_outbound_region(pcie, r);
+		r++;
+	}
+}
+
 static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -487,6 +564,12 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	return cdns_pcie_host_map_dma_ranges(rc);
 }
 
+static void cdns_pcie_host_deinit(struct cdns_pcie_rc *rc)
+{
+	cdns_pcie_host_deinit_address_translation(rc);
+	cdns_pcie_host_deinit_root_port(rc);
+}
+
 int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 {
 	int err;
@@ -499,6 +582,14 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_init);
 
+static void cdns_pcie_host_link_disable(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+
+	cdns_pcie_stop_link(pcie);
+	cdns_pcie_host_disable_ptm_response(pcie);
+}
+
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -524,6 +615,19 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_link_setup);
 
+void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+
+	cdns_pcie_host_deinit(rc);
+	cdns_pcie_host_link_disable(rc);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_disable);
+
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 4b7f295e24e7..0b6bed1ac146 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -523,6 +523,7 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 #else
@@ -541,6 +542,10 @@ static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
+{
+}
+
 static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 					     int where)
 {
-- 
2.34.1


