Return-Path: <linux-pci+bounces-35683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A897CB49660
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD421C217C1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8730F545;
	Mon,  8 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khYYiWO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E53FFD;
	Mon,  8 Sep 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350824; cv=none; b=qzQIUbhwsms4246Wfypu1ZwxwjdjaexqcDrSwRGySTHqD3D7UFVYAta2bKkEArSmistXuW9/YsxBF/gZezvPUX3GyGbawH1BnIHxhi97UtFoiCM/7OyhDzQJeKxqciPd8qVN8vv+zyslzCES/GogcQ0pGt+7BW/l2Mxc3h/OTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350824; c=relaxed/simple;
	bh=zq8ZP1y7XvQPZTqCvnVAYN0DfbrRS2r3coqP5dx1aYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeRL8OjwDQwFu/XBmPjOo81veYlZTq2HJLEXL66AADXAJzSjfgpJBCpc7TpTz+OBmhWcWGHjGQ1//LL/ocWHfanQNz8/RDRLtHN+TbzUCBbvSBU0wxObD+JOHrDDB3gy9PcdrfmMDRGjtjn8CGvxck0r3dpeiN99YvZ4QJCR72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khYYiWO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DF4C4CEF7;
	Mon,  8 Sep 2025 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350823;
	bh=zq8ZP1y7XvQPZTqCvnVAYN0DfbrRS2r3coqP5dx1aYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khYYiWO4Oq/q0r7y0EQxDKJ2k8j/mwT4u5+BXihexEC/xbDg+VibOoYimvMw3Wjpu
	 dAaiGdw1CX3Ng525SC++xJVuUnT4eDGFZ0J52bgs9+koMeiXLlzde73KTXmCcwbHBu
	 QtlCVniYOM1DO8lSLrLRs+OtCsl6Mp15qwZyYF9pgx853t94Lv9W1PJfTmvcQGIAlA
	 JbMqiIdPPYIiDYKVBqS+X4NDV9rGlqPTEsVR/MhJm01hLBYhCjpd+DRwwnFwsjqsBs
	 zUsTrtpiKgbZuHToUAs1QdP61EISkFFuyHk1LJBIu29eQV50oBnRsQfVLhXJqhHHZa
	 ZYkvfI+a7BF0Q==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] PCI: qcom-ep: Remove redundant edma.nr_irqs initialization
Date: Mon,  8 Sep 2025 18:59:16 +0200
Message-ID: <20250908165914.547002-4-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908165914.547002-3-cassel@kernel.org>
References: <20250908165914.547002-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=cassel@kernel.org; h=from:subject; bh=zq8ZP1y7XvQPZTqCvnVAYN0DfbrRS2r3coqP5dx1aYE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL2c6fd/spU0Vq3cHbLnZb0Sf3We5m5nzmduJSYeW65s dOU1McvOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRiAkM/zQk9k3wsjBYJMgR tr3nWF3LB7+KA7y7Gq+75ipfuXjY9yIjw3L5ix5ff9y6OaPB5aJzmmnQl2h/hroLr6NmcXntqO8 5xwgA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

dw_pcie_edma_irq_verify() already parses device tree for either "dma" (if
there is a single IRQ for all DMA channels) or "dmaX" (if there is one IRQ
per DMA channel), and initializes dma.nr_irqs accordingly.

Additionally, the probing of the eDMA driver will fail if neither "dma"
nor "dmaX" is defined in the device tree.

There therefore no need for a glue driver to specify edma.nr_irqs.
Thus, remove the redundant edma.nr_irqs initialization.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index bf7c6ac0f3e39..ad98598bb5228 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -874,7 +874,6 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.dev = dev;
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
-	pcie_ep->pci.edma.nr_irqs = 1;
 
 	pcie_ep->cfg = of_device_get_match_data(dev);
 	if (pcie_ep->cfg && pcie_ep->cfg->hdma_support) {
-- 
2.51.0


