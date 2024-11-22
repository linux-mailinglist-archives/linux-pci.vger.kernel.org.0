Return-Path: <linux-pci+bounces-17205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EBB9D5E75
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FB328243C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F51DC05D;
	Fri, 22 Nov 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1UgAHKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513BD524F
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276659; cv=none; b=QGrGjCRWo5JGjBO06d8NG43KuxSqCWwpIXMnJayevVhgIA5H0Rrkk+A0hNTktdCk50WcXFewIlNpT1Y9TvtwauoeK1qZaa2lVQEMO59/cfaIvy2Odo3p/B01UoI9OqXDElmYAv52dXn9Sf5WCO404ugaMny5tiVak+vzvNS8azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276659; c=relaxed/simple;
	bh=cfD5D141doNNZ7xz4A7VC2kjyhmOZXMIKeGOKLLrsY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O624RA5yLxoP1//bL9e+xp9LKDCPqVGLb5mwQUdqxJvFoBNvxpTIwQmKgAtIRSwEiX6NzPYEvv4G4YUp/TNXwipWtsMoaHzIOrTHguPZpj0xL30K8g7iKpjnLahu5Cby0bms/DLrvxq0RTLvIK+FiOwbxlgjcl/mbMXbKaCRjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1UgAHKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666CAC4CECE;
	Fri, 22 Nov 2024 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276658;
	bh=cfD5D141doNNZ7xz4A7VC2kjyhmOZXMIKeGOKLLrsY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1UgAHKJOyMfCLxaL/tfm7QaKz27jPWJ+SBX0qaSY0iMR4T23r/VLhFmTVBx8Z6Sv
	 G3biLatPI1Be3Gz7O0lYcpZQu/KG7obwWbPeFjeLl8FKV/Jxya32GUxkUVaXcUq8eC
	 Yocu7IqfXARtf9evM21mIbfGaFI59oYhi06CGes+TXaZWYLx5arCSceGulJLWAkx/J
	 53xr9tben7L9w+fuP2bmkQcir6kqTNT65ep4hJ3skULiG1E8Iha9Ni0i05OweOYhlE
	 2VqmCGXob8K73adU51Inw3O6t9/dOJ/95q0JwCWW1dnojIh0KPudX1aywzPlCAD+Gl
	 5JXrW/GavnkcQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/5] PCI: dwc: ep: iATU registers must be written after the BAR_MASK
Date: Fri, 22 Nov 2024 12:57:10 +0100
Message-ID: <20241122115709.2949703-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122115709.2949703-7-cassel@kernel.org>
References: <20241122115709.2949703-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556; i=cassel@kernel.org; h=from:subject; bh=cfD5D141doNNZ7xz4A7VC2kjyhmOZXMIKeGOKLLrsY4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCmd1XXKaUMl2J/WuqkKLaaGaRsYN3sJwBSZjpgw1i 7Msi3M7SlkYxLgYZMUUWXx/uOwv7nafclzxjg3MHFYmkCEMXJwCMBGHXIb/fi0GfLq1kwq5vNSu OuzQyhctyFpzO1Ch+cvzNK5TctYMDP9zLidysdTr1JVOYeau+VLwTGrOrdqJayYIezBuKqt93ck MAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

If we do not write the BAR_MASK before writing the iATU registers, we are
relying the reset value of the BAR_MASK being larger than the requested
size of the first set_bar() call. The reset value of the BAR_MASK is SoC
dependent.

Thus, if the first set_bar() call requests a size that is larger than the
reset value of the BAR_MASK, the iATU will try to write to read-only bits,
which will cause the iATU to end up redirecting to a physical address that
is different from the address that was intended.

Thus, we should always write the iATU registers after writing the BAR_MASK.

Since set_bar() supports dynamically changing the physical address of a
BAR, this change is slightly bigger than a single line change.

While at it, add comments which clarifies the support for dynamically
changing the physical address of a BAR. (Which was previously missing.)

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 46 ++++++++++++++-----
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 507e40bd18c8..34d60142ffb5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,19 +222,30 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
-
-	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-		type = PCIE_ATU_TYPE_MEM;
-	else
-		type = PCIE_ATU_TYPE_IO;
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically change a BAR if the new configuration
+		 * doesn't fundamentally differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->size != size ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
-	if (ret)
-		return ret;
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
+		goto config_atu;
+	}
 
-	if (ep->epf_bar[bar])
-		return 0;
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -246,9 +257,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
 	}
 
-	ep->epf_bar[bar] = epf_bar;
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+config_atu:
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		type = PCIE_ATU_TYPE_MEM;
+	else
+		type = PCIE_ATU_TYPE_IO;
+
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	if (ret)
+		return ret;
+
+	ep->epf_bar[bar] = epf_bar;
+
 	return 0;
 }
 
-- 
2.47.0


