Return-Path: <linux-pci+bounces-27104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20072AA79AE
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CE44C57BF
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2E1EBFEB;
	Fri,  2 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVCxA7Fi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188182F2E;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212445; cv=none; b=fgxG3H3ktHYjAd0FkPuzlxEJOJZLwNrNpx/lwXSbWZw+Cgs/uO0VqGGlQXGgns6zLocC5KP5FPaVKQwi0Tk1P74PLzDY5itTtUarg33k9XRwv1VBf0GuACf0D0kdDB0aCFSUkBfrRQ8kJfA/x94yrRbPtbpThN8hdxLn8isb0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212445; c=relaxed/simple;
	bh=LRTzkroHpUqBBS66F+/5iJ/bP7dLfCm5QyQ+g9hrpLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYP+IdN6Q26kLppO/T7rNO3fOTLbw7jqXpSXFG0SpGCqI3pWyIGR2+F5xW1q1GXrJAH6lCoMmcfmbHPJ7+3ePZyfgg+BGlhfx+RT49+W+OIdIfi5wA7GbCcwlWARbBnIKTy4SDVVypqaS+ssHgbzXD6lhhL1dXgABO678qWUR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVCxA7Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE755C4AF0D;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212444;
	bh=LRTzkroHpUqBBS66F+/5iJ/bP7dLfCm5QyQ+g9hrpLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RVCxA7Fi2kC70zTldFhPrK12iBLCevvXON41AsQDhiT1fNWYAKJzGGtG2vHmHgeQz
	 kjELgmD5yS/RwhIz6ZsP4qOmmrnBCBAI42KTEdcI36beuHzh6rrohOww0jH7VCepXq
	 niPchHhpAF6xaYAvHHj71qbjmogoNEPbk5PS/ZTMFIQPFLJc1/b/7cjvbZq5TS1z3B
	 raweVQ0sMEm2uUVth8Puo6kpl5vNGooYCbCs5hfBrUX4Am9pMc3eK51s2xuQPhU2Df
	 W7P1tgBzpvX8TxFZ3rsLRfHw6ga1iEdjKpHK53zdXnOwsfm3v+nNaelfk5T9Es7/1Z
	 iyvrzzxvfnmKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CDC3ABAC;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 02 May 2025 14:00:32 -0500
Subject: [PATCH v3 4/4] PCI: tegra: Drop unused remove callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pci-tegra-module-v3-4-556a49732d70@gmail.com>
References: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
In-Reply-To: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746212443; l=1781;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=miAFNHWEF9RJxGC8gWXehC/2+WRlc/Ou80W+mmEfiFc=;
 b=Waqua4Tb7qWUjc1jh0Wel81cwJ28ZdHn3RtzwEJsCdSru2Wde97OIA4t1VBCcM2Gt/PaW64r4
 m3PfBEnaE9fCLOlIe+Ks563X1TV6HHbYThvPTaXeCeMIL7ObcY64WHr
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Debugfs cleanup is moved to a new shutdown callback to ensure the
debugfs nodes are properly cleaned up on shutdown and reboot.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 1539d172d708c11c3d085721ab9416be3dea6b12..cc9ca4305ea2072b7395ee1f1e979c24fdea3433 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2674,27 +2674,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static void tegra_pcie_remove(struct platform_device *pdev)
+static void tegra_pcie_shutdown(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct tegra_pcie_port *port, *tmp;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_pcie_debugfs_exit(pcie);
-
-	pci_stop_root_bus(host->bus);
-	pci_remove_root_bus(host->bus);
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		tegra_pcie_msi_teardown(pcie);
-
-	tegra_pcie_put_resources(pcie);
-
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		tegra_pcie_port_free(port);
 }
 
 static int tegra_pcie_pm_suspend(struct device *dev)
@@ -2800,7 +2785,7 @@ static struct platform_driver tegra_pcie_driver = {
 		.pm = &tegra_pcie_pm_ops,
 	},
 	.probe = tegra_pcie_probe,
-	.remove = tegra_pcie_remove,
+	.shutdown = tegra_pcie_shutdown,
 };
 builtin_platform_driver(tegra_pcie_driver);
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");

-- 
2.48.1



