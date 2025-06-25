Return-Path: <linux-pci+bounces-30610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B6AE7F17
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59C9175202
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C400029ACCB;
	Wed, 25 Jun 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLZeQuv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957472882CA
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847063; cv=none; b=p9Z8RYOcoqqh9KlUUUUgkubxyL51C6rTWvte32i+0zopOesNLmWmIbXN/IXNYT8pw6xULv8jT/FE7pGDrMIXC65LqJ1d7r4SKRmr48ScjsWtxti0TP3X9qCBZAuDjZ3v35ymnIUFXgcNZIF6Mder+WefX7NprGGTGqAaiWAbshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847063; c=relaxed/simple;
	bh=k0j9kWDlQZY6R60Cg4LekXDZ6uzbeKLxppQmBfkQVsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRx7ABT1+h5MLK5U+uVVxODFDFMkDVeIZxqbeU3WGT3kC/brTLUF323iTHgiPPa55fvTC/uzZkl4OuBwluahd9+rWx5bh0eqJ/sx8Tk9SR3xhFwWJnrrAySmA8soDlIYZ5SDupXC1/kf5iDRswgNsIYuLiYGCiGxh8AvPQ7YG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLZeQuv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C1C4CEEA;
	Wed, 25 Jun 2025 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847063;
	bh=k0j9kWDlQZY6R60Cg4LekXDZ6uzbeKLxppQmBfkQVsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLZeQuv8b/PU5OFV5HRoRdyNNWqxBPw4+dLq9qU2MRnu1j/piNccJBtD5DJEs9tzr
	 oXyFG21oWNSdU9pUXi1Y+MzUktgeb/fH9ne9DyWLusivwcPN9z7Rjm2cfGBi0X3dgN
	 aqdgWOmodICmvEm/KDtXIa8LIN5wLl2re8drAuv9Fbq+HZzcEoG5UhnLKLMzMIGdOA
	 0C9cOvBoa3zt2E5GSK3qvjomdCD8NhTNp9Rn3v8sK2GS5YpHC/zNG86uDfzrQzxKQ2
	 hvtbGmdBsWwA0CvKgrI1MAaxoYFvGMTsHFPgGuAGNYkd9OswpAfwCXXv247ocrmXp9
	 6ByAKmgZJU67A==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
Date: Wed, 25 Jun 2025 12:23:51 +0200
Message-ID: <20250625102347.1205584-14-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=cassel@kernel.org; h=from:subject; bh=k0j9kWDlQZY6R60Cg4LekXDZ6uzbeKLxppQmBfkQVsk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1mutavTLr1x57J41bLQY4wPPFTeLxddO232zVPOW pd25KyI6yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEzH0ZGU7MDJ7Q4x/wdqfD 1yShd1vzVrmfXbR49mXz6S/WLS5aWNrI8N+zOCH9a+xxpVNyc4JNlsqfPCt72fCVkeapZw/f5R2 5FM8HAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add this delay in dw_pcie_wait_for_link(), after the link is reported as
up. The delay will only be performed in the success case where the link
came up.

DWC glue drivers that have a link up IRQ (drivers that set
use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
perform this delay in their threaded link up IRQ handler.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..053e9c540439 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -714,6 +714,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
+	/*
+	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
+	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
+	 * after Link training completes before sending a Configuration Request.
+	 */
+	if (pci->max_link_speed > 2)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
-- 
2.49.0


