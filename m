Return-Path: <linux-pci+bounces-17402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD039DA5CF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D59FB26E33
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B56198851;
	Wed, 27 Nov 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP3eroBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756619883C
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703439; cv=none; b=gmY4G2o32UJqo0RJKBeF3Oh2cObMJeayEsnfwv/TzHPzpHVVEooTGWQj/JHGgAjliaI8+WeJAc/qoBtKyM05cJB2A9ED2NYvRUq9RQTFmakQ8qiWblaaZhujun6b4NP+K0rnwtiUZ/Zabr3rumznub5ei+09b5a+zHkP/+pVrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703439; c=relaxed/simple;
	bh=j9gRtPAhuBuJha0qKMSBpmyuO6GmdHdWJO5z2g+PXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHvomAO4TgX3kgbAngqZbW1SFC/QmTj40UnE9+dAbTS5Se+rLu1g7+dUorFx+Vg1GNAcKe/8+zth2oBJMpVIA8IwqBxDlve2Ps34NyrxiEDCYDwhux8DE/phioAArKKw3MSMfvOwvRJrlKHceHOO/w/Xbg2kuD3M7j758pCXz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP3eroBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA0C4CED2;
	Wed, 27 Nov 2024 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703437;
	bh=j9gRtPAhuBuJha0qKMSBpmyuO6GmdHdWJO5z2g+PXrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP3eroBJdVTrbgRb4jgXVtAcNayOhObldsUsqWkmJ1l9ft+QoybZh9qen1nGupPdw
	 EoQ5sfWFSCxhTnVOD1y3HKnx/okkqNYmlgU0b8hCm8SOJd8gUlpgzszMIEAwZ+EwYx
	 scqY5mUXQ/P6lEk/0uq9+GvpbYBOHk3F3lnhpRRJw6Ojfgw3AUKrEJiNya9JSkNkCX
	 HlQS8F10yN10qLjJaV6SSedzewQmC0LDVWZuNCsjBQyNnfDf79NTX7yv2fdN0wDADq
	 VPf2QOldcoz8t1jPbF2RtlfkYkbZz4hwJ/PG8PSbXlrldy49j5Qh94L3TBkiVqJRfM
	 nVnpAPtHx297w==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 2/6] PCI: dwc: ep: Add missing checks when dynamically changing a BAR
Date: Wed, 27 Nov 2024 11:30:18 +0100
Message-ID: <20241127103016.3481128-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=cassel@kernel.org; h=from:subject; bh=j9gRtPAhuBuJha0qKMSBpmyuO6GmdHdWJO5z2g+PXrk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuyt6H53t+Aca/3iexy3YrimS+eeEc+wudIQIOUl8 KPK+eGHjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykI5Phf+1ypXi3F5vEb63z XplmItsqp2Q1+Vl9g9Rq/jbezWuc/zEyfJ3neuBtz97/yiIb3t+YM+Pb/6i37gEcnz76lfq773d axQkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
inbound map address") set_bar() was modified to support dynamically
changing the physical address of a BAR.

This means that set_bar() can be called twice, without ever calling
clear_bar(), as calling clear_bar() would clear the BAR's PCI address
assigned by the host).

This can only be done if the new BAR configuration doesn't fundamentally
differ from the existing BAR configuration. Add these missing checks.

While at it, add comments which clarifies the support for dynamically
changing the physical address of a BAR. (Which was also missing.)

Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bad588ef69a4..01c739aaf61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,8 +222,28 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	if (ep->epf_bar[bar])
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically change a BAR if the new configuration
+		 * doesn't fundamentally differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->size != size ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
+
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
 		goto config_atu;
+	}
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
-- 
2.47.0


