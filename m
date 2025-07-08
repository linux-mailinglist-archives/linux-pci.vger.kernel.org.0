Return-Path: <linux-pci+bounces-31716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CEAFD571
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B045956690D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F382E7F06;
	Tue,  8 Jul 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbM5gYfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23342E7BBC;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996053; cv=none; b=oUNEvQNXGdYDKxmgmbTsz+eY10uPbm0DKyLYNCzDffNeMp5R6oC7u8N9WpllNt1BolQQ8+AmCJBu38xhzDdzC+ashg0W1rKdnsykNyAYHex+Ain4zuoLC7awLmTnH61K3KxPObYi5YKz7eA6itEco9R4yYdHN7ttnL1L/AE4HDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996053; c=relaxed/simple;
	bh=R1XE97PXvA2ANKeTAsd6SDjyoafLP7919cZJ82aU2GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFmXKZ+v5ncR9Qp06nmAjospIih4sKNG0w8suBEJ6Ri9YWaebZuQiaTeGj4iMtKI3f/18zf+vn3YFbE3oVOYKBjmoynwPEnlicMcmpPfpDAQTYYgUwv/girLRfISE6ip8WnwXPJOXA4EcCz5mE/rp3dC6LxGCreFoHYhrQHOrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbM5gYfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CB0C4CEF8;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996052;
	bh=R1XE97PXvA2ANKeTAsd6SDjyoafLP7919cZJ82aU2GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbM5gYfp7zNIfYsBNm9Yil6S+w3K1LUNu7NHSjNpD6v2mDyXpjJX8BX4SeC8THFze
	 3FJpGCOWwpcWKnMyjLVVI3brVfYF25HO7lRLxbCAH41IXFM2d0iO2wlKcbQZMllSmM
	 byytUP52pOLhqk/aQrTnLgJY0r4fW+OveghnhitKPz2gRD1Bw0rC+IgQutehm0RrV9
	 PP7/GMGRG6fcGgkxnomWPZJdtT2ob4zKwluEPhguctvBwoRPOrO3/9TBcOsFtZV0zK
	 q/ROl8pl00R3OzWZ/Nx3cg/h5ZwBD4phK/SjleA5dp0sF+Kov4D9/v6HhOqNK5gAkJ
	 ivpmOv2YxbQGg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCo-00Dqhw-PD;
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
Subject: [PATCH v2 11/13] PCI: xgene-msi: Probe as a standard platform driver
Date: Tue,  8 Jul 2025 18:34:02 +0100
Message-Id: <20250708173404.1278635-12-maz@kernel.org>
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

Now that we have made the dependedncy between the PCI driver and
the MSI driver explicit, there is no need to use subsys_initcall()
as a probing hook, and we can rely on builtin_platform_driver()
instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index a190c25c8df52..243c7721c8799 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -429,9 +429,4 @@ static struct platform_driver xgene_msi_driver = {
 	.probe = xgene_msi_probe,
 	.remove = xgene_msi_remove,
 };
-
-static int __init xgene_pcie_msi_init(void)
-{
-	return platform_driver_register(&xgene_msi_driver);
-}
-subsys_initcall(xgene_pcie_msi_init);
+builtin_platform_driver(xgene_msi_driver);
-- 
2.39.2


