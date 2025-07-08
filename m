Return-Path: <linux-pci+bounces-31706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC35AFD562
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA973B4B86
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FA2E5B2F;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZEa4lmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B32DC33D;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=OanZa6CqEkkM+Ydc9YwMfJwqBOsStpOq7Kh6DVRQHQpoAyT8gCy+MTAwPtL2soxRjen/V8/HkRKllpGH9mvPdrG8RQWULirLtsCTQ8GXiJmD+BrK8teo73FBvH4uQ8WbDyUjIwIlQE2a4iF1bhEI7hvWjpKpGfnBLIByQEVnU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=XyHVZgTEEU9jeG0R0aHxp6hZU2S5LzzIaxTXL9QhFBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gd4RWa7FR/eLO38N+rHa6m/co7Nwu/8rUYfnEANeUuhlZE0vrULQwOB5rghruUl4WkO8ZEdPa8DZ3tKt1EHcmsPC6jT2blZzL/SnPVkbf7A9nH4Xmj8X+gpAQ3foGW6R6GrwNgE7EjlFejB87IhN1/i7BxMXER+06NkdwcfGCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZEa4lmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B6DC4CEFA;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996051;
	bh=XyHVZgTEEU9jeG0R0aHxp6hZU2S5LzzIaxTXL9QhFBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZEa4lmr/XbpSiQfqy9xVJlRrLxqSoRb3TAE4WOf6rxiPDcBTlnNnN2iPqVPYdIgx
	 LxHD93E78a9QAQkE6f13GM83mP3T7mCyGtUwmDAztFgFWVcls4LfUMsJjQKvw9LOe9
	 S/0z/mp3EjrLkCaN/KNt9Uxsf2IOz5lxRpn/k1N862bCadwfdyv7zqCti1h+sy6Of0
	 81c9jVULtaOrKRJ0YejX3n2bRkO7EsfZUCXyPoM760hSwaBv56rVOucwjcLO7hPH9V
	 huv2Gff272VBr8LbUwKy3BKnkk/5mbDwQxHDt1Zi7Fh6bbGVAaYg4sGM4kfYlsNY90
	 BtMnq0bMi0zoQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCn-00Dqhw-6d;
	Tue, 08 Jul 2025 18:34:09 +0100
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
Subject: [PATCH v2 03/13] PCI: xgene: Drop useless conditional compilation
Date: Tue,  8 Jul 2025 18:33:54 +0100
Message-Id: <20250708173404.1278635-4-maz@kernel.org>
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

pci-xgene.c only gets compiled if CONFIG_PCI_XGENE is selected.
It is therefore pointless to check for CONFIG_PCI_XGENE inside
the driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index f26cb58f814ec..a848f98203ae4 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -58,7 +58,6 @@
 #define XGENE_PCIE_IP_VER_1		1
 #define XGENE_PCIE_IP_VER_2		2
 
-#if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 struct xgene_pcie {
 	struct device_node	*node;
 	struct device		*dev;
@@ -189,7 +188,6 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 
 	return PCIBIOS_SUCCESSFUL;
 }
-#endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 static int xgene_get_csr_resource(struct acpi_device *adev,
@@ -280,7 +278,6 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 };
 #endif
 
-#if defined(CONFIG_PCI_XGENE)
 static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
 				  u32 flags, u64 size)
 {
@@ -670,4 +667,3 @@ static struct platform_driver xgene_pcie_driver = {
 	.probe = xgene_pcie_probe,
 };
 builtin_platform_driver(xgene_pcie_driver);
-#endif
-- 
2.39.2


