Return-Path: <linux-pci+bounces-2832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDAD842CD0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940731C24D11
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDC7B3D2;
	Tue, 30 Jan 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnMLKDx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85D7B3D7
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643170; cv=none; b=FKFMdYe+G2ELnDXexuYTgkz/pf81iPn1snOHO/c6Ma0sSMgBQEYOvUBlXlZ47sCH8jL1YWY4+KFu/GYCijE0Y63xSl5YSPADpn/+eWLvCykQDgmfJH/bAc812yyhJb70nzb9I2MubFylpMa2Cdhvf8EtjCzZw7H9ZS56wNOGspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643170; c=relaxed/simple;
	bh=HkTP8QLZ2wUmYFw3qPAWMOnihHIKq1QZFX+AVr7GUy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCkeN2CVIkApRuZTtXlCHIiBY6zQ9y716/lufscsdm94CNLU1N4+neWo/t6z55bNDvWhQ8iuvwNfQGdmTCBK3IYS61vAK1ADYdK9ncm6R0fICgHZyOPB3sbuVS+EH0TTBteNb2x8WC+05Dp5G0fXJ/tsfVNqoV4lET2sD4xGEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnMLKDx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D4C433F1;
	Tue, 30 Jan 2024 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643170;
	bh=HkTP8QLZ2wUmYFw3qPAWMOnihHIKq1QZFX+AVr7GUy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnMLKDx5CvyxBLgdKOxV15Mh163CogI+vDfcQhchaIljrbKHUaiDvdQCQL9HJtdvU
	 SlJRvuwD694DGDXhHYml36RKZGyjQphB5MJM9sSko2F6JaW0uXjZUahDQgCX0beDxU
	 1bABB4Z7pII9n3pR4/c0EcnP0NvpoFXejp9Fty/otKa/ZXuLe0cK4ctrGfLI9ebFzB
	 65/MzRx736vkBm+5B2DwPW3bcNvKurZUC7fDq1xNOP3GJzKFKGQA3TfKCKTc4ek6/i
	 9PccZAx8jTaEzSXY/GXbIyoiAfwmLdCktuKjs77nLOXF5020I0HSi04vCLrGsQAW9R
	 szEtKX2nFpMpQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: endpoint: improve pci_epf_alloc_space()
Date: Tue, 30 Jan 2024 20:32:10 +0100
Message-ID: <20240130193214.713739-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130193214.713739-1-cassel@kernel.org>
References: <20240130193214.713739-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_epf_alloc_space() already performs checks on the requested BAR size,
and will allocate and set epf_bar->size to a size higher than the
requested BAR size if some constraint deems it necessary.

However, other than pci_epf_alloc_space() performing these roundups,
there are checks and roundups in two different places in pci-epf-test.c.

And further checks are proposed to other endpoint function drivers, see:
https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/

Having these checks spread out at different places in the EPF driver
(and potentially in multiple EPF drivers) is not maintainable and makes
the code hard to follow.

Since pci_epf_alloc_space() already performs roundups, move the checks and
roundups performed by pci-epf-test.c to pci_epf_alloc_space().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 --------
 drivers/pci/endpoint/pci-epf-core.c           | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 15bfa7d83489..981894e40681 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -841,12 +841,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
-	if (epc_features->bar_fixed_size[test_reg_bar]) {
-		if (test_reg_size > bar_size[test_reg_bar])
-			return -ENOMEM;
-		test_reg_size = bar_size[test_reg_bar];
-	}
-
 	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
 				   epc_features, PRIMARY_INTERFACE);
 	if (!base) {
@@ -888,8 +882,6 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
 		if (bar_fixed_64bit)
 			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-		if (epc_features->bar_fixed_size[i])
-			bar_size[i] = epc_features->bar_fixed_size[i];
 	}
 }
 
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e44f4078fe8b..37d9651d2026 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -260,6 +260,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
+	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
 	size_t align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
@@ -270,7 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	if (size < 128)
 		size = 128;
 
-	if (align)
+	if (bar_fixed_size && size > bar_fixed_size) {
+		dev_err(dev, "requested BAR size is larger than fixed size\n");
+		return NULL;
+	}
+
+	if (bar_fixed_size)
+		size = bar_fixed_size;
+	else if (align)
 		size = ALIGN(size, align);
 	else
 		size = roundup_pow_of_two(size);
-- 
2.43.0


