Return-Path: <linux-pci+bounces-30609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A0AE7F1A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3111899C94
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CEC28E607;
	Wed, 25 Jun 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clvX5fs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6802882CA;
	Wed, 25 Jun 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847063; cv=none; b=mr3VxMXEZFmxS6EocQ2bi/bfxBPHNE6t/BSYvGOgzZD1M4fPPLoyeZS3JGQpVzkb0GINy5duqeDQTLoosEc/A9a041itAGWUHYMB6XckKN++ooQn/nH8udYTUP9Hunanw4C2ra8j23DqPrlawAXv9RshN4G5x8oXOCMe/WZoKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847063; c=relaxed/simple;
	bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fya3qfkubz0LyHkNyx+MMRzRv7zpjx+tH9T0WYfGeR2E9261W+W0bi7ZnhjdEGXd9dtvAQxEcSASysR54xxS/sI7qqj1f6zwGJvT4A1Jx1l9/ywJ6hCRzvnfqPbDDlhbtLrsN3fj86oKB9ANl/pJk4ZOiocFLqP4dPigWKIUwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clvX5fs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03601C4CEF1;
	Wed, 25 Jun 2025 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847060;
	bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clvX5fs9yrPRPiUn3IMwFHtsdln+M2wjb2XuGlaSNkHqZZp2eR6JM0xWjeaG+b9/T
	 QxfJwSsh2YGyXdBXx+Sl40DOXCUo1b2U0NCmn7tExzc0NuUOVTmhusVOkb7Gea5kja
	 MCHgBz1fKEoIyo23ewCJP3sevwaAacuxhDEPZd+J9Zdvmwn6ukjONKyLq/92JtnjPA
	 b/wOUSUSPeI8lsxT667Ha0ezWQvNFjqDPCHygvSA1OD8r6PPW441WrAkm7iGXXivLZ
	 W9M6IRbPOVz0U9tIUfDWnW4WnH9kt9VGRu/vcqO28rgO3n3/5fbb3sFUmCKTxNd9eA
	 EyEMIqoOdfzWw==
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
Subject: [PATCH v4 4/7] PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
Date: Wed, 25 Jun 2025 12:23:50 +0200
Message-ID: <20250625102347.1205584-13-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=cassel@kernel.org; h=from:subject; bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1n6+x4o9q/e8065fmYodw7vhZkn/TqmHHr7UaP/w vMnXXO3dJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiQXsYGaZ/M6qVPmspczPt eVGE14Sl22JMIpbHp8ibf9ipENW7VIjhf0T6qWP2G9It66wset6wRqWv+swp/oKR9c/aJPUvB7b 28wIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
100ms (PCIE_RESET_CONFIG_WAIT_MS) after Link training completes before
sending a Configuration Request.

Prior to 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect
Link Up"), qcom used dw_pcie_wait_for_link(), which waited between 0
and 90ms after the link came up before we enumerate the bus, and this
was apparently enough for most devices.

After 36971d6c5a9a, qcom_pcie_global_irq_thread() started enumeration
immediately when handling the link-up IRQ, and devices (e.g., Laszlo
Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready to handle config
requests yet.

Delay PCIE_RESET_CONFIG_WAIT_MS after the link-up IRQ before starting
enumeration.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f85655..9b12f2f02042 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1564,6 +1564,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
-- 
2.49.0


