Return-Path: <linux-pci+bounces-29543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706EAD6F7B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1A83B21D3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBB223DF6;
	Thu, 12 Jun 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgKjGCsL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E77223714
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728998; cv=none; b=PkxVB2PPYWeVcqRbhwlt878HtnQ30R00KbKIFSLdZRMkUuWNxmIuloR3X9Gn0nrnx2GA1XxKty2/t6f40FG51Xt2p5QKRivbAJ2++vuqoLHycYVeFMG4izL8gZuhGbGP3ioxTKBUnA6JiX8gE/bTJa9E2I+CsI+aZenxAPhdRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728998; c=relaxed/simple;
	bh=aSJ9TixcfQ1Ijs281cPrBI+5YJjQIIZcMZivKXfnp3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLSO0g0FQvSIYDad5eDDNtZPmtuJRXa9i266N2LQO1d3YgST35VD4mcewRYoKuZL6PlsHBt60YE4dfG1QvTilZKIZyx+56Qk4zNuAOZw+igHzScctGOaSaXHv01hipriiFAa1F47SQl5W2X4jDG9KbWbKkzAQEkI/j21upp0o6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgKjGCsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED317C4CEF7;
	Thu, 12 Jun 2025 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728998;
	bh=aSJ9TixcfQ1Ijs281cPrBI+5YJjQIIZcMZivKXfnp3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgKjGCsLuNm/YA3Y0p2DMicDkaZXxrUg8lQfmcc7F0xVpDoBPG/grwv25MVLHYjE8
	 D/Y3YzsdRCT2JLwFnr2NwBmYKeH/RE9UkDvPxnn8P70PJgsfDT3kvlmoLO7f9yc5Rx
	 iE2pifAC8Dxjmp0+V26UYzOo8ifBc7TqbwmLnjmVkM5nYtrAe/0ev1IrMiHtMQ8nRy
	 xhry8fotPYZB8kNFcWI7fRJh0uR9XCKy22jOmDXPKSNToJti3+mCcQKJ56g/crMZuq
	 DTkVW5zRZQokcR5AOKRYu5Rdd0WJDXPzAsJyYlnuPqwvK3TkKbV71yTjWPSacEPE7F
	 3kV75trd28n8Q==
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
Subject: [PATCH v2 3/5] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Thu, 12 Jun 2025 13:49:26 +0200
Message-ID: <20250612114923.2074895-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612114923.2074895-7-cassel@kernel.org>
References: <20250612114923.2074895-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=cassel@kernel.org; h=from:subject; bh=aSJ9TixcfQ1Ijs281cPrBI+5YJjQIIZcMZivKXfnp3M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89p34+GKm2n/3j7ZWEvp8hhfKrxsfDaguXdvodWfXl IRHik6aHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIVjgjwy1LpUMx1/0P3v68 psriXu135Qe5/TuU1Q8av3NUq5lesI2RYVJYcfHn7MT7TXMvvKzri/3jzJ1R/b67rC9C/8CGF52 BrAA=
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..7fd3e926c48d 100644
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
+	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-- 
2.49.0


