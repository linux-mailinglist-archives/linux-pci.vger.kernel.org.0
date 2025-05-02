Return-Path: <linux-pci+bounces-27108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBACAA79B9
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39594C5274
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A31EF38E;
	Fri,  2 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYk9O1ao"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189401B393C;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212445; cv=none; b=RuhXZW21bm3mNGlA68HBpHviSIh2B11j2Yw1AfS0LUXxDYiWb2wY0QbvH3VlecIO/3fb+ZU43QlF5vLXQILHFwZo4mt8kJIkgyytqzF8pzx9WnGhS3VVR8bgtEfg7wCzGxxfDJWUMYLg483ekFXglEKjAwW2Ld0icieryPgHXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212445; c=relaxed/simple;
	bh=EM6ElMfbJozbwi36h7rM3Qknfs+VrjA5AmrU9DsF36s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWwgvHWbJQUuUr45EoeRhzMfDwloSxbbUY4PeBD6AbxfPreEdEdKjkwpEQ+B704+pEgZUisujfH9jLVuPF3ttbWj8QqK0h/Nl5kF5cnoibGjmDvF4GfImUNlbSJj0M4VMHMoAPwZ2VkSwZO2XuPpPgaIrXj94p9M70IPVSu4Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYk9O1ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A607DC4CEE9;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212444;
	bh=EM6ElMfbJozbwi36h7rM3Qknfs+VrjA5AmrU9DsF36s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VYk9O1aoPmu0AGsHsWYGcOvFTNkG5k5HBdSxIUgQ23nsQNxBzq3joz4pEGPw6mKxO
	 JDybJA8k62Lol1jHhn881y1JWwbMpAX/6GBmbqy0fOhH01Saj9u62opFFwhyop8aUf
	 VG6zeavbM4q44h2RqPRZFWEF7bAdR2FD7rBK98GboC0oH3FBgnEIw4v3S0VtazC/j1
	 4GWK74R9qB71A4Doq+S9/UKRWCFzxoLQAmH/0ssO5I/szHmqpdOIf9Kx60muo5Bj8h
	 Bo4ZoVJXVXphVo89bafFJCONslJZl/MLaS5qMgwNp/A4kt/tnsFaauDaaKAfHFPxoe
	 2heui5+ACIEkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9791FC3ABAA;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 02 May 2025 14:00:30 -0500
Subject: [PATCH v3 2/4] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pci-tegra-module-v3-2-556a49732d70@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746212443; l=830;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=xVyHjzSr7wHYXMLNGdp54ReYaOCWfcLl7SzVd0MbeFs=;
 b=SqXjWEAxLjXZ8IA642yInZJFT5zVd1nLIm+wRIuqLxf1ecpSS54HDkd1vt24WdaR5cLTNfshs
 VuuD0ygtyLJB4jBitbzfc2U5jSgSfnU+RV8dUr8yaJ//yilQWNe53IS
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



