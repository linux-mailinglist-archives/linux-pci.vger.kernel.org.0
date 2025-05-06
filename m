Return-Path: <linux-pci+bounces-27262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA4AABC78
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC57A00C5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526F209F43;
	Tue,  6 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvOj3xPQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E99205E2F;
	Tue,  6 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517194; cv=none; b=IRR3JhhPMj4MT2Va5TRxyChhJUg627EcK+2KgeGHwIGoBNtv1ek9e60QmGmJnM9n2V9nY+ybLGd0TLcZspjmW3g7mEUDqeK3gd8jYLgN6R+v7GDOX6DCCMkW4AJDGtZCxX/kuUa4r4CXBrJTJFB/MH34wQI5DCkUzKIAMUNDSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517194; c=relaxed/simple;
	bh=gdkx6I9xAd8ChXompWb96uSWQh1bxe/w+FMbYjeo0OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tScN/StF+DNkHzS8SIZXZJ12WwjoCcOBYBmPaPRLmQYLDch+Mulf3I1OH9i93qmnWEfdVcqasIdfBatG6+2ZJYwnF+/IWIW4JSwahbZ4DpUKR8y82tnDEtOWdge/6MlThpL2Rvkw1DBIvOiu1FdnB1OvMoYATsLDbpO0qmfH6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvOj3xPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736FAC4CEE4;
	Tue,  6 May 2025 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517194;
	bh=gdkx6I9xAd8ChXompWb96uSWQh1bxe/w+FMbYjeo0OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvOj3xPQjrwvoboH8TxqKe5QgbnHRYzQe2xmaoi2Y3Np0izv3Tci4b+8DWuQLey3Z
	 U9wY4Z6T0bKl4Me4lOMfuUlAilRYuZR0t1bT3haFELlxwZiYA0J0QTVwmvxxU563cc
	 cwyN4ywkrkUYysOoJLoycMCqwnypkPUnOXTppj06qfpVx2NWnMz7bB2orzRYVuuOOv
	 DiY0gaOBFYdkKh4cxTlK50emSw/BlTnmpUoh5WSxFofQVkQOOehENFykP/bj+VhKkD
	 BMsAXhuzJqf8zVYHj7KnVt9M+bmrPmXRB2i2dXmtkke8pYlnGPRJXSeImfIUcYLlzh
	 mE8pwYWBN+g4g==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: qcom: Do not enumerate bus before endpoint devices are ready
Date: Tue,  6 May 2025 09:39:37 +0200
Message-ID: <20250506073934.433176-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=cassel@kernel.org; h=from:subject; bh=gdkx6I9xAd8ChXompWb96uSWQh1bxe/w+FMbYjeo0OI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIk9+yu0FjDEmsrzfpYUuCanvkuh5rbO2rm5zW6+iVqT BC9y3Guo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpADc5m5Fhr8Gio/+NdXf4zT3x 4t+0LS9C/RL+qlUl3da4bhzwofHMBYb/iRVNj+fu1Zs4kS3WnOnB9MRTj83DKxPEDmUFOHfz33v IAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link
Up") changed so that we no longer call dw_pcie_wait_for_link(), and instead
enumerate the bus when receiving a Link Up IRQ.

Before 36971d6c5a9a, we called dw_pcie_wait_for_link(), and in the first
iteration of the loop, the link will never be up (because the link was just
started), dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS
(90 ms), before trying again.

This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
(100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
bus would essentially be delayed by that time anyway (because of the sleep
LINK_WAIT_SLEEP_MS (90 ms)).

While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST
(qcom already has an unconditional 1 ms sleep after deasserting PERST),
that would essentially bring back an unconditional delay during probe (the
whole reason to use a Link Up IRQ was to avoid an unconditional delay
during probe).

Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
IRQ handler. This way, for qcom SoCs that has a link up IRQ, we will not
have a 100 ms unconditional delay during boot for unpopulated PCIe slots.

Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Link Up")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362d..01a60d1f372a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1565,6 +1565,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+		msleep(PCIE_T_RRS_READY_MS);
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
-- 
2.49.0


