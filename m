Return-Path: <linux-pci+bounces-22246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63EA42A7C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204FC3AB905
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990FE264F9D;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acjmclkd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51E264A90;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419821; cv=none; b=GCWjRYrYTe948K6swUpOAgWECAm7wAhzTr4o4qyavnIAnJJpRC7O5iPihyruZi/H3/j1NqG4mjiNZ5L3CaFvt0GYaQK58eB4xEsh1gh9DSl46nQzO+WLapDzKK7p8caNyuvRs3MPWBqykf6bzZHGuYKFL5+YDhrb33XcSj8GvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419821; c=relaxed/simple;
	bh=4a+Ba8QZYK76xIgo6O5qF/2YSpsFX90O4jcMzoEqCR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nim5kbE7XXknqGd/ndRkueNbEGhRWMGoFj1fiDqCIoePw37KRAFMDVJPWU4b5KjppK8CPc/UEIK4ChPMIU5AqnIprLUrAWnA9m+e7cRTzKIc3GxFEBl8NwLYQ/6g2kIpNknIi7Dm2i64Cx5I7LDOnIIqvMgI6Epk/hjxmBc5sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acjmclkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E64C4CEE7;
	Mon, 24 Feb 2025 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740419821;
	bh=4a+Ba8QZYK76xIgo6O5qF/2YSpsFX90O4jcMzoEqCR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=acjmclkd2iyzf5qnON7OEfyBLlFf/RvCXgCrUeyog/B9FoyNWRy7icEnszYGdl8Iq
	 H9F4h89dzW54PzFOSpyXKCzt7BxUbVTjIlmw8d4C2Qw/lsoF4cfwNgyq8dSwkkaQz0
	 /0jkI3N9Vj4zS3KOh5RP7MexKM4ivPm7/3rtpAocdEQHC7bjY2uisqLwUeKTWchFg2
	 GI+CWjHHVtUr3L+6/AlPyvstvQlBuEOtEcgkJVs9/nG9AxZYWSvREyOsG3TjtL0XKM
	 M0C8QVpNtoFXbpxXfTy0TP1Z7x93sNVF76NOPD1unWsN9v+TU6X5KxJLgcQ6zvXsAB
	 iJJZdb6PUAEmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281AC021A4;
	Mon, 24 Feb 2025 17:57:00 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 24 Feb 2025 11:55:33 -0600
Subject: [PATCH 1/2] cpufreq: tegra194: Allow building for Tegra234
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-build-tegra234-v1-1-39e4e912f968@gmail.com>
References: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
In-Reply-To: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740419820; l=901;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=N2Unw1HuoZWqut2GowZ6qITdgEN13Wd6f/8bHNS8mDo=;
 b=B8qdAanYCm4O6Ij5o9kyBkVQdPmpbNKzWrUVatQgd0MRn5PaeCkcVY7+cxX2EsGFxYRGcfnir
 bTVg0lW5L+qBQygnAPy7tsip9aQK4lToggc7ZlO9tn5dmalOrJxcG2+
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Support was added for Tegra234 in the referenced commit, but the Kconfig
was not updated to allow building for the arch.

Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9e46960f6a862b8b686a79bf3c20f1024ce3d02d..4f9cb943d945c244eb2b29f543d14df6cac4e5d4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -254,7 +254,7 @@ config ARM_TEGRA186_CPUFREQ
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC || (64BIT && COMPILE_TEST)
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
 	default y
 	help

-- 
2.48.1



