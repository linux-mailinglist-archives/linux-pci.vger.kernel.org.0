Return-Path: <linux-pci+bounces-36761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E2B95AA2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA9C2E6C55
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E5322A0A;
	Tue, 23 Sep 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSGF6VcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEE322A04;
	Tue, 23 Sep 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626840; cv=none; b=SxCjDDcm7kHGuBDOtSmNrnA5cgZI4EtnEkLbQjbK3UmtITvsfVB+8v76SqinV1O58R71uLbYhUQWnLKC9ClF5767mxWgXJyNprxdDZzTjzEQ5kFeGmv5ilrVhBdaI2+98Yu+DIiem7Eg6AbULHf3Al8XLICm73PlmVfoz4w6zLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626840; c=relaxed/simple;
	bh=Y6Ks5wTiGs+ByHpP/pFcc1umqPWY5L5vAWv9OUX9xY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NL41A1zmQxDgX7YDivuTsPgTa7lUswkZJLXlMbtDpHSrF+T951tV/PHeorq8ImKlmh7AHfN5qob7WokZzBMJtoi3DDgOuQWpVPgdL5NEtGtRcF+6HSHi5fPPxYEf3dKdqT2TLqlPl7LS0YX0u42bQtAFhoPSIs70FGpsciMn8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSGF6VcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C285CC113D0;
	Tue, 23 Sep 2025 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626839;
	bh=Y6Ks5wTiGs+ByHpP/pFcc1umqPWY5L5vAWv9OUX9xY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lSGF6VcZInmak+B2nWzBYISkHvSHzLyb6KqUZmybeHjCUvZ2zSZiSshpUWaFIC/+/
	 KIPPH90NuiZ4PJdQZKOuFQ7eEIgQM0euVR+UDpHvINhha8BkeinZ3AYrz0xE5yAo8D
	 dMqGfU0SipM0Q+y9ea1s1z3c5Ta1eRaYNWgs8SdQw0BVKSbOs4ii/e14hImcGW1Smq
	 jcUa9swNvFFk0vqERZNOlCdftDtXcughtKx7esxyNbeNVrv5kBQYp33YyoDd5mIzOm
	 w0Z8xUuYHY+V0/ZTe4p/GP6OhH5OUVT5TR1xBXD/8jSrX+0htFJEKvOmj6EgPCnyJF
	 AAl/AeT1DgpWQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Tue, 23 Sep 2025 16:56:54 +0530
Subject: [PATCH v10 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-controller-dwc-ecam-v10-4-e84390ba75fa@kernel.org>
References: <20250923-controller-dwc-ecam-v10-0-e84390ba75fa@kernel.org>
In-Reply-To: <20250923-controller-dwc-ecam-v10-0-e84390ba75fa@kernel.org>
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
 h=from:subject:message-id; bh=lqpEGDikWMpJGoh9O49BHabw0FX3kIuCt8c+nBt0Fho=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo0oP+nT1B3irIDsL2tBTAYHWeInJiZBrMnFQ05
 AMvJOLqXayJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNKD/gAKCRBVnxHm/pHO
 9cUGB/9mDuyKuvKq+CVaMM99wK7fYEnjT595IwhOdIKIy2KvO0vicoCYdJhIcC7gnv+JM/ndKqe
 ZZonzGWZ5UnI7h1e7FRGc8jXLsRoc5ho3EP6I3R8dpXV634QumVCUglmAiiy9AQh8yun3XEnH0p
 XAZQhQ7gIUR38caj7YWj1PkqHikqkT4zBlaH+NybnNkTOYfOFxKxQMm5E+3rqHEOQ7huyyBXtYR
 E03eue8AmKHIHFfTEZ9rLA2Oxnwtoh2W7rSKqBksRdmQI+jVnlVNAXdiEeKCKV3A9yTeDT/S0sX
 zvWMVWZ/ThtygcydYXhWiOQX7Rv23g7d5Mu8EqVjT/F2LGI6
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
index 779868e8fa8fd78e5f35cd0fa2575f52cc07c335..625320565360c0134ee9345bcc2e54a6ce83326a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -429,6 +429,7 @@ struct dw_pcie_rp {
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
+	bool			native_ecam;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.48.1


