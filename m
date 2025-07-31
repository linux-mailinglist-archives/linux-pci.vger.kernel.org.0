Return-Path: <linux-pci+bounces-33260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4AB178A2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D73C188DC1F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919E26B2D3;
	Thu, 31 Jul 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djiJg1l4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073142512D7;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999170; cv=none; b=FI43vqqK3C+2SqxvXzWGyQyx4SGfu8xd5Fp6Rrl7tP2cSPN95GLAsmEJlwxt/+Tma7GefkoUgXrlyIUiwPzbl2G0cJ6uqU3Iw3c5FMw6zGWoMvFUiS3roSxdFijifOnm6gsdUx31YCJIshq0NOM4jp6oOaj3XXxM5gydusPuV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999170; c=relaxed/simple;
	bh=y9EfpfER3iG3oJpzB7Uv3sr7TbGqdJp799v9Smx2dtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMizuyxMavdtMI89chXCVIy3/idAYr40wQ/g3Vb+/p5Vy1GyX+xQLfznsZJMSLIqkKm9JZKMNxODfEveldzgE/dnkPoXq6EDqo1HlvNmWL9OEMuGTw+MeYCeFUjvGnwPsU03Mep0CEp4EGrHn5rG6q0oZkIUjn6LIiIAJoAD0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djiJg1l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A201DC4CEF7;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999169;
	bh=y9EfpfER3iG3oJpzB7Uv3sr7TbGqdJp799v9Smx2dtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=djiJg1l4ih+UsnPUwY18CbuRXx1laKZBwwOCnAT6OOw6QYTCAO2WwpsCRZVH4ESF/
	 oDgcrp1n3vDYOv7DVTPqstO4L5NKk5lGN7UsV6TAqSbktWFVzOr1RQuozw7raZRwbG
	 hg5ABhjse2nuHnQDVDWgk4H1Wus7Xxz55z7N7yQYIvEckhp5/Rt01GqNGIMMjpOKUI
	 uCFX0E+7eYoZq5enLQwL8+WgS33ADQlGv72DDwu/R3hKaOOi0SZFT/oru2e03HmISt
	 nF+8QDeMIGZwaMjCCSTbhA/pHWkcrfn9HSP+rCBjiYFtH973uOUik3EuDc6X2AOHLx
	 Txe6xScz7FCWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC8FC87FCA;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 31 Jul 2025 16:59:24 -0500
Subject: [PATCH v7 1/3] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pci-tegra-module-v7-1-cad4b088b8fb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753999168; l=813;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=zJfRZvCFTASylxqukHtONT8I03A9oylELli++Nq/N/o=;
 b=ziUT+U5OXljSSxWG75aYDzENmEmMIKimjN6dg8rDSrrFJWgzsmIfThorogDkzvbLqnhEBKRgg
 rMgixqVsE2cAAdM99wuBTqH30UNpSzUrq0GG4TUFU1QXep1hO2BMgM8
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
index c8b6de09047be768624b622a7a31fad1441de6d2..eb8eb9ee147cdc5d27a4da53ab62f852b78841f4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1877,6 +1877,7 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	irq_domain_free_irq_data(virq, nr_irqs);
 	irq_free_descs(virq, nr_irqs);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_irqs);
 
 static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
 {

-- 
2.50.1



