Return-Path: <linux-pci+bounces-27164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B3AA96AB
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C187A63FF
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0058925CC62;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/rTnS5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC725A347;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457142; cv=none; b=pIO8GX3XhGSJnnWAMdPeiI1XW10/DDl0x2oOUhyATnzNYPVJOLP7EStjuQ5bWgI5GArUKG+QpNR0lh4JaQjwE8fqJR1ytsFj+svHBo4y0PK1FdqX3B4XzZ3Q1y46Ac4V6rWdB70qY4vc6JzCiW5k0C8xKQKzzsqJHyJsQpjTgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457142; c=relaxed/simple;
	bh=XfnNt0vfVa8HGrSabzaESkrjv8dkBZEyTRGeaexI14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PF+SoO6riCSk9Wszv3RIsl9dlQnibaS4HUcmphYh6oOd6YBw/ID+0Ra21s2uaXdx8vUZlzYQOCkp3ejWesagNURaYEa5uGn/M/fi8pjI0KE/Re3n3TEYB9xs4bio0m0L6Q6btewF/ICGRabzYDZQdxIe6mWxjejDouGk1FH7hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/rTnS5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AFBC4CEEF;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457142;
	bh=XfnNt0vfVa8HGrSabzaESkrjv8dkBZEyTRGeaexI14Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A/rTnS5aRRNhMVKa09tYWR6yIIe4RfBag15V8+NVgt7D/+SS8uv3/rLbO0vcCmM7l
	 EBIOFKMrYt1TxXr8yosDIpidHTNBXbiHS/7t0+LgzLCYQuK2VZEmtgHS03uzWC7kgc
	 HZamXgSiRCfzDhkoYmvHPBujQMzIgVB51CrNnuWHVXUfVHIbm1VhsFlHL90l7hdmAI
	 mBC9NsqWGix0H8ZgP7+C4JKILr6IOYbh5bAdvvtYyO+XASsqpQBMneMm49MUgwNd0t
	 TmllwdflJFboFnY71Oy3JU7zn0A/zJQHUVbPZT1mffGEDY/NB465SiV2bDguvjSTKs
	 daXOxRi2wUvRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D7C3ABBB;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 09:58:58 -0500
Subject: [PATCH v4 1/4] irqdomain: Export irq_domain_free_irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v4-1-088b552c4b1a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746457141; l=814;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=yKoL2BZYFazD3iSZv29fWk1kN2/gg+pLglDfVorCPZs=;
 b=tLSntJbP2HXQLz5X3kwQPtjV7Us65lRMH1k/JqRWTR5U8KrbYyyvT9o8qN5JJ95MQUkbFbJt7
 ywxx/PkAN1VBBPZrU5gLFOzGh9jsvYp911wD/YFgCm1vpEZMpkJwAST
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add export for irq_domain_free_irqs() so that drivers like pci-tegra can
be loaded as a module.

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



