Return-Path: <linux-pci+bounces-35682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0DB49662
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61473B024A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826493112BB;
	Mon,  8 Sep 2025 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+Bih6h8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA383112D0
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350817; cv=none; b=IdPhPhswvrtAC7Bk4L6lXNAapAn7lNetWsFGkJATvDbGFxmdVcuv+QFT9dMImDNaonr2kAH1i7ROL6PHfnSipOQTNmwFll4AmPNlqtdeIFjjyj95xaS3mdTWhAXIQ6Ws0R/adqQiN5MTF82PE7s1nRm5vYO0IJ2xOEUnuW6hgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350817; c=relaxed/simple;
	bh=PNANOMUtFs631/9enB5yqEG1KbUbfuE8xuz5SmVIrH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3+BUO4Yn7ca9gYdUpCsEBFuGhmiQ0uO5QWr5TsYWOgj/0Il9ZkQGPLarWdqZZFbSA0V5E3xMzPhm6actgF4/cscdO6ATmv6bqSlDZFdf+Cv5rSAa+4HkUMQb4ZYfmtbckMITgwZXgUH1fxBkgY3EwQIn5QqGfQDJVoyURrXqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+Bih6h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5FDC4CEF5;
	Mon,  8 Sep 2025 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350817;
	bh=PNANOMUtFs631/9enB5yqEG1KbUbfuE8xuz5SmVIrH0=;
	h=From:To:Cc:Subject:Date:From;
	b=r+Bih6h8EV51YJeTbh53V6goWOYDCvG+cCsr7U4dKr5SiyxZ5Gsa1wLnJQnI3gLUF
	 RirFfZf4xNwPiDPlbEYuezKWsE3jBzbuPBusTE36kMsqIY8tGRC28IEFbvnuJo2Y19
	 n8MiR0GecY3PJq4C7QjS4go24VXfLXRNrzLUzRUOwA+B3B13KIxh6VFJC2DH3mfbbn
	 VK35e+o0kKznv1aFOS2q05MS3FKKfZKRJ18UDYe1L9AU2HPXYRa7q5MznnNsj1jnC5
	 xLp0YN0jdbPzfh5gcdPjIT9mFsxhB+4H4bj21mEmTWT43TjmCpEz6tReqKlqYbas4M
	 5JaslGIqPBnGA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: Cleanup dw_pcie_edma_irq_verify()
Date: Mon,  8 Sep 2025 18:59:15 +0200
Message-ID: <20250908165914.547002-3-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=cassel@kernel.org; h=from:subject; bh=PNANOMUtFs631/9enB5yqEG1KbUbfuE8xuz5SmVIrH0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL2cyc9nPbt+YTVi/uPpPHvbDmgLjZff63Auoy6wl9em vWa0TKtHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjImTaGfxZyB80mGBb3Ovj0 7RKPk5IvfM+4ru//Uq/Va9v9X4VfZ2RkuJ2ysMSyXE9OdCkvb+/PjXP85bzOmm/6p/XSoDXNKfY eLwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

dw_pcie_edma_irq_vector() requires either "dma" (if there is a single IRQ
for all DMA channels) or "dmaX" (if there is one IRQ per DMA channel) to
be specified in device tree.

Thus, it does not make any sense for dw_pcie_edma_irq_verify() to have a
looser requirement than dw_pcie_edma_irq_vector(). (Since both functions
will get called during the probe of the eDMA driver. First
dw_pcie_edma_irq_verify(), then dw_pcie_edma_irq_vector().)

Thus, remove this redundant code in dw_pcie_edma_irq_verify(), such that
dw_pcie_edma_irq_verify() and dw_pcie_edma_irq_vector() have the same
requirements.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928c..c7a2cf5e886f3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1045,9 +1045,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 	char name[15];
 	int ret;
 
-	if (pci->edma.nr_irqs == 1)
-		return 0;
-	else if (pci->edma.nr_irqs > 1)
+	if (pci->edma.nr_irqs > 1)
 		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
 
 	ret = platform_get_irq_byname_optional(pdev, "dma");
-- 
2.51.0


