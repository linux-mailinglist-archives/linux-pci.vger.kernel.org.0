Return-Path: <linux-pci+bounces-27409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87814AAF18D
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790AA9C6FFD
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB61FC0ED;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqmgEZwf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDE1F4736;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674754; cv=none; b=u1nlTdGyfpeiyoUnIQHoGx83NoQ+J0z9QV9t8FhF98AUs4N9rCx+xWaBZ8tvcdw9cj4xjAscUembUlS2w+KHCARtrIEvUfswpsK8pJbAZ93vXA/btyHeppaDTWHWi6mlxt043RpFFq/cK9RgSACZ/esG2s0/IpmASwVd+r+YF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674754; c=relaxed/simple;
	bh=9FN4e+9q1iQnxjAeLllxG2YEgg/RjuG3V6jT5Cc3/I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5UnRVeqibyBPBi2p0omchrZR87swviM9JryoMBK0Cx08f7q8UzThtii8ZXAjZi9v1glODHRWr1BPGdJDFL63gb7yW9rp/XKmMplzd7zIAXYRv9nJHn+hdzHq8ptz1/Gaf3KWFHztnSPYW6GgANM+A0g5V8pMxj54ewNkTsoISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqmgEZwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 151F2C4CEEB;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746674754;
	bh=9FN4e+9q1iQnxjAeLllxG2YEgg/RjuG3V6jT5Cc3/I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aqmgEZwfQs6C478DF1mfn7fFY7uzh1X5I+N5ei8S1FeI6ytAp6UgJmvTgY94Z7hW2
	 EFmAfFbfs2wpM2cZa9tmcaJmEWrMeaw7EHHfLK2HNcUd/2Rvc8QcJLlrw9etht/8g0
	 l4yxARRn74cc3JDTjVMJOV3uxe2niYcsLdEyIX5DUxUugByGme3O+ZMolJFar1xj4t
	 Rqm6k5not1iCP93XMBpVz4XtbPGS8uhqZCvyo/RkjkxINQ2FJkpbk9jkUekmARU8e2
	 ZZ1E4Hj+SeiD9g+Yzq7u5X43XFqDb1jFFbiHA/xDRIK3hN844gnyBYq6NkabZEbyUQ
	 BGyz5ek5T2QbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984FC3ABC0;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 07 May 2025 22:25:52 -0500
Subject: [PATCH v6 1/3] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pci-tegra-module-v6-1-5fe363eaa302@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746674753; l=813;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=HMpL5ZC0u0zHUx7X6iaMy1A5L01kC5VZDDTCKB3qS7U=;
 b=yNLWjKrlPioYJb28O/Qirs4sZiLKKFoYgaQMQj2YGLEysic2Q97uljDn0Hz1TEQFsIXL7JwIi
 BVmBC/xy6ArANd+VC9d+jaqJ6Md+HkTrVNMWbmepYZqEBxNMvF/mY7X
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



