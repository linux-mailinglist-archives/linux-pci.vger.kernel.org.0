Return-Path: <linux-pci+bounces-26971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB9A9FEC3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803061714A2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867B15748F;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JklXKfpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF132AEFB;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888750; cv=none; b=fZzntOWWtq9YPtlYDNYEREvyyTWqfI8O/GeZQ8OksSnkx/8h+pXlP7w86eK/7zD+VM7JN+N8cxizzJLFfB4pruIILPMq37azECKGKu+N9+H1/HoK5bRW1P6OS/++ipG9T93r+qVwKpWveXX08ZQdINffrogOsRQ4r82YviQRKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888750; c=relaxed/simple;
	bh=EM6ElMfbJozbwi36h7rM3Qknfs+VrjA5AmrU9DsF36s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZnxP9P+SU472jvsI8T/1Ih+8dB7fP+Wy0aeifF9SVR4br3NNCP15R0pR0pv7+PMDhbfhsC+WScAi96bUQv9z6IB8ZYohRz2IeUXwMQCgkH4sn5k83cSIkgosvzLRkkcxrnrJ7fLepjCZy66RUFEllpedDQ6V+4sDTh414xwLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JklXKfpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE96C4CEEE;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745888750;
	bh=EM6ElMfbJozbwi36h7rM3Qknfs+VrjA5AmrU9DsF36s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JklXKfpoM6eam6ewpkiiJrk+oLEyBOFDks2ysMzVEglltyYGv+PMcXRClDJtXRLhl
	 MIcNRdfkLIDiD4ZDUjlxFe7VaJya00ZtFRxOFUIfGpH54jsAouhgA7kVpDR1AmIz/D
	 DkfYbgndHVPHg3KgzvozsJRvAldT4p6ljg8z7wlz3qn9O2TAzS9PD7pRWmZZrH+pAc
	 LcJPODpg2LsRop1IUcxfwovVBvaofYFmbwNLeHAOpL3f2tZUfTf8I2O+mjCTnG+bIi
	 QedYFK8HSWHU2mVpCiGtlZICTRDKRYPZQ+CbnFnTUQBXdvxCWcTbKlelvSS7whD7H0
	 YpMPvVf3wD6Mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C184C3ABA5;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 28 Apr 2025 20:05:47 -0500
Subject: [PATCH v2 2/3] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pci-tegra-module-v2-2-c11a4b912446@gmail.com>
References: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
In-Reply-To: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745888749; l=830;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=xVyHjzSr7wHYXMLNGdp54ReYaOCWfcLl7SzVd0MbeFs=;
 b=gIud+Pwnuh30AZATYddoB8kGlcEmY/P9Nw0DW7/uOyryc78z11uWGMo9bZX3IGoqdTjnxY2mH
 yeby/7GMn7+CowD+fN5sc9KPPJ89qdEWjbHPF6D/bEfFopMgG7F56jJ
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add export for tegra_cpuidle_pcie_irqs_in_use() so that we can allow
drivers like the pci-tegra driver to be loadable as a module.

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



