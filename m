Return-Path: <linux-pci+bounces-29542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F108AAD6F73
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFB3178AD3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60F23A58B;
	Thu, 12 Jun 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUDWEhqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B6239E8B;
	Thu, 12 Jun 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728995; cv=none; b=Gi3csXem1+NDJErsiqhAzrxzMpGR9CwUb/dUAVXuFzmS3v+39OWPr5zObwCc2uyfy7EF8Nc4JpuG63o+04Jf1A5cI75IItU0boAcQzkf8a/L0EHxqrl49VYZzx4YsdFkBLNCJo96Ms5LUgoZf/i+uZhHA+cZLcPrKPCGyO28aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728995; c=relaxed/simple;
	bh=q8pKIoDPwCRg23YQspRG+K9CqXAcbsdGdQC29hGbGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv+miIKeWAZBNhmYdaqn2EbqaSyRmt25qExn1SPQ9TVtohNO1Exvs6iVCLaCJedNbRfCvwiHPVGcA7YhLNi6SWHKir9SVGpgrAJym8WTuy+BsdJAWyBJluQFjHEFaFnkco4RqL6ZjRGa8azagK84//nfDoFw7/5zxXbASR7gH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUDWEhqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14C7C4CEED;
	Thu, 12 Jun 2025 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728995;
	bh=q8pKIoDPwCRg23YQspRG+K9CqXAcbsdGdQC29hGbGco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUDWEhqZK02b567evEHayS9I20+9KujFsz2JqSwo9mlUoFm7rBTMrDEGYHrqnA4wf
	 uN/BjB2toBtC0oXw4WcP9h4D+jQs2mVi8nE1f9sx2WDKnLn0zOl+weUiWacSA2vS0s
	 6cs39nLj0pgq9h2DRESQ5YeM0DFff3P/4//0kV7cy1qEJ3Bngx6PwTkizLtXFhZJeH
	 WsRnGCg5rECDa4TuOcAHhRPNqEc09hbjAXcDkZDu+JoTaI5ftgU5Wp18Iu9U9G+Htk
	 4GtbfO1b0RQ9Xt6rLnGDsIuGKGy1JiRhBehYYr1EA4RsSG8rsuRAlQIHRTdzo/1fMD
	 svSiGXG4aLGjQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/5] PCI: qcom: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS after link-up IRQ
Date: Thu, 12 Jun 2025 13:49:25 +0200
Message-ID: <20250612114923.2074895-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612114923.2074895-7-cassel@kernel.org>
References: <20250612114923.2074895-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=cassel@kernel.org; h=from:subject; bh=q8pKIoDPwCRg23YQspRG+K9CqXAcbsdGdQC29hGbGco=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89p3YXjanbtudJhmpspq/gnzLiydk3d03+X+Pvi2Ty AoO/YywjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwktp2RYffDjr7bi5I0daJj E8/H5XA2cS2IfCzMM3GZpXlig8h+SUaG3Q33jSZfVGvcv3K+3QORTXGsB8rL70tPtgy/7eRT8Wk VHwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
100ms (PCIE_RESET_CONFIG_DEVICE_WAIT_MS) after Link training completes
before sending a Configuration Request.

Prior to 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect
Link Up"), qcom used dw_pcie_wait_for_link(), which waited between 0
and 90ms after the link came up before we enumerate the bus, and this
was apparently enough for most devices.

After 36971d6c5a9a, qcom_pcie_global_irq_thread() started enumeration
immediately when handling the link-up IRQ, and devices (e.g., Laszlo
Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready to handle config
requests yet.

Delay PCIE_RESET_CONFIG_DEVICE_WAIT_MS after the link-up IRQ before
starting enumeration.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f85655..ff257fec6ad7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1564,6 +1564,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
+		msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
-- 
2.49.0


