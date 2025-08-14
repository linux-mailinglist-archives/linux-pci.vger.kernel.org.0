Return-Path: <linux-pci+bounces-34051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1617B26AF3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CF15A0F7A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127AB21CA1E;
	Thu, 14 Aug 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5GBarMu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0EC21ABA4;
	Thu, 14 Aug 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184920; cv=none; b=W+58FWAz5ev3KmqKwBnj9msj7ijmF1d4zOjHDeRxZf/h5ZMLuj8sklF0vEH42kVvTI7W/YvQq5FqUTjDgGWf5WTsDJeoO9LkDAFu8EF3wE84MBkrnc1yr6kOhTMCM6wGBTr+2SVSxzixBB8WD4WOlZKBo1qnuOBlGDJcgEueX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184920; c=relaxed/simple;
	bh=jnYozd3vWL8E5iUlI97XyQZtx57KDI/7g/iBSexDyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejPQgn1nFMdepZ/RdAc1S7WGE5ULR1eOLKQseK4RYocYwnLhY0MuL33+AkN/Z11cd0lswe74Lcii+0BdbgSivPbb3DDXS/67VYrvl8Yp4BGhZ1IJM06bs8e5g3jaQEU+mZ0Vmip1nBWRLRxWvIzBLnpY/L7odjZHqov1bjG8URQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5GBarMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983DC4CEEF;
	Thu, 14 Aug 2025 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184919;
	bh=jnYozd3vWL8E5iUlI97XyQZtx57KDI/7g/iBSexDyDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5GBarMuVEM/72tqKNvIlO2TVy4/oRNZ/7VGEr3DNJemfXy6nbqtUVMLP1lg+t0Va
	 Dt5eD2GG2iiFND/6gVywDZoLB+uJc1CDErkXS1CTygzVKujAk79PPwSvJXHeZBQsmm
	 2Z2HvWFxqhj/reW0K3z5IDPJBMBod/GSVXoti8PpVgNkg1xy04FZFbNAcPPqIbz5JR
	 SAFTgs48ksxtoY54hQMXlnVDSdMvtJp183aZhjnRrEBkgy0s2dPwIpHRLg4FHvEE8x
	 G1VAJV40F5VGFGRQSAh0zhe0wKMWN62+pXLZ36UzAtlxH52lwZ1IVAyI6WrIyTa4f3
	 1tEOkhhLDa4lQ==
From: Niklas Cassel <cassel@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/13] PCI: dra7xx: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:23 +0200
Message-ID: <20250814152119.1562063-19-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=cassel@kernel.org; h=from:subject; bh=jnYozd3vWL8E5iUlI97XyQZtx57KDI/7g/iBSexDyDg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vtWeid1x/1Gtf831LP+pN/j2SV44ozdhlD9jtmL7 0tMF93M2lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJaGUxMrxw7u6Z7pBm2/r8 +KdPK/uTtcWcllfc/9MsGnVc5bLTyg8Mv1mz0tTaKtrWK9vJ/Nilsab5rpPN1Znd3MWff1blJW9 7ywcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index f97f5266d196..01cfd9aeb0b8 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -426,7 +426,6 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 static const struct pci_epc_features dra7xx_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.msix_capable = false,
 };
 
 static const struct pci_epc_features*
-- 
2.50.1


