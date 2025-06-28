Return-Path: <linux-pci+bounces-31015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE85AEC971
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE73BF5BC
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E02882CE;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbK2Lldp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B52882B6;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131830; cv=none; b=RHGUb+ssnaeCLL6uClv6F+AqTCm2h+oCbR3GPDE4zOQ4OBWFyW14Ts7mR1Efd3ELoiEEUdrqFnaOvcmtLU24MuT/UqGdPE7Gc8Pq5rrQN8aCgvwhyr7CZXXS9DJBkxJ29wY6+WU8RA9enMc1ImFivGRCjLw5i0ykBtc9RzSYtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131830; c=relaxed/simple;
	bh=7TKWmvcmwH8EPAgGzhd5SaoCtxIYJA2s5UD/FxVMb24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5tV5J4NxqCcCXX7UqvrqtVVoFKB4ZPcK+6QJhkRLsJ2B6NaAnRs8y1vTvWKCiEm9wEbAmiQ2xnFUkDHhqd3cSPvyzQI8PJamtV0ur3qNL7NtrZeedLWiEnolMZYTKGE/W+oOIVPnJQEhWqUu/p5Ia8JlG3XtMUA5IoOHJXccDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbK2Lldp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DF0C4CEF7;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131830;
	bh=7TKWmvcmwH8EPAgGzhd5SaoCtxIYJA2s5UD/FxVMb24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbK2Lldpk+5feq9A359lTu/tVzT5DORZ+3NRgDVCNNuSAQOXg3by+CADp1by1l1LY
	 nkb8nIyXxVy8iNAnXXCd95XqIPAsbeUohcI9bKtkNKixH/K+y2QglmjPNI6a8fBvZF
	 zy15F684XQ75nuWhIQoZdvgFGcBaBIJ/VjLthGvCMWkTBaqJHUKibOrbwAvvehju9S
	 blmBcaf6TbKYa8HG+tzoyDg3YXi0bHHEjwwzzGAjiUIYIYMQoP0+hUqx6Ef8cTRUrC
	 R0k1ZUxkMhCEjaQhtvM/qHefylBFIRNmNT+H6c1siqyNY2Onq/VF1Ws56C9nEq6lfb
	 WLuYJooE9+3Iw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNk-00AqZC-62;
	Sat, 28 Jun 2025 18:30:28 +0100
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
Subject: [PATCH 10/12] PCI: xgene-msi: Resend an MSI racing with itself on a different CPU
Date: Sat, 28 Jun 2025 18:30:03 +0100
Message-Id: <20250628173005.445013-11-maz@kernel.org>
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
index fbfdc80942596..f797ba0524783 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -168,6 +168,7 @@ static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_domain_set_info(domain, virq, hwirq,
 			    &xgene_msi_bottom_irq_chip, domain->host_data,
 			    handle_simple_irq, NULL, NULL);
+	irqd_set_resend_when_in_progress(irq_get_irq_data(virq));
 
 	return 0;
 }
-- 
2.39.2


