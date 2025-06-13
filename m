Return-Path: <linux-pci+bounces-29690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2CDAD8C7F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A1C178CF3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541C1A29A;
	Fri, 13 Jun 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5c+G9fz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3501862A;
	Fri, 13 Jun 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818956; cv=none; b=lnimYa3RG5aWDR2GnWUfqkTV9eY4E41i2QahpB3Wy1czIcq8McwOtiGpg6T3EhXRPD80vRCd2b9j5sJ19WceAqRLTcyYkTB7AflJc3mIzn093G21jU90j0tiCUWvx2yFZpIGPTz3JC0BvTWrGcATAwNFp5JV0WLKgTH5YALEskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818956; c=relaxed/simple;
	bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeaDjBC39mUsy+m8qa6Zrk5Xm8ixpB23z9pnLoiW1LOrWx5XC3Ryqd/SraLNjd7SH6uWz1KUrPF5dsiTGjmq+6Ef98VkKnxf2csT9aSqnMLnd8UdPZkQ4SFqNed0HTDJIGkK/KsqpqdQF8jXLNltlC0bgxA99efhRugOXcvbuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5c+G9fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DF9C4CEE3;
	Fri, 13 Jun 2025 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818955;
	bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5c+G9fzWlPTHtYhT+qe2tFczK/chGDcqlMKJudl5pJCwrm5CJrz0s/CNSUHcmZES
	 IY0RRSm9yYJnusE460WwBcVdubI7X/jA4mX/oEiVmsZpK33NO5b4AsaUVPX/Sw4fRW
	 B1+k6D5utP58rnkxExqjoejS3y438xp7we7gH1LpKOZ6s+4797/zBEC6ITXAFhD4zr
	 wfvWO3WbALxoQiEljQyiOo/CRVlj3RmiRVWgGd/6a5t/Zu8mQIE5r0ZXyFbWGVTz5a
	 cPCMd3kJ74K4qsgARqnKcihOqzEtUaavkQDqM78I8s1lFYnNtl02lmLQq6PJjgMjGO
	 D9BAGNRDqtHQQ==
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
Subject: [PATCH v3 4/6] PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
Date: Fri, 13 Jun 2025 14:48:43 +0200
Message-ID: <20250613124839.2197945-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=cassel@kernel.org; h=from:subject; bh=6/IMz6KsQOndP2uMWYKRTgnrZOpx554WwEzl9Odz8YI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85HT8fQ8U+1fveadcPzOUO4f3wsyTfh1TDr39qNF/4 fmTrrlbOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRVzMYGVpEf2tfDOKo0rX5 klKycd7RbpuUpmNelUuPnlK93+K/3pvhf2rk5IMd9hcZ6zx33X9/4f+nc192X51067muuUw20zr BXQwA
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


