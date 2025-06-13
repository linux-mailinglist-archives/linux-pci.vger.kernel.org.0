Return-Path: <linux-pci+bounces-29691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54024AD8C80
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223BC3BA1C6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96179F5;
	Fri, 13 Jun 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUSqfKk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A679F2
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818959; cv=none; b=AB4X8rOBQFxHILG6ov1W2fryQ/V6TEHkWPjx85Zz7hVai+9A5PWRfS94AHJV/AJ1VZ9owPxxHpsntbupUS2VSSD9W9e5MZzdjiFbDnlYz+4K+ddrRrKGANf2fj0nYO8kDhIyJzqKu1E6LawV3UcwPj3yfvHg0/ubmORwsRKsD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818959; c=relaxed/simple;
	bh=ssqAWVH5QI5vbnIpdXWZwd9CJCkHPrKBSARfm2dGLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIwMqcBl3ULbrZtYJ7Q2b4PIeWowlVr4pmvz3rxpWq7SjGIVVlhDQg1dp8SCZHOVOR5RVgbYYNZksFh8R6o4QIYlZq5GaEziW4lNn1nHAnKqATO/Kq+BjGUk4yr0yKhi1G45k3Sy9oWErqWZEsz+97jX/81icFi9dbZO0NK8J+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUSqfKk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A3EC4CEE3;
	Fri, 13 Jun 2025 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818958;
	bh=ssqAWVH5QI5vbnIpdXWZwd9CJCkHPrKBSARfm2dGLGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUSqfKk8rrHfnTRBHBFAQp5y2tMbv6OJute23smTj5vDaJ7mt68yXJC721M/RcHq0
	 RNNLmmUsFr5eeSFt3vRDiPBT7CWKPBj+R7tKj/gswA4aQY+pZMe0TPFig2Z3T6+CG3
	 vrAVJ6raCeFhxeJDoGVZWxHP44CnfYscH3Lkl6E64RG5pi60svbWg9eXnCnq72pNh1
	 Q7wQmmGDKyIcYh5j69d3ow9IJDWrCDIAlPInnuDFKZSRyotfsqEW1vXBWOeo+cCVWa
	 lygHX3FqTRCDjgmGGLdIwghzFz6jORtsFY9KgP3DADC3uxMm1d/z/QqnaKdKDgUlgr
	 4kFX6Dt/bM4JQ==
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
Subject: [PATCH v3 5/6] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Fri, 13 Jun 2025 14:48:44 +0200
Message-ID: <20250613124839.2197945-13-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=cassel@kernel.org; h=from:subject; bh=ssqAWVH5QI5vbnIpdXWZwd9CJCkHPrKBSARfm2dGLGA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85HSfhacuK5vj+PDpDw+FPoX1R8s0/kWqvZy+YOHqS 3Z7Xq1J6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEfu9iZNjPd+LHtkw9dnM3 o+5NVp59AWLHj6g0R77mNtqj3HnwdQ0jw8fohO0fJsydPvPypemd+pNKtq1TWdmgPuPSKeZT9nM tPzICAA==
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
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..24903f67d724 100644
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
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-- 
2.49.0


