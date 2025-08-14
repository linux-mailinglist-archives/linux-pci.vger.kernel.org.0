Return-Path: <linux-pci+bounces-34053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E5B26AE6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BCB1C841E0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A82746C;
	Thu, 14 Aug 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMpUwMcV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22922E555
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184926; cv=none; b=XwECDML5VxJZSAmdyUCRLGE/VCQ/CQXblybhmaDsmdiYu/w5SNxnb44a6niSld9SZS+HJYJyu7H87IjDReFTVtDOVHD7sMqGhXTtQfuZkMce+HLcIUqIdUnuSj4g+gVbTacp1RhqSKT+ONXBs0fVH4CSG5+GU+trWlX22lDzsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184926; c=relaxed/simple;
	bh=Mrw/Omdl7B46BjK1PSjfRP4lzsXHNv539FayxUs8LQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj+X5P5suV3jk0GvgkudCGhGFon7B3/oS8PkE1iJPgE+/9kEvbBLPQk6EvBPU+9Rk8orP/7J+Leld7jlevbmETmy6DUxB/NLrU0W8touvb6+4WYJQw4T3j6Y2zC0fPdrEXt+lxfYungdUBNKKPfo0MqnbKMIZ26MpSvEVt7u+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMpUwMcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488E0C4CEEF;
	Thu, 14 Aug 2025 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184926;
	bh=Mrw/Omdl7B46BjK1PSjfRP4lzsXHNv539FayxUs8LQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMpUwMcV/yeo52u6iBPQQnuvQTFeB7y0FAvkS/77yG3jLZVyrzo1W92QCgQqCXK5r
	 onqwyTsXoN1jykLiTnMeOtfmWv2KnknSxH9NFQ7SyHLF/Aaeb0bQcNfrrJmx/NsJnL
	 +iDYDS4C9VmW6FPhzzGLS4S8ea1M83VB0x0r7GhOass2/zkbRaNbgDNuSzPqCfw2E9
	 lyiaNy5rJ/FLLHUP6RlA1focSpx9M5UDv/Qc5MyPg4T8/zOx3vY3x1Vw4GrfG/gC4x
	 beDeEjEcyDAOtFsPJz02wXmkk7jaTRLfwmfymSB8lQKLnUImlEg7Z8b/YRpg0H/M+p
	 zWa7RlzrRqbKA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 06/13] PCI: keystone: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:25 +0200
Message-ID: <20250814152119.1562063-21-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=cassel@kernel.org; h=from:subject; bh=Mrw/Omdl7B46BjK1PSjfRP4lzsXHNv539FayxUs8LQ0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vteuF41YP8VG93behlbnpxZcMs/YJKTttaXx3wP1 oWm8Ozq6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEEjsZGV6U9nBmfJ7RpP7Z +a68Wq7FY84Ez6MKSQ+LrD6q3FHR/MHI8PIe//F1j3wuxqz/MN351mTneFadA+nP5j5c+jV213q dQB4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2b2632e513b5..7d7aede54ed3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -960,7 +960,6 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features ks_pcie_am654_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
-- 
2.50.1


