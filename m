Return-Path: <linux-pci+bounces-3317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D58501BF
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 02:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA221C27EE6
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 01:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F61FB5;
	Sat, 10 Feb 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/SzB7p8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFC4405
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528433; cv=none; b=j1O6enOjh0EwGknJ0Ja/SOtUnHvL7iD/qPqQazupnMqIuNEVci0rAbf9f/DTCdT6uzHBL0dz1LnLkCrFnI7dXqBugiV+Pm8l7wlckwwgfLKZsxERrZFEc0yxwfxA6sAGp/TibOfS1m2IutSdFz+jcZU9wBlH5FVYoEhf8sgWpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528433; c=relaxed/simple;
	bh=8TNAfcSSMjI6WBnGqAerfMLesmkB1OZ7qW9doZtfcPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N59LkQB4kvVByE+G7RoEfZf8xg49y3sJtijUvVAKMAzJrnQaUecPUOC4wDHWIayAchtb9heKZwKURH/pZmej/055LsuGYXyLbizwG1IxPA3YYlCrC8TxcUoVy/BW54tQbyxauh9by4jizL5g8utyaKyJC81R4V+NgxXMuzT3aso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/SzB7p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C48C433C7;
	Sat, 10 Feb 2024 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528432;
	bh=8TNAfcSSMjI6WBnGqAerfMLesmkB1OZ7qW9doZtfcPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/SzB7p869UDkFLnB4IpU9PDMUPEh95oEEi9XZW5zmN7C6gU64kWcAWSq8cqNJtvg
	 0tMkGThybnE6l6BJJuhO68e347/QgZyOmS/TaJmsdSjJNk76Zj9oIE2v+WUj3SELT/
	 J/zOxXXRs2KtKGQ3LR2lhxokr8iDQ0nagOvJKpb29wF7HmZXfIoOTsuxdbMFFaHRRM
	 NJYrzn0TIr6+2LEqDb3hY8A/pQubDkVyWcfzHIjiXaxPdM8X1Ru2qsEpCmf1oCeknM
	 ZEoLELGXFxx9eklJHKeBoLIyhGYWz/WH3hNhy4p1iWCfRv+9yKYI4fRITjMEo09K9w
	 aILqssS+RgPSQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: endpoint: Drop only_64bit on reserved BARs
Date: Sat, 10 Feb 2024 02:26:26 +0100
Message-ID: <20240210012634.600301-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012634.600301-1-cassel@kernel.org>
References: <20240210012634.600301-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of a reserved BAR is that EPF drivers should not touch
them.

The definition of only_64bit is that the EPF driver must configure this
BAR as 64-bit. (An EPF driver is not allowed to choose if this BAR should
be configured as 32-bit or 64-bit.)

Thus, it does not make sense to put only_64bit of a BAR that EPF drivers
are not allow to touch.

Drop the only_64bit property from hardware descriptions that are of type
reserved BAR.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c     | 2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 7 -------
 include/linux/pci-epc.h                       | 4 ++++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b2b93b4fa82d..844de4418724 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -924,7 +924,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
-	.bar[BAR_0] = { .type = BAR_RESERVED, .only_64bit = true, },
+	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 265f65fc673f..639bc2e12476 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -415,7 +415,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 		.bar[BAR_1] = { .type = BAR_RESERVED, },
 		.bar[BAR_2] = { .only_64bit = true, },
 		.bar[BAR_3] = { .type = BAR_RESERVED, },
-		.bar[BAR_4] = { .type = BAR_RESERVED, .only_64bit = true, },
+		.bar[BAR_4] = { .type = BAR_RESERVED, },
 		.bar[BAR_5] = { .type = BAR_RESERVED, },
 	},
 };
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7fe8f4336765..da3fc0795b0b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -120,13 +120,6 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 		/* If the BAR is not reserved, return it. */
 		if (epc_features->bar[i].type != BAR_RESERVED)
 			return i;
-
-		/*
-		 * If the BAR is reserved, and marked as 64-bit only, then the
-		 * succeeding BAR is also reserved.
-		 */
-		if (epc_features->bar[i].only_64bit)
-			i++;
 	}
 
 	return NO_BAR;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4ccb4f4f3883..bb9c4dfcea93 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -164,6 +164,10 @@ enum pci_epc_bar_type {
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit. Additionally, the BAR succeeding
  *		this BAR must be set to type BAR_RESERVED.
+ *
+ *		only_64bit should not be set on a BAR of type BAR_RESERVED.
+ *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
+ *		touch, then you must set both BARx and BARx+1 as BAR_RESERVED.)
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
-- 
2.43.0


