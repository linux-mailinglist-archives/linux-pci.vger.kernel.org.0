Return-Path: <linux-pci+bounces-29427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B49AD5323
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907DD3AE329
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED228246327;
	Wed, 11 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/NeboJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421B2E6132;
	Wed, 11 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639225; cv=none; b=OSTuc4tUZfvXPhUOKg23JC9pR1Z4GM5d98kOf6iO9zEqBWKCxSgQC1A6at4JzmeJ0O/4zEhjz+h5R+4rFDQgICSAtBydrUMFfQFlIYk+GigeR+4SRtWVQXsEnO90eOvUQuEWQHEWaCtOBlp9Tvx9vWeF9L81Ra5RBiVkAgghivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639225; c=relaxed/simple;
	bh=Tjbv52A446x/2OGiJ3cXLWJW5uniN/S8WxZ2OpPiVSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOK7SYi7NUwWKnejoABWy0xGu8GKTCHcJMRiJRAAf8p3dx85/xa6p9gds0gSJJRIiWLXUQIQN6Gz6RbNVqT+P1Lbxqy9FLeVjZTBDOPbk8m/tg08eTxIc7zngRPIe8DPvExkF66U2oiJeVle+n/XKHx8KYPEr3vNOvobQ4FBOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/NeboJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3AAC4CEEE;
	Wed, 11 Jun 2025 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639225;
	bh=Tjbv52A446x/2OGiJ3cXLWJW5uniN/S8WxZ2OpPiVSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/NeboJY6f9BRmAk9E7oMaLnsyidRaPgyXy/A+LFTM1+TtFFbotOc+jSWGJB7MQxY
	 m4KIFtiMkC/brIwbD5X5Z7f7Yhg25pQU8s81Z5FyrWvoDYoNS7ffwZu8iJiIFnfAoT
	 4zq+vX0pnRKx+wECkDhaCpt2Jg+GRjYwKNEhGLV36XpwOpK+hsop8I586VcU1Gk1PZ
	 aFCDuO0p+Y0+FhKYJGpwLclk6PfoMo5VxK/FNxNuLur07D6fbyMMRuvax/KzND4IyG
	 F/0dpQ6hZ7H8QNVlbM+6SFuk9wo+uL+jUpgdGlraZcEFXMRHNax1cP92TXIvHzSr9m
	 FSUmzHgJlPNMg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI: qcom: Do not enumerate bus before endpoint devices are ready
Date: Wed, 11 Jun 2025 12:51:43 +0200
Message-ID: <20250611105140.1639031-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611105140.1639031-6-cassel@kernel.org>
References: <20250611105140.1639031-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=cassel@kernel.org; h=from:subject; bh=Tjbv52A446x/2OGiJ3cXLWJW5uniN/S8WxZ2OpPiVSc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI84/fOEdiSr6Szx6HsfCZnk1h0WvKPjQ/SdrNdjlrkO nvXlLPXOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRp0UM/3T3Pr+27cW2LXxz lszbueGZTfYmRZVTvxp7djTMqBJ6v96N4X/5KT2dBX4twhefSx5qvhU/tfhShKb09177KaHB/wQ V/FgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link
Up") changed so that we no longer call dw_pcie_wait_for_link(), and instead
enumerate the bus directly after receiving the Link Up IRQ.

This means that there is no longer any delay between link up and the bus
getting enumerated.

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add this delay in the threaded link up IRQ handler in order to satisfy
the requirements of the PCIe spec.

Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f85655..0a627f3b5e2c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1565,6 +1565,13 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+		/*
+		 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports
+		 * Link speeds greater than 5.0 GT/s, software must wait a
+		 * minimum of 100 ms after Link training completes before
+		 * sending a Configuration Request.
+		 */
+		msleep(PCIE_T_RRS_READY_MS);
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


