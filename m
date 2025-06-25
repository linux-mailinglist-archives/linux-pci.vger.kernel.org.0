Return-Path: <linux-pci+bounces-30611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB99AE7F1C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1375C3A9D5E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCC29E0EA;
	Wed, 25 Jun 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyPJr4pb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00929E0EC
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847067; cv=none; b=JhkFFnJydRqzvVHQL9p0KPS0zKHjh8uIma/6hGkqGb1ytmncGLd1F2hq1xNp7g6P5koQ1d2/i6YJxX+d5WObtdSHTHRk3dxNnLjFhyz6uz8iuexIIXbXLdEsmOYKBGGL1q+aB2GnPvgWTo13s14pG2LPkk9S05idjUDGSIRXU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847067; c=relaxed/simple;
	bh=DC8hh29w13+ZU8edJTQTMPlT5oEXHqT1sBFC28I2ru4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAvMGJ18/s3pTKvYrIG5dSbSGaP1O2JbThYQ51AA2CpY/WNDr3Wbsf9BcnJgAWh44LXxcIqGCx+F47NIWcL1aMSj4qvgo9Ia1fMzpAoKnH0rz1Huo2lzhnAl2y4ykRbfBj0QmMockR4Yaeg7ykjaYSnPEufppQuQkipoxJMN4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyPJr4pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593B9C4CEEE;
	Wed, 25 Jun 2025 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847066;
	bh=DC8hh29w13+ZU8edJTQTMPlT5oEXHqT1sBFC28I2ru4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyPJr4pbwp1A3O9o4Qdjjyk1T53mKBIk68Cy7pulkNM17kq7FmKMPTc03D6UsXdaC
	 01Qn0mnTCPFPmwwilzE7p5fucF2AYNiBgc1WdvbKda5JQYgjVBRxz21ctl3dLxwWZU
	 furZU1HFytWfIR65HiO/LFRS6sBW1VxJUIQV011qZc+AXRlfIOSoJs+7JjcqV2rczK
	 TFn5WNzZ82chvLH/CEli4/Hf6NWUs1Ps3ZqjHkd2XSrSbqXLa3qkbtcNLscJD+NMeb
	 zqFttiGRG/FvT80UF/3MXMYNfmsQVzZLvn5JltJZLElZpBtbv1XNvI/Ky2rLdZm6++
	 3blWgtM2pRwyA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 6/7] PCI: Move link up wait time and max retries macros to pci.h
Date: Wed, 25 Jun 2025 12:23:52 +0200
Message-ID: <20250625102347.1205584-15-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483; i=cassel@kernel.org; h=from:subject; bh=DC8hh29w13+ZU8edJTQTMPlT5oEXHqT1sBFC28I2ru4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1l5qCye4Hnz4IuzjoyPF+xMbzD8fWq+g2YGq5mo2 Zmj9/cEdpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAij40Y/rub9dotfbpFU+bK E8VMhQU/OacvvhQy+8/ib0XXFabMv3GFkeHCwuelVtOZPIPPHkjNyZMqkQsM3/m7m8vjtmKC09T Kx1wA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Move the LINK_WAIT_SLEEP_MS and LINK_WAIT_MAX_RETRIES macros to pci.h.
Prefix the macros with PCIE_ in order to avoid redefining these for
drivers that already have macros named like this.

No functional changes.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h | 4 ----
 drivers/pci/pci.h                            | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 053e9c540439..89aad5a08928 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -702,14 +702,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	int retries;
 
 	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+	for (retries = 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
 		if (dw_pcie_link_up(pci))
 			break;
 
-		msleep(LINK_WAIT_SLEEP_MS);
+		msleep(PCIE_LINK_WAIT_SLEEP_MS);
 	}
 
-	if (retries >= LINK_WAIT_MAX_RETRIES) {
+	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..1bf1e08ab4c3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -62,10 +62,6 @@
 #define dw_pcie_cap_set(_pci, _cap) \
 	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_SLEEP_MS		90
-
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 819833e57590..43cb77c27ac0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -56,6 +56,10 @@ struct pcie_tlp_log;
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
+/* Parameters for the waiting for link up routine */
+#define PCIE_LINK_WAIT_MAX_RETRIES	10
+#define PCIE_LINK_WAIT_SLEEP_MS		90
+
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
 #define PCIE_MSG_TYPE_R_ADDR	1
-- 
2.49.0


