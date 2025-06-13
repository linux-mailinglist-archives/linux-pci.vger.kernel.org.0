Return-Path: <linux-pci+bounces-29687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9503AD8C7C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63653B61A2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C23595E;
	Fri, 13 Jun 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzREhr0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEB3594E
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818945; cv=none; b=neXDeOIfxS1jVtiRolWhq4LPLywT02MvO+MiGysJsBbGs6X1SoX43heBy6mNkMnPvZw0gEaKKSlIr2k7npEXWr3JAMYdmU+znr5+zZGGIgo/N5jbQfWVGmAV1FXNTZsLVYjjRizHyGnVutcqMdARuhTqaX7UG3eZXQeUWNgLYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818945; c=relaxed/simple;
	bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdo941X82Mp8EWrbBJRiCxK1i/cd7Cn4V6KCj0jg3oV0oAcQym7JKIrcFWDVX5q4URKisxDKSkOVmQDHih0P08hW65CSwPRCdHZvE3gpQeNCnfTcfaU1O5lHQ5TmyJP0DohViSCtvGapSVGzETsCcTHOuEUtV1frcWHFFzhmG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzREhr0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2E6C4AF09;
	Fri, 13 Jun 2025 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818945;
	bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzREhr0bOh3xXmqRW4AUDihdy2ZJ0v6bbZsMYi+6W5ASHqv2uuYCs2H8fM4hEQLtj
	 MzVM6Y/yDC3saJ4yc+N+Iz2hZ/j7TfM3wuLKwJ8jTIZpVZCVNdSxpKFYqfiZh52PhO
	 hQtpyhHeKFKOd98Mif1GmFV5AH2fKuG3eQDxUisXhrNF62mbt90wyrJk/OKJIIqC8z
	 +wcQkXXJOYNZTfRlaJXxurLj6UsqNdOjPIRNrskkAziLedKjRo3tD2A0KSL5pRZSzr
	 QinN/GBfo22aj4YrBsWfwlifzPGdxSI4GZWFp6i8cSfC0ZTeoRTE74lGWon9xR6GCJ
	 WiZIEQ3SL93xw==
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/6] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Fri, 13 Jun 2025 14:48:40 +0200
Message-ID: <20250613124839.2197945-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=cassel@kernel.org; h=from:subject; bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85LTdgh5L7Nh1Nrv0bvnhy3JPfsj9rVL47rh6S8Tqn X1Fm7Zu6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE/t1nZFj+79k9GzlW3umv xax/TV15MXXBRq3DrBL/NB5sM3znYTaX4X+Etesawx+JLtklR71/l6rWNOko3ra5Ljfzgwj/6ps h7zkB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/plda/pcie-starfive.c | 2 +-
 drivers/pci/pci.h                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index e73c1b7bc8ef..3caf53c6c082 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -368,7 +368,7 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 * of 100ms following exit from a conventional reset before
 	 * sending a configuration request to the device.
 	 */
-	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	if (starfive_pcie_host_wait_for_link(pcie))
 		dev_info(dev, "port link down\n");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..98d6fccb383e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -61,7 +61,7 @@ struct pcie_tlp_log;
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.49.0


