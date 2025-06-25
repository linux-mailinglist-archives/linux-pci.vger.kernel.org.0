Return-Path: <linux-pci+bounces-30619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C62AE80CB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF9D3B7867
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F52BEFE9;
	Wed, 25 Jun 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKHGkbpN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF062BE7B1;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850294; cv=none; b=m/+nwjhAamb9OhQi76MgfisUOwNrDslwYh/ot5tAJRNuE1TUHkxco6tdvgq2l4qU5SSzR6Hl9KTUaw2WXO20e9VPbqWbtlR7ImXffckRpyRLSH56pIqXJAGBpmSVQc4dK5TM+9xnFRTC6+9Qmy/5s1c+d3djg/kFsQfIqQzMuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850294; c=relaxed/simple;
	bh=ynGFjdcNjSc6sRsTsuXQoAEgvgF/ccNZ82PF3o/rowk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDZiQwQh7uq28L0I3++srWw6WZR+//JAjgtEMkKFSwyEpVQyymbDU1aRT2fVBNnPVmWLt4M3MwYftfLSE8Ye+4tSfoI+iWeh0sy2c4qIgAeFlBWxS5cMr7C2VkuN1YKubrjz28n2lc55LKhCRtbbhGkLeo6MJtVXmady14QIeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKHGkbpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFEFC4CEEA;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850293;
	bh=ynGFjdcNjSc6sRsTsuXQoAEgvgF/ccNZ82PF3o/rowk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKHGkbpNcCQqSAO3nLNRYXJFMSVUynxv+ueAOjnW3dDZbAHJp4nn+7mG0km6oXAHl
	 ebvnd0Zr+u723V4d07pXU48zI+1lecFSJq8Tbj+43p+/ZPDY4Ol7QZKOSimJ9XKLT7
	 LQYz9ckXor4Fv0G5H4FV+r01aG9RaRCuAnQdF9a3hu61O9R6xkY5N6670aQAhZQfY8
	 f35i6KA0VaNsLhTOeGZpdghIDd1K5Hvdicr3RowGWjhJTwC6KBBrqv9owum63q7Q7N
	 pVWatgm+Alx909RPYmtNaFZkQBwNvt0LyMNelPJAK3MpSeq1P/tvr3QA+W9QkXO4kr
	 fF+cq86F73dLg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uUO8p-009qM2-D6;
	Wed, 25 Jun 2025 12:18:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root port device"
Date: Wed, 25 Jun 2025 12:18:06 +0100
Message-Id: <20250625111806.4153773-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250625111806.4153773-1-maz@kernel.org>
References: <20250625111806.4153773-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: bhelgaas@google.com, alyssa@rosenzweig.io, robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, j@jannau.net, geert+renesas@glider.be, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

This reverts commit 4900454b4f819e88e9c57ed93542bf9325d7e161.

Now that nobody relies of cfg->priv containing anything useful before
the .init() callback is used, restore the previous behaviour.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/ecam.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 2c5e6446e00ee..260b7de2dbd57 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -84,8 +84,6 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 			goto err_exit_iomap;
 	}
 
-	cfg->priv = dev_get_drvdata(dev);
-
 	if (ops->init) {
 		err = ops->init(cfg);
 		if (err)
-- 
2.39.2


