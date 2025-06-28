Return-Path: <linux-pci+bounces-31016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F0AEC973
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE03BF28A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F92882D4;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjRiiX2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5D2882BB;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131830; cv=none; b=NGCueiEWYKkYYgSaUD0IMrwV2i3Mnnf5wXIr6l/fZ2Z9ptH/CNL+ojXcAX2OyftCGIsVeehh+2DLp3Rz33aBi9OkMjuw0k1JWIG+NfcGvaXfKfFhK6UoZmI3qU7/h1zt5YQMlgJpAx8zy8hFGzi7MUcEqF/8nK3pdKaB57rxyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131830; c=relaxed/simple;
	bh=+GYSKd8aIM8xo28+bC9TFYEOVhobRPsyzp0tu6Fgk3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzmI4xSmfxVmpEB0Yvd3MnutEZtcThJj89Wng0YhZYBXWcHuU9+yQTPrbqjrYWGggcbQt1Cxsz5xXHFSrVcNs3ml8g6kp/kjDkEqn7YX2xj35cotdUDhRU2g93RzJZLh6j/H/TZIfEHX41CmttWtFVUyJThn5jw48Xsturyfs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjRiiX2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A2C4CEF4;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131830;
	bh=+GYSKd8aIM8xo28+bC9TFYEOVhobRPsyzp0tu6Fgk3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjRiiX2ytUjhCedtYc9Qd1lJMVXPsynbsX2z5LJR+xNHvTUh0thKE5RKQRMp3jbSN
	 UkZKBJBsVKPWnTJlfEObly4mf5qol55dPg+NUaCeUiKLspMA1oaJfLyJ9YK0qds+sT
	 Ka86SdsZMimLOzbYkiB0LnngAzY21dAGFSYQmveNP1FdEkAzN7hpb9fW0EuuIlACrg
	 0VB6sQFN7iAy3V8mHby0jnQnTqmZv2IRzar/dG3U/+t8C77Gs88bMO8U/Fl5224+P6
	 15RkI7XBhPP1m5b2Js8DbTBgFT1+JuOaqIU3mt/omJsP02/BMa+eUoiY4pZegWVEMM
	 4O6ZSZK2eLV5Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNk-00AqZC-DX;
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
Subject: [PATCH 11/12] PCI: xgene-msi: Probe as a standard platform driver
Date: Sat, 28 Jun 2025 18:30:04 +0100
Message-Id: <20250628173005.445013-12-maz@kernel.org>
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

Now that we have made the dependedncy between the PCI driver and
the MSI driver explicit, there is no need to use subsys_initcall()
as a probing hook, and we can rely on builtin_platform_driver()
instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index f797ba0524783..a22a6df7808c7 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -419,9 +419,4 @@ static struct platform_driver xgene_msi_driver = {
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


