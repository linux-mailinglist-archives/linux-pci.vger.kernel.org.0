Return-Path: <linux-pci+bounces-26320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F454A94B3A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 04:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CD4188E14F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFE256C9A;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFM9BnoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D53D53C;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204359; cv=none; b=OWokZsx0b4+0OZKn0h1I5Y5pYm3QTDc7qjF+5V27grJwDXbzgw6Cld8350UwGLw8P3x9ZV3VADo/riHxUqTo38iTHTeHy5S967tPw2daKoccaFm1f6IY2ZkmDR6UdgsDZFZiVqMb3YSZh5JGGXeaQQNZVLUTH1T/5pbfRsRTohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204359; c=relaxed/simple;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLzPO2NumzosHZ7FJOTlb1vWbEVTD9Tf1yNInLwtztQbF20QuRh7PGNez4tlKNtJL8so7JNEAqOlBn4yevImiLkUJONNeK6jiBhXKHcIue4cz0PtTMf8wVfzS4LygAiHQNdhRGWaWaQlGwIE4M4fzB/tHv+Q32spmtzLwYoelyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFM9BnoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD65C4CEE9;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745204359;
	bh=vXaXCEnytVJuFEeQkEbX7/pKBg2a7GeFNnk0YyHXzz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AFM9BnoWIFxnBEKW0GXGtowfs/qQSRIHL32OBZqrGoKzUB+iS/+M28cp7Bz2z+UXA
	 RTNwqRBrLjnglNfFDeFFi0xe394FjozlFfDq/eDTnvnmNyFrnzrql06AoNcJ2AvNow
	 EQKZcUX28G7bM6linhZ2gW7QLeRBrrgfhHf/KJvj4rMVLcd2PcwkjdnhuF8ANi9qZs
	 llKz7iYbCZOHTnU5uaMK5AVmc8jjhPjXO4GZhO8xm0jP+h1hqfaR4Y/r7QhXZGNzG0
	 qvLLiKI5kG3fJzKqi9CZpgGSpRL+rVwwqxwYqygvqDZHOnD8g/joBScI/5U7X44G0p
	 ySAof75flkxOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97DC369D1;
	Mon, 21 Apr 2025 02:59:18 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Apr 2025 21:59:05 -0500
Subject: [PATCH 1/2] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-pci-tegra-module-v1-1-c0a1f831354a@gmail.com>
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
In-Reply-To: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745204358; l=788;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=WmKEd3TO9tPKzFNggls+Iy5PtWJNMd2mTPJMCu0pPuI=;
 b=bGxGzNcIrwMZ0D+7pyP9QrXvMWdT+tYHR0Ciql7ZceIOyH3wcuRC8uh5pCIH3/gAWV63nJQsk
 KkO8PIXiUJCAXTOXbPKH1RlmjzxVDHEyAa9VP0+w5TGHyVQ1LCVCDCQ
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



