Return-Path: <linux-pci+bounces-25140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E303A78ADC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1161E7A414B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473731C8603;
	Wed,  2 Apr 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beKz68Uz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80A14AD20;
	Wed,  2 Apr 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585395; cv=none; b=SEPcfcXEwRv2ru3HpKWBv7C90EOcQNqKABAvmFXx0qQwqfsIetSEKrxdbNLw5ILk8MOnAm3LjM7NuIv+Y71S+sMnx82hjp/VHOaFWw31UHJq4lE7XOzcZNriYBGtW1JweFlxGkGwIqbM9Rj8Xsnm2yLWP+TfKiiu6Pf/iIxuXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585395; c=relaxed/simple;
	bh=BSQEOky9uXtFXmfTRUERvyYxHFSLPROB2lWF0RqK44k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9JY3b+B0s0/FSUKIzifzIXkaFvLAgyYhiRNwbYcLHvOarvLieTAOvvg0aO8d4nmnvF8fpNkR8H9TW3aQJoqTYZ4ykoJ1lfK3XYbgARdZ2MkwZewcv+hi7VhEz5TlBKd3zD1/i0uIv80EnOatf7+F63xDlZ0Je1DCdHAWX+AJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beKz68Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C163DC4CEDD;
	Wed,  2 Apr 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743585393;
	bh=BSQEOky9uXtFXmfTRUERvyYxHFSLPROB2lWF0RqK44k=;
	h=From:To:Cc:Subject:Date:From;
	b=beKz68Uzbr3wCRLIP2LwGO40T/4kCPEUKTzcYWL5o+rziL6WHrRuv6WwTEi2Cefbf
	 wIW+3yzmUBB+CnapU4fMMXhE+614W5YkWHiRYCHY/O1XN+qFa1oEwAM9Ekq7Jb1Ewd
	 o2YE9kohWyOLGyfUt/tJ6CpZCVlODxdTvIxb5TW7vpIlshv5eZMDjJiAm9gKiW1/o+
	 QP/QYyRhhnjibUy72I9AXRfPu0GbGjdQdh719pck7kz7h0YPqUMKKOwiMZiireBg06
	 G49Kzq6plgxbERK4A5KsypFP+PYmnGD86thlmfZFsWM7w96N7B/m0nu1VFGKs4lvM2
	 lttA87P8Bi3Kg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: qcom-ep: Set intx_capable in epc_features
Date: Wed,  2 Apr 2025 11:16:28 +0200
Message-ID: <20250402091628.4041790-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=cassel@kernel.org; h=from:subject; bh=BSQEOky9uXtFXmfTRUERvyYxHFSLPROB2lWF0RqK44k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLfMuSUbHfO7RZIWm3m8qoleu2pNx7b9uYtPiS09pi6Z vSB1cobOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR5GZGhn7NH3FbBHfxHz3A uuuwrqDrDYnsc7umqOyq1n2c9MN13xtGhgdMGa2sYht3Znxjay9rXBH+LXaOgmyA3zPVOwzvfO0 OMAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While I do not have the technical reference manuals, the qcom-ep
maintainer assures me that all compatibles support generating INTx IRQs.

Thus, set intx_capable to true in epc_features.

This will currently not have any effect, as PCITEST_IRQ_TYPE_AUTO will
always prefer MSI over INTx when both are available, however, perhaps the
supported irq_types in epc_features will be used for something else, e.g.
failing a ioctl(PCITEST_SET_IRQTYPE) with PCITEST_IRQ_TYPE_INTX, on the
host side, before ever configuring anything on the EP side. Thus, ensure
that epc_features represents reality.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 46b1c6d19974..25468025e945 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -824,6 +824,7 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
+	.intx_capable = true,
 	.align = SZ_4K,
 	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-- 
2.49.0


