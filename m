Return-Path: <linux-pci+bounces-31713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BAAAFD56F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80F956674B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ECE2E7658;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im2I+iWD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33E2E7644;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996052; cv=none; b=R5qd03pvfZXdCX5jwtHPxN22rEV4r9lWi39GPNAg9L3uOIM/yPQdcK14auDzDW9TeS/78p2zwk4KYftVpr0CLS4it9VZiMgj/Vk8B55KmD1uZznZiDG/qEIfH8Rv7qRoAEpbh8gWraLrLluJYAYM4EbxREcE6UoS0o2edhf2ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996052; c=relaxed/simple;
	bh=z4Ig+4c3O1m133hnPsDcA3pm1ASaonn9kHoCQ9HjQXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0P092lOsTotGRZNPmIVADnrmz9atCPPtSPhs0KOxOeKBMKsjg0xn0g78xnFrYRzhlOUFUvMkfEq/6L+B9JAph0wI3mmWT1BcQwlGwRD94Phfr8rdYyC68/+gbmDcrUnE6sly4YcGMIrYChACfbcit1ccBeHwmom9xb06oT2Ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im2I+iWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA1CC4CEF6;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996052;
	bh=z4Ig+4c3O1m133hnPsDcA3pm1ASaonn9kHoCQ9HjQXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Im2I+iWD8CS4Jt1cft7/CN6/TlJhIy9vRGvcqmxLwx/G8LMLwUnmLvCo6vbBBy0+X
	 VcpYLKjr+aGpyhnA7lPCmpZ8ovKxKPXCjvLvEF74iFdfRhWjOxYlAztfSvo9aLLWBn
	 kum0105EDhmGNd1DdEw6OdH00jykx8y0rPEYcFIhts7LQ29vICE/CHSg3Sjtbb9AJF
	 71ms7PA5laq2cNfTqP98ThvqPU65d7PdcEPSaOG/B/Lhq1XWEhPShZRvVG6z6FN8Jr
	 2hk94hvfjVq8/QPE60MgvEbSd2mDwhxcOAtv2ZecJuYW6vr8z5SSHcUMK7lfmauUDM
	 UQ/2/Qf66onZg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCo-00Dqhw-If;
	Tue, 08 Jul 2025 18:34:10 +0100
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
Subject: [PATCH v2 10/13] PCI: xgene-msi: Resend an MSI racing with itself on a different CPU
Date: Tue,  8 Jul 2025 18:34:01 +0100
Message-Id: <20250708173404.1278635-11-maz@kernel.org>
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

Since changing the affinity of an MSI really is about changing
the target address and that it isn't possible to mask an individual
MSI, it is completely possible for an interrupt to race with itself,
usually resulting in a lost interrupt.

Paper over the design blunder by informing the core code of this
sad state of affair.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index b9f364da87f2a..a190c25c8df52 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -183,6 +183,7 @@ static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_domain_set_info(domain, virq, hwirq,
 			    &xgene_msi_bottom_irq_chip, domain->host_data,
 			    handle_simple_irq, NULL, NULL);
+	irqd_set_resend_when_in_progress(irq_get_irq_data(virq));
 
 	return 0;
 }
-- 
2.39.2


