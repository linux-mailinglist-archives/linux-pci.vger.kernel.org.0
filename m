Return-Path: <linux-pci+bounces-38436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE5BE7459
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20501AA1048
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C162C11F5;
	Fri, 17 Oct 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5QYaH/W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6E23BF91;
	Fri, 17 Oct 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690892; cv=none; b=Q+7BMQRtZVMrJcCzZJrKr865jyAo1Jef8Ilve74dOulSD0NArUGfywYXKntZUuyM9LPA/FNiaGu5DBAZEOOLN5E3yhFtYv0z3xrvqUdcMYgcHGV/W3+2QUGi7hlpcu/wGiwnUXLTIw9KAvS/ESavLZlu69tmAqCJmXV3iryMyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690892; c=relaxed/simple;
	bh=XGXorEJawrWEzTdrR4D/nXvovbfYzhFoHVqFZYAEOXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb+EIUg1/tl5W6FNTc8zn6CSIZsmDcQ8y60GsXFwYOIROiGKvlFiXE9bATj68FdUnYvNk5COsxuNo85yNZg94YU5nZObz4W05Fpr5xUKcht6X1XkvbnKRFA5bVo5wxCQnJUmRjzsnRPFQqV56aEtyGyVY4Px42flS2KC72MMvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5QYaH/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D40C113D0;
	Fri, 17 Oct 2025 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760690887;
	bh=XGXorEJawrWEzTdrR4D/nXvovbfYzhFoHVqFZYAEOXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5QYaH/WEXygWVrPOjMqdEhRrPdFXruUYtqnHZ4Fmv8H3ZWEzwwid0w3JeLYbrv6k
	 8aWbPMNETE4+njNuSsGmJ06/LoOwD0Nf2sVekIfotn4vCR9sSAqEb0ogSuIIW0bneu
	 QdzoH+VyKUf+qiqScez0+3XbbPtYvx0qkWF1s/tAqdBtH7Ox7M13htnmRPMOy6dWU0
	 LwE4sGc7oVOD3yWiXmM4wBDEITiKazUQnJotUasF7MYeUbPp4Dv0EVjQ21pemjj+Yb
	 h5v8nvNYoSqzh9RMxijXBZB0v/mI4ZZQ6zyZ/wX/8vaphS4RZOS+hPO0P12uaO3MKe
	 A6Pg1Sedj6y1g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 2/5] of/irq: Fix OF node refcount in of_msi_get_domain()
Date: Fri, 17 Oct 2025 10:47:49 +0200
Message-ID: <20251017084752.1590264-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017084752.1590264-1-lpieralisi@kernel.org>
References: <20251017084752.1590264-1-lpieralisi@kernel.org>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


