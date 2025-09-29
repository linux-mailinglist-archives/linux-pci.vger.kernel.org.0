Return-Path: <linux-pci+bounces-37228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975EBAA46E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328361C4590
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0454230264;
	Mon, 29 Sep 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gzohR3+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16B222565;
	Mon, 29 Sep 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170147; cv=none; b=ueWytO+/xW7g3sSkhvFQx2/WRlgn1jJKoG0GoC7LAQau3QWd5l7lZr2WZ0H9NXGkrF5AfOBpuDYZvxxqQ5LwRMozx0s9VZ8hJpZfHnljESyfEa7xsxUj3QMkgJsJqElJdXCQ7r7Qxxo17PczvuRQhemboQ3WwifwprKsK/dGv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170147; c=relaxed/simple;
	bh=R31Eudw3sKURmOO2Aq8qBpLMf6lzPrcyDJZurOnal2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y79i6vDVMpAv+CLRe5VX8llLMwITJVskfEOKfV63ASiYXQ/Y8A1NXQkEYjiOS7NecC+ajfQHV2keuCImf9qCDJgKkA40lHFG2RGvVVIcdBEkon5n4GFCQB9h3r7gI0UqkekgEg0/qeOQK9S/unYwuJVqOdnAFHXPN1RUhHASHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gzohR3+m; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 3INMv36YvVNU73INMvuMjv; Mon, 29 Sep 2025 20:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1759169608;
	bh=Mc4Pc8eiwGSdwox5Cd2amTY3CAyX0P3Mao0oIJvCrC8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gzohR3+mgdUJmeN8Tcn+jIYki/8ypM1DgxTe7QV9jewtYnhrqSPtlbjBxsXZqjTp2
	 vA3hWBleVatFKif4pu53VjCAOdR+US7l3IClbd3tIRoDQMCl+VV2swcKpbZth5US23
	 Crfu5G99OH5e18fTBGFRBaxuo4dWo07kTE8VKRKJHSmugQA79DBP4xXYggP2MzFiQs
	 Jfe1lWWILbshMMMKsspHj2ZF63pmZc9r+DhGUhJ3eTRWiBJf0md/Ot3cCbjYCQDHSd
	 V0V0kHPjhdXFVcTkxL8ib2V71Beuhtf1MGbECDnuQMvtFcKUAwuIZlctVID4NpuJAX
	 2JedxpCYkmI9w==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Sep 2025 20:13:28 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: sg2042: Fix a reference count issue in sg2042_pcie_remove()
Date: Mon, 29 Sep 2025 20:13:22 +0200
Message-ID: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
should not be called explicitly in the remove function.

Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/pci/controller/cadence/pcie-sg2042.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
index a077b28d4894..0c50c74d03ee 100644
--- a/drivers/pci/controller/cadence/pcie-sg2042.c
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -74,15 +74,12 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
 static void sg2042_pcie_remove(struct platform_device *pdev)
 {
 	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
 	struct cdns_pcie_rc *rc;
 
 	rc = container_of(pcie, struct cdns_pcie_rc, pcie);
 	cdns_pcie_host_disable(rc);
 
 	cdns_pcie_disable_phy(pcie);
-
-	pm_runtime_disable(dev);
 }
 
 static int sg2042_pcie_suspend_noirq(struct device *dev)
-- 
2.51.0


