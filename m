Return-Path: <linux-pci+bounces-16751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC749C8857
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106662815C7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC81F81AD;
	Thu, 14 Nov 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F966ltl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3858139CFA
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582226; cv=none; b=dSan6yjtVGcosSnBcZHYTFQXyPo/iOfjEDCs9Z6TJgp5V8xgqYJP0BlktaIwE5yjTkB28xDVGLtkBJoWmdg5/yMHAfn0+9lS0sGhKcf8bHeoI/O2gMSz3+FOCxEfzHoqiEPUlZhLSWDyxrr4deJucuVhqQJHEJm+fOeQ2BAjk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582226; c=relaxed/simple;
	bh=abotO2HAnrJ6WH0HrCwpozQx2eXGtw03RjZB+isfNDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olZ8g6KJidUMa/zmTRDutAgBx9T0Lr9+HHXE6vuE5XrrDosEvzzxJdygZTlX9lNvpz1GH7OEXD4B4WxBy26QXlGSW3zxktQSA1p9uwt4IFMn5CatC8EH+BN60C3zah+C+jDW4+y2pmpGlWognHh0i8bjUKP3/pUx4CaUqzio2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F966ltl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA58C4CED6;
	Thu, 14 Nov 2024 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582226;
	bh=abotO2HAnrJ6WH0HrCwpozQx2eXGtw03RjZB+isfNDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F966ltl8bfsTG7XYONHWalO/5MMWWXUQnGHZTVkN2XNC471h6Olk7fQkNPaRKy4n2
	 jY1J31jU0wdOfb2kDLg7xTmt/BAVjImGRMO7i8+NotW4GvcpL7P71QWxeh1HGBd8bM
	 Rr5zfq/yAaJyX6TXQ5A354UUH6z987bcACUVHjdXL6lDGT1qbfr6xtjek86ELmvhhw
	 7jIeOtCLV9yXHxtI8HTFgM0dZeeHIZXVLOs9Lvxmlq1Dd2gRtqHvny6znhrktw5Km/
	 HR3RVgRo3uJ54MF1fbHJ22WTjVt5tlAmDAUF3gDkOTVNYl1osXnEq5VtW7r+NY7gSE
	 Ia7r1c8h5K6cg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: dwc: ep: Improve alignment check in dw_pcie_prog_ep_inbound_atu()
Date: Thu, 14 Nov 2024 12:03:29 +0100
Message-ID: <20241114110326.1891331-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114110326.1891331-5-cassel@kernel.org>
References: <20241114110326.1891331-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4206; i=cassel@kernel.org; h=from:subject; bh=abotO2HAnrJ6WH0HrCwpozQx2eXGtw03RjZB+isfNDE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJNb/zX5WnrrRL+UX+A8bZi5MrJblu2mcZaTNZ78fNXn srjNceOdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAizAWMDHOb/+u5Rv5vYuTi kjRR/rwz6k7C9wlbBPd8EbmUdfIQ0x+G/67rutQ3TM3Sfh288fHfmJavfqy5Oaab8pLfOqsxhpQ 28QIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
"BAR Match Mode".

While a memory address returned by kmalloc() is guaranteed to be naturally
aligned (aligned to the size of the allocation), it is not guaranteed that
the address that is supplied to pci_epc_set_bar() (and thus the addres that
is supplied to dw_pcie_prog_ep_inbound_atu()) is naturally aligned.

See the register description for IATU_LWR_TARGET_ADDR_OFF_INBOUND_i,
specifically fields LWR_TARGET_RW and LWR_TARGET_HW in the DWC Databook.

"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

Add a check to ensure that the physical address programmed in the iATU is
aligned to the size of the BAR (BAR_MASK+1), as without this, we can get
hard to debug errors, as we could write to bits that are read-only (without
getting a write error), which could cause the iATU to end up redirecting to
a physical address that is different from the address that we intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c    | 5 +++--
 drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 507e40bd18c8f..4ad6ebd2ea320 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar)
+				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -145,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar);
+					  cpu_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -229,7 +230,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
+				     size);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c6..3c683b6119c39 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -597,11 +597,12 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar)
+				int type, u64 cpu_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align))
+	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(cpu_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..fc08727116725 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -491,7 +491,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar);
+				int type, u64 cpu_addr, u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
-- 
2.47.0


