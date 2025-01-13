Return-Path: <linux-pci+bounces-19659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC2A0B491
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D7B7A587E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E41FDA9F;
	Mon, 13 Jan 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdZonzD3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D06235C07
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764085; cv=none; b=UA5sE4etk6ejBQvBPScHkYA7Eew+iD17SXOiFpXrsMhQpSEgeQI5atkcTCorltGRUBEUsMyXvkmq8/UOT3CyGNRbRCmR9fJuN/69IB91n25DGQXUhOuIeR8t8FCnYaVQRbpkFbkhM9m7TZMezTpqqIXdRWT8CHvlNeOxWQiWoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764085; c=relaxed/simple;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp9NDOLbAzKsHsW9aYBkCu0nHF5Bl9hFMGMqQbny0ro9z8nZD1TsR3J5qNvggG00gm0SJWgdccKMFQBp9iYl5LS4O2/m7nVzRS40M6dO45y+i/BFU7yn8GqmMDE/k8fMlZ+SwL+AZX9KPZflVOlYVOVV2jW9ars9MXkM3AvtPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdZonzD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B7CC4CED6;
	Mon, 13 Jan 2025 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736764085;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdZonzD3weGG/HfPVTUzGr16dRN/IN8wONxB/UrdJpoLSCbEce3IOtuOEAbJ8SUR+
	 rYCsiEyGMlSZJ/jogSVy8hKpOCr5NGRbAHKvL2iMIlAcPEURnrhdlkXWxxJe20EnGX
	 KGpQHF4s+Fwz+Ku1BuLn02nxxqSQR8ZVfqyztpLSItR3JuZbnGLLnTkiJFyrbKqfRJ
	 oReFxtc79aHvFQGqW6etYVH1KZXY1pLy8F3U13sOhUWiHO6IQOr8aZW8XWNas9C+yY
	 D8ifhNUA86R2Idwanxz3ICnEv5hfufT7fNdUVWV5d4/p3KwqhDEqY3+u1fI3ia9v59
	 Eb4nBDdqBw7MA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 4/6] PCI: keystone: Describe resizable BARs as resizable BARs
Date: Mon, 13 Jan 2025 11:27:35 +0100
Message-ID: <20250113102730.1700963-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113102730.1700963-8-cassel@kernel.org>
References: <20250113102730.1700963-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=cassel@kernel.org; h=from:subject; bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbXs188+TkMpljEbNvz44466Vl/KLw8oqb9oK3JPxPH tS9Yqh3oaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATuZvAyDA1XfB+VfyS3bF7 3H57Rup/+D/p267c+V/VkoKPPPsk3f2D4X/IxVvT++4c/voqT+HRootTH27o2X7PVPaFsqbAEfZ 88e2sAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Looking at "12.2.2.4.15 PCIe Subsystem BAR Configuration" in the
AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

We can see that BAR2 and BAR5 are not Fixed BARs, but actually Resizable
BARs.

Now when we actually have support for Resizable BARs, let's configure
these BARs as such.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 63bd5003da45..fdc610ec7e5e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -966,10 +966,10 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 	.align = SZ_1M,
 };
 
-- 
2.47.1


