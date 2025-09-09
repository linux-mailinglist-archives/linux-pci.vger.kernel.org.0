Return-Path: <linux-pci+bounces-35729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45562B4A305
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83CB16D780
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F5307AD8;
	Tue,  9 Sep 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0JibHB2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22763305065;
	Tue,  9 Sep 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401693; cv=none; b=eonMO66vL+0qvkY+jLH1OAWfhByAKjChBdaaH7u2yYLvBdXbje77St2lnPkKz9Huz2fTbNZkat0ELqqSzFJ88h6EN74kxYQrqxzuF8mlokc+3D3fRzKr28VWcYf4OrljHAufimDGGwLwhlO4rNuoV9U99nrmYTMb/DSe4Eb8AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401693; c=relaxed/simple;
	bh=pJ/zy2j2yL48etAelVsHr4zQ0MwUIqr2xqTE+1DT7Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuKb5PWFHzB5cix4Fjishfe8V2qiNTNH2V2JGBbjLXY8Kod1DgnA4FYbQVQXaweIbqcsLHINHkHx13c8aR/pDceXYvPXfmvuZO+uN/quGgAN4p3m6vqqmuyPSfYeZgwKJi3Fa7WkdzosziZ+kJ3FH+qnHPlo5n7bO04mihd3c2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0JibHB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C7FC4CEF5;
	Tue,  9 Sep 2025 07:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757401692;
	bh=pJ/zy2j2yL48etAelVsHr4zQ0MwUIqr2xqTE+1DT7Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V0JibHB2kj7X9a9Vfwv+du9WGzKpx8vDIntIQaG+Dmhep+5WMVJ3vRvW6NVcGhFcA
	 DHATo/tqN/d7V6cfze5AcleFoDLYIpehf4LHljgJcXzyNLAEdqEsXTVdQrwvJLb26h
	 W+IFOsjlHBDuSpNXOa1X43lKPcj/T7D1aI7x04PF448d1nfvETN/Lwz58kvHz7v5bK
	 REePYZhn73n/PdiJuRjB30NXSmRJDwFUFD1jijZ369wvjSE++uLFwmgW6Kh4+3FXlv
	 sHU388vACgttkqaorfauIdzMjRBLFpjAz/rCpio4fiFdXrVX36Iah7UY8Tc+dBT7d4
	 BbhNSThXIwT7g==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Tue, 09 Sep 2025 12:37:51 +0530
Subject: [PATCH v9 2/4] PCI: dwc: Prepare the driver for enabling ECAM
 mechanism using iATU 'CFG Shift Feature'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-controller-dwc-ecam-v9-2-7d5b651840dd@kernel.org>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
In-Reply-To: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8333; i=mani@kernel.org;
 h=from:subject:message-id; bh=qxCp8ufCt4ZHsD2ezcKN0nfE2cMC50zEF4EN1QGHCQQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBov9JNCF+qKFP1XSWCTQgMUWIriRSN+D0rnVfw3
 bFTaqD8G2qJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaL/STQAKCRBVnxHm/pHO
 9b1bB/9rtiXNZRe1TqeiOHyBJKmmZAOr7MUC/+hYl1wv+VRkxusfl/hz9jExipgujp4B99t9TXG
 VqW0D0oHrTYejtS6TGqtJT5PkpgdwojlQ8XdoVcVBeSr2ASf/VJRri6p9qRcQbqqspYLwwUWtDJ
 hEFLIgCxLtpkCWb6ZGPisWIsY9vqdUYoLXInQFFs1vZ/PptQ3lXWEfmp0kM/2I6IEoRdXXXeGqt
 CFPgmUHGbcoz8u2ySfmfpthp/yManeQD3/MAJ3DrxjTpfWfkm6JFkVGWV2gNZIvR/q+7K/jrdui
 Y1FWB+YGE1RhdjkxGXaAz1MkZroFAbcUMC5icvTWbTuGkSR9
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

In order to enable PCIe ECAM mechanism in DWC driver as per the 'CFG Shift
Feature' documented in Designware databook r5.20a, sec 3.10.10.3, prepare
the driver to handle the one time iATU setup and creating ECAM window.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: splitted the preparatory code into a separate commit for bisectability]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 116 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   5 +
 4 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -20,6 +20,7 @@ config PCIE_DW_HOST
 	bool
 	select PCIE_DW
 	select IRQ_MSI_LIB
+	select PCI_HOST_COMMON
 
 config PCIE_DW_EP
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..94e0fe11a0b062d0f14e09fe586e20bde46a4266 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -413,6 +413,67 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = {0};
+	resource_size_t bus_range_max;
+	struct resource_entry *bus;
+	int ret;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+
+	/*
+	 * Root bus under the host bridge doesn't require any iATU configuration
+	 * as DBI region will be used to access root bus config space.
+	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * remaining buses need type 1 iATU configuration.
+	 */
+	atu.index = 0;
+	atu.type = PCIE_ATU_TYPE_CFG0;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
+	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
+	atu.size = SZ_1M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	bus_range_max = resource_size(bus->res);
+
+	if (bus_range_max < 2)
+		return 0;
+
+	/* Configure remaining buses in type 1 iATU configuration */
+	atu.index = 1;
+	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
+	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+
+	return dw_pcie_prog_outbound_atu(pci, &atu);
+}
+
+static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct resource_entry *bus;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pp->cfg))
+		return PTR_ERR(pp->cfg);
+
+	pci->dbi_base = pp->cfg->win;
+	pci->dbi_phys_addr = res->start;
+
+	return 0;
+}
+
 static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -422,10 +483,6 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	struct resource *res;
 	int ret;
 
-	ret = dw_pcie_get_resources(pci);
-	if (ret)
-		return ret;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!res) {
 		dev_err(dev, "Missing \"config\" reg space\n");
@@ -435,9 +492,31 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	pp->cfg0_size = resource_size(res);
 	pp->cfg0_base = res->start;
 
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_create_ecam_window(pp, res);
+		if (ret)
+			return ret;
+
+		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->sysdata = pp->cfg;
+		pp->cfg->priv = pp;
+	} else {
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+
+		/* Set default bus ops */
+		pp->bridge->ops = &dw_pcie_ops;
+		pp->bridge->child_ops = &dw_child_pcie_ops;
+		pp->bridge->sysdata = pp;
+	}
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret) {
+		if (pp->cfg)
+			pci_ecam_free(pp->cfg);
+		return ret;
+	}
 
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
@@ -476,14 +555,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	/* Set default bus ops */
-	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_child_pcie_ops;
-
 	if (pp->ops->init) {
 		ret = pp->ops->init(pp);
 		if (ret)
-			return ret;
+			goto err_free_ecam;
 	}
 
 	if (pci_msi_enabled()) {
@@ -525,6 +600,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
+			goto err_free_msi;
+		}
+	}
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -560,8 +643,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		/* Ignore errors, the link may come up later */
 		dw_pcie_wait_for_link(pci);
 
-	bridge->sysdata = pp;
-
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto err_stop_link;
@@ -587,6 +668,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+err_free_ecam:
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -609,6 +694,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
+
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 93da8a26c9313dfdd6b269a90bbfb017aab2abe7..ee8caae1edbd44c10e6986430a6932c10f20a9eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -575,7 +575,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	val = PCIE_ATU_ENABLE;
+	val = PCIE_ATU_ENABLE | atu->ctrl2;
 	if (atu->type == PCIE_ATU_TYPE_MSG) {
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ceb022506c3191cd8fe580411526e20cc3758fed..cfeb99b89c3739b867a54da38e0f94835c2ce3a0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/reset.h>
 
 #include <linux/pci-epc.h>
@@ -169,6 +170,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
@@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
+	u32 ctrl2;
 	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
@@ -425,6 +428,8 @@ struct dw_pcie_rp {
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
+	struct pci_config_window *cfg;
+	bool			ecam_enabled;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.45.2


