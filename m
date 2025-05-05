Return-Path: <linux-pci+bounces-27165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A0AA96CC
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351D3188AA12
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBED1F8AD3;
	Mon,  5 May 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSyErdpy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97525B67E;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457142; cv=none; b=PPg8PUm9rPl6fsNNc1kiqyLb5woXtxi+jFNy+wGobTPVEr7NJtpx0qRtHDMv33IuUv+gLJFr5a7hYqryApP1rio/c4JavhAR4JmutQmLqCJNKY7ldlAMCjuxwkdSAonZ2ifr0RF7ZruP/QuygSm6x2PSDF8irc/EhUMzW+/PlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457142; c=relaxed/simple;
	bh=LRTzkroHpUqBBS66F+/5iJ/bP7dLfCm5QyQ+g9hrpLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITzYTM3BXK658KO3A+z8R1SF/h4J0t9nG8V3NLS1jCCeZkioWiNArDx7EmL0aigNDdaNjk5OBwhiq/3i/RpWpVkRwAMYyHPFizznfz+Yi+OSH4t1o5LP9+AaVY8nt8MIJCLacBP/B1J0f8+2btHYXWUidbfBsILcWoDnMB2DJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSyErdpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6963FC4CEF4;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457142;
	bh=LRTzkroHpUqBBS66F+/5iJ/bP7dLfCm5QyQ+g9hrpLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aSyErdpyIssxCH0cyBCBG4XRW0vCWkp/D/YYrWNkhF2ZRgKruYWKAfV8yAAM/uZNw
	 Qpa9sBhUQRMgkzh15IiVSW3UKlHBrYudeIQyyGk5X7ApOgB1vqlKKsCcC+4xNVpkzA
	 SZ0u/4CFFUuAxmgWYPb3rFC3GmBX9YFu6Kr327TY4ZWZfLJUVfSxwps2+gZem8xhgC
	 /6NY0ox+vBU4cw9cf+R0RV2X7pgmQG56pKns054Fw2vxB1LlINtBeyy3fjWsoLec08
	 oZ6scWjXpNkDcmDwccmXMfgg7pvb7X0VLhC7QoGJoKjl7Nb6OhGyqvJvg98gkqmVot
	 xGGIqJrpPGmoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6131EC3ABBC;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 09:59:01 -0500
Subject: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
In-Reply-To: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746457141; l=1781;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=miAFNHWEF9RJxGC8gWXehC/2+WRlc/Ou80W+mmEfiFc=;
 b=VxWydBojj4iW1Ijuwovo5IQ9vqX/in+EsYY0WDnypg5xmW4Q2g9vI9d6lUykgCKAtRdZU7OCn
 +owjcHXA2DgCy/zWR1931CqjgR748RFtWhmGo3BmB4Rs668bnJne/OA
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



