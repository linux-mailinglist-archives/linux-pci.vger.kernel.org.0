Return-Path: <linux-pci+bounces-27237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF6AAAD3B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C06F3BD3E8
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FA03CF323;
	Mon,  5 May 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFpUdF6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9772DA0EA;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487042; cv=none; b=j+LMLDmCTY5nU95MdBbo5oKfGtbmK3yqPghx9NE7qdngzW30WNLOdjPHk+3jNt7X5/2MV2Q22aZv3gVWGmAMcR98TMoT02NdJdcrDg615MpdVDnK5GXSCWmghnkOkPe9jRxnMYJMi9//wJ+r5JeJmHrYHjgWVcHF3u9xhVU3LP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487042; c=relaxed/simple;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8hjj6J+taOKrlCPYkR5845rC82QBArdIimfYUJf0uoNw6xhNBqvrtzc7/GXf9XrL7xfW7u+wRPLpGexcn7i6yMXfQMQf6tG5myQFVrNA+M7kS5UWmTwkMDvd9X+4c3G1WXA2+MMGaHdL1T1ni23iciy2N7DIj4CMB3ESOSj6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFpUdF6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71740C4CEE4;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487041;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YFpUdF6uvuXHBNQroEBQGOXU42T9Ojja5dNWud17KGZGd70Hnp2+Kl+5j+jWzDkPP
	 4G0wULQ2KcZ1DVzdk0oIYoihMgoQ/NUQC7OfqSBfVRZMm8eN7rm94aOY+jt74hGQH2
	 3k4nt07VvGdfdNEIruU0y6hQQRu1HrSCdksbgbWzDcZ5F6G2MsGGZ+yYeXPbJmLeD0
	 iSQbHYXJs3bqzH3pmcQfMC/+4uZUOCHiOadxEM8sOZ8if6JKYpDo0ES8Y8SzAoCwoZ
	 L2ftLo8jxpmCDXHH5AL3Fhv2oAYdr6Kkzd2zV17r1uuvbHWTL6s9gjDhHEjQN7ZHXj
	 qdj9V+OfND9xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86DC3ABC2;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 18:17:21 -0500
Subject: [PATCH v5 2/3] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v5-2-827aaac998ba@gmail.com>
References: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
In-Reply-To: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746487040; l=805;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=VxJ9HgkNV4IxH20jYpaAA9e5Ei6kk4ytu1PVu0wpNxM=;
 b=z0W8d1Q64bfmqnl3a4wP5TKAH7EjzkwLbmJxq1UHI5FFF3Kx7RAK2oAK5+8b1qLQQ4rTygQlv
 XNqsbCcZzfqDKnx2o3KR3tU5gQmKhc8Zoqq3x8faYHwniL8tcdYJ7O4
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



