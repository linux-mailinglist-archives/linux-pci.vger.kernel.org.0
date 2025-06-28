Return-Path: <linux-pci+bounces-31010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D60AEC969
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D03A3BEA71
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB4287268;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo7vjY6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080527FB0D;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131829; cv=none; b=ivh0E8K3ySrZbVC8iYuP7aerNjw2ZA4LrUc+uBJRtpmtxPKFuwAEHCMDoi4y4Auhc1uop6qgapJL6F4Ij/xC0Y1qW5wmPbbzq2pOcqKbYnMRVHb5+IozKB/vHHKGr68BH2DcgPZ83PM4WLZHK10AareGux8Bb82HkPP3HqQs/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131829; c=relaxed/simple;
	bh=XyHVZgTEEU9jeG0R0aHxp6hZU2S5LzzIaxTXL9QhFBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AF1TlwVA8Ya2UhgRWnabskVlsf+JKfo/h8bUUBGO90U98ckOjZrPCr80A99sCbJdhZVG/9arnmEASVeCv5DoaKE62BYXXg/o0iaPwXI8mRFBDr95m7vGEhSh3d0f93YYFFE5NMmMWoYOnL3v1Ow7Ek3Ha82mQsM0vLb5yJdNO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo7vjY6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8DDC4CEF2;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131828;
	bh=XyHVZgTEEU9jeG0R0aHxp6hZU2S5LzzIaxTXL9QhFBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lo7vjY6he4xWIMh1pX/S8sSy8sa2VSOPIMc9V5Ayn8nWMgHmsFhuJ7XMXSxjJ52Ri
	 g1u7MJqMzIS5gAbrvtsirGBRVzU+J+tQDrOtmrWX+FeoveZEOg51x/E2EqwwhX+ToQ
	 vh8AoAK8zs8raM2LEI0Q7yXxgLkG4qXp9OZ0hhdZZDXz38OgGB0bufrYuR5+3ho5Iu
	 L0y0IIkVBue7vuZrkOS7kYJps0fNDG04KEvIlnwF3LMQ4eebPbaMdDqhHHcI6xh8tE
	 1AKc1Qn9Akab5x7+8aEuRWHTRmh7NQxKpFXfFvSPoxMBdeux4CfGwBKaZ6ucUCgH97
	 I1WYQBAnKIa/g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNi-00AqZC-8D;
	Sat, 28 Jun 2025 18:30:26 +0100
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
Subject: [PATCH 03/12] PCI: xgene: Drop useless conditional compilation
Date: Sat, 28 Jun 2025 18:29:56 +0100
Message-Id: <20250628173005.445013-4-maz@kernel.org>
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


