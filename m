Return-Path: <linux-pci+bounces-38026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5501BD89B5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB01923FC8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A52EB5B0;
	Tue, 14 Oct 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMnrRDku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8872EAB70;
	Tue, 14 Oct 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435940; cv=none; b=KP8ikDMbftuj8Fd0M0aJx0FH2VVcfCcSYBm3iABlKi4n1TppuBi5eyza1C1beyiXD5O/+qTeFRf2nwbYeEjivj49cnCEbf5oTdz2pHEgGDNaBKarkCN3nkTPoQBbD7wYTh8QfCQmtd7QVJVwIeIoFB7DiXeGEkmxBdrylbhP860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435940; c=relaxed/simple;
	bh=T1moSDjDx6AIFQ4/WCSXt0NBcwIuqhZV4QnKZW8jK0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SttIkAa3s9c+Q4ZmM3+lB0RtNuFV0q93EZ7vV7MehjZv/Te07ECyJgn8V95tPevXHkClM41BJRxe+vRsM6s06gTQ3lsLiJM78Ft3Wt8Bu0Oy41bAqvsxT3tkeP6NFQ8WI2NNnkmv48H+1YEr+tIjesKbEpQwWliMmoyqQUDWZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMnrRDku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667EBC16AAE;
	Tue, 14 Oct 2025 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435940;
	bh=T1moSDjDx6AIFQ4/WCSXt0NBcwIuqhZV4QnKZW8jK0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMnrRDku3v2pqZdglfonyg3bHwZ+UdM1d/NZeQMlHg6s9RC4KL8bXP59YarcKXwEm
	 lrRp2iCjsFsW5B0DY61+FEKqnKAd0xc1mZtakjX2rS+jIOTQG1CGdq70q2zB6bARYE
	 rvG2fdupt7AY0Fp/7sGYeqjs8tbJ7+pMbJBnImjRfAz8V7463irI+JhMAs4+RHkN/y
	 6MkkU3nxUlFsxStckBODhVCB254o+nozhu+GrvoOuNxnM5VYtCp/C4/P9hW+46NVrt
	 UUUfgkPCOhw2uwOt1+cLc8z/CoaimVjnyJEIWf+HmmY9iewa5C2L1y9Yz0evvbUTaS
	 Otv77qBqsc54Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 2/4] of/irq: Fix OF node refcount in of_msi_get_domain()
Date: Tue, 14 Oct 2025 11:58:43 +0200
Message-ID: <20251014095845.1310624-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014095845.1310624-1-lpieralisi@kernel.org>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_msi_get_domain() if the iterator loop stops early because an
irq_domain match is detected, an of_node_put() on the iterator node is
needed to keep the OF node refcount in sync.

Add it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/of/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e67b2041e73b..9f6cd5abba76 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -773,8 +773,10 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
 		d = irq_find_matching_host(it.node, token);
-		if (d)
+		if (d) {
+			of_node_put(it.node);
 			return d;
+		}
 	}
 
 	return NULL;
-- 
2.50.1


