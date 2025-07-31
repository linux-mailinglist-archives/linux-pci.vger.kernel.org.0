Return-Path: <linux-pci+bounces-33261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF0B178A7
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E3D1890704
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C526C383;
	Thu, 31 Jul 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuSZViBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07377256C9C;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999170; cv=none; b=rW/76QYs3uI94NVudFWVWS4B35o3CrIza/SI4ZFXpH4UqPl9U7JswaiVRugCb7riaROGcDI8zzIBiPVgqFyLt65smoPwWoqBpGR7huSYrwfn4cQ3dClZIsfmYHnnKkk3dVc0FSoVpLjREDzJDqxUNwpfMz4dYWQr9Ya26Hlba5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999170; c=relaxed/simple;
	bh=F9e9tSYIordXZeE5OqM2JTzyisbrcH2j1AtrPQ2LZuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEOsMPVoWuf5frz8xPkRf2T9JqBZ++tgyYNmMzXuzXLrA9yze7E0AJAb48ga6yoHLJahSoKy+1x1FtiERHsGMMbo1gBK3hdqJmnKEVvyf2ZwhcvK3n/3/jy+y9HhmhJ6lTFsVeE5Wn+h3fTCR3rsDn43JhG0GsIbCCDFvKrHaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuSZViBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B08E8C4CEF4;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999169;
	bh=F9e9tSYIordXZeE5OqM2JTzyisbrcH2j1AtrPQ2LZuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IuSZViBukNwZ1H5iO3RNSBrnvWZi3SFdRE4TBd7fjKn6vzjUoAqAk8pQoMwEPB60E
	 4mr4Omc1f1X8cyuuSC5RXwcnUJKxvl0vTkW2X6byenbheZswD0jSREekb+SdJ21+2T
	 o9jwavJxXTKrASheQfCCKCtSffc6O+KoLaCokSCqGVFl0UFTxdlMDZtybXkOrqMy24
	 jeG0JUA2ebRZ4hHtL0JBFhGYBB6pdR5kbR/QBFzAaQiWxkFjGE+W+C/Ufqs3oVak3Q
	 JxB23jE7UAEmgPMr0iOvWuuwD6X3nDRov9LwnoN9eYFr53sNw4MmdJcD57NT0oLzUs
	 4Wq8zWfXjiwVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0253C87FDA;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 31 Jul 2025 16:59:25 -0500
Subject: [PATCH v7 2/3] cpuidle: tegra: Export
 tegra_cpuidle_pcie_irqs_in_use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pci-tegra-module-v7-2-cad4b088b8fb@gmail.com>
References: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
In-Reply-To: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753999168; l=805;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=BQaFZtR7Fm7B7nsp2ZQnjqbnUiyMM8zRmZn2k2TW44w=;
 b=wfFDEDELw372gFNOlZws1E4tAwNhCQGy1Cm8MSywVcEUzrZorttMs/ZN4oswzg/oR2LxGkIB3
 iBjhF90b2H5Chb8th6Tx0XoU/S3JD6V4zCpe4TVJdhD/RRtWdlHoaRo
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
2.50.1



