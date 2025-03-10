Return-Path: <linux-pci+bounces-23309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8713A59255
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829D8188AE3B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF25227B94;
	Mon, 10 Mar 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH3e+cl/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47870226CF3
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605061; cv=none; b=LiJMV5AL7zvWG4BvQQwkPpePHKvhliHgkqN3sybT6q4ny6vg/A0mi9y2UPwHoRafjCBT7Ac5MXEYoeVZ7ajHLUl7467tZGfiRf3Juk+t+6X/btoKkpORq01Qs9WdOhV1KQ+k15u9jFhM0SF7Y7J3vlMdk1YTiCik7oyRXm2fpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605061; c=relaxed/simple;
	bh=n72aWwT98ZggG+Y6LDC3CZxTDfMDH7cYnt/JJu0ZCyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM9b5CFs6004P0nYmT4Tp6MjDw/+ejgIneNNcY/IvO6VR4N+dx33V/emvnBF4zzcj5UmO22jdzHeZOOcjmUs/SQWR8KQ7hDWIe9jMGuFUStuTGE2AF+Qwq5qiodRZ7rVo54xsaIQUoH2RCFrJQZKEMJYd6aOMxjBiJEJIf2+qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH3e+cl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D02C4CEEE;
	Mon, 10 Mar 2025 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605061;
	bh=n72aWwT98ZggG+Y6LDC3CZxTDfMDH7cYnt/JJu0ZCyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bH3e+cl/htoNaJ4b0psi+3dk9Eb+/81kXsX+73wRmAk3zZPDwfwFLWt8U6FUNfH2F
	 Kv8Iw5nQnmvXr0Rmt6wvfBHOquA+4jcVA8bzhz2epiZgR2nWKVLKGjoXcL7c+Cyj3a
	 g9eDiaQP8CES4FQB6xgyGrhXePQx6qwPf73VxA608cVALWJkNllaMQ4Lt5A8WGvnXX
	 McnrkmGfCdKhSkpmCr8khBHttXMFJH55/eW6tUfNtMkN/70T5Sh06kAez/ls10GUIg
	 5dbU0IaQMNJIKNfJUlGr5aZ95uIJLzHXA/cuAKWHdg8L5YcaVYOMLzDlOjuEe+6cCh
	 a4kTxsEYVyCJA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/7] PCI: dw-rockchip: EP mode cannot raise INTx interrupts
Date: Mon, 10 Mar 2025 12:10:22 +0100
Message-ID: <20250310111016.859445-14-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=cassel@kernel.org; h=from:subject; bh=n72aWwT98ZggG+Y6LDC3CZxTDfMDH7cYnt/JJu0ZCyQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZgXxtoZvf7jBas6X78P836cztPU8pm9ZJmz1tJ46 /CFJ0JvdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi1WEM/2zr9i4877lgmmD4 Xu+88q5lTYIOrUVXdt83tHwZ0nzQ+SUjw//DDawu2XMfbdJysLcJlnsl/CGWZwpDvllsRTJX4dE qXgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Neither rk3568 or rk3588 supports INTx interrupts.

Since epc_features is zero initialized, this is strictly not needed.
However, setting intx_capable explicitly to false makes it more clear
that neither rk3568 or rk3588 supports INTx interrupts.

No functional change.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 7bf22146cfd1..c42766146e1e 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -298,6 +298,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
+	.intx_capable = false,
 	.align = SZ_64K,
 	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
@@ -318,6 +319,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
+	.intx_capable = false,
 	.align = SZ_64K,
 	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
-- 
2.48.1


