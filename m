Return-Path: <linux-pci+bounces-34060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF61B26AF5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBD25E2D7F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1421B9FE;
	Thu, 14 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADc/SI9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23DC21B8F8;
	Thu, 14 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184945; cv=none; b=FELCA+8+ycKjej30vbfppdnkX5WMbzO/eOZdfzhWIjrRNjqcg/FFFKgMFmcA5xNcx4ZN6mm1SoZX2ym3LbO5IDnzctXQf7fg9APyXXbFQ/nK6ndMMuTTlQG4vTIVgrQCFmGmkKmLNPhG9QCmE8r7GdTmSCjzVUUm3WPmK1sJ3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184945; c=relaxed/simple;
	bh=+1gG3qlmSkwGj/oU7QDjRpIhc3oEnnm/tmA6uBQL3RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs1wWXAEuPNmup7uIxyGeAhkTgYN8QnweHD10xjpvwDCb9+g+x6k36rhbmZyESfeSMqgLuu54HuNb31OZZwMJTuUdfucNBu1MFZqY51IAjSZdgGy6+LxgHEBw1jULu4gludpLa3e2X1FEgtgS0RnmpNYEdai46LODuXu8PgqPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADc/SI9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F4C4CEED;
	Thu, 14 Aug 2025 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184945;
	bh=+1gG3qlmSkwGj/oU7QDjRpIhc3oEnnm/tmA6uBQL3RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADc/SI9Q0CYssF6iFsm297aNyk1X6W440Rz5x0B4uZTlf+1C9/uPnCAOGKoLVtNx8
	 BXgqtIH5mtJ2x1DVi7VOHNwN0OXGRKGYDuxxqXu1FrRjkPZBSoFxyTFwahAIuClCPl
	 P+rmyyNu73fEtq/Sln4AvPPzuoOjXqEjiiGcXgLVPTgBecTMUrANB5meFaQ2eOpu/T
	 iseg9h80RM7Gcxj4KW4NSx6IiFoMGYQypKzhbOpPoN/4EtYNfNJyuIdf/lwTn8A8QI
	 sfTNB3+B5xqYGoLB8BWBjsstV/B7JwE/sZji54A4TQitt1NhVOlaoTtyj5BC51pUKA
	 rO0m5xEihJbEQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 13/13] PCI: tegra194: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:32 +0200
Message-ID: <20250814152119.1562063-28-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=cassel@kernel.org; h=from:subject; bh=+1gG3qlmSkwGj/oU7QDjRpIhc3oEnnm/tmA6uBQL3RM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vspwigcseZin6jWJ7uQY9pGZuJ1gs+D3h7U8ohhi O6deeVuRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayuIHhf47pCY/PK3O0OSrE sh7MlVs6IbBxzvfpy3gP+XEYGrrYijIyLLJZ8iQ0iVt5e8xOA+PPAlP3H3NalLQ6f7v9rjMqkbX vuAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4f26086f25da..0e413857649f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1998,8 +1998,6 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
-	.msi_capable = false,
-	.msix_capable = false,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
 			.only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-- 
2.50.1


