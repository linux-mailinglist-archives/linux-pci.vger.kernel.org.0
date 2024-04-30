Return-Path: <linux-pci+bounces-6840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BA8B6B26
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 09:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A821F2280B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400236AEF;
	Tue, 30 Apr 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9YmfKcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB271C291
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461071; cv=none; b=X0eAK+8Y/bo+ka7QHFDe2kioJW4llo4T+Nd3JHXVFi6DxoDnBbp1T2grvStipplJ9Fjlqpn78+qi5+XlYvMcCGgHvm8hf0xyyOT/RriO5udEBif7sKWRI0LjRNA9c/Qis1fl67rJD+xB9JyAN46GvbNvJVSIIigQ944mrbJiNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461071; c=relaxed/simple;
	bh=b0xYZ9pHla2HGOqalo1ucoxwIxK4fcaev8A2o+7ig/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiYzUIFwU8lmpe6Q3WcNrCpv+U3FzE5SfiSM1rsybjvfPj324pQvxKgIfbqulwR9mViCgrdr7edszjXG7SkTdhrrIFSyHvIkY/yad/A7ilJwQ+WJBJsyECNQZOy3d0IkMKZq4bXdp1AYS3rfJBXLNtCDnhNtlf7lqOluUu7D+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9YmfKcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD4EC4AF49;
	Tue, 30 Apr 2024 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714461071;
	bh=b0xYZ9pHla2HGOqalo1ucoxwIxK4fcaev8A2o+7ig/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9YmfKcWqq8fG4DWHhHo/hAILcoSj2Hg4bKJlFBhXSAO52LwopShJ8jfrhpP7S/DH
	 oE5p8T6U7CCnMH/ax4J/AaGBxhhfpnYCAg3GLXGeSICJY++X3iWU/juZGdngvfzAKj
	 VKTcV8vHQQeQ/dTBDiyeY+97Op5/Vf0y9K9bTkfqxCdVUkFwvThqfbYKOaHN1lm7hl
	 zvSW/8CAfaHNjMVBrdV2AK/TjtdO8WIjJGPvTJXqMZaUNMwyP4MqNBdPyaGRY/Owgd
	 oZrtSLuairqu/KTysa+QqsC4jWz8VrPqKoPCX5sacLOZAdBWFacGVDVb+C9DToUGz+
	 27XBGWsURMWJQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: artpec6: Fix cpu_addr_fixup parameter name
Date: Tue, 30 Apr 2024 09:10:56 +0200
Message-ID: <20240430071054.248008-4-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430071054.248008-3-cassel@kernel.org>
References: <20240430071054.248008-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=cassel@kernel.org; h=from:subject; bh=b0xYZ9pHla2HGOqalo1ucoxwIxK4fcaev8A2o+7ig/Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIMZtY17cutVu0IPLbjh7zn54dTdTTMzXROrHQ0Xvt76 uaFGZYXO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARTzFGhi1qU5nYbZZ4FFmY aaz+ungLx+ZfEmqVi7tW6rw95OyR68vw3421ys1x28VF34yPbC29pDxTlNPfXnadwWS274+/Pnv zhhMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The function pointer declaration for the cpu_addr_fixup() callback uses
"cpu_addr" as parameter name.

Likewise, the argument that is supplied to the function pointer when the
function is actually called is "cpu_addr".

Rename the cpu_addr_fixup parameter name to match reality.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index a4630b92489b..65cbb267881d 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -94,7 +94,7 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
-static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
+static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
 {
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
@@ -102,13 +102,13 @@ static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
 
 	switch (artpec6_pcie->mode) {
 	case DW_PCIE_RC_TYPE:
-		return pci_addr - pp->cfg0_base;
+		return cpu_addr - pp->cfg0_base;
 	case DW_PCIE_EP_TYPE:
-		return pci_addr - ep->phys_base;
+		return cpu_addr - ep->phys_base;
 	default:
 		dev_err(pci->dev, "UNKNOWN device type\n");
 	}
-	return pci_addr;
+	return cpu_addr;
 }
 
 static int artpec6_pcie_establish_link(struct dw_pcie *pci)
-- 
2.44.0


