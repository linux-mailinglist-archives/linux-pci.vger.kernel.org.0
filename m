Return-Path: <linux-pci+bounces-27656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A71AB5B3D
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEC73BB9EA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33B52BF979;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm8fnhbb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2762BF970;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157311; cv=none; b=McEniaojrY18E0yebVCtCCXBh11fdxYM/z5tTQZWS6JgIbBHtfap0qDr4S9r1pLcsKlZg7sQOdfMwPyVAT3vMT/3qLMzZa6zyhCICHPfINp10Tt2b7CA9qZbZJwQMNcsEMas2V4PCILeLuyxt/vf3w7HyXWbeWz49YgsbvwrebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157311; c=relaxed/simple;
	bh=5BoSY6I4E3zhXcU/3IAaz838Ni4OzdDS8jPXJzV6qg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KemKTF9qoj5J97HVsx8XQ2Fu94z338ZMwkP+24ZX9l0ioz7RfJfqvC1LeqhVtrXDiNkL0TxjEuSsrKE1YHSHML/sPSBWpxwiUNkKeOoXiOUFKV+z70R4obpOAB5nj0suVa5zIux8c+UmBk9yiAmqQlqD/GGlmvZX35e+ah7GUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm8fnhbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A5AC4AF0C;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157311;
	bh=5BoSY6I4E3zhXcU/3IAaz838Ni4OzdDS8jPXJzV6qg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dm8fnhbb1HXn9Xj7HTUoE8BQAcuWlp0sNhyErxY9mHhVVE0lAMWqRBK5LDrxmjB0W
	 BS5PshtG6OQFNM0XU9LNbzNgGHixp9rMcaBz1q/oJGMJSGReYcm8NwfdtY1/I6M4C7
	 m+hnhYBkHPddwowLFrZ9QmEsoGOvnPZsTG1FXaVfc4DHU/lC6x5dNiYAWVTvfbk3hw
	 rILWiC4xmuFJ/brRqRagFPQKNRidwiQITQfBJnwg3Vzvwwf9d3yF8zKNZN0Gd4Gdj8
	 /StB4Cng0CwOX8TfoNfXeSYyA1ch6cQ0tTg1iWwdj10ajEWztRiu18loLqYfddn4Uv
	 dXn5Kn/l5w7XQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQb-00EbRz-7F;
	Tue, 13 May 2025 18:28:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 6/9] irqchip/msi-lib: Honour the MSI_FLAG_NO_AFFINITY flag
Date: Tue, 13 May 2025 18:28:16 +0100
Message-Id: <20250513172819.2216709-7-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Bad MSI implementations multiplex MSIs onto a single downstream
interrupt, meaning they have no concept of individual affinity.

The old MSI code did a reasonable job at this by honouring the
MSI_FLAG_NO_AFFINITY, but the new shiny device MSI code doesn't.

Teach it about the sad reality of existing hardware.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 2a61c06c4da07..246c30205af40 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -105,8 +105,13 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 * MSI message into the hardware which is the whole purpose of the
 	 * device MSI domain aside of mask/unmask which is provided e.g. by
 	 * PCI/MSI device domains.
+	 *
+	 * The exception to the rule is when the underlying domain
+	 * tells you that affinity is not a thing -- for example when
+	 * everything is muxed behind a single interrupt.
 	 */
-	chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
+		chip->irq_set_affinity = msi_domain_set_affinity;
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
-- 
2.39.2


