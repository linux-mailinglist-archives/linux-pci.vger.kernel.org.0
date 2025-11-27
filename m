Return-Path: <linux-pci+bounces-42202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45DC8E8DB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 14:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00303A9484
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006D2874F6;
	Thu, 27 Nov 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOIE5ZQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688628506A;
	Thu, 27 Nov 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251007; cv=none; b=RdMCnTbh+Bf1miiNAEwaBzYQzNf9/a22D0DioHs/aUBAEjnepUpUHyNqcfNk4lun/BNeCtTfHD9fcvRsfTVtrWwO+0COxzOW77xd2dDNkwZR2D0woWW/gKFac76/prOldf/Q48rkggYarZsbVtOEV+HrIpBSwXXiLP2mJLh4T4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251007; c=relaxed/simple;
	bh=bTValxf+f2qX5cdb/j1rGGZlwo5p3B9YvqSqzKFNiXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ups68cBvPwbtglg+o9RkH3JG1Vtct+5fzRiXE4/BVp+gMNY0aQ93Cl/r2c1sIaE/hdmRaFPWOaIynUhcqRJ7Xl1kjBINTEycW1e6wN/Tdn8Q6J8guZ/GhRPCRHoCMJ1aAWd2o9tpShcyiQDC1lrLYK4BVONXnm7q9SZUtJdIqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOIE5ZQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7252C4CEF8;
	Thu, 27 Nov 2025 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251006;
	bh=bTValxf+f2qX5cdb/j1rGGZlwo5p3B9YvqSqzKFNiXc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZOIE5ZQ3CIeVYkCDllBpS+JRDy7GFUQxtgUJkgpV06AekofaBN+c43mmesS/9OapK
	 DeTT8sNVUNL+SCN0IjRrWkZH2Rglr9vYbz8I2D3tO4F3SQUyxEIkJ9Zzb7VcA/d3m+
	 bgsn0hUqF6DPWolgPro8idyHQdz8RID5QQekvvb6HbC8vLVvJOQrbzm/fZ1Htdwntn
	 QQOMf/IgoHmcjKtZEa69W7z6Eg2JNLXFcjcktpok9TSVuKuTv67gCUPFF8Xi2EYraR
	 /Hhphbp3NrU5fGa4+08Pwe785AE0n5DOVhGJ/rXB3u/xda3F6P6QJU70VjTlTwip0x
	 hZfnN60qg0uuQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] PCI: dwc: Make Link Up IRQ logic handle already powered on PCIe switches
Date: Thu, 27 Nov 2025 14:43:18 +0100
Message-ID: <20251127134318.3655052-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9552; i=cassel@kernel.org; h=from:subject; bh=bTValxf+f2qX5cdb/j1rGGZlwo5p3B9YvqSqzKFNiXc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Qst0Sybb2N2/zfne8XPhEgcejniJ5Xy3LHZvWWAf8 bTi1N66jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkfz3Df/8jD/6na3tGVe27 IZP+tXqx0br5Vx0vPRDi2pi/4Ugw50ZGhgPvjoqxLJxpw85ydlJiZceq/CkSkhtVP27aHnEzxuP kb34A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The DWC glue drivers always call pci_host_probe() during probe(), which
will allocate upstream bridge resources and enumerate the bus.

For controllers without Link Up IRQ support, pci_host_probe() is called
after dw_pcie_wait_for_link(), which will also wait the time required by
the PCIe specification before performing PCI Configuration Space reads.

For controllers with Link Up IRQ support, the pci_host_probe() call (which
will perform PCI Configuration Space reads) is done without any of the
delays mandated by the PCIe specification.

For controllers with Link Up IRQ support, since the pci_host_probe() call
is done without any delay (link training might still be ongoing), it is
very unlikely that this scan will find any devices. Once the Link Up IRQ
triggers, the Link Up IRQ handler will call pci_rescan_bus().

This works fine for PCIe endpoints connected to the Root Port, since they
don't extend the bus. However, if the pci_rescan_bus() call detects a PCIe
switch, then there will be a problem when the downstream busses starts
showing up, because the PCIe controller is not hotplug capable, so we are
not allowed to extend the subordinate bus number after the initial scan,
resulting in error messages such as:

pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

While we would like to set the is_hotplug_bridge flag
(quirk_hotplug_bridge()), many embedded SoCs that use the DWC controller
have synthesized the controller without hot-plug support.
Thus, the Link Up IRQ logic is only mimicking hot-plug functionality, i.e.
it is not compliant with the PCI Hot-Plug Specification, so we cannot make
use of the is_hotplug_bridge flag.

In order to let the Link Up IRQ logic handle PCIe switches that are already
powered on (PCIe switches that not powered on already need to implement a
pwrctrl driver), don't perform a pci_host_probe() call during probe()
(which disregards the delays required by the PCIe specification).

Instead let the first Link Up IRQ call pci_host_probe(). Any follow up
Link Up IRQ will call pci_rescan_bus().

Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
Fixes: 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ")
Reported-by: FUKAUMI Naoki <naoki@radxa.com>
Closes: https://lore.kernel.org/linux-pci/1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 70 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  5 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  5 +-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda51..8654346729574 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -565,6 +565,59 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static int dw_pcie_host_initial_scan(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct pci_host_bridge *bridge = pp->bridge;
+	int ret;
+
+	ret = pci_host_probe(bridge);
+	if (ret)
+		return ret;
+
+	if (pp->ops->post_init)
+		pp->ops->post_init(pp);
+
+	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
+
+	return 0;
+}
+
+void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
+{
+	if (!pp->initial_linkup_irq_done) {
+		int ret;
+
+		ret = dw_pcie_host_initial_scan(pp);
+		if (ret) {
+			struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+			struct device *dev = pci->dev;
+
+			dev_err(dev, "Initial scan from IRQ failed: %d\n", ret);
+
+			dw_pcie_stop_link(pci);
+
+			dw_pcie_edma_remove(pci);
+
+			if (pp->has_msi_ctrl)
+				dw_pcie_free_msi(pp);
+
+			if (pp->ops->deinit)
+				pp->ops->deinit(pp);
+
+			if (pp->cfg)
+				pci_ecam_free(pp->cfg);
+		} else {
+			pp->initial_linkup_irq_done = true;
+		}
+	} else {
+		/* Rescan the bus to enumerate endpoint devices */
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pp->bridge->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -669,18 +722,17 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	 * If there is no Link Up IRQ, we should not bypass the delay
 	 * because that would require users to manually rescan for devices.
 	 */
-	if (!pp->use_linkup_irq)
+	if (!pp->use_linkup_irq) {
 		/* Ignore errors, the link may come up later */
 		dw_pcie_wait_for_link(pci);
 
-	ret = pci_host_probe(bridge);
-	if (ret)
-		goto err_stop_link;
-
-	if (pp->ops->post_init)
-		pp->ops->post_init(pp);
-
-	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
+		/*
+		 * For platforms with Link Up IRQ, initial scan will be done
+		 * on first Link Up IRQ.
+		 */
+		if (dw_pcie_host_initial_scan(pp))
+			goto err_stop_link;
+	}
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd..a31bd93490dcd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -427,6 +427,7 @@ struct dw_pcie_rp {
 	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
+	bool			initial_linkup_irq_done;
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
@@ -807,6 +808,7 @@ void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
+void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
@@ -844,6 +846,9 @@ static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static inline void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
+{ }
+
 static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3e2752c7dd096..8f2cc1ef25e3d 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -466,10 +466,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 		if (rockchip_pcie_link_up(pci)) {
 			msleep(PCIE_RESET_CONFIG_WAIT_MS);
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-			/* Rescan the bus to enumerate endpoint devices */
-			pci_lock_rescan_remove();
-			pci_rescan_bus(pp->bridge->bus);
-			pci_unlock_rescan_remove();
+			dw_pcie_handle_link_up_irq(pp);
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c48a20602d7fa..2d8aca6630949 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1617,10 +1617,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-		/* Rescan the bus to enumerate endpoint devices */
-		pci_lock_rescan_remove();
-		pci_rescan_bus(pp->bridge->bus);
-		pci_unlock_rescan_remove();
+		dw_pcie_handle_link_up_irq(pp);
 
 		qcom_pcie_icc_opp_update(pcie);
 	} else {
-- 
2.52.0


