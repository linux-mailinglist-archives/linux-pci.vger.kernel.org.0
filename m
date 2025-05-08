Return-Path: <linux-pci+bounces-27410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53FAAF190
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AFE4E4052
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67421FF5E3;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+JdQB4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FB1F63F9;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674754; cv=none; b=bHMUZpBGQTXC0P+BcW2CWq8iT1g5fAY6UBPcXPCs/Auw2URbEz6aN4oCt1dai+nEcO3vB5u3bVs6dFH604Am4GvqBoCg4m3U+uz3K1SThfuTswQ9DJZyJqBgPPQXVXoXJo6VljFwTtHNsZCAQ2uxYtpyvSq5o6/+Ui7VTOkLesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674754; c=relaxed/simple;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cU0XMJmEgQdzjv8wnkZrSty2bI1ZYDXJvnb4tEtSc6oC0awV+ub3DUDLeE0Ic/SMIohhb0kDhH9R07YFzEDNAnMAr6uCabAPIlJb9Yj/gYIfsWWmDuqkLkd3RoIi6DgKTkr36mbrF19kdt8LKZefeAnEKOq44ogRjI1t2A5G1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+JdQB4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21025C4CEEE;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746674754;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P+JdQB4tAi+TiDVPILWH5+ddlj5ErAeVXCgjBQPmgivU5S2Z5sGV1eJPAzcQVdXji
	 VkouQ6h6FW4mKpGw8SlhVEE/x9yBGgVZ2mhjv1tI6u/5dsYczK2/QkMsMS/IM0i3A7
	 XR8fvFDYHqIJXQhsl8jA6iBhih5HPLIkonwUr7+kotCUe+U0V3pyh0/EYrM2LHlHFf
	 OTFzUAGX7sI8h/j+5SYAV3AHF40t1qOaWxbzhBVqS+bYVJa0uO1V/Vmns14Wy0sPX5
	 2GJ3KqhjS1wEjfkZ/PJMx7dxpUfpx3FvrsZUAp8tOU1Vl/yZfya0uOcmWlmcVN++3Q
	 rFKmbGHvx1ZNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EC1C3ABCA;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 07 May 2025 22:25:53 -0500
Subject: [PATCH v6 2/3] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pci-tegra-module-v6-2-5fe363eaa302@gmail.com>
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
In-Reply-To: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746674753; l=805;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=VxJ9HgkNV4IxH20jYpaAA9e5Ei6kk4ytu1PVu0wpNxM=;
 b=jQ5uhYJxgIm/O3kgeqGTl+rnw8R8GlbKBUwE8eXdNvKwfkQLnHXHG+wyTdLYhO476ZT9ln/Yh
 WWDn7CHnFGQDXye1BtJu7iGJu6Z++Oq64YAD5f7fpKIh8z+D3twuY0w
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add export for tegra_cpuidle_pcie_irqs_in_use() so that drivers like
pci-tegra can be loaded as a module.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index b203a93deac5f378572be90e22c73e7417adb99e..aca907a62bb5de4ee4c71c1900eacedd4b90bc0a 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -336,6 +336,7 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
 	pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
 	tegra_cpuidle_disable_state(TEGRA_CC6);
 }
+EXPORT_SYMBOL_GPL(tegra_cpuidle_pcie_irqs_in_use);
 
 static void tegra_cpuidle_setup_tegra114_c7_state(void)
 {

-- 
2.48.1



