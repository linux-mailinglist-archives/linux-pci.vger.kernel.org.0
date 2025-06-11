Return-Path: <linux-pci+bounces-29428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30BAD530E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63BB17FFE1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF7283689;
	Wed, 11 Jun 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNzHJEvy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E472E6132
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639229; cv=none; b=uiJyX83VEuQ7QFFxcAFtINXSkNZjXK8z/CxJ5LUJRvpKFUNSE0Nc/Iqexud3QijlzUO3lF9tUt46HUT4rTXmNTUvYC4W+y5g4Wrz8atzPsvCA2pu6DyytrXDOpPBmiOWf9t0uej6dNQVp62aGyYonLQhGRUKso9T1ijdrimYAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639229; c=relaxed/simple;
	bh=tI+LtKti4AzlUuHRllt7kmun1TVubD5em76uHJEOkxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl35JC77UHhCdPjelFL7lH72gU85iLc9IpuRVveevRiq6VwUjGgj9CDT07mtcxc1FL7wayc4BjUvNvmkzm52FrLpNPblin71b/pTBrmy6/cTXmaiRcnuRwBiOAovRPOjQufYhBMaW0Z2r0E0OhUw5H5zuT5VR6CnOyI/fUmI23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNzHJEvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221C7C4AF09;
	Wed, 11 Jun 2025 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639228;
	bh=tI+LtKti4AzlUuHRllt7kmun1TVubD5em76uHJEOkxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNzHJEvyjY2cdYpmmbHxF79FaGzvN2F86fWnsX2Lkb5xSz9c31jUrSuTOLPDRMZGW
	 fr0+JY7GJ0lXMDIgvntbjfrIAydMAfSTxGIVKLCanNDy8F483qQvFdSL/2GBzozDPy
	 ucFSIJZRf1aoHly+PNvRoAYMuWHfxePapCUloyBUZUlX4t/TSLC8wWsmRzUEPP7AGp
	 dcBbuZf3R4ZUZ9EGSDAe3k9hzW/yvMZe3juVObK5RR18Sd6BxVW5yd1XzjqJlgj3R0
	 2n6inpMUz6uST/wF8nW9VABrhfPxGwbwIHieZ+cUt1oNzwqlQ5EDIV6i7/XzqLF7XT
	 B4yCYwXRJY34A==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Wed, 11 Jun 2025 12:51:44 +0200
Message-ID: <20250611105140.1639031-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611105140.1639031-6-cassel@kernel.org>
References: <20250611105140.1639031-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=cassel@kernel.org; h=from:subject; bh=tI+LtKti4AzlUuHRllt7kmun1TVubD5em76uHJEOkxk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI84/feXzuneHJCYNrti2c5Jr22X9i84VGc/o6ca3455 w4syVjo2lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJXApnZPhzXc7GVu/E57vX OSUkhDUFL+3fY3nTy/HvKRfrFbs+G/5n+J9rmjDvCuOf5uj1WkdX3n7efiv0V5GIqOmOZtaN79Z OV+IAAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add this delay in dw_pcie_wait_for_link(), after the link is reported as
up. The delay will only be performed in the success case where the link
came up.

DWC glue drivers that have a link up IRQ (drivers that set
use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
perform this delay in their threaded link up IRQ handler.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..dbb21a9c93d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -714,6 +714,13 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
+	/*
+	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
+	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
+	 * after Link training completes before sending a Configuration Request.
+	 */
+	msleep(PCIE_T_RRS_READY_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-- 
2.49.0


