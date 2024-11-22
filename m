Return-Path: <linux-pci+bounces-17206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7B9D5E76
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E182821F6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8D1CCB50;
	Fri, 22 Nov 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixCJsekC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6D524F
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276662; cv=none; b=gWaz9jhLE9/mE2QI3cgfYgRXrinclZoYKMGFqABCayqfpEa+QhSS1eumOSMV+BH0mubAahrfZk6LIAwUkB7ByY88ZyfE0Rxz0nByT7broWqLq1/EgHbEzfTVbzQHhV4wK6OYBqv3yYjwuwsLHb8V00Frtn1xG4d2za0+LcZIlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276662; c=relaxed/simple;
	bh=upNCPc9D/m4J70XmQNctLDQGOmeQN4f4dphCC/Twwio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgXcioQkk3f5I+qQxayJXoFUeg+J71v4dafaeDEiQkkny5cl8AzqxM3mhDXV6/A8cyL1+PEXuBw+SCI1GYHpXePM9e28l4G0C+vTe2/YtAGS+LaaSOmlZwYgE/fxeyyjTM0eH/4FjOD36cXaKDdXNycnvEPUpRoz9eedNuvex9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixCJsekC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B977DC4CED0;
	Fri, 22 Nov 2024 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276662;
	bh=upNCPc9D/m4J70XmQNctLDQGOmeQN4f4dphCC/Twwio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixCJsekCsQpndEwEjVIHYJ19FrSvpGKOh3IxYL4PQ7aqq74gCKJNG9f+8bPOK+RYV
	 uPaOVsSKW2jB6Wych0NbaY7EXPMnvKyuGyCai+ZYNVHh0clVI1CO2UKkD1a40SiwOG
	 6sJSzp97efF7vZlTjwrCDTx41C/1Gtm4Ryk6RnfvUU5P9ysY1HjAIs6odTPG1Cz09s
	 zTBPqA+LqcFEokKUsxtRGmbjnXns9Ea/ymwwc/C4wfgyZHPwgUHlUXHVM7HbXL0Fqz
	 VDqOmx2f7tmPx81kyZ635hvRUDFL39/ojxbBVS1V1NzhaVgsSTG+CJw4LEfidgoowq
	 MTzCmyOH+ap3A==
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
Subject: [PATCH v4 2/5] PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()
Date: Fri, 22 Nov 2024 12:57:11 +0100
Message-ID: <20241122115709.2949703-9-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122115709.2949703-7-cassel@kernel.org>
References: <20241122115709.2949703-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=cassel@kernel.org; h=from:subject; bh=upNCPc9D/m4J70XmQNctLDQGOmeQN4f4dphCC/Twwio=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCmffPLTtR/CFWGdv5+Tb9o8Xq3fLTeGVmi+3s3pmZ nmU46mTHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiI6kyGvyK5MfzcHEEGFp6R PY2BEvduHUjOXXzDdOtk5smzc033hTP8U/8fvHRdjAnv9mhfs+0JJa1PrGLnBOSf2/joUfMVjqx iRgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
"BAR Match Mode".

A memory address returned by e.g. kmalloc() is guaranteed to have natural
alignment (aligned to the size of the allocation). It is however not
guaranteed that pci_epc_set_bar() (and thus dw_pcie_prog_ep_inbound_atu())
is supplied an address that has natural alignment. (An EPF driver can send
in an arbitrary physical address to pci_epc_set_bar().)

The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
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
index 34d60142ffb5..ff4350e7adb6 100644
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
@@ -265,7 +266,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
+				     size);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..3c683b6119c3 100644
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
index 347ab74ac35a..fc0872711672 100644
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


