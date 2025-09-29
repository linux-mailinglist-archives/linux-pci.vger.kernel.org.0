Return-Path: <linux-pci+bounces-37229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C9BAA49E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 20:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F97A16BE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEC23B62C;
	Mon, 29 Sep 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tTpZknqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CA19F13F;
	Mon, 29 Sep 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170532; cv=none; b=Ou4l8aE4/QqmBi0oFbYfn6G+NAcxh5T7i7yW94c8WgIyMSHcWQmgrjQM+vcM4e4hKfuSEqDj3N+xNzEchRtZLE3QHlemKGbiv74BrWskZq8A+x8K4GYwP3eUSuC2bSd6qcT9GUv7wgI/iQc/HCPy5k2YVA9TI47p93v0JQnedL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170532; c=relaxed/simple;
	bh=vgCxGCSK27MQPtQozsmkHWiMKjltThhDC6HzpUXtL5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwynHSKrQXItp09VMpQdcOhbRmXlMr5GwFOvSEv0DvJQEihHvxmAYG9tUPDbZ+d9a8NJ6ywPlLq0nEKYCmW9C8wIIXul7MpN0GDAsOJLfqk3edBrr6ool3GaiFkT6T+WA9N0OPXn3LKn5f2C7x9v7bu4X6lPylb38OZ4bVN1vEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tTpZknqU; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 3ITEvqX6XRHxd3ITEvYxTM; Mon, 29 Sep 2025 20:19:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1759169974;
	bh=wTnIMh7xoEfksOfJHKUgA8+GhzjMgsbCB2sGq5dPA74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tTpZknqUSmXo+Xqm8X+UH3zMbiw1hD8niVucVZrWGfDeodUlaV2SCMACaBSqPqB5Y
	 XaBQ1i8OAwB6Yi4sogD+qHfYCpqrPPdrpau769Y6lB2GceUIJCspANhI82oD56OaAE
	 jIoxVCmWIf4k2scI7jjIHs4tq4pCkP2Wqi+cmK2V2Vp1j/YVWcHUWCRYF3wdrO27gr
	 h0j5uOmTjVUc7ruZ/Bd0AwpllqoEe9ASIGVsBKHdurEde2whEJ3asMnih0IKIoPtMc
	 V4hBEmaVaJqE5g8uTbdLE3cPRSC+GC8SmuG2fPhcyMd0kAUwRUXOhj4S3NSGab0TaO
	 sNKxpsF2TK7Dg==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Sep 2025 20:19:34 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: stm32: Re-use existing error handling path in stm32_pcie_probe()
Date: Mon, 29 Sep 2025 20:19:30 +0200
Message-ID: <e69ade3edcec4da2d5bfc66e0d03bbcb5a857021.1759169956.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An error handling path is already available, so use it instead of hand
writing the same code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/dwc/pcie-stm32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 964fa6f674c8..96a5fb893af4 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -287,18 +287,16 @@ static int stm32_pcie_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0) {
-		clk_disable_unprepare(stm32_pcie->clk);
-		stm32_remove_pcie_port(stm32_pcie);
-		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+		dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+		goto err_disable_clk;
 	}
 
 	pm_runtime_no_callbacks(dev);
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		clk_disable_unprepare(stm32_pcie->clk);
-		stm32_remove_pcie_port(stm32_pcie);
-		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		goto err_disable_clk;
 	}
 
 	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
-- 
2.51.0


