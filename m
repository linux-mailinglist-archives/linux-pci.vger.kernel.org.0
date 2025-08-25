Return-Path: <linux-pci+bounces-34633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8790B338A9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BD874E15D9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66B29A323;
	Mon, 25 Aug 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McfoWVbp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA6220F49;
	Mon, 25 Aug 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110181; cv=none; b=OofZIX4Su57yYmg4IjCakfjt/H5LZ01roFXqNu4vwQ6z67aYqC1+UuTCizyyzFP8xvXIA3p2Y5Oat8WfO8Ho+L+sNjJTxGDgq34g2s3hAra6/q4Pv9A7I7OH4nbdP2bMPjA03KVn4k+shm1mbm0xhNYdvh8fMlT2pOrIr3W6hXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110181; c=relaxed/simple;
	bh=Y12UbNmGRMBp3XvlpYT+g49Dam4kM2RUMeMUmsFeiyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OVYTho0fsmpEbwfA8aXASQST/9V61uH8uGrUWcQHUrirVDBcRvfYye8jqldi+ycHfiIoW1EPfPQP+LVAddta7079551XkKKvHg/Oj06dR8XRvMd0o2FqSCjHJQsD0ZQWvqLoN56IgCp2MVavcYqDa+DfNt85OvZ9/PSb5RMfLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McfoWVbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5269C4CEED;
	Mon, 25 Aug 2025 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110180;
	bh=Y12UbNmGRMBp3XvlpYT+g49Dam4kM2RUMeMUmsFeiyk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=McfoWVbpCva0MmVRvgt7//H6h620+4mV/9pTqtfd0A5dpliS1XqWRFsIY8OL3f6O/
	 Mzt1GslhgF4zN8UewFAXygojjAMPrLeLOLAaDqYJZWDNqzoeKs/51v4cCG/y+f9o0f
	 jYLZYYLGXPjGJnW9bRrWhskfOn7xu6jaQsPUXZhTGRGrIfmmv47MwOzGe9y29xQFod
	 pnZat3tHxsJHVD6Dwv1BdRNh3qKzfAs+o8rZLVICPK92ouarSnljLEUv/3B+B3kZVy
	 ZH5uCHZhkOM4ON5LBXcHjm1/0svN3SuwUa5xa/PNoB+L2Fds/CFIBFNjR+78iS+GXL
	 X8P1B24ScO3Zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A2CCA0EFA;
	Mon, 25 Aug 2025 08:23:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 13:52:57 +0530
Subject: [PATCH v3] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qcom_aspm_fix-v3-1-02c8d414eefb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGAdrGgC/3WMQQ6CMBBFr0JmbUmZQlVW3sMQUmqRJkKho42Gc
 HdH9s7iJ+/nz1uBXPSOoM5WiC558mFiUIcM7GCmuxP+xgwosZInVGKxYWwNzWPb+7dQqMsz6q7
 qihL4Z46O6913bZgHT88QP7s+4a/9Z0ooCnG0ri+l5lP2Eojy5WUePBtzDmi2bfsCkGEcrLEAA
 AA=
X-Change-ID: 20250823-qcom_aspm_fix-3264926b5b14
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6079;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=kD48LqXQ0kIw79nOsBnFczEUjdSW0UWpmm15mJe9M6U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorB1jzzCXC0f91MAypDDrWPKfrSfHgkD2tZwup
 YvFwIquYrWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKwdYwAKCRBVnxHm/pHO
 9S78CACI7ucFiuz5aINc+QsLk7iMgfRf0Dfg0sG0icJdecH939+GeCvQC55tSqjQluzyA3+pp3N
 9T80f11MtdaQSn3LT9hs2H7Qf6TMjzxrzwMXDDhFUMrw6LW6s/GDa7r11s+kbe5Ejbui7kGHvja
 s2cg9pW9hd3x1J7kc9NekinTl2lGzWCqZQ20iNJg9zRHOwHA52FC2KBINatpC5xobwtHry8MtAR
 qNKkBDE/P7hZm2e7XJ1aHEsVnT7zTbMrayc9YDoZ1J3sPhjAQ40isKJz5LcG8Db0h8HYY/cTI4W
 JOOY7udt0+A1pHkenj9ZFtZXKEQldmoYAkOwUHUo4aRgz6Bd
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
enumerated at the time of the controller driver probe. It proved to be
useful for devices already powered on by the bootloader, as it allowed
devices to enter ASPM without user intervention.

However, it could not enable ASPM for the hotplug capable devices i.e.,
devices enumerated *after* the controller driver probe. This limitation
mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
and also the bootloader has been enabling the PCI devices before Linux
Kernel boots (mostly on the Qcom compute platforms which users use on a
daily basis).

But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
started to block the PCI device enumeration until it had been probed.
Though, the intention of the commit was to avoid race between the pwrctrl
driver and PCI client driver, it also meant that the pwrctrl controlled PCI
devices may get probed after the controller driver and will no longer have
ASPM enabled. So users started noticing high runtime power consumption with
WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
T14s, etc...

Obviously, it is the pwrctrl change that caused regression, but it
ultimately uncovered a flaw in the ASPM enablement logic of the controller
driver. So to address the actual issue, use the newly introduced
pci_host_set_default_pcie_link_state() API, which allows the controller
drivers to set the default ASPM state for *all* devices. This default state
will be honored by the ASPM driver while enabling ASPM for all the devices.

So with this change, we can get rid of the controller driver specific
'qcom_pcie_ops::host_post_init' callback.

Also with this change, ASPM is now enabled by default on all Qcom
platforms as I haven't heard of any reported issues (apart from the
unsupported L0s on some platorms, which is still handled separately).

Cc: stable+noautosel@kernel.org # API dependency
Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:

- Moved the ASPM change to qcom_pcie_host_init()
- Link to v2: https://lore.kernel.org/r/20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com

Changes in v2:

* Used the new API introduced in this patch instead of bus notifier:
https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/

* Enabled ASPM on all platforms as there is no specific reason to limit it to a
few.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..0c6741b9a9585bd5566b23ba68ef12f1febab56b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -247,7 +247,6 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
-	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
-{
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
-	return 0;
-}
-
-static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci->pp;
-
-	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
-}
-
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1336,6 +1316,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
+
 	return 0;
 
 err_assert_reset:
@@ -1358,19 +1340,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pcie->cfg->ops->deinit(pcie);
 }
 
-static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-
-	if (pcie->cfg->ops->host_post_init)
-		pcie->cfg->ops->host_post_init(pcie);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
-	.post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1432,7 +1404,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
@@ -1443,7 +1414,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };

---
base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
change-id: 20250823-qcom_aspm_fix-3264926b5b14

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



