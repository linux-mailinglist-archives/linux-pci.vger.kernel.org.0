Return-Path: <linux-pci+bounces-26968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75EA9FEBC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 03:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39D71A808ED
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAF153836;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCI09zdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7E367;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888750; cv=none; b=koTdsJg4wlqXVrd5tP8gqkE0Gw17oFluKuRqBgJwYdn5n4x0vIgK0sBVcfLBK+/bQE+yIHxps5VonXn1nNacP0e0qrOt0FGf4wcz4JolTOtcHkKZaqYJq/JsRBuU3FSDKSP4Ea1qnPw+cH3U41hhIpwaaWNvAwdzL9ok+JfO0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888750; c=relaxed/simple;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b52WPlEA3yh5UPw2FSXsYQ6lIIqSercQy/UnbrRGBIrTPUKNA8vzo00ALxPMSHGzkYnonP8ctZbESa3m2C+oRfjpyxTJPUePOoUfncrTQSbiyFBbjFHrT85mJQsWWZYtLZ5A5j2XIcyDGoKHcjZRveFO4nIueKwGnAmL0orL2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCI09zdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C4F8C4CEEA;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745888750;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WCI09zdIFaArkdQd6znFm98SAcz7F3udHrzr6cF5gCkPwdBwKp6HTpqCtu7FQNxuj
	 O9c9c/WT7dUw15eMGKwVCdRFsyzQoDwny/owKGZg/Oru4YCqsIRDPulIK4adzmmIbm
	 AVa5MDxRfIOJbR06CwsAquuaYcVG57ykChIF24j4PMT9em/40Vv63b64m3FsEbS1Jq
	 MHDA18ZneZx1oBRUGxCg7vlxV5jiK5VL0//RsOtSSDLfTNDgW5qPiAGSzN5Fpa3rhU
	 hFw2lurJNUsni7wplAR+Dghxl3SIMDX2NCvSmLwbP5137uNrIwhmXn95W/LwZpte79
	 EGESI6HJ4R85w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A6C3ABA3;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 28 Apr 2025 20:05:46 -0500
Subject: [PATCH v2 1/3] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pci-tegra-module-v2-1-c11a4b912446@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745888749; l=788;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=WmKEd3TO9tPKzFNggls+Iy5PtWJNMd2mTPJMCu0pPuI=;
 b=jCLW9LgNr0TnmsWzN9heH3hRW4SkFQzSnXaUMJnOezHdX36AfMUfRPg0zbT5GUyK0LfNqFaGH
 rL4ecw7yPHrCf0ybirLuwjAfzrQDYAT0ZR6bopNvnJcUBIK9n6/C/20
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add export for irq_domain_free_irqs() so that we can allow drivers like
the pci-tegra driver to be loadable as a module.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e72d980f604ded2bfa2143420e0e0095920..36cd79a8a2ce960b07b03c40067343ec8f632452 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1890,6 +1890,7 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	irq_domain_free_irq_data(virq, nr_irqs);
 	irq_free_descs(virq, nr_irqs);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_irqs);
 
 static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
 {

-- 
2.48.1



