Return-Path: <linux-pci+bounces-31005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF6AEC963
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2C170666
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FD219312;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyAcDTzC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333661EB36;
	Sat, 28 Jun 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131828; cv=none; b=ARaytfP8aWwDa4OMaYADnwvbTFTLge7py34bhLEWzM2OjFlqgzinkw+r9WRQOeUAkkIL+ax2TqJH9yL0o0P9W3QMWVuhg/l9C8U21nxWhBhdLrSHNCHjeQOa4un7wGVON4P7wEkBCPAF5EOm21iY9IE5uiN1u1xadQG7HSlRYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131828; c=relaxed/simple;
	bh=LTJgQeXifMFvhewXq1QziXQmUhfSC8Gh4RQFCzcAmcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5h6b0zFAjO0w1OGu5xPnUdFF+MsFLiGyOIcqOyUFsYGbbbcErtPpCLKYlyCr9ok2NZvi0Arsw0IS5sINcnV68kKppXNl2EnAx02LNx1HMKb4vYk8PwrTgSoFZmHdnsZjrIJL7TKE2FW4wD7Llj2fXf/AEy+uPRgeLy1NwimOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyAcDTzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3888C4CEEA;
	Sat, 28 Jun 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131827;
	bh=LTJgQeXifMFvhewXq1QziXQmUhfSC8Gh4RQFCzcAmcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyAcDTzCLnxhbBnq6ie4dvRqywD9yApCSndQJcRyr2M7f7vU64foxquEIZGNmvRFY
	 1iM8GgjF9k14Vf5nl6LvqUU2/LrjArPqX9l+9lB8f82/jtZSHno//oO6dbeE0hBPzZ
	 euMhMhzxyJXndom80z1ca+tr8u0yAjbfVb4aoS/9nJVKhKT0ekyH79ByX12SujhmE1
	 3akMbafBNQesEg4lSiEvdbPneLk3PlckhCyj5zItEKSnxh+O7uB7FHrL9kdh88fFH1
	 +Qf5rUnathXrF6IBi4+0oywzE1ecG59FMv9UASYUipWSE9wMZv6MqxNmssN6Vcqocn
	 cwK8FaMbbLtMw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNh-00AqZC-Pf;
	Sat, 28 Jun 2025 18:30:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/12] genirq: Teach handle_simple_irq() to resend an in-progress interrupt
Date: Sat, 28 Jun 2025 18:29:54 +0100
Message-Id: <20250628173005.445013-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628173005.445013-1-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

It appears that the defect outlined in 9c15eeb5362c4 ("genirq: Allow
fasteoi handler to resend interrupts on concurrent handling") also
affects some other less stellar MSI controllers, this time using
the handle_simple_irq() flow.

Teach this flow about irqd_needs_resend_when_in_progress(). Given
the invasive nature of this workaround, only this flow is updated.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2b274007e8bab..6e789035919f7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -559,7 +559,13 @@ void handle_simple_irq(struct irq_desc *desc)
 {
 	guard(raw_spinlock)(&desc->lock);
 
-	if (!irq_can_handle(desc))
+	if (!irq_can_handle_pm(desc)) {
+		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
+			desc->istate |= IRQS_PENDING;
+		return;
+	}
+
+	if (!irq_can_handle_actions(desc))
 		return;
 
 	kstat_incr_irqs_this_cpu(desc);
-- 
2.39.2


