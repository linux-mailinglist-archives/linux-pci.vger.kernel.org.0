Return-Path: <linux-pci+bounces-31704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD7AFD563
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752DD1896790
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197F2E5418;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1uXX1a9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFB1F4190;
	Tue,  8 Jul 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=FV3yDbjmu4B0TZgtcLGtPuVzOhyEAlgl3K+hbMMTsf6PdqeQCy1WY+1/p0BfpuGiITZWudIBa/5dBqrMpcgykeOMnzORwskJq4rTsoOxmgwe98r0TyN+FMKoqotiL7W+zNldzkgOMY6rDkgh8EwWZNg2ctKkSYsuR7w62ILvn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=eO//bdZjML2f/yBZKp3pfm6LXOZ7G6limhAcR80kGHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQmG8lvA7LyFuWPmeqbXgOmC+/vi/KlLjJLCaI2buGzYXMTrAz94kHW558/M9MfUTd7Lj1+ZL0KGfizc4mcf5YBbx90BbNUXPJsABnF90gO/HLafH0nRq4Pa7J+hUbaWofxJfvajZIhrDyaSThbAPGoPkkhsdxeZ/l3FfoNBvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1uXX1a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B06C4CEED;
	Tue,  8 Jul 2025 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996050;
	bh=eO//bdZjML2f/yBZKp3pfm6LXOZ7G6limhAcR80kGHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1uXX1a9l+I8CG9FADpHMOcZ3yd7vIohUDkbLuCoFJL29a5uBH6HmBitz7BcBI3Pi
	 22oA/96TYkhn4RUhUWX/1AuGTw1UEdedkbTuR4ds/nZcEI8eqap3HSrUksWw+bXvxD
	 Ci0oxoqFkzjbVGl7W79dh5RmobXurAXbrGOPIi7W6yS+sR8P557cfhMY1/kCqEdG7e
	 ejVw4rq7LRZnzLHmLG4QXdw88ixV07LXBNqGqCXSqCvvRdPbISzyf9EGKtj6Bh9BLO
	 N3GdHsSMbf3pI5s0Zjn2VJ2baD2cXY1tUYDOHRIqI0Ke6kIAxBkKVg/YwEQ8MiARpg
	 rNZVXwjCv1HjA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCm-00Dqhw-Pt;
	Tue, 08 Jul 2025 18:34:08 +0100
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
Subject: [PATCH v2 01/13] genirq: Teach handle_simple_irq() to resend an in-progress interrupt
Date: Tue,  8 Jul 2025 18:33:52 +0100
Message-Id: <20250708173404.1278635-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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


