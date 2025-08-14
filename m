Return-Path: <linux-pci+bounces-34058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C4B26AE4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265EC3B5A48
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25222746C;
	Thu, 14 Aug 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey9GAAzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7978F49;
	Thu, 14 Aug 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184940; cv=none; b=p3wiDU6T6TSsVnby587HZ2zaUt9k98TyRRkH3vKT4QgIS+kCf0bJNcDgk9Z+m1JtI9MQzjMg4j7tR8Sd5uEGDSmi2RPGClSs0lv8ghAgOFdEthuO6rZSkDTjoy4GQgWO1E/9evO7+9I6FuXaE50W77oNvB4RiFPLNDFNqPTLTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184940; c=relaxed/simple;
	bh=7y2t1s04GKrnujTi5HTYb2X9WQXQ2FTgCTLmgBGTTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBPzTgPaZLWCA0pIZEeU3z98mgqY6Is5NHCqD40MVNPkHNC7rXACZ0OYJDQoIQrZVY6vr7wRBiurhnQVC4TdS9ZsrfajRMxXdL8mumpOjoEcJv5chi5BfPM8IHtNzsWpKlFIHtQpllc6BRbi4z8JO8G6r47pM8f44WFuP7Nv0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey9GAAzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71072C4CEED;
	Thu, 14 Aug 2025 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184939;
	bh=7y2t1s04GKrnujTi5HTYb2X9WQXQ2FTgCTLmgBGTTdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ey9GAAzl20ggH45t2sOIC8P5NZN46k/V8WFt2t+4cyKYNhtscpEtuuFYkulLJtfnT
	 ztBtIlMyJlty6OklLgptnAHo0nBZXSeDMHcNIyzz52OFHggm46k35dU0q7ttXfastU
	 mSBAeyBrV6mtSRLXNXAEL07Rof+F+PhHPASKrLAFEB0t95mynbjGaBFHZcLNjh1NkH
	 2ULIJZvqEZDB5WyAyIgN2DHWyUQ5wPl5CeTwTEBKLxDBDKdjKD7r2FTv6Ld2fLNxVp
	 EX08pnYZdXolW9e/CXnKueaZb+iMkeV879DaI5Yw2uw/zUMZrpieoMVLEEbeHTi1nw
	 +kIq66+zwjxEQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 11/13] PCI: qcom-ep: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:30 +0200
Message-ID: <20250814152119.1562063-26-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=cassel@kernel.org; h=from:subject; bh=7y2t1s04GKrnujTi5HTYb2X9WQXQ2FTgCTLmgBGTTdA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vtxZX3LWafzHtIKk/gvigWUP2Ve8qKhvnr+1O3f7 4s2hfDt7ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEFpUy/PdY0LYjINucoS17 hv2s/MlztqsUK9+cNueTY+tKj++/qg0ZGfZOuhE5fa1j5pRbK+Ty3h7nVvY8cVi37r7MpzO7zhp 86eAHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index bf7c6ac0f3e3..60afb4d0134c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -831,7 +831,6 @@ static void qcom_pcie_ep_init_debugfs(struct qcom_pcie_ep *pcie_ep)
 static const struct pci_epc_features qcom_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.msix_capable = false,
 	.align = SZ_4K,
 	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-- 
2.50.1


