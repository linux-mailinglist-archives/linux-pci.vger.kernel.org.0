Return-Path: <linux-pci+bounces-27163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899BAAA96C7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF72188A07A
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7325CC58;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0jbAMTA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6625A2C6;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457142; cv=none; b=nY0srCxiRyijWj8sYnOvHR+tybTeO5O6o7kYmnnuHdYxm0dW3HeFAvAN3HoGU7EWKg/K9B9jWXvBgDmxICkEj/nYWS5+s9OsimRBcyPblISTQp7WNh4t7Wi1DHFsjcXbt2QWlRn51NReA4O75/n/tMP+IyMM/P1xN+WVlB7cbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457142; c=relaxed/simple;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUhGi+mspjMU1QKL4UNgnnEcaMuPhiO9i6reZ6D1F9MxwnkqT8hX83QkpVY/gC1ouI0hXfIoB0GQIKO9bzhQxTvC9klaYAldH61/OLiknukj7Hfu77jli0jCtm30sIdfIP/Zju80brHFkY0uVtl0Vi4OwQuXpNED6fECMwLiVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0jbAMTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5248FC4CEEE;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457142;
	bh=BTogwoPQhqDb5Lb0ED+JhY3WyEMYPQZBPF+4Xj5VUFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T0jbAMTAafVnbqu5lNX0d3PJPu+3V9Pq7QhyARDB2hXZUF4QMD+HMG2/XaKahG18H
	 TN/zzXIw6eeBC3oIRHNSaWd8o12H21d6QdoGU/L9dLWFCFLyhsEH9x68wQT90EGJk+
	 VqdYxfa1ion1xT5PtSW3ni9YtjGC//EC75m5OULisSTldKmNhi5+GeYdScS9PCC2nv
	 SKV3GSCjkrEeFqVvWLPpHOMKDJxxKlghvLGLLgDGtv0yEn8diK1bXHB4bXdOLuPY8b
	 Buy4elGz9deZTA/QqNx+c5xXmK7GnUnXmxhe9vlKTnxrsviy7BMHaJvXuLewAmhE/y
	 zdANeKZQ7kzqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C54C3ABAA;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 09:58:59 -0500
Subject: [PATCH v4 2/4] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v4-2-088b552c4b1a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746457141; l=805;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=VxJ9HgkNV4IxH20jYpaAA9e5Ei6kk4ytu1PVu0wpNxM=;
 b=6jgX9ffm9Nmwy2049q2VtY0GOGl6UakWcODkZmokzrC44xXM7rRJ/g1pFvXlwYX3lnDE4jSzD
 vrXe7XFvWvzBujbjcgwqmRtxD9oOk5dE+w6l0D0dAo6WvQ8a0Sj233V
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



