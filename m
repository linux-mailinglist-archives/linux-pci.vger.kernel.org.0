Return-Path: <linux-pci+bounces-17484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74109DED93
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 00:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9443F16387B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DDC38FAD;
	Fri, 29 Nov 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY4Q+u5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94C1A08CA;
	Fri, 29 Nov 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922506; cv=none; b=nslgNlEWEsf5W/a7IfeEn/cH32ee2MyCVbW21Zwf0cx+/r8UH7V7+iFq5hnZ1YeR+MZ9FPLpo53Ss+9YUiHWVjo836+ADILpFWrsXWS9oA8ZU3+EJz7MXx20C+HbtBeEoklWU/2+KzBjs+8Y/hHbKimhzGMzo8k2AcTSzuNkYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922506; c=relaxed/simple;
	bh=RF3q5O23wBAonOVltARg7fJQ3V5muUeYMukIBjPft+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvd7Yk47SWiUXbcR+aQQLFiZzY9iz4D1YFdjnPTZkMqqEYJSy50K2fR87UPEAVwx+fS+eYeqSzwges4B+6ai01AKbuKs4SD5qLjJT73WVyc/9j1S0CSWawz2HHY7L03x7ElARrHEaJaJTLkS6hHh8x2WO0uR9ju2gjG9a/XcnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY4Q+u5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763F8C4CECF;
	Fri, 29 Nov 2024 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922506;
	bh=RF3q5O23wBAonOVltARg7fJQ3V5muUeYMukIBjPft+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kY4Q+u5MYbYurISr6lmZRf/rHl7NOIa1OCmedWiWjAZvUw/+1U8fqT5DnYLTfhU3m
	 VsasxitWqdDAZNyvSDc2SL3c9np7j/lb/uZlmWoJ8Znibwpx7oRH/Ps18Ts7KI+aDg
	 Ee4DRCBw1VjT4uXl3DKcsJTuhk1FDo+BSvJeze9Qk6Oa4azcgw062GygOwqTxBD8sK
	 2b56+H1bYmcFLuNmhQgPcoBEHZdfPBsd6wgpAIgN9iOCP2domJyndDuHESc7MZG//g
	 fc3itkw/Pa2JpEfelXQ2d4DSSykEm2Ds28H+Frls/XauhqA+1nREDVfw7gS0oWMzOL
	 OjpV5ev1h9NeA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:20:14 +0100
Subject: [PATCH v5 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-pcie-en7581-fixes-v5-5-dbffe41566b3@kernel.org>
References: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
In-Reply-To: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
causing occasional PCIe link down issues. In order to overcome the
problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
REG_RESET_CONTROL (0x834) registers available in the clock module
running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
In order to make the code more readable, move the wait for the time
needed to complete the PCIe reset from en7581_pci_enable() to
mtk_pcie_en7581_power_up().
Reduce reset timeout from 250ms to the standard PCIE_T_PVPERL_MS value
(100ms) since it has no impact on the driver behavior.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/clk/clk-en7523.c                    | 1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 22fbea61c3dcc05e63f8fa37e203c62b2a6fe79e..bf9d9594bef8a54316e28e56a1642ecb0562377a 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -393,7 +393,6 @@ static int en7581_pci_enable(struct clk_hw *hw)
 	       REG_PCI_CONTROL_PERSTOUT;
 	val = readl(np_base + REG_PCI_CONTROL);
 	writel(val | mask, np_base + REG_PCI_CONTROL);
-	msleep(250);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 01e8fde96080fa55f6c23c7d1baab6e22c49fcff..da01e741ff290464d28e172879520dbe0670cc41 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -977,6 +977,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 		goto err_clk_prepare_enable;
 	}
 
+	/*
+	 * Airoha EN7581 performs PCIe reset via clk callabacks since it has a
+	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
+	 * complete the PCIe reset.
+	 */
+	msleep(PCIE_T_PVPERL_MS);
+
 	return 0;
 
 err_clk_prepare_enable:

-- 
2.47.0


