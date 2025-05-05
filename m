Return-Path: <linux-pci+bounces-27236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A2AAAD37
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DA3BCBDC
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73730034E;
	Mon,  5 May 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHQSb+UR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953493A80FF;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487042; cv=none; b=t/XpIFQxF7azmnpAA5IihSYJz/PNlrlh4V22h8uiGlhd0SBu9b0E4ivbf2lzXta34E3BrAiCqiGjr4VLj0rFPfCag9M/4zbT+QhObNNbG94rSGzoowdHHmzfwrDtFq33du72Hx4jbFPdkhPe2C4pjpKNAvR2zMihq8YpCkmCtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487042; c=relaxed/simple;
	bh=9FN4e+9q1iQnxjAeLllxG2YEgg/RjuG3V6jT5Cc3/I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGfHopJNiK7y8vtbuZYugt/+c2GyiJxyl/+GwEEBnqvXlPR4+uosVSlh7HKgELRK8qudqbSsmFIR2PabhXjeyrz/KZqtln4Nd+fR2boP+/+ZYvvrSHFM6m7EQTlf1F9VpLI+VzUEFIORzhQjOOseCijBDsnENcMF0HAkrqTUfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHQSb+UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F69CC4CEF2;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487041;
	bh=9FN4e+9q1iQnxjAeLllxG2YEgg/RjuG3V6jT5Cc3/I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oHQSb+UR+on+kuZusS9Yu74PTg3VBf6O9EhkFSwAscwWh/7IvbA4ztA4SH+cmg15t
	 g8ZLwtjHsHzAuMWSc+jMIjyYKIYyXx95ktNZ0IwM15htJ9gUmIpY8xIdeTqtWbQ+i0
	 1Rc/GewX1n1w6AAu6zCoWSrjjUhHu4qa3AEWChngqWzhwNrkeB+HLXnY+noq0CrOdG
	 YIDEVys9BKVuFfWHeUe1MFPUcFmaXf3d/CsgfP3pysh86V0m+WFj7TiwpYMyEwGmeU
	 dMBbGVNVfOS6siIpmAn3GnQU1aof0MlLCUErNNPNs5bOpyOpreDoVr26Ac8rZVD8/3
	 MGI5QnhlPnPUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513CBC3ABBF;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 18:17:20 -0500
Subject: [PATCH v5 1/3] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v5-1-827aaac998ba@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746487040; l=813;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=HMpL5ZC0u0zHUx7X6iaMy1A5L01kC5VZDDTCKB3qS7U=;
 b=LaAbT5EvNzNwAB4BC0Ck5T23zGZj4q9krSlQ7WSRYBQo5Edwt9whPV4JQW2SGuncIi8euA16N
 qsRIrfwehp3AWws1U7UZfrIqd+wtNHfvXlBn2AC/Ug9FpOzwewuTj6U
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Export irq_domain_free_irqs() to allow PCI/MSI drivers like pci-tegra to
be built as a module.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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



