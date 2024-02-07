Return-Path: <linux-pci+bounces-3224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CD84D57E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66B21C20DE7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD712EBFE;
	Wed,  7 Feb 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgCpOrMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BC1384BC
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342029; cv=none; b=FpmiYuWsPIRUTTRsc3o/Swrx7gS8nqqbe+7IbSNoA4PmdB7giJW+cIPFfg8IuOhnRxsA5wB6tazDvsjhV35hb+65nbJss6l6LE7j2xpqdJshfXTTnxM3wLjxEUEMLKa0dcVtmeGgDQqXSKNMUjRkUdP/HVFWi0WFXY1Tme8vb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342029; c=relaxed/simple;
	bh=w6QU8DprQSPzQIrjxMXngpDc2DP7OjoMXjmp2NuW8e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt46ap7QuRHcdbJgxWKRMn6MevDyj535dlcXvFUBeSBCPsDx4r14NEdzqwI0NOqo8Dzbj6eqHLe2jVU5vlN8MgupurU5EfCaIiyEyqLQHcpCsx5lvn3/VQXldhXKm7vQvwe3eI0puivaWD9DpMU7kjAdbbSdywv02vrAollZTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgCpOrMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA75C433F1;
	Wed,  7 Feb 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342029;
	bh=w6QU8DprQSPzQIrjxMXngpDc2DP7OjoMXjmp2NuW8e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgCpOrMciJ+VHYwkoEn+aHlmrlI0PknnAldFXON7XBCqyNtllPVN4Z8l2LciUQ8Q0
	 zXLY5K81CWXie2UETtmTLwtL1yghZ2pateO47mTE3WstHKH/npy57phwa+b+kYCJg7
	 qhlZ2ZCS3IDHGaD4xMvt43O/MUuCkrssVYUg7gycnK+RJjv5i17FbiJ9fFxDp+IjKU
	 QuBWKMd7RsDmBd9D4wcAD4F+1yhysr5+Nl9llBfP59fTNxLjyipPn/NQZl3nHsJUMa
	 bEaJgXsLIaJNz6Tj5vW+80fxOgUoOYnMfxm0h1pZ764jeAP/1AFzU08MN1W2TiJl5i
	 w9RYmfMHMMkKg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: endpoint: improve pci_epf_alloc_space()
Date: Wed,  7 Feb 2024 22:39:15 +0100
Message-ID: <20240207213922.1796533-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>
References: <20240207213922.1796533-1-cassel@kernel.org>
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

However, other than pci_epf_alloc_space() already doing these roundups,
there are additional checks and roundups done in e.g. pci-epf-test.c.

And similar checks are proposed to other endpoint function drivers, see:
https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/

Having these checks scattered over different locations in multiple EPF
drivers is not maintainable and makes the code hard to follow.

Since pci_epf_alloc_space() already performs roundups, add the checks
currently performed by pci-epf-test.c to pci_epf_alloc_space(), such that
a follow up patch can drop these checks from pci-epf-test.c.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epf-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1d405fd61a2a..367e029f6716 100644
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
@@ -270,6 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	if (size < 128)
 		size = 128;
 
+	if (bar_fixed_size && size > bar_fixed_size) {
+		dev_err(dev, "requested BAR size is larger than fixed size\n");
+		return NULL;
+	}
+
+	if (bar_fixed_size)
+		size = bar_fixed_size;
+
 	if (align)
 		size = ALIGN(size, align);
 	else
-- 
2.43.0


