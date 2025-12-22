Return-Path: <linux-pci+bounces-43516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D113CD5B5E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C181300BBA4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DF30BB9D;
	Mon, 22 Dec 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQS2W4kN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAA295DB8
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401315; cv=none; b=uWf1yoD7WdkBLH3J6J19HybDxJENan1j94H30qHx0QAK4ut6aUR/0iXFQYYN18ORTh127UI7n2+5qhNoE4dlbDxD5Q7+YiijMdQKARULidhY05n9+TPrg7xkROsLJfxCuPs5iNYEP/ukz5Sr3IBCqgAQYM+mHaeehFZZe28eHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401315; c=relaxed/simple;
	bh=EnY2FYOqAG/hDhu/Aqr0yd7D9Uma6B0iVnVnI2QKBk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv7dbQnN0iibrs+UVmnfDQmWAEafli2tDKae4bB2djqOF95gMEiXq+cOtO0g6dut0ZfUeks8OAM+S6FY0YgbIrzuGiD8z3yx0Ym2tMbHffxPOGvP+AO4auSAPkTtksLMg7DVdKYhsZyNockChIfkYgTjg2n3vthKmI5hoMLn1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQS2W4kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6780C4CEF1;
	Mon, 22 Dec 2025 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766401315;
	bh=EnY2FYOqAG/hDhu/Aqr0yd7D9Uma6B0iVnVnI2QKBk4=;
	h=From:To:Cc:Subject:Date:From;
	b=oQS2W4kNTMVp04g0ehGDsPBqCjsAoGjYnVm7fxdO82aZclPF4wMlVUK+RWgIoVHnu
	 I49p2JEij7C5HAA9P7kehBkmwlJG4IHTz8AGwn19+AJIYm/N94+nNx6WVQzafXSTmZ
	 TDUPIcJPAcrpHsg9rL7fDmPLxzaPpg/o6LNv4FXmNNoeNt5umWtwoQgFoc7/wqmdGq
	 MHcFx4bK1NjdCo4Sa6mDhtHqwa8+EhKH2MAgn+rG1fiq7nUBc1yU0FQLDYqAMdVlVT
	 f/wZ6hZBHk94MNPsYSPRuxutMcqM9sd4UaGaowyl5GCUyvn1NZ0sgpR01UGRUXVI++
	 MQhcyazQiAMew==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: ep: Cache MSI outbound iATU mapping
Date: Mon, 22 Dec 2025 12:01:44 +0100
Message-ID: <20251222110144.3299523-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5416; i=cassel@kernel.org; h=from:subject; bh=I6iM8ASKUK7LFGzxRiDVkUxWqtSFXRujd9pJ3Jz5mUc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI9VSXWzts/uSxyxTZfceY/T7ntyo7VHrH3nFLEJ7q3w ec+i+WbjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkpRkjw25DtX3u58M51F59 +Mpyr3rZKiUG2V9RLezLa0N/b3tscIWRYf40l4jL5YH8MifXP+9KPy7p/Pn0hXyX8ipzrsvTf5V HswEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
for the MSI target address on every interrupt and tears it down again
via dw_pcie_ep_unmap_addr().

On systems that heavily use the AXI bridge interface (for example when
the integrated eDMA engine is active), this means the outbound iATU
registers are updated while traffic is in flight. The DesignWare
endpoint databook 5.40a - "3.10.6.1 iATU Outbound Programming Overview"
warns that updating iATU registers in this situation is not supported,
and the behavior is undefined.

Under high MSI and eDMA load this pattern results in occasional bogus
outbound transactions and IOMMU faults, on the RC side, such as:

  ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000

followed by the system becoming unresponsive. This is the actual output
observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.

There is no need to reprogram the iATU region used for MSI on every
interrupt. The host-provided MSI address is stable while MSI is enabled,
and the endpoint driver already dedicates a scratch buffer for MSI
generation.

Cache the aligned MSI address and map size, program the outbound iATU
once, and keep the window enabled. Subsequent interrupts only perform a
write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
the hot path and fixing the lockups seen under load.

dw_pcie_ep_raise_msix_irq() is not modified, as each vector can have a
different msg_addr, and because the msg_addr is allowed to be changed
while the vector is masked. Neither problem is easy to solve with the
current design. Instead, the plan is for the DWC vendor drivers to
transition to dw_pcie_ep_raise_msix_irq_doorbell(), which does not rely
on the iATU.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
[cassel: improve commit message]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Do not modify dw_pcie_ep_raise_msix_irq_doorbell()
-Mention why we don't modify dw_pcie_ep_raise_msix_irq_doorbell() in the
 commit message.

 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7f2112c2fb21..dc6fdf9ef3ac 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -601,6 +601,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	/*
+	 * Tear down the dedicated outbound window used for MSI
+	 * generation. This avoids leaking an iATU window across
+	 * endpoint stop/start cycles.
+	 */
+	if (ep->msi_iatu_mapped) {
+		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	dw_pcie_stop_link(pci);
 }
 
@@ -702,14 +712,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
 
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  map_size);
-	if (ret)
-		return ret;
 
-	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
+	/*
+	 * Program the outbound iATU once and keep it enabled.
+	 *
+	 * The spec warns that updating iATU registers while there are
+	 * operations in flight on the AXI bridge interface is not
+	 * supported, so we avoid reprogramming the region on every MSI,
+	 * specifically unmapping immediately after writel().
+	 */
+	if (!ep->msi_iatu_mapped) {
+		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
+					  ep->msi_mem_phys, msg_addr,
+					  map_size);
+		if (ret)
+			return ret;
+
+		ep->msi_iatu_mapped = true;
+		ep->msi_msg_addr = msg_addr;
+		ep->msi_map_size = map_size;
+	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
+				ep->msi_map_size != map_size)) {
+		/*
+		 * The host changed the MSI target address or the required
+		 * mapping size changed. Reprogramming the iATU at runtime is
+		 * unsafe on this controller, so bail out instead of trying to
+		 * update the existing region.
+		 */
+		return -EINVAL;
+	}
 
-	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
 
 	return 0;
 }
@@ -1086,6 +1119,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	ep->msi_iatu_mapped = false;
+	ep->msi_msg_addr = 0;
+	ep->msi_map_size = 0;
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a31bd93490dc..1093c622826d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -472,6 +472,11 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+
+	/* MSI outbound iATU state */
+	bool			msi_iatu_mapped;
+	u64			msi_msg_addr;
+	size_t			msi_map_size;
 };
 
 struct dw_pcie_ops {
-- 
2.52.0


