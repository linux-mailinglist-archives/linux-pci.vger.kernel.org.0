Return-Path: <linux-pci+bounces-35731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CAB4A30C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726133B9CC8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773A308F08;
	Tue,  9 Sep 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN1rArAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A3081B3;
	Tue,  9 Sep 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401702; cv=none; b=g2TrrCtqWBG7Z1v1htqVJHuILgGsf2pwMqSrMXXP9a7D76REVLz1OiKsAwqvv2x0Ehz+Mf62sMUDDpgpmYGFrJICN0KadTMRC9aSLIt8VqGnDurT9vEi+/5i5CAgdrO7rqfYlGGWq1F9rMILaU+U2e1t+peWuGMGy0KBDDxmQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401702; c=relaxed/simple;
	bh=JcX5sMd35IxrVvsTREydkJ8njtVmY4I5zmPtLgF6QXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnnG5WNohgglFqvrZfHe4Kavv3Szj1n068robk4vP950ZRZFV5LZ/4hUAnhB1lOCgFSXIu3WOHSXh5kOvOjI0LBjoId1Vn47qHJFaHDvTXIhDAKHyjTOyxgHqco8NICfK0sSYtLf02iKmHDww0s/SP0RO+irJP9iNMaTtjO6M3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN1rArAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E88C4CEFC;
	Tue,  9 Sep 2025 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757401702;
	bh=JcX5sMd35IxrVvsTREydkJ8njtVmY4I5zmPtLgF6QXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gN1rArAtvz/75KmFujq4tt7h8xv+e9c4gwZLWe4XarPYN5T7bfcFbBECZ1lLlxFGh
	 KfDhB2QJLWt+ufb69W/TY0e5Zn5U+PmM/nIwx3589EgCfvXhHzToXMYLYYeyiyYp2R
	 3rQxUboo2mzoSkafI2fJTFBEB4NTChvDqUIfc6ipTqBF4jSC1F7J6oCDyeRk6nm7uj
	 f9cGhNEhlO+ilbxPGE9tkK4V0Aea6WSttF773F14jdCgCih410ghlO2cfbi1Vtzxh2
	 G2Ae89o4mWE/KXuiIvPWkZoAt47JfCpMZGTpt5gb7R0vDahFGRoIwGNJVvpmvQHVIA
	 ZvEBnJ69Qz1DQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Tue, 09 Sep 2025 12:37:53 +0530
Subject: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5632; i=mani@kernel.org;
 h=from:subject:message-id; bh=/cFYYevGob1uAYxI4ZncSQu20U+0sPloWtq5jp0SqWs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBov9JOzFKBNccdGX6QZq4yGjuITchaiJw5Ob019
 XAM25bOlk6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaL/STgAKCRBVnxHm/pHO
 9aasCACqatn67Ql5bQeCfBts9M21TM04X9aRVPDyAob6aynLyET/6ham/DM07Tf3OCC64v/gyyL
 JZtgJYfI/eL1IFMbZ76aq2XYG/aaKzaRWByTLMitfZgws0mduVR6k3Yd7AQNthFSKNLjHr5htMP
 dQilfqe6V1qXb6vblK20opUchcwr9/9h+0olkPhQQC7F/JrgPeLZ3f5/YfySyhCszHdEcDnEdTR
 dHTtdRIUgXce+jsapHTXXzNIM1XtUbArKKa8WsQRI2tX4Ro5h/KxvOzl4ZQ1LJ8ZlSla6WX+wuB
 U0jQsMnafSP8j/Ok5/iRhi+welAoPmXH2EB0an2jzEmiAnfl
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Designware databook r5.20a, sec 3.10.10.3 documents the 'CFG Shift Feature'
of the internal Address Translation Unit (iATU). When this feature is
enabled, it shifts/maps the BDF contained in the bits [27:12] of the target
address in MEM TLP to become BDF of the CFG TLP. This essentially
implements the Enhanced Configuration Address Mapping (ECAM) mechanism as
defined in PCIe r6.0, sec 7.2.2.

Currently, the driver is not making use of this CFG shift feature, thereby
creating the iATU outbound map for each config access to the devices,
causing latency and wasting CPU cycles.

So to avoid this, configure the controller to enable CFG shift feature by
enabling the 'CFG Shift' bit of the 'iATU Control 2 Register'.

As a result of enabling CFG shift (ECAM), there is longer a need to map the
DBI register space separately as the DBI region falls under the 'config'
space used for ECAM (as DBI is used to access the Root Port).

For enabling ECAM using CFG shift, the platform has to satisfy following
requirements:

  1. Size of the 'config' memory space to be used as ECAM memory should be
     able to accommodate the number of buses defined in the 'bus-range'
     property of the host bridge DT node.

  2. The 'config' memory space should be 256 MiB aligned. This requirement
     comes from PCIe r6.0, sec 7.2.2, which says the base address of ECAM
     memory should be aligned to a 2^(n+20) byte address boundary. For the
     DWC cores, n is 8, so this results in 2^28 byte alignment requirement.

It should be noted that some DWC vendor glue drivers like pcie-al may use
their own ECAM mechanism. For those controllers, set
'dw_pcie_rp::native_ecam' flag and skip enabling the CFG Shift feature in
the DWC core.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: code split, reworded subject/description, comment, native_ecam flag]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-al.c              |  1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 32 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 643115f74092d1c9319e9738db6e94b2752d30c4..345c281c74fefd2113233ef5461f96834b3765de 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -352,6 +352,7 @@ static int al_pcie_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 	al_pcie->ecam_size = resource_size(ecam_res);
+	pci->pp.native_ecam = true;
 
 	controller_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						      "controller");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 94e0fe11a0b062d0f14e09fe586e20bde46a4266..20c9333bcb1c4812e2fd96047a49944574df1e6f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/align.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
@@ -32,6 +33,8 @@ static struct pci_ops dw_child_pcie_ops;
 				     MSI_FLAG_PCI_MSIX			| \
 				     MSI_GENERIC_FLAGS_MASK)
 
+#define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)
+
 static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
@@ -474,6 +477,34 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
 	return 0;
 }
 
+static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct resource *config_res)
+{
+	struct resource *bus_range;
+	u64 nr_buses;
+
+	/* Vendor glue drivers may implement their own ECAM mechanism */
+	if (pp->native_ecam)
+		return false;
+
+	/*
+	 * PCIe spec r6.0, sec 7.2.2 mandates the base address used for ECAM to
+	 * be aligned on a 2^(n+20) byte boundary, where n is the number of bits
+	 * used for representing 'bus' in BDF. Since the DWC cores always use 8
+	 * bits for representing 'bus', the base address has to be aligned to
+	 * 2^28 byte boundary, which is 256 MiB.
+	 */
+	if (!IS_256MB_ALIGNED(config_res->start))
+		return false;
+
+	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
+	if (!bus_range)
+		return false;
+
+	nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
+
+	return nr_buses >= resource_size(bus_range);
+}
+
 static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -492,6 +523,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	pp->cfg0_size = resource_size(res);
 	pp->cfg0_base = res->start;
 
+	pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
 	if (pp->ecam_enabled) {
 		ret = dw_pcie_create_ecam_window(pp, res);
 		if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index cfeb99b89c3739b867a54da38e0f94835c2ce3a0..6ec0a737294b2a69bbcc05bbdbe0a11c5f8310bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -430,6 +430,7 @@ struct dw_pcie_rp {
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
+	bool			native_ecam;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.45.2


