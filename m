Return-Path: <linux-pci+bounces-37024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75CBA15A0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A819C3D53
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF62741A6;
	Thu, 25 Sep 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9D2PDwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614435695;
	Thu, 25 Sep 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832063; cv=none; b=mrI/YDH4IoVnRt8uoy6GhKWOil15v3K1OS9/2IBZVyFAfEV/b9X9onJADAPmKo73mlTt4JWAyxlJ1Xgjz0qky49z8uf+NpFt2UUYUKIy7SHaCF7pzxd9s0xrj2V0YxYrWYhg4SzEE/ENYAlqC17eIcB2PyUOw/Q38CvpXHUTrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832063; c=relaxed/simple;
	bh=/wUZUSVzXqtNZ31rc/nwzO9NvxfLuwldDq9ROGmBJvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DN4Mdzex9RZx7itPaIwDuRAEgdYvmlzBYIfCYQpdNjzCNYJ+bj6gDiT3IQVbQewY+moAwBRvaszLlp9wZcMSli/HeUh04BNOu7Uu6lo7pSWAYVB8K+K1JGxWiEXad/D3C85Li9cVzIRcq5s6NyH5JyG1hdvzRoDBGcpxNYrFeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9D2PDwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C458AC4CEF0;
	Thu, 25 Sep 2025 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758832062;
	bh=/wUZUSVzXqtNZ31rc/nwzO9NvxfLuwldDq9ROGmBJvw=;
	h=From:To:Cc:Subject:Date:From;
	b=u9D2PDwkmgjdSzgnChhJQIjUTHNfkHcVsfHyJZIzeWfIDdT/2uKexQdYAKCfbJG8y
	 xc6mVusvEVTSXTLkv7Xl4IPk2fopNhZtcE2Wj3cyEnoucOqxrbMTJcInc89CzwTPPC
	 ifTuWge8ywlVY7XBwVMurer+RILfOPmidK3T4+/4lYqEs7bxREnlzZHEg8JVthHHt7
	 zUFq19cSWGF3AAKMUOtqybJhWVZm3Zkt+bZ+pctk/Q9aHI7JLVUSw8iTOKwYGRR2SU
	 IMzFQQD4V20mP2JblUkungCtjVjYhWukOUeR7p0BdE9CY7Q/TT54OOZ356c+URc9oL
	 LojsU0G/522tg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
Date: Thu, 25 Sep 2025 15:26:46 -0500
Message-ID: <20250925202738.2202195-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

hook_fault_code() is an ARM32-specific API.  Guard it and related code with
CONFIG_ARM #ifdefs so the driver can be compile tested on other
architectures.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-ixp4xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index acb85e0d5675..9fd401838bad 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -214,6 +214,7 @@ static u32 ixp4xx_crp_byte_lane_enable_bits(u32 n, int size)
 	return 0xffffffff;
 }
 
+#ifdef CONFIG_ARM
 static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
 				  u32 *value)
 {
@@ -251,6 +252,7 @@ static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+#endif
 
 static int ixp4xx_crp_write_config(struct ixp4xx_pci *p, int where, int size,
 				   u32 value)
@@ -470,6 +472,7 @@ static int ixp4xx_pci_parse_map_dma_ranges(struct ixp4xx_pci *p)
 	return 0;
 }
 
+#ifdef CONFIG_ARM
 /* Only used to get context for abort handling */
 static struct ixp4xx_pci *ixp4xx_pci_abort_singleton;
 
@@ -509,6 +512,7 @@ static int ixp4xx_pci_abort_handler(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static int __init ixp4xx_pci_probe(struct platform_device *pdev)
 {
@@ -555,10 +559,12 @@ static int __init ixp4xx_pci_probe(struct platform_device *pdev)
 	dev_info(dev, "controller is in %s mode\n",
 		 p->host_mode ? "host" : "option");
 
+#ifdef CONFIG_ARM
 	/* Hook in our fault handler for PCI errors */
 	ixp4xx_pci_abort_singleton = p;
 	hook_fault_code(16+6, ixp4xx_pci_abort_handler, SIGBUS, 0,
 			"imprecise external abort");
+#endif
 
 	ret = ixp4xx_pci_parse_map_ranges(p);
 	if (ret)
-- 
2.43.0


