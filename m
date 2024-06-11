Return-Path: <linux-pci+bounces-8597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD4904179
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6954EB24064
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDEB40867;
	Tue, 11 Jun 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEcwFhol"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785938FA0;
	Tue, 11 Jun 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123785; cv=none; b=ixXAJAZUkZklWBBGAKn2ZAPHjEIL+N8RDXNdTa/LOUQT/Eo47AaLDELOiqNRqTFxO1bh+AMXfaBUUpdqCfla/8ivul1Rq9aUjev0RPOrEBM7A/xbXM3GcdQG2Gfpq1GauIHh0ozI7HkqIUfhrfbjBAZYIX86/W3TtwXQvpyaOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123785; c=relaxed/simple;
	bh=Br185Yo6/5F9RMGQZLgDnvgMIisyh5/Lt78nH4PPTx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pypDZpGAzO8tV/saQAfZ8D4ktvPH889NN+69tkxbDnlUx1tDwGHsJK3Zgg9Y/ugkZ6R8cvWlgCWID1SbRxnEzSe9PWrBhc4TTC28nwxs4voo4vwAqBXrl3Ahnfo+jM/AoT9gYMgw1OQefF4at0t+Rlq3pNZUhXG3DUZR+Wzbojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEcwFhol; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718123785; x=1749659785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Br185Yo6/5F9RMGQZLgDnvgMIisyh5/Lt78nH4PPTx0=;
  b=iEcwFholf5zxy2o5jRt3qBaCJl60883B4G52pAE13rjGnTidDFWxTJ0/
   aQIbvxVmCFC5r2kwbizKzFQzEzVXfDG0MuZyzYPdEBuhlfTLtyzr0ozje
   McwFAcpxonQIGszBEwCjGkTGqNG9RApMOKCz2uLTrOMHfE1stCZKMXlld
   /9qudHZh6d5Hrn0XiWuPKidxgKsZ6IXwDksQqmxwcti1+0XJOI0VJBUMj
   a+uJNta+zf+5gYARwIbsJI4Dj/eCUneNnJJyhc0vzMnAi//4cjgR2B+ry
   +X1ge6rYDVZxb3bpE3+HK1ssLrpaKi7Cmrv/0u12chLkpdDMBKcXIFngd
   w==;
X-CSE-ConnectionGUID: zUmtaTvQRJWgFp6fdT9KOw==
X-CSE-MsgGUID: 3rdMKXsRRviQDme3gS9NWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14972723"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14972723"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:36:24 -0700
X-CSE-ConnectionGUID: /4QubWDsTIu0IhSnxowjIw==
X-CSE-MsgGUID: G72oLDd2TbeBRHeyQp/7cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39959470"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa006.jf.intel.com with ESMTP; 11 Jun 2024 09:36:22 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 2/2] PCI: altera: support dt binding update
Date: Tue, 11 Jun 2024 11:35:25 -0500
Message-Id: <20240611163525.4156688-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611163525.4156688-1-matthew.gerlach@linux.intel.com>
References: <20240611163525.4156688-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add support for the device tree binding update. As part of
converting the binding document from text to yaml, with schema
validation, a device tree subnode was added to properly map
legacy interrupts. Maintain backward compatibility with previous binding.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/pci/controller/pcie-altera.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index a9536dc4bf96..88511fa2f078 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -667,11 +667,20 @@ static void altera_pcie_isr(struct irq_desc *desc)
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct device_node *node, *child;
 
 	/* Setup INTx */
+	child = of_get_next_child(dev->of_node, NULL);
+	if (child)
+		node = child;
+	else
+		node = dev->of_node;
+
 	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-					&intx_domain_ops, pcie);
+						 &intx_domain_ops, pcie);
+	if (child)
+		of_node_put(child);
+
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
-- 
2.34.1


