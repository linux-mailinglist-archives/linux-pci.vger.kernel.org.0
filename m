Return-Path: <linux-pci+bounces-27271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C0AAC069
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE02B1C0361E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816926E16F;
	Tue,  6 May 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee6RV+bT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A726D4D3
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525124; cv=none; b=lVRtAKwtT15YwoCpvakj83ReL4REYjwziFH2LAcEgm5gqs2DxU+f42kbTvzMlRm7pNe/tyi1rgS8hbAGzpP25c4C/pHaU0ERRggKElZtkpBuf70n3xOzV6D2vJ5kmH2n/bpV9jD0lZ7UK1DBg7fOkzb2luZfxLCC/1GqWFDvpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525124; c=relaxed/simple;
	bh=aPfN4LIF+p/6z7TUd1T56abbvQp5kZWX3Zsp7fvTMmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tldMDQ9IWig1enc82wa47Mv+nMz+zPsSVP79MgwF/TXyfWreCsxgojjaCNXkmvaGSeyxi0m7PccOm98U978wN4u3h/fnjDh8LEyNNDuaMehkuiC/0GOcvfzdOMS8iFNs9Gvv7MbcI1gEmLo8haJYZL5XMQxZvrTacVzQeWv+XxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee6RV+bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD63C4CEE4;
	Tue,  6 May 2025 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746525123;
	bh=aPfN4LIF+p/6z7TUd1T56abbvQp5kZWX3Zsp7fvTMmA=;
	h=From:To:Cc:Subject:Date:From;
	b=ee6RV+bTQcYy/nuoYEu+AfTgsYeSkG4539Mciuojq3zvQerAJZ/0CBwRJzGCUyjQS
	 vfYbbqh2PBh79e7f42JbfrZIr6PjBF1GNrMCzFFwbKtXvhLiCAAc4WiI3hRUmKrU1T
	 uiNlPgwLR9/4nUHNdTQdupaBeax9rt0hp0elANB+j/qu2vEiH5sbSI64y2zWDvXJVS
	 CbEXV9D67MDz5C6ghHEx8wL413yneoIcSG1SNUZjmRiCTirZYadFozI+oGLHeFwswg
	 ovMChuOuBAVH3HSjQhcKnSNhqWAQyplTGo5hV12Tc2iyg5l7ZzWF7a44WewWTHwHxM
	 ZbZtllX2CnA3g==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Fix errno typo
Date: Tue,  6 May 2025 11:51:39 +0200
Message-ID: <20250506095138.482485-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=cassel@kernel.org; h=from:subject; bh=aPfN4LIF+p/6z7TUd1T56abbvQp5kZWX3Zsp7fvTMmA=; b=kA0DAAoWyWQxo5nGTXIByyZiAGgZ26rIBpCuPgmbP0gWuR9hqgwCuA1MbAJVmAmTQcfMsqfQU Yh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmgZ26oACgkQyWQxo5nGTXJH8gEA8aI4 c/EuMwaC8/BkVmeTlmYRIdVxWjH/C2FzddYD1+EBAO3Z++K0MsBYrFrjoeBJS22hXsAhzWJUIur Gio2NhHgN
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Fix errno typo in kernel-doc comments.

Fixes: 7cbebc86c72a ("PCI: dwc: ep: Add Kernel-doc comments for APIs")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1a0bf9341542..d12fa7c74bb1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -671,7 +671,7 @@ static const struct pci_epc_ops epc_ops = {
  * @ep: DWC EP device
  * @func_no: Function number of the endpoint
  *
- * Return: 0 if success, errono otherwise.
+ * Return: 0 if success, errno otherwise.
  */
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
@@ -690,7 +690,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
  * @func_no: Function number of the endpoint
  * @interrupt_num: Interrupt number to be raised
  *
- * Return: 0 if success, errono otherwise.
+ * Return: 0 if success, errno otherwise.
  */
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
-- 
2.49.0


