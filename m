Return-Path: <linux-pci+bounces-34056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B6B26AE7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CD21C850EB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9EAE555;
	Thu, 14 Aug 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8G/nwgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549108F49
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184934; cv=none; b=f/1tdKHQxpAhvFLoINS/En8ImMWVhSnKV8tSXsGeTggbdx4Ul/i9Exu++LCt0ikIYiPoYeBNEM/twAELxA/dJaXOcu6/x4Yex6Ke26TC63MCcMWOERtVZcTYSAz+1IjUzgNFzqWRH0UOWswAmQsFf02/qignahBIUq8pUuZznMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184934; c=relaxed/simple;
	bh=74Vt3a6n4teThZfYp3RaKUgXovIDf9PomEewqYdyFlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Daj7OcjFHB8ANNLGoigu/tBB2SmaEzTfaez7O4BYxe2dKnNaE1A1H1XcjO/iBzMgN4Qx/7ExR8xcnf+PEGfPcFXOWeC1hEbKuHMfgEUvKhlt3adUVT/ZQOCGrZzKQ3KjKHPQzx78FCl2fNtUa6ApSWf3AM7PuqKT4TVLNBFDuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8G/nwgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0289EC4CEF6;
	Thu, 14 Aug 2025 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184934;
	bh=74Vt3a6n4teThZfYp3RaKUgXovIDf9PomEewqYdyFlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8G/nwgTbuZmIIfx/MYu0RtWPSsH57qPusFyf5ZmNv7b+96E/7doIjPukmMRRsqFB
	 pxVUgittAXpitSSA0/z+oGVVBR8yeKqRLeQcogrNrslyxnAInrc+coC0lscy7uOxk8
	 Y7zPK2aWd07X6vKhr8PHW1xVgye1pqaGgtQpdG6WrPOjmUbWXup8K/R1C2OGZ9Pvu0
	 lVOXBYVzg+Z8Ok3tZ77VBMOz4vqy/foFIUlz10SRQp9unRJkFJI89DeOzTppdrbdmZ
	 geqAva12zeV9GbVShDLdSZXQivQnDR1JPmn8QS90BOQvHlfBA6AUxN65Ei1H29fjrq
	 btV2jPKWYHHJA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 09/13] PCI: dw-rockchip: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:28 +0200
Message-ID: <20250814152119.1562063-24-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=cassel@kernel.org; h=from:subject; bh=74Vt3a6n4teThZfYp3RaKUgXovIDf9PomEewqYdyFlM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vvx5hjvPTPNraVXuW0sWZZZJd53YGf3thbwMZnT5 iNvceplRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZS+oXhn42x7c2bm+ZkMnyZ HDC/unNqVnOnX8YZoxBL3jzL0ze4lRj++xeuXfpx4a4fbledVpxQeGujk/hwQheD2F1fV9a7gpq /WQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b5f5eee5a50e..c045353fa493 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -325,7 +325,6 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
-	.intx_capable = false,
 	.align = SZ_64K,
 	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
@@ -346,7 +345,6 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
-	.intx_capable = false,
 	.align = SZ_64K,
 	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
-- 
2.50.1


